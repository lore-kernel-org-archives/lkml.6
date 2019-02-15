Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAA3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C35205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfBORdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:33:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36668 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfBORdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:33:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 592CCA78;
        Fri, 15 Feb 2019 09:33:54 -0800 (PST)
Received: from [10.1.197.2] (ostrya.cambridge.arm.com [10.1.197.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53A513F589;
        Fri, 15 Feb 2019 09:33:51 -0800 (PST)
Subject: Re: [RFC PATCH 1/5] iommu: Add APIs for IOMMU PASID management
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "sanjay.k.kumar@intel.com" <sanjay.k.kumar@intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "yi.y.sun@intel.com" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "tiwei.bie@intel.com" <tiwei.bie@intel.com>,
        Zeng Xin <xin.zeng@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181112064501.2290-1-baolu.lu@linux.intel.com>
 <20181112064501.2290-2-baolu.lu@linux.intel.com>
 <20190130110507.54e8bfad@jacob-builder>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <65452190-afac-bc71-de29-ce24b508955a@arm.com>
Date:   Fri, 15 Feb 2019 17:33:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130110507.54e8bfad@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob, Lu,

On 30/01/2019 19:05, Jacob Pan wrote:
> On Mon, 12 Nov 2018 14:44:57 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> This adds APIs for IOMMU drivers and device drivers to manage
>> the PASIDs used for DMA transfer and translation. It bases on
>> I/O ASID allocator for PASID namespace management and relies
>> on vendor specific IOMMU drivers for paravirtual PASIDs.
>>
> Trying to integrate this with VT-d SVM code had some thoughts.
> First of all, it seems to me the problem we are trying to solve here is
> to allow custom PASID/IOASID allocator.
> IOASID, as in driver base, is a common infrastructure of its own right.
> So it is OK to let device drivers such as VT-d driver directly
> communicate with IOASID w/o going through common IOMMU layer. Therefore
> I see little value of adding this wrapper to ioasid code, instead I
> feel it might be less work to enhance ioasid with the following:
> 
> 1. allow ioasid code to register a system wide custom asid allocator,
> which takes precedence over the idr allocator
> e.g.
> typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
> void ioasid_set_allocator(ioasid_alloc_fn_t fn)
> {}
> We can still use idr for tracking ioasid and private data lookup, since
> the ioasid idr is exclusively owned by ioasid_alloc, we can rest and be
> sure there is no conflict with other callers. See code comments below.

Yes, I think we need the alloc function to be registered at boot time.
Because even when using a PV allocation instead of idr allocation, we do
need a way to quickly retrieve PASID->mm when handling an I/O page
fault. In the ioasid_alloc() function, we could do, roughly:

static ioasid_t (*ioasid_alloc_fn)(...);

ioasid_t ioasid_alloc(... min, max...)
{
	if (ioasid_alloc_fn) {
	   ioasid = ioasid_alloc_fn(min, max);

	   /* With PV allocation, only use the IDR for storage */
	   min = ioasid;
	   max = ioasid + 1;
	}

	idr_lock
	ioasid = idr_alloc(... min, max... );
	idr_unlock
}

> 2. support setting asid private data _after_ asid is allocated. The use
> case is that PASID allocation and mm bind can be split into separate
> stages. Private data (mm related) are not available at the time of
> allocation, only bind time.
> Since IDR needs the data pointer at allocation time, we can still
> create an empty ioasid_data for ioasid tracking at alloc time. i.e.
> struct ioasid_data {
> 	void *ptr; /* private data */
> };

I think I agree as well (though finding the right ordering and locking
in SVA allocation is giving me the biggest headache these days). If the
PASID becomes reachable early we need to make sure that concurrent
threads working on the PASID space can deal with incomplete data, but I
think that might be one of the easiest alternatives.

> 3. allow NULL ioasid_set
> I also had a hard time understanding the use of ioasid_set, since there
> is already a private data associated with each ioasid, is it not enough
> to group ioasid based on private data?

The idea behind ioasid_set is that different modules compete for the
single IOASID space, and associate different data types to their IOASIDs.

(a) iommu-sva associates an mm_struct
(b) IOMMU driver allocates a PASIDs for each auxiliary domain, and
probably associates an iommu_domain to it.
(c) device drivers (e.g. AMD KFD) want some PASIDs for their own use in
the same space, and will have their own private data in there.

For (a) we also want the io_pgfault code to find the mm associated with
a PASID:
  iopf_handle_mm_fault()
    iommu_sva_find(pasid)
      ioasid_find(&shared_pasid_set, pasid) -> mm struct

And in this case we really need the search to be only on the
shared_pasid_set, or else the IOPF code gets something that's not an mm
struct.

The easy alternative is to let the IOMMU driver handle both (a) and (b),
and store the same data type for both. I've been considering this a few
times this week, but it doesn't solve case (c).

Thanks,
Jean

> So the usage scenarios can be.
> 1. during boot, vt-d driver register a custom ioasid allocator (vcmd) if
> it detects its running as a guest.
> 
> 2. Running as a guest, all pasid allocation via ioasid_alloc() will go
> to this custom allocators and tracked
> 
> 3. for native case, there is no custom allocator, ioasid just use IDR
> alloc
> 
> 4. for native bind mm, pasid allocation already has private data filled
> in when calling ioasid_alloc
> 
> 5. for guest bind, pasid is allocated with empty private data (called
> by VFIO layer), but private data is filled in later by bind guest
> pasid inside the vt-d driver.
> 
> So my thinking is that we can avoid having another layer of APIs as
> below and keep everything within ioasid. Also allows private data to be
> managed at lower level as compared to VFIO.
> 
> 
> Thanks,
> 
> Jacob
> 
>> Below APIs are added:
>>
>> * iommu_pasid_init(pasid)
>>   - Initialize a PASID consumer. The vendor specific IOMMU
>>     drivers are able to set the PASID range imposed by IOMMU
>>     hardware through a callback in iommu_ops.
>>
>> * iommu_pasid_exit(pasid)
>>   - The PASID consumer stops consuming any PASID.
>>
>> * iommu_pasid_alloc(pasid, min, max, private, *ioasid)
>>   - Allocate a PASID and associate a @private data with this
>>     PASID. The PASID value is stored in @ioaisd if returning
>>     success.
>>
>> * iommu_pasid_free(pasid, ioasid)
>>   - Free a PASID to the pool so that it could be consumed by
>>     others.
>>
>> This also adds below helpers to lookup or iterate PASID items
>> associated with a consumer.
>>
>> * iommu_pasid_for_each(pasid, func, data)
>>   - Iterate PASID items of the consumer identified by @pasid,
>>     and call @func() against each item. An error returned from
>>     @func() will break the iteration.
>>
>> * iommu_pasid_find(pasid, ioasid)
>>   - Retrieve the private data associated with @ioasid.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>  drivers/iommu/Kconfig |  1 +
>>  drivers/iommu/iommu.c | 89
>> +++++++++++++++++++++++++++++++++++++++++++ include/linux/iommu.h |
>> 73 +++++++++++++++++++++++++++++++++++ 3 files changed, 163
>> insertions(+)
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index d9a25715650e..39f2bb76c7b8 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -1,6 +1,7 @@
>>  # IOMMU_API always gets selected by whoever wants it.
>>  config IOMMU_API
>>  	bool
>> +	select IOASID
>>  
>>  menuconfig IOMMU_SUPPORT
>>  	bool "IOMMU Hardware Support"
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 0b7c96d1425e..570b244897bb 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2082,3 +2082,92 @@ void iommu_detach_device_aux(struct
>> iommu_domain *domain, struct device *dev) }
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_detach_device_aux);
>> +
>> +/*
>> + * APIs for PASID used by IOMMU and the device drivers which depend
>> + * on IOMMU.
>> + */
>> +struct iommu_pasid *iommu_pasid_init(struct bus_type *bus)
>> +{
>> +	struct iommu_pasid *pasid;
>> +	int ret;
>> +
>> +	if (!bus || !bus->iommu_ops)
>> +		return NULL;
>> +
>> +	pasid = kzalloc(sizeof(*pasid), GFP_KERNEL);
>> +	if (!pasid)
>> +		return NULL;
>> +
>> +	pasid->ops = bus->iommu_ops;
>> +	/*
>> +	 * The default range of an IOMMU PASID is from 0 to the full
>> +	 * 20bit integer.
>> +	 */
>> +	pasid->min = 0;
>> +	pasid->max = 0x100000;
>> +	/*
>> +	 * Give vendor specific iommu drivers a chance to set the
>> pasid
>> +	 * limits imposed by the iommu hardware.
>> +	 */
>> +	if (bus->iommu_ops->pasid_init) {
>> +		ret = bus->iommu_ops->pasid_init(pasid);
>> +		if (ret) {
>> +			kfree(pasid);
>> +			return NULL;
>> +		}
>> +	}
>> +
>> +	return pasid;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_pasid_init);
>> +
>> +void iommu_pasid_exit(struct iommu_pasid *pasid)
>> +{
>> +	kfree(pasid);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_pasid_exit);
>> +
>> +int iommu_pasid_alloc(struct iommu_pasid *pasid, ioasid_t min,
>> +		      ioasid_t max, void *private, ioasid_t *ioasid)
>> +{
>> +	ioasid_t start, end, hw, val;
>> +	int ret = -EAGAIN;
>> +
>> +	start = max_t(int, min, pasid->min);
>> +	end = min_t(int, max, pasid->max);
>> +
>> +	if (pasid->ops->pasid_alloc)
>> +		ret = pasid->ops->pasid_alloc(pasid, start, end,
>> &hw); +
>> +	if (ret == -EAGAIN)
>> +                val = ioasid_alloc(&pasid->set, start, end, private);
>> +	else if (ret == 0)
>> +		val = ioasid_alloc(&pasid->set, hw, hw + 1, private);
> this may fail due to conflict with other callers of ioasic_alloc(), but
> we should really respect the iommu ops allocator. If we move the
> pasid_alloc op into ioasid code, then we don't need to worry about the
> conflict.
>> +	else
>> +		goto hw_ret;
>> +
>> +	if (val == INVALID_IOASID)
>> +		goto ioasid_ret;
>> +
>> +	*ioasid = val;
>> +
>> +        return 0;
>> +
>> +ioasid_ret:
>> +	if (pasid->ops->pasid_free)
>> +		pasid->ops->pasid_free(pasid, hw);
>> +
>> +hw_ret:
>> +	return -ENODEV;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_pasid_alloc);
>> +
>> +void iommu_pasid_free(struct iommu_pasid *pasid, ioasid_t ioasid)
>> +{
>> +	if (pasid->ops->pasid_free)
>> +		pasid->ops->pasid_free(pasid, ioasid);
>> +
>> +	ioasid_free(ioasid);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_pasid_free);
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 9bf1b3f2457a..4f5202c8170b 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -20,6 +20,7 @@
>>  #define __LINUX_IOMMU_H
>>  
>>  #include <linux/scatterlist.h>
>> +#include <linux/ioasid.h>
>>  #include <linux/device.h>
>>  #include <linux/types.h>
>>  #include <linux/errno.h>
>> @@ -48,6 +49,7 @@ struct bus_type;
>>  struct device;
>>  struct iommu_domain;
>>  struct notifier_block;
>> +struct iommu_pasid;
>>  
>>  /* iommu fault flags */
>>  #define IOMMU_FAULT_READ	0x0
>> @@ -194,6 +196,9 @@ enum iommu_dev_attr {
>>   * @of_xlate: add OF master IDs to iommu grouping
>>   * @get_dev_attr: get per device IOMMU attributions
>>   * @set_dev_attr: set per device IOMMU attributions
>> + * @pasid_init: initialize a pasid consumer
>> + * @pasid_alloc: allocate a pasid from low level driver
>> + * @pasid_free: free a pasid to low level driver
>>   * @pgsize_bitmap: bitmap of all possible supported page sizes
>>   */
>>  struct iommu_ops {
>> @@ -246,6 +251,12 @@ struct iommu_ops {
>>  	int (*attach_dev_aux)(struct iommu_domain *domain, struct
>> device *dev); void (*detach_dev_aux)(struct iommu_domain *domain,
>> struct device *dev); 
>> +	/* IOMMU pasid callbacks */
>> +	int (*pasid_init)(struct iommu_pasid *pasid);
>> +	int (*pasid_alloc)(struct iommu_pasid *pasid, ioasid_t start,
>> +			   ioasid_t end, ioasid_t *ioasid);
>> +	void (*pasid_free)(struct iommu_pasid *pasid, ioasid_t
>> ioasid); +
>>  	unsigned long pgsize_bitmap;
>>  };
>>  
>> @@ -428,12 +439,41 @@ extern int iommu_attach_device_aux(struct
>> iommu_domain *domain, extern void iommu_detach_device_aux(struct
>> iommu_domain *domain, struct device *dev);
>>  
>> +/*
>> + * Per IOMMU PASID consumer data.
>> + */
>> +struct iommu_pasid {
>> +	ioasid_t		max;
>> +	ioasid_t		min;
>> +	struct ioasid_set	set;
>> +	const struct iommu_ops	*ops;
>> +
>> +	/* vendor specific iommu private data */
>> +	void			*priv;
>> +};
>> +
>> +struct iommu_pasid *iommu_pasid_init(struct bus_type *bus);
>> +void iommu_pasid_exit(struct iommu_pasid *pasid);
>> +int iommu_pasid_alloc(struct iommu_pasid *pasid, ioasid_t min,
>> +		      ioasid_t max, void *private, ioasid_t *ioasid);
>> +void iommu_pasid_free(struct iommu_pasid *pasid, ioasid_t iosid);
>> +static inline int
>> +iommu_pasid_for_each(struct iommu_pasid *pasid, ioasid_iter_t func,
>> void *data) +{
>> +	return ioasid_for_each(&pasid->set, func, data);
>> +}
>> +static inline void*
>> +iommu_pasid_find(struct iommu_pasid *pasid, ioasid_t ioasid)
>> +{
>> +	return ioasid_find(&pasid->set, ioasid);
>> +}
>>  #else /* CONFIG_IOMMU_API */
>>  
>>  struct iommu_ops {};
>>  struct iommu_group {};
>>  struct iommu_fwspec {};
>>  struct iommu_device {};
>> +struct iommu_pasid {};
>>  
>>  static inline bool iommu_present(struct bus_type *bus)
>>  {
>> @@ -734,6 +774,39 @@ static inline void
>>  iommu_detach_device_aux(struct iommu_domain *domain, struct device
>> *dev) {
>>  }
>> +
>> +static inline struct iommu_pasid *
>> +iommu_pasid_init(struct bus_type *bus)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline void iommu_pasid_exit(struct iommu_pasid *pasid)
>> +{
>> +}
>> +
>> +static inline int
>> +iommu_pasid_alloc(struct iommu_pasid *pasid, ioasid_t min,
>> +		  ioasid_t max, void *private, ioasid_t *ioasid)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline void iommu_pasid_free(struct iommu_pasid *pasid,
>> ioasid_t iosid) +{
>> +}
>> +
>> +static inline int
>> +iommu_pasid_for_each(struct iommu_pasid *pasid, ioasid_iter_t func,
>> void *data) +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline void*
>> +iommu_pasid_find(struct iommu_pasid *pasid, ioasid_t ioasid)
>> +{
>> +	return NULL;
>> +}
>>  #endif /* CONFIG_IOMMU_API */
>>  
>>  #ifdef CONFIG_IOMMU_DEBUGFS
> 
> [Jacob Pan]
> 

