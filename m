Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA99C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B83C2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbfBVFLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 00:11:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:17543 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfBVFLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 00:11:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 21:11:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,398,1544515200"; 
   d="scan'208";a="116884303"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga007.jf.intel.com with ESMTP; 21 Feb 2019 21:11:49 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jis Ben <jisben@google.com>
Subject: Re: [PATCH] iommu/vt-d: Handle hotplug devices' default identity
 mapping setting
To:     James Dong <xmdong@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
References: <20190222024455.20802-1-xmdong@google.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <cf965dec-1bae-1d98-e97c-6a84c0c9862f@linux.intel.com>
Date:   Fri, 22 Feb 2019 13:06:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222024455.20802-1-xmdong@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/22/19 10:44 AM, James Dong wrote:
> With specific Linux command line option such as "iommu=pt", some types
> of hotplug devices will be assigned to the static 1:1 iommu domain by
> default during kernel init.
> 
> If such a hotplug device is rescanned after being removed, for example,
> with following sample commands:
>    echo 1 > /sys/bus/pci/devices/0000\:03\:00.1/remove
>    echo 1 > /sys/bus/pci/rescan
> , an iommu group for this hotplug device will be added without attaching
> it to the default static 1:1 domain. As a result, this device's I/O
> operation won't work.

What does "I/O operation won't work" exactly mean here? Do you see any
IOMMU fault message? Or, something doesn't work as expected?

> 
> Keep hotplug devices with default static 1:1 iommu mapping in their default
> domain after such hotplug devices are rescanned.
> 
> Signed-off-by: James Dong <xmdong@google.com>
> Reported-by: Jis Ben <jisben@google.com>
> ---
>   drivers/iommu/intel-iommu.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 78188bf7e90d..4b02949e58ca 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5230,6 +5230,7 @@ static int intel_iommu_add_device(struct device *dev)
>   	struct intel_iommu *iommu;
>   	struct iommu_group *group;
>   	u8 bus, devfn;
> +	int ret = 0;
>   
>   	iommu = device_to_iommu(dev, &bus, &devfn);
>   	if (!iommu)
> @@ -5242,8 +5243,19 @@ static int intel_iommu_add_device(struct device *dev)
>   	if (IS_ERR(group))
>   		return PTR_ERR(group);
>   
> +	if (!iommu_group_default_domain(group) &&
> +	    !find_domain(dev) && iommu_should_identity_map(dev, 0)) {
> +		ret = domain_add_dev_info(si_domain, dev);
> +		if (!ret)
> +			pr_info("identity mapping for device %s\n",
> +				dev_name(dev));
> +		else
> +			pr_info("identity mapping failed (%d) for device %s\n",
> +				ret, dev_name(dev));
> +	}
> +

I am not sure about whether this is a good place to fix this problem
before Intel IOMMU driver switches to default domain.

Do you mind checking this?

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6ecdcf8fc8c0..f62f30bc1339 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2632,6 +2632,9 @@ static struct dmar_domain 
*find_or_alloc_domain(struct device *dev, int gaw)
                         goto out;
         }

+       if (!iommu_should_identity_map(dev, 0))
+               return si_domain;
+
         /* Allocate and initialize new domain for the device */
         domain = alloc_domain(0);
         if (!domain)

Best regards,
Lu Baolu
