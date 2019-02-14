Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A8FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DF721904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391231AbfBNBnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:43:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:11444 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390871AbfBNBnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:43:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 17:39:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,367,1544515200"; 
   d="scan'208";a="114766256"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga007.jf.intel.com with ESMTP; 13 Feb 2019 17:39:38 -0800
Cc:     baolu.lu@linux.intel.com,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "sanjay.k.kumar@intel.com" <sanjay.k.kumar@intel.com>,
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "yi.y.sun@intel.com" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "tiwei.bie@intel.com" <tiwei.bie@intel.com>,
        "xin.zeng@intel.com" <xin.zeng@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v6 1/9] iommu: Add APIs for multiple domains per device
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
References: <20190213040301.23021-1-baolu.lu@linux.intel.com>
 <20190213040301.23021-2-baolu.lu@linux.intel.com>
 <1735d302-8fab-68b5-d016-01731546fd36@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <53660512-df41-6398-0923-47f224a7b0ef@linux.intel.com>
Date:   Thu, 14 Feb 2019 09:34:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1735d302-8fab-68b5-d016-01731546fd36@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 2/13/19 7:55 PM, Jean-Philippe Brucker wrote:
> Hi,
> 
> I have a few boring nits and one question below

Thanks a lot for reviewing my patch.

> 
> On 13/02/2019 04:02, Lu Baolu wrote:
>> Sharing a physical PCI device in a finer-granularity way
>> is becoming a consensus in the industry. IOMMU vendors
>> are also engaging efforts to support such sharing as well
>> as possible. Among the efforts, the capability of support
>> finer-granularity DMA isolation is a common requirement
>> due to the security consideration. With finer-granularity
>> DMA isolation, all DMA requests out of or to a subset of
>> a physical PCI device can be protected by the IOMMU.
> 
> That last sentence seems strange, how about "With finer-granularity DMA
> isolation, subsets of a PCI function can be isolated from each others by
> the IOMMU."

Yours looks better. Thanks!

> 
>> As a
>> result, there is a request in software to attach multiple
>> domains to a physical PCI device. One example of such use
>> model is the Intel Scalable IOV [1] [2]. The Intel vt-d
>> 3.0 spec [3] introduces the scalable mode which enables
>> PASID granularity DMA isolation.
>>
>> This adds the APIs to support multiple domains per device.
>> In order to ease the discussions, we call it 'a domain in
>> auxiliary mode' or simply 'auxiliary domain' when multiple
>> domains are attached to a physical device.
>>
>> The APIs include:
>>
>> * iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)
>>    - Check whether both IOMMU and device support IOMMU aux
>>      domain feature. Below aux-domain specific interfaces
>>      are available only after this returns true.
> 
> s/after/if/ since calling has_feature() shouldn't be a prerequisite to
> using the aux-domain interface (unlike calling enable_feature()).

After reconsideration, I think my comments about this API isn't
correct. It should be like,

* iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)
   - Detect both IOMMU and PCI endpoint devices supporting the feature
     (aux-domain here) without host driver dependency.

* iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX)
   - Check the enabling status of the feature (aux-domain here). The
     aux-domain interfaces are available only if this returns true.

> 
>>
>> * iommu_dev_enable/disable_feature(dev, IOMMU_DEV_FEAT_AUX)
>>    - Enable/disable device specific aux-domain feature.
>>
>> * iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX)
>>    - Check whether the aux domain specific feature enabled or
>>      not.
> 
> "is enabled"

Sure.

