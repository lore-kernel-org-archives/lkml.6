Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B754C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 09:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2289F20652
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 09:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfBXJDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 04:03:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:57284 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbfBXJDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 04:03:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2019 00:56:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,407,1544515200"; 
   d="scan'208,223";a="117352953"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga007.jf.intel.com with ESMTP; 24 Feb 2019 00:56:11 -0800
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jis Ben <jisben@google.com>
Subject: Re: [PATCH] iommu/vt-d: Handle hotplug devices' default identity
 mapping setting
To:     James Dong <xmdong@google.com>
References: <fe6dcb4e-03c4-0bbf-c51f-5964b20593dd@linux.intel.com>
 <20190222073658.66798-1-xmdong@google.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <897e8383-ad75-35d0-5ad9-3d3a8b46b6ba@linux.intel.com>
Date:   Sun, 24 Feb 2019 16:51:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222073658.66798-1-xmdong@google.com>
Content-Type: multipart/mixed;
 boundary="------------7CCEAC9A72412DAE6199B60C"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7CCEAC9A72412DAE6199B60C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/22/19 3:36 PM, James Dong wrote:
> Baolu:
> 
> Sorry that my last reply email seems not text format. Resend it now.
> 
> Thanks for your comments and your patch. Please find below our responses to
> each of your comments:
> 
>> What does "I/O operation won't work" exactly mean here? Do you see any
>> IOMMU fault message? Or, something doesn't work as expected?
> 
> Yes, DMAR fault messages as following came out:
> [  354.939896] DMAR: DMAR:[DMA Read] Request device [03:00.1]fault addr 1fdfe80000
> [  354.939896] DMAR:[fault reason 02] Present bit in context entry is clear
> 
> 
>> Do you mind checking this?
>>
>> index 6ecdcf8fc8c0..f62f30bc1339 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -2632,6 +2632,9 @@ static struct dmar_domain
>> *find_or_alloc_domain(struct device *dev, int gaw)
>>                           goto out;
>>           }
>>
>> +       if (!iommu_should_identity_map(dev, 0))
>> +               return si_domain;
>> +
>>           /* Allocate and initialize new domain for the device */
>>           domain = alloc_domain(0);
>>           if (!domain)
> 
> Tried this patch, and the same DMAR fault message came out.

Thank you!

> 
> Guess it is because of the iommu code path for hotplug devices. If a hotplug
> device is rescanned after removal, iommu_bus_notifier will be called as part
> of the notifier chains to handle BUS_NOTIFY_ADD_DEVICE event. Along the code
> path, intel_iommu_ops->add_device() created an iommu group for this hotplug
> device, but failed to create an iommu domain because of the default domain
> type IOMMU_DOMAIN_IDENTITY imposed by current IOMMU command line option got
> declined by intel_iommu_ops->domain_alloc().

The Intel IOMMU driver hasn't switched to default domain yet although
it's in the pipe line. So, there should be no domain allocated when a
group is allocated for the device.

The problem is we need to check whether a hot-added device requires
identity map instead of allocating a normal domain blindly.

> 
> Since si_domain is type of "struct dmar_domain", which is platform dependent,
> it is hard to make this change in intel_iommu_ops->domain_alloc().
> 
> In your patch, function find_or_alloc_domain() is not in the code path of
> BUS_NOTIFY_ADD_DEVICE event notifier chain.
> 
> Please let us know if your have more concerns and suggestions.

Can you please try the patch attached? I think this is a generic issue
as I described in the commit message.

Best regards,
Lu Baolu

--------------7CCEAC9A72412DAE6199B60C
Content-Type: text/x-patch;
 name="0001-iommu-vt-d-Check-identity-map-for-hot-added-devices.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-iommu-vt-d-Check-identity-map-for-hot-added-devices.pat";
 filename*1="ch"

From d942e60557fc7ea6fee535fb9a0a7d334d65b636 Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Sun, 24 Feb 2019 10:01:03 +0800
Subject: [PATCH 1/1] iommu/vt-d: Check identity map for hot-added devices

The Intel IOMMU driver will put devices into a static identity
mapped domain during boot if the kernel parameter "iommu=pt" is
used. That means the IOMMU hardware will translate a DMA address
into the same memory address.

Unfortunately, a hot-added device doesn't subject to this. That
results in some devices not working properly after hot added. A
quick way to reproduce this issue is to boot a system with

    iommu=pt

and, remove then readd the pci device with

    echo 1 > /sys/bus/pci/devices/[pci_source_id]/remove
    echo 1 > /sys/bus/pci/rescan

You will find the identity mapped domain was replaced with a
normal domain.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6ecdcf8fc8c0..730ee29d561b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3001,9 +3001,9 @@ static int iommu_should_identity_map(struct device *dev, int startup)
 	}
 
 	/*
-	 * At boot time, we don't yet know if devices will be 64-bit capable.
-	 * Assume that they will — if they turn out not to be, then we can
-	 * take them out of the 1:1 domain later.
+	 * At boot time or hot added, we don't yet know if devices will be
+	 * 64-bit capable. Assume that they will — if they turn out not to
+	 * be, then we can take them out of the 1:1 domain later.
 	 */
 	if (!startup) {
 		/*
@@ -4807,16 +4807,19 @@ static int device_notifier(struct notifier_block *nb,
 	if (iommu_dummy(dev))
 		return 0;
 
-	if (action != BUS_NOTIFY_REMOVED_DEVICE)
-		return 0;
-
-	domain = find_domain(dev);
-	if (!domain)
-		return 0;
+	if (action == BUS_NOTIFY_REMOVED_DEVICE) {
+		domain = find_domain(dev);
+		if (!domain)
+			return 0;
 
-	dmar_remove_one_dev_info(dev);
-	if (!domain_type_is_vm_or_si(domain) && list_empty(&domain->devices))
-		domain_exit(domain);
+		dmar_remove_one_dev_info(dev);
+		if (!domain_type_is_vm_or_si(domain) &&
+		    list_empty(&domain->devices))
+			domain_exit(domain);
+	} else if (action == BUS_NOTIFY_ADD_DEVICE) {
+		if (iommu_should_identity_map(dev, 1))
+			domain_add_dev_info(si_domain, dev);
+	}
 
 	return 0;
 }
-- 
2.17.1


--------------7CCEAC9A72412DAE6199B60C--
