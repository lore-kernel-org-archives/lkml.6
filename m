Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E3DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DF420660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfANFeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 00:34:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:22761 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfANFen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 00:34:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2019 21:34:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,476,1539673200"; 
   d="scan'208";a="106377970"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by orsmga007.jf.intel.com with ESMTP; 13 Jan 2019 21:34:39 -0800
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, xin.zeng@intel.com,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 2/8] iommu/vt-d: Add per-device IOMMU feature ops
 entries
To:     Joerg Roedel <joro@8bytes.org>
References: <20190110030027.31447-1-baolu.lu@linux.intel.com>
 <20190110030027.31447-3-baolu.lu@linux.intel.com>
 <20190111111644.epawu474jdjv4a33@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9fd40493-6140-c4e9-f6c8-fefbe4c33ccd@linux.intel.com>
Date:   Mon, 14 Jan 2019 13:30:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111111644.epawu474jdjv4a33@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Thanks for reviewing my patch.

On 1/11/19 7:16 PM, Joerg Roedel wrote:
> Hi,
> 
> this looks a bit confusing to me because I can see no checking whether
> the device actually supports scalable mode.

Yes. I should put some checking there. Device scalable mode capability
is exposed in PCI extended capability list.

> More below:
> 
> On Thu, Jan 10, 2019 at 11:00:21AM +0800, Lu Baolu wrote:
>> +static int intel_iommu_enable_auxd(struct device *dev)
>> +{
>> +	struct device_domain_info *info;
>> +	struct dmar_domain *domain;
>> +	unsigned long flags;
>> +
>> +	if (!scalable_mode_support())
>> +		return -ENODEV;
>> +
>> +	domain = get_valid_domain_for_dev(dev);
>> +	if (!domain)
>> +		return -ENODEV;
>> +
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>> +	info = dev->archdata.iommu;
>> +	info->auxd_enabled = 1;
>> +	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +
>> +	return 0;
>> +}
> 
> This code sets a flag to mark scalable mode enabled. Doesn't the device
> need some handling too, like enabling the PASID capability and all?

Yes. My design was rough. We should prepare the device for scalable mode
instead of assuming that everything is ready.

> 
>> +
>> +static bool
>> +intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
>> +{
>> +	struct device_domain_info *info = dev->archdata.iommu;
>> +
>> +	if (feat == IOMMU_DEV_FEAT_AUX)
>> +		return scalable_mode_support() && info && info->auxd_enabled;
>> +
>> +	return false;
>> +}
> 
> Why is this checking the auxd_enabled flag?

We need an API to check whether this feature is enabled. In vfio, it
is used like below,

if (iommu_dev_has_feat(dev, FEAT_AUX_DOMAIN))
     iommu_aux_attach_device(dev, domain)
else
     iommu_attach_device(dev, domain)

> The function should just
> return whether the device _supports_ scalable mode, not whether it is
> enabled.

Do we want to have an API to tell whether device has aux-domain feature?
It could be included in the enable API. The enable API returns failure
if device doesn't support aux-domain.

> 
> Regards,
> 
> 	Joerg
> 

Best regards,
Lu Baolu