> 
>>
>> * iommu_aux_attach_device(domain, dev)
>>    - Attaches @domain to @dev in the auxiliary mode. Multiple
>>      domains could be attached to a single device in the
>>      auxiliary mode with each domain representing an isolated
>>      address space for an assignable subset of the device.
>>
>> * iommu_aux_detach_device(domain, dev)
>>    - Detach @domain which has been attached to @dev in the
>>      auxiliary mode.
>>
>> * iommu_aux_get_pasid(domain, dev)
>>    - Return ID used for finer-granularity DMA translation.
>>      For the Intel Scalable IOV usage model, this will be
>>      a PASID. The device which supports Scalable IOV needs
>>      to write this ID to the device register so that DMA
>>      requests could be tagged with a right PASID prefix.
>>
>> This has been updated with the latest proposal from Joerg
>> posted here [5].
>>
>> Many people involved in discussions of this design.
>>
>> Kevin Tian <kevin.tian@intel.com>
>> Liu Yi L <yi.l.liu@intel.com>
>> Ashok Raj <ashok.raj@intel.com>
>> Sanjay Kumar <sanjay.k.kumar@intel.com>
>> Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Alex Williamson <alex.williamson@redhat.com>
>> Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> Joerg Roedel <joro@8bytes.org>
>>
>> and some discussions can be found here [4] [5].
>>
>> [1]
>> https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
>> [2] https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf
>> [3]
>> https://software.intel.com/en-us/download/intel-virtualization-technology-for-directed-io-architecture-specification
>> [4] https://lkml.org/lkml/2018/7/26/4
>> [5] https://www.spinics.net/lists/iommu/msg31874.html
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Suggested-by: Kevin Tian <kevin.tian@intel.com>
>> Suggested-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> Suggested-by: Joerg Roedel <jroedel@suse.de>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu.c | 91 +++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/iommu.h | 70 +++++++++++++++++++++++++++++++++
>>   2 files changed, 161 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 3ed4db334341..d0b323e8357f 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2033,3 +2033,94 @@ int iommu_fwspec_add_ids(struct device *dev, u32
>> *ids, int num_ids)
>>           return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
>> +
>> +/*
>> + * Per device IOMMU features.
>> + */
>> +bool iommu_dev_has_feature(struct device *dev, enum iommu_dev_features
>> feat)
>> +{
>> +       const struct iommu_ops *ops = dev->bus->iommu_ops;
>> +
>> +       if (ops && ops->dev_has_feat)
>> +               return ops->dev_has_feat(dev, feat);
>> +
>> +       return false;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_dev_has_feature);
>> +
>> +int iommu_dev_enable_feature(struct device *dev, enum
>> iommu_dev_features feat)
>> +{
>> +       const struct iommu_ops *ops = dev->bus->iommu_ops;
>> +
>> +       if (ops && ops->dev_enable_feat)
>> +               return ops->dev_enable_feat(dev, feat);
>> +
>> +       return -ENODEV;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_dev_enable_feature);
>> +
>> +int iommu_dev_disable_feature(struct device *dev, enum
>> iommu_dev_features feat)
>> +{
>> +       const struct iommu_ops *ops = dev->bus->iommu_ops;
>> +
>> +       if (ops && ops->dev_disable_feat)
>> +               return ops->dev_disable_feat(dev, feat);
>> +
>> +       return -ENODEV;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_dev_disable_feature);
>> +
>> +bool iommu_dev_feature_enabled(struct device *dev, enum
>> iommu_dev_features feat)
>> +{
>> +       const struct iommu_ops *ops = dev->bus->iommu_ops;
>> +
>> +       if (ops && ops->dev_feat_enabled)
>> +               return ops->dev_feat_enabled(dev, feat);
>> +
>> +       return false;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
>> +
>> +/*
>> + * Aux-domain specific attach/detach.
>> + *
>> + * Only works if iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX) returns
>> true.
> 
> Rather "Only works if iommu_dev_feature_enabled(dev, AUX) returns true"?

Yes. I will change this and above.

> 
>> + * Also, as long as domains are attached to a device through this
>> interface,
>> + * any tries to call iommu_attach_device() should fail
>> (iommu_detach_device()
>> + * can't fail, so we fail on the tryint to re-attach). This should make
> 
> "when trying to re-attach"

Sure.

> 
>> us safe
>> + * against a device being attached to a guest as a whole while there
>> are still
>> + * pasid users on it (aux and sva).
> 
> A related question: is calling iommu_dev_disable_feat(dev, AUX) enough
> to detach all auxiliary domains? I guess device drivers will always need
> to tidy contexts up one by one, so maybe iommu_dev_disable_feat(dev,
> AUX) can return -EBUSY in this case? I think we need to specify this in
> a comment so device drivers know how to clean up.

Yes, -EBUSY sounds better.

iommu_dev_disable_feat() will not detach all aux-domains, it requires
the device drivers to do so before calling it. So if it sees anything
not cleaned up, it should return -EBUSY. And we should put it as a
comment for this API so that the device drivers know it.

> 
> Thanks,
> Jean

Best regards,
Lu Baolu

> 
>> + */
>> +int iommu_aux_attach_device(struct iommu_domain *domain, struct device
>> *dev)
>> +{
>> +       int ret = -ENODEV;
>> +
>> +       if (domain->ops->aux_attach_dev)
>> +               ret = domain->ops->aux_attach_dev(domain, dev);
>> +
>> +       if (!ret)
>> +               trace_attach_device_to_domain(dev);
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_aux_attach_device);
>> +
>> +void iommu_aux_detach_device(struct iommu_domain *domain, struct device
>> *dev)
>> +{
>> +       if (domain->ops->aux_detach_dev) {
>> +               domain->ops->aux_detach_dev(domain, dev);
>> +               trace_detach_device_from_domain(dev);
>> +       }
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_aux_detach_device);
>> +
>> +int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
>> +{
>> +       int ret = -ENODEV;
>> +
>> +       if (domain->ops->aux_get_pasid)
>> +               ret = domain->ops->aux_get_pasid(domain, dev);
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index e90da6b6f3d1..831eb29b35c5 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -156,6 +156,11 @@ struct iommu_resv_region {
>>           enum iommu_resv_type    type;
>>   };
>>   
>> +/* Per device IOMMU features */
>> +enum iommu_dev_features {
>> +       IOMMU_DEV_FEAT_AUX,     /* Aux-domain feature */
>> +};
>> +
>>   #ifdef CONFIG_IOMMU_API
>>   
>>   /**
>> @@ -183,6 +188,11 @@ struct iommu_resv_region {
>>    * @domain_window_enable: Configure and enable a particular window for
>> a domain
>>    * @domain_window_disable: Disable a particular window for a domain
>>    * @of_xlate: add OF master IDs to iommu grouping
>> + * @dev_has/enable/disable_feat: per device entries to check/enable/disable
>> + *                               iommu specific features.
>> + * @dev_feat_enabled: check enabled feature
>> + * @aux_attach/detach_dev: aux-domain specific attach/detach entries.
>> + * @aux_get_pasid: get the pasid given an aux-domain
>>    * @pgsize_bitmap: bitmap of all possible supported page sizes
>>    */
>>   struct iommu_ops {
>> @@ -226,6 +236,17 @@ struct iommu_ops {
>>           int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
>>           bool (*is_attach_deferred)(struct iommu_domain *domain, struct
>> device *dev);
>>   
>> +       /* Per device IOMMU features */
>> +       bool (*dev_has_feat)(struct device *dev, enum iommu_dev_features f);
>> +       bool (*dev_feat_enabled)(struct device *dev, enum
>> iommu_dev_features f);
>> +       int (*dev_enable_feat)(struct device *dev, enum
>> iommu_dev_features f);
>> +       int (*dev_disable_feat)(struct device *dev, enum
>> iommu_dev_features f);
>> +
>> +       /* Aux-domain specific attach/detach entries */
>> +       int (*aux_attach_dev)(struct iommu_domain *domain, struct device
>> *dev);
>> +       void (*aux_detach_dev)(struct iommu_domain *domain, struct
>> device *dev);
>> +       int (*aux_get_pasid)(struct iommu_domain *domain, struct device
>> *dev);
>> +
>>           unsigned long pgsize_bitmap;
>>   };
>>   
>> @@ -412,6 +433,14 @@ static inline void dev_iommu_fwspec_set(struct
>> device *dev,
>>   int iommu_probe_device(struct device *dev);
>>   void iommu_release_device(struct device *dev);
>>   
>> +bool iommu_dev_has_feature(struct device *dev, enum iommu_dev_features f);
>> +int iommu_dev_enable_feature(struct device *dev, enum
>> iommu_dev_features f);
>> +int iommu_dev_disable_feature(struct device *dev, enum
>> iommu_dev_features f);
>> +bool iommu_dev_feature_enabled(struct device *dev, enum
>> iommu_dev_features f);
>> +int iommu_aux_attach_device(struct iommu_domain *domain, struct device
>> *dev);
>> +void iommu_aux_detach_device(struct iommu_domain *domain, struct device
>> *dev);
>> +int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev);
>> +
>>   #else /* CONFIG_IOMMU_API */
>>   
>>   struct iommu_ops {};
>> @@ -696,6 +725,47 @@ const struct iommu_ops
>> *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>>           return NULL;
>>   }
>>   
>> +static inline bool
>> +iommu_dev_has_feature(struct device *dev, enum iommu_dev_features feat)
>> +{
>> +       return false;
>> +}
>> +
>> +static inline bool
>> +iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
>> +{
>> +       return false;
>> +}
>> +
>> +static inline int
>> +iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
>> +{
>> +       return -ENODEV;
>> +}
>> +
>> +static inline int
>> +iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
>> +{
>> +       return -ENODEV;
>> +}
>> +
>> +static inline int
>> +iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev)
>> +{
>> +       return -ENODEV;
>> +}
>> +
>> +static inline void
>> +iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev)
>> +{
>> +}
>> +
>> +static inline int
>> +iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
>> +{
>> +       return -ENODEV;
>> +}
>> +
>>   #endif /* CONFIG_IOMMU_API */
>>   
>>   #ifdef CONFIG_IOMMU_DEBUGFS
>> -- 
>> 2.17.1
>>
> 
> 
