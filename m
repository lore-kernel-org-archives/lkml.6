Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C839C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7747B21855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfAXGwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 01:52:16 -0500
Received: from mga06.intel.com ([134.134.136.31]:56237 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfAXGwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 01:52:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 22:52:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,515,1539673200"; 
   d="scan'208";a="120880652"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga003.jf.intel.com with ESMTP; 23 Jan 2019 22:52:12 -0800
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, Zeng@8bytes.org, Xin <xin.zeng@intel.com>,
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
Message-ID: <b96994da-b3bd-1321-b45f-4c9c1fc4b0c4@linux.intel.com>
Date:   Thu, 24 Jan 2019 14:47:39 +0800
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

On 1/11/19 7:16 PM, Joerg Roedel wrote:
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
> Why is this checking the auxd_enabled flag? The function should just
> return whether the device_supports_  scalable mode, not whether it is
> enabled.

Yes, as the API name implies, it should return the device capability
instead of enable/disable status. I misused this API in the IOMMU
driver.

Since we already have iommu_dev_enable/disable_feature() to enable and
disable an iommu specific feature, is it possible to add another API to
query whether a specific feature has been enabled?

How about

bool iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX)?

This is necessary for the third party drivers (like vfio) to determine
which domain attach interface it should use:

if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
         iommmu_aux_attach_device(domain, dev)
else
         iommu_attach_device(domain, dev)


Best regards,
Lu Baolu
