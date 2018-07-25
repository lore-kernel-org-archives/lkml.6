Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6F8C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F7520843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F7520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbeGYUdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:33:10 -0400
Received: from foss.arm.com ([217.140.101.70]:43544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbeGYUdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:33:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DBB8ED1;
        Wed, 25 Jul 2018 12:20:07 -0700 (PDT)
Received: from ostrya.localdomain (ostrya.Emea.Arm.com [10.4.12.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B63893F6A8;
        Wed, 25 Jul 2018 12:20:04 -0700 (PDT)
Date:   Wed, 25 Jul 2018 20:19:53 +0100
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: Re: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated
 devices
Message-ID: <a530c220-9bf1-05ec-5698-526ccbea127f@arm.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
 <1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
 <5B568D5B.5050606@linux.intel.com>
 <ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19127FB9E@SHSMSX101.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19127FF05@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19127FF05@SHSMSX101.ccr.corp.intel.com>
FCC:    imap://jeabru01@foss.arm.com/Sent
X-Identity-Key: id3
X-Account-Key: account4
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=4
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/18 07:19, Tian, Kevin wrote:
>> From: Tian, Kevin
>> Sent: Wednesday, July 25, 2018 10:16 AM
>>
> [...]
>>>
>>> There is another way: as we're planning to add a generic pasid_alloc()
>>> function to the IOMMU API, the mdev module itself could allocate a
>>> default PASID for each mdev by calling pasid_alloc() on the mdev's
>>> parent, and then do map()/unmap() with that PASID. This way we don't
>>> have to add IOMMU ops to the mdev bus, everything can still be done
>>> using the ops of the parent. And IOMMU drivers "only" have to
>> implement
>>> PASID ops, which will be reused by drivers other than mdev.
>>
>> yes, PASID is more general abstraction than mdev. However there is
>> one problem. Please note with new scalable mode now PASID is not
>> used just for SVA. You can do 1st-level, 2nd-level and nested in PASID
>> granularity, meaning each PASID can be bound to an unique iommu
>> domain. However today IOMMU driver allows only one iommu_domain
>> per device. If we simply install allocated PASID to parent device, we
>> should also remove that iommu_domain limitation. Is it the way that
>> we want to pursue?
>>
>> mdev avoids such problem as it introduces a separate device...
> 
> another thing to think about is to simplify the caller logic. It would
> be good to have consistent IOMMU APIs cross PCI device and 
> mdev, for common VFIO operations e.g. map/unmap, iommu_
> attach_group, etc. If we need special version ops with PASID, it 
> brings burden to VFIO and other IOMMU clients...

Yes, providing special ops is the simplest to implement (or least
invasive, I guess) but isn't particularly elegant. See the patch from
Jordan below, that I was planning to add to the SVA series (I'm
laboriously working towards next version) and my email from last week:
https://patchwork.kernel.org/patch/10412251/

Whenever I come back to hierarchical IOMMU domains I reject it as too
complicated, but maybe that is what we need. I find it difficult to
reason about because domains currently represent both a collection of
devices and a one or more address spaces. I proposed the io_mm thing to
represent a single address space, and to avoid adding special cases to
every function in the IOMMU subsystem that manipulates domains.

> For IOMMU-capable mdev, there are two use cases which have 
> been talked so far:
> 
> 1) mdev with PASID-granular DMA isolation
> 2) mdev inheriting RID from parent device (no sharing)

Would that be a single mdev per parent device? Otherwise I don't really
understand how it would work without all map/unmap operations going to
the parent device's driver.

> 1) is what this RFC is currently for. 2) is what Alex concerned 
> which is not covered in RFC yet.
> 
> In my mind, an ideal design is like below:
> 
> a) VFIO provides an interface for parent driver to specify 
> whether a mdev is IOMMU capable, with flag to indicate 
> whether it's PASID-granular or RID-inherit;
> 
> b) Once an IOMMU-capable mdev is created, VFIO treats it no
> different from normal physical devices, using exactly same 
> IOMMU APIs to operate (including future SVA). VFIO doesn't 
> care whether PASID or RID will be used in hardware;
> 
> c) IOMMU driver then handle RID/PASID difference internally, 
> based on its own configuration and mdev type.
> 
> To support above goal, I feel a new device handle is a nice fit 
> to represent mdev within IOMMU driver, with same set of 
> capabilities as observed on its parent device.

It's a good abstraction, but I'm still concerned about other users of
PASID-granular DMA isolation, for example GPU drivers wanting to improve
isolation of DMA bufs, will want the same functionality without going
through the vfio-mdev module.

The IOMMU operations we care about don't take a device handle, I think,
just a domain. And VFIO itself only deals with domains when doing
map/unmap. Maybe we could add this operation to the IOMMU subsystem:

child_domain = domain_create_child(parent_dev, parent_domain)

A child domain would be a smaller isolation granule, getting a PASID if
that's what the IOMMU implements or another mechanism for 2). It is
automatically attached to its parent's devices, so attach/detach
operations wouldn't be necessary on the child.

Depending on the underlying architecture the child domain can support
map/unmap on a single stage, or map/unmap for 2nd level and bind_pgtable
for 1st level.

I'm not sure how this works for host SVA though. I think the
sva_bind_dev() API could stay the same, but the internals will need
to change.

Thanks,
Jean

-----
I was going to send the following patch for dealing with private PASIDs.
I used it for a vfio-mdev prototype internally: VFIO would call
iommu_sva_alloc_pasid on the parent device and then sva_map/sva_unmap on
the parent domain + allocated io_mm (which redirects to
iommu_map/iommu_unmap when there is no io_mm). Since it relies on io_mm
instead of child domains, it duplicates the iommu ops, and as discussed
might not be adapted to Vt-d scalable mode.

Subject: [PATCH] iommu: sva: Add support for private PASIDs

Provide an API for allocating PASIDs and populating them manually. To ease
cleanup and factor allocation code, reuse the io_mm structure for private
PASID. Private io_mm has a NULL mm_struct pointer, and cannot be bound to
multiple devices. The mm_alloc() IOMMU op must now check if the mm
argument is NULL, in which case it should allocate io_pgtables instead of
binding to an mm.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu-sva.c | 211 +++++++++++++++++++++++++++++++++-----
 drivers/iommu/iommu.c     |  49 ++++++---
 include/linux/iommu.h     | 118 +++++++++++++++++++--
 3 files changed, 331 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 35d0f387fbef..12c9b861014d 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -15,11 +15,11 @@
 /**
  * DOC: io_mm model
  *
- * The io_mm keeps track of process address spaces shared between CPU and
IOMMU.
- * The following example illustrates the relation between structures
- * iommu_domain, io_mm and iommu_bond. An iommu_bond is a link between
io_mm and
- * device. A device can have multiple io_mm and an io_mm may be bound to
- * multiple devices.
+ * When used with the bind()/unbind() functions, the io_mm keeps track of
+ * process address spaces shared between CPU and IOMMU. The following example
+ * illustrates the relation between structures iommu_domain, io_mm and
+ * iommu_bond. An iommu_bond is a link between io_mm and device. A device can
+ * have multiple io_mm and an io_mm may be bound to multiple devices.
  *              ___________________________
  *             |  IOMMU domain A           |
  *             |  ________________         |
@@ -97,6 +97,12 @@
  * non-PASID translations. In this case PASID 0 is reserved and entry 0
points
  * to the io_pgtable base. On Intel IOMMU, the io_pgtable base would be
held in
  * the device table and PASID 0 would be available to the allocator.
+ *
+ * The io_mm can also represent a private IOMMU address space, which isn't
+ * shared with a process. The device driver calls iommu_sva_alloc_pasid which
+ * returns an io_mm that can be populated with the iommu_sva_map/unmap
+ * functions. The principle is the same as shared io_mm, except that a
private
+ * io_mm cannot be bound to multiple devices.
  */

 struct iommu_bond {
@@ -130,6 +136,9 @@ static DEFINE_SPINLOCK(iommu_sva_lock);

 static struct mmu_notifier_ops iommu_mmu_notifier;

+#define io_mm_is_private(io_mm) ((io_mm) != NULL && (io_mm)->mm == NULL)
+#define io_mm_is_shared(io_mm) ((io_mm) != NULL && (io_mm)->mm != NULL)
+
 static struct io_mm *
 io_mm_alloc(struct iommu_domain *domain, struct device *dev,
 	    struct mm_struct *mm, unsigned long flags)
@@ -148,19 +157,10 @@ io_mm_alloc(struct iommu_domain *domain, struct
device *dev,
 	if (!io_mm)
 		return ERR_PTR(-ENOMEM);

-	/*
-	 * The mm must not be freed until after the driver frees the io_mm
-	 * (which may involve unpinning the CPU ASID for instance, requiring a
-	 * valid mm struct.)
-	 */
-	mmgrab(mm);
-
 	io_mm->flags		= flags;
 	io_mm->mm		= mm;
-	io_mm->notifier.ops	= &iommu_mmu_notifier;
 	io_mm->release		= domain->ops->mm_free;
 	INIT_LIST_HEAD(&io_mm->devices);
-	/* Leave kref to zero until the io_mm is fully initialized */

 	idr_preload(GFP_KERNEL);
 	spin_lock(&iommu_sva_lock);
@@ -175,6 +175,32 @@ io_mm_alloc(struct iommu_domain *domain, struct
device *dev,
 		goto err_free_mm;
 	}

+	return io_mm;
+
+err_free_mm:
+	io_mm->release(io_mm);
+	return ERR_PTR(ret);
+}
+
+static struct io_mm *
+io_mm_alloc_shared(struct iommu_domain *domain, struct device *dev,
+		   struct mm_struct *mm, unsigned long flags)
+{
+	int ret;
+	struct io_mm *io_mm;
+
+	io_mm = io_mm_alloc(domain, dev, mm, flags);
+	if (IS_ERR(io_mm))
+		return io_mm;
+
+	/*
+	 * The mm must not be freed until after the driver frees the io_mm
+	 * (which may involve unpinning the CPU ASID for instance, requiring a
+	 * valid mm struct.)
+	 */
+	mmgrab(mm);
+
+	io_mm->notifier.ops = &iommu_mmu_notifier;
 	ret = mmu_notifier_register(&io_mm->notifier, mm);
 	if (ret)
 		goto err_free_pasid;
@@ -202,7 +228,6 @@ io_mm_alloc(struct iommu_domain *domain, struct device
*dev,
 	idr_remove(&iommu_pasid_idr, io_mm->pasid);
 	spin_unlock(&iommu_sva_lock);

-err_free_mm:
 	io_mm->release(io_mm);
 	mmdrop(mm);

@@ -231,6 +256,11 @@ static void io_mm_release(struct kref *kref)
 	/* The PASID can now be reallocated for another mm. */
 	idr_remove(&iommu_pasid_idr, io_mm->pasid);

+	if (io_mm_is_private(io_mm)) {
+		io_mm->release(io_mm);
+		return;
+	}
+
 	/*
 	 * If we're being released from mm exit, the notifier callback ->release
 	 * has already been called. Otherwise we don't need ->release, the io_mm
@@ -258,7 +288,7 @@ static int io_mm_get_locked(struct io_mm *io_mm)
 	if (io_mm && kref_get_unless_zero(&io_mm->kref)) {
 		/*
 		 * kref_get_unless_zero doesn't provide ordering for reads. This
-		 * barrier pairs with the one in io_mm_alloc.
+		 * barrier pairs with the one in io_mm_alloc_shared.
 		 */
 		smp_rmb();
 		return 1;
@@ -289,7 +319,7 @@ static int io_mm_attach(struct iommu_domain *domain,
struct device *dev,
 	struct iommu_sva_param *param = dev->iommu_param->sva_param;

 	if (!domain->ops->mm_attach || !domain->ops->mm_detach ||
-	    !domain->ops->mm_invalidate)
+	    (io_mm_is_shared(io_mm) && !domain->ops->mm_invalidate))
 		return -ENODEV;

 	if (pasid > param->max_pasid || pasid < param->min_pasid)
@@ -550,7 +580,7 @@ int iommu_sva_device_init(struct device *dev, unsigned
long features,
 	struct iommu_sva_param *param;
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);

-	if (!domain || !domain->ops->sva_device_init)
+	if (!domain)
 		return -ENODEV;

 	if (features & ~IOMMU_SVA_FEAT_IOPF)
@@ -584,9 +614,11 @@ int iommu_sva_device_init(struct device *dev,
unsigned long features,
 	 * IOMMU driver updates the limits depending on the IOMMU and device
 	 * capabilities.
 	 */
-	ret = domain->ops->sva_device_init(dev, param);
-	if (ret)
-		goto err_free_param;
+	if (domain->ops->sva_device_init) {
+		ret = domain->ops->sva_device_init(dev, param);
+		if (ret)
+			goto err_free_param;
+	}

 	dev->iommu_param->sva_param = param;
 	mutex_unlock(&dev->iommu_param->lock);
@@ -688,7 +720,7 @@ int __iommu_sva_bind_device(struct device *dev, struct
mm_struct *mm,
 	}

 	if (!io_mm) {
-		io_mm = io_mm_alloc(domain, dev, mm, flags);
+		io_mm = io_mm_alloc_shared(domain, dev, mm, flags);
 		if (IS_ERR(io_mm))
 			return PTR_ERR(io_mm);
 	}
@@ -723,6 +755,9 @@ int __iommu_sva_unbind_device(struct device *dev, int
pasid)
 	/* spin_lock_irq matches the one in wait_event_lock_irq */
 	spin_lock_irq(&iommu_sva_lock);
 	list_for_each_entry(bond, &param->mm_list, dev_head) {
+		if (io_mm_is_private(bond->io_mm))
+			continue;
+
 		if (bond->io_mm->pasid == pasid) {
 			io_mm_detach_locked(bond, true);
 			ret = 0;
@@ -765,6 +800,136 @@ void __iommu_sva_unbind_dev_all(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(__iommu_sva_unbind_dev_all);

+/*
+ * iommu_sva_alloc_pasid - Allocate a private PASID
+ *
+ * Allocate a PASID for private map/unmap operations. Create a new I/O
address
+ * space for this device, that isn't bound to any process.
+ *
+ * iommu_sva_device_init must have been called first.
+ */
+int iommu_sva_alloc_pasid(struct device *dev, struct io_mm **out)
+{
+	int ret;
+	struct io_mm *io_mm;
+	struct iommu_domain *domain;
+	struct iommu_sva_param *param = dev->iommu_param->sva_param;
+
+	if (!out || !param)
+		return -EINVAL;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (!domain)
+		return -EINVAL;
+
+	io_mm = io_mm_alloc(domain, dev, NULL, 0);
+	if (IS_ERR(io_mm))
+		return PTR_ERR(io_mm);
+
+	kref_init(&io_mm->kref);
+
+	ret = io_mm_attach(domain, dev, io_mm, NULL);
+	if (ret) {
+		io_mm_put(io_mm);
+		return ret;
+	}
+
+	*out = io_mm;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
+
+void iommu_sva_free_pasid(struct device *dev, struct io_mm *io_mm)
+{
+	struct iommu_bond *bond;
+
+	if (WARN_ON(io_mm_is_shared(io_mm)))
+		return;
+
+	spin_lock(&iommu_sva_lock);
+	list_for_each_entry(bond, &io_mm->devices, mm_head) {
+		if (bond->dev == dev) {
+			io_mm_detach_locked(bond, false);
+			break;
+		}
+	}
+	spin_unlock(&iommu_sva_lock);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
+
+int iommu_sva_map(struct iommu_domain *domain, struct io_mm *io_mm,
+		  unsigned long iova, phys_addr_t paddr, size_t size, int prot)
+{
+	if (WARN_ON(io_mm_is_shared(io_mm)))
+		return -ENODEV;
+
+	return __iommu_map(domain, io_mm, iova, paddr, size, prot);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_map);
+
+size_t iommu_sva_map_sg(struct iommu_domain *domain, struct io_mm *io_mm,
+			unsigned long iova, struct scatterlist *sg,
+			unsigned int nents, int prot)
+{
+	if (WARN_ON(io_mm_is_shared(io_mm)))
+		return -ENODEV;
+
+	return domain->ops->map_sg(domain, io_mm, iova, sg, nents, prot);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_map_sg);
+
+size_t iommu_sva_unmap(struct iommu_domain *domain, struct io_mm *io_mm,
+		       unsigned long iova, size_t size)
+{
+	if (WARN_ON(io_mm_is_shared(io_mm)))
+		return 0;
+
+	return __iommu_unmap(domain, io_mm, iova, size, true);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unmap);
+
+size_t iommu_sva_unmap_fast(struct iommu_domain *domain, struct io_mm *io_mm,
+			    unsigned long iova, size_t size)
+{
+	if (WARN_ON(io_mm_is_shared(io_mm)))
+		return 0;
+
+	return __iommu_unmap(domain, io_mm, iova, size, false);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unmap_fast);
+
+phys_addr_t iommu_sva_iova_to_phys(struct iommu_domain *domain,
+				   struct io_mm *io_mm, dma_addr_t iova)
+{
+	if (!io_mm)
+		return iommu_iova_to_phys(domain, iova);
+
+	if (WARN_ON(io_mm_is_shared(io_mm)))
+		return 0;
+
+	if (unlikely(domain->ops->sva_iova_to_phys == NULL))
+		return 0;
+
+	return domain->ops->sva_iova_to_phys(domain, io_mm, iova);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_iova_to_phys);
+
+void iommu_sva_tlb_range_add(struct iommu_domain *domain, struct io_mm
*io_mm,
+			     unsigned long iova, size_t size)
+{
+	if (!io_mm) {
+		iommu_tlb_range_add(domain, iova, size);
+		return;
+	}
+
+	if (WARN_ON(io_mm_is_shared(io_mm)))
+		return;
+
+	if (domain->ops->sva_iotlb_range_add != NULL)
+		domain->ops->sva_iotlb_range_add(domain, io_mm, iova, size);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_tlb_range_add);
+
 /**
  * iommu_sva_find() - Find mm associated to the given PASID
  * @pasid: Process Address Space ID assigned to the mm
@@ -779,7 +944,7 @@ struct mm_struct *iommu_sva_find(int pasid)

 	spin_lock(&iommu_sva_lock);
 	io_mm = idr_find(&iommu_pasid_idr, pasid);
-	if (io_mm && io_mm_get_locked(io_mm)) {
+	if (io_mm_is_shared(io_mm) && io_mm_get_locked(io_mm)) {
 		if (mmget_not_zero(io_mm->mm))
 			mm = io_mm->mm;

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b02e1d32c733..26ac9b2a813e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1816,8 +1816,8 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 	return pgsize;
 }

-int iommu_map(struct iommu_domain *domain, unsigned long iova,
-	      phys_addr_t paddr, size_t size, int prot)
+int __iommu_map(struct iommu_domain *domain, struct io_mm *io_mm,
+		unsigned long iova, phys_addr_t paddr, size_t size, int prot)
 {
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
@@ -1825,7 +1825,8 @@ int iommu_map(struct iommu_domain *domain, unsigned
long iova,
 	phys_addr_t orig_paddr = paddr;
 	int ret = 0;

-	if (unlikely(domain->ops->map == NULL ||
+	if (unlikely((!io_mm && domain->ops->map == NULL) ||
+		     (io_mm && domain->ops->sva_map == NULL) ||
 		     domain->pgsize_bitmap == 0UL))
 		return -ENODEV;

@@ -1854,7 +1855,12 @@ int iommu_map(struct iommu_domain *domain, unsigned
long iova,
 		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
 			 iova, &paddr, pgsize);

-		ret = domain->ops->map(domain, iova, paddr, pgsize, prot);
+		if (io_mm)
+			ret = domain->ops->sva_map(domain, io_mm, iova, paddr,
+						   pgsize, prot);
+		else
+			ret = domain->ops->map(domain, iova, paddr, pgsize,
+					       prot);
 		if (ret)
 			break;

@@ -1865,24 +1871,30 @@ int iommu_map(struct iommu_domain *domain,
unsigned long iova,

 	/* unroll mapping in case something went wrong */
 	if (ret)
-		iommu_unmap(domain, orig_iova, orig_size - size);
+		__iommu_unmap(domain, io_mm, orig_iova, orig_size - size, true);
 	else
 		trace_map(orig_iova, orig_paddr, orig_size);

 	return ret;
 }
+
+int iommu_map(struct iommu_domain *domain, unsigned long iov,
+	      phys_addr_t paddr, size_t size, int prot)
+{
+	return __iommu_map(domain, NULL, iov, paddr, size, prot);
+}
 EXPORT_SYMBOL_GPL(iommu_map);

-static size_t __iommu_unmap(struct iommu_domain *domain,
-			    unsigned long iova, size_t size,
-			    bool sync)
+size_t __iommu_unmap(struct iommu_domain *domain, struct io_mm *io_mm,
+		     unsigned long iova, size_t size, bool sync)
 {
 	const struct iommu_ops *ops = domain->ops;
 	size_t unmapped_page, unmapped = 0;
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;

-	if (unlikely(ops->unmap == NULL ||
+	if (unlikely((!io_mm && ops->unmap == NULL) ||
+		     (io_mm && ops->sva_unmap == NULL) ||
 		     domain->pgsize_bitmap == 0UL))
 		return 0;

@@ -1912,7 +1924,11 @@ static size_t __iommu_unmap(struct iommu_domain
*domain,
 	while (unmapped < size) {
 		size_t pgsize = iommu_pgsize(domain, iova, size - unmapped);

-		unmapped_page = ops->unmap(domain, iova, pgsize);
+		if (io_mm)
+			unmapped_page = ops->sva_unmap(domain, io_mm, iova,
+						       pgsize);
+		else
+			unmapped_page = ops->unmap(domain, iova, pgsize);
 		if (!unmapped_page)
 			break;

@@ -1936,19 +1952,20 @@ static size_t __iommu_unmap(struct iommu_domain
*domain,
 size_t iommu_unmap(struct iommu_domain *domain,
 		   unsigned long iova, size_t size)
 {
-	return __iommu_unmap(domain, iova, size, true);
+	return __iommu_unmap(domain, NULL, iova, size, true);
 }
 EXPORT_SYMBOL_GPL(iommu_unmap);

 size_t iommu_unmap_fast(struct iommu_domain *domain,
 			unsigned long iova, size_t size)
 {
-	return __iommu_unmap(domain, iova, size, false);
+	return __iommu_unmap(domain, NULL, iova, size, false);
 }
 EXPORT_SYMBOL_GPL(iommu_unmap_fast);

-size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
-			 struct scatterlist *sg, unsigned int nents, int prot)
+size_t default_iommu_map_sg(struct iommu_domain *domain, struct io_mm *io_mm,
+			    unsigned long iova, struct scatterlist *sg, unsigned
+			    int nents, int prot)
 {
 	struct scatterlist *s;
 	size_t mapped = 0;
@@ -1972,7 +1989,7 @@ size_t default_iommu_map_sg(struct iommu_domain
*domain, unsigned long iova,
 		if (!IS_ALIGNED(s->offset, min_pagesz))
 			goto out_err;

-		ret = iommu_map(domain, iova + mapped, phys, s->length, prot);
+		ret = __iommu_map(domain, io_mm, iova + mapped, phys, s->length, prot);
 		if (ret)
 			goto out_err;

@@ -1983,7 +2000,7 @@ size_t default_iommu_map_sg(struct iommu_domain
*domain, unsigned long iova,

 out_err:
 	/* undo mappings already done */
-	iommu_unmap(domain, iova, mapped);
+	__iommu_unmap(domain, io_mm, iova, mapped, true);

 	return 0;

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b525f5636df8..1f63a8691173 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -248,13 +248,17 @@ struct iommu_sva_param {
  * @mm_invalidate: Invalidate a range of mappings for an mm
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
+ * @sva_map: map a physically contiguous memory region to an address space
+ * @sva_unmap: unmap a physically contiguous memory region from an
address space
  * @map_sg: map a scatter-gather list of physically contiguous memory chunks
  *          to an iommu domain
  * @flush_tlb_all: Synchronously flush all hardware TLBs for this domain
  * @tlb_range_add: Add a given iova range to the flush queue for this domain
+ * @sva_iotlb_range_add: Add a given iova range to the flush queue for
this mm
  * @tlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
  * @iova_to_phys: translate iova to physical address
+ * @sva_iova_to_phys: translate iova to physical address
  * @add_device: add device to iommu grouping
  * @remove_device: remove device from iommu grouping
  * @device_group: find iommu group for a particular device
@@ -302,13 +306,24 @@ struct iommu_ops {
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
 		     size_t size);
-	size_t (*map_sg)(struct iommu_domain *domain, unsigned long iova,
-			 struct scatterlist *sg, unsigned int nents, int prot);
+	int (*sva_map)(struct iommu_domain *domain, struct io_mm *io_mm,
+		       unsigned long iova, phys_addr_t paddr, size_t size,
+		       int prot);
+	size_t (*sva_unmap)(struct iommu_domain *domain, struct io_mm *io_mm,
+			    unsigned long iova, size_t size);
+	size_t (*map_sg)(struct iommu_domain *domain, struct io_mm *io_mm,
+			 unsigned long iova, struct scatterlist *sg,
+			 unsigned int nents, int prot);
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
 	void (*iotlb_range_add)(struct iommu_domain *domain,
 				unsigned long iova, size_t size);
+	void (*sva_iotlb_range_add)(struct iommu_domain *domain,
+				    struct io_mm *io_mm, unsigned long iova,
+				    size_t size);
 	void (*iotlb_sync)(struct iommu_domain *domain);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
+	phys_addr_t (*sva_iova_to_phys)(struct iommu_domain *domain,
+					struct io_mm *io_mm, dma_addr_t iova);
 	int (*add_device)(struct device *dev);
 	void (*remove_device)(struct device *dev);
 	struct iommu_group *(*device_group)(struct device *dev);
@@ -528,15 +543,20 @@ extern int iommu_sva_invalidate(struct iommu_domain
*domain,
 		struct device *dev, struct tlb_invalidate_info *inv_info);

 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
+extern int __iommu_map(struct iommu_domain *domain, struct io_mm *io_mm,
+		       unsigned long iova, phys_addr_t paddr, size_t size,
+		       int prot);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
+extern size_t __iommu_unmap(struct iommu_domain *domain, struct io_mm *io_mm,
+			    unsigned long iova, size_t size, bool sync);
 extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 			  size_t size);
 extern size_t iommu_unmap_fast(struct iommu_domain *domain,
 			       unsigned long iova, size_t size);
-extern size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned
long iova,
-				struct scatterlist *sg,unsigned int nents,
-				int prot);
+extern size_t default_iommu_map_sg(struct iommu_domain *domain, struct
io_mm *io_mm,
+				   unsigned long iova, struct scatterlist *sg,
+				   unsigned int nents, int prot);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain,
dma_addr_t iova);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
@@ -622,7 +642,7 @@ static inline size_t iommu_map_sg(struct iommu_domain
*domain,
 				  unsigned long iova, struct scatterlist *sg,
 				  unsigned int nents, int prot)
 {
-	return domain->ops->map_sg(domain, iova, sg, nents, prot);
+	return domain->ops->map_sg(domain, NULL, iova, sg, nents, prot);
 }

 /* PCI device grouping function */
@@ -710,12 +730,25 @@ static inline struct iommu_domain
*iommu_get_domain_for_dev(struct device *dev)
 	return NULL;
 }

+static inline int __iommu_map(struct iommu_domain *domain, struct io_mm
*io_mm,
+			      unsigned long iova, phys_addr_t paddr,
+			      size_t size, int prot)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_map(struct iommu_domain *domain, unsigned long iova,
 			    phys_addr_t paddr, size_t size, int prot)
 {
 	return -ENODEV;
 }

+static inline size_t __iommu_unmap(struct iommu_domain *domain, struct
io_mm *io_mm,
+		     unsigned long iova, size_t size, bool sync)
+{
+	return 0;
+}
+
 static inline size_t iommu_unmap(struct iommu_domain *domain,
 				 unsigned long iova, size_t size)
 {
@@ -729,8 +762,9 @@ static inline size_t iommu_unmap_fast(struct
iommu_domain *domain,
 }

 static inline size_t iommu_map_sg(struct iommu_domain *domain,
-				  unsigned long iova, struct scatterlist *sg,
-				  unsigned int nents, int prot)
+				  struct io_mm *io_mm, unsigned long iova,
+				  struct scatterlist *sg, unsigned int nents,
+				  int prot)
 {
 	return 0;
 }
@@ -1017,6 +1051,22 @@ extern int __iommu_sva_bind_device(struct device
*dev, struct mm_struct *mm,
 extern int __iommu_sva_unbind_device(struct device *dev, int pasid);
 extern void __iommu_sva_unbind_dev_all(struct device *dev);

+int iommu_sva_alloc_pasid(struct device *dev, struct io_mm **io_mm);
+void iommu_sva_free_pasid(struct device *dev, struct io_mm *io_mm);
+
+int iommu_sva_map(struct iommu_domain *domain, struct io_mm *io_mm,
+		  unsigned long iova, phys_addr_t paddr, size_t size, int prot);
+size_t iommu_sva_map_sg(struct iommu_domain *domain, struct io_mm *io_mm,
+			unsigned long iova, struct scatterlist *sg,
+			unsigned int nents, int prot);
+size_t iommu_sva_unmap(struct iommu_domain *domain,
+		       struct io_mm *io_mm, unsigned long iova, size_t size);
+size_t iommu_sva_unmap_fast(struct iommu_domain *domain, struct io_mm *io_mm,
+			    unsigned long iova, size_t size);
+phys_addr_t iommu_sva_iova_to_phys(struct iommu_domain *domain,
+				   struct io_mm *io_mm, dma_addr_t iova);
+void iommu_sva_tlb_range_add(struct iommu_domain *domain, struct io_mm
*io_mm,
+			     unsigned long iova, size_t size);
 extern struct mm_struct *iommu_sva_find(int pasid);
 #else /* CONFIG_IOMMU_SVA */
 static inline int iommu_sva_device_init(struct device *dev,
@@ -1048,6 +1098,58 @@ static inline void
__iommu_sva_unbind_dev_all(struct device *dev)
 {
 }

+static inline struct io_mm *
+iommu_sva_alloc_pasid(struct iommu_domain *domain, struct device *dev)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void iommu_sva_free_pasid(struct io_mm *io_mm, struct
device *dev)
+{
+}
+
+static inline int iommu_sva_map(struct iommu_domain *domain,
+				struct io_mm *io_mm, unsigned long iova,
+				phys_addr_t paddr, size_t size, int prot)
+{
+	return -EINVAL;
+}
+
+static inline size_t iommu_sva_map_sg(struct iommu_domain *domain,
+				      struct io_mm *io_mm, unsigned long iova,
+				      struct scatterlist *sg,
+				      unsigned int nents, int prot)
+{
+	return 0;
+}
+
+static inline size_t iommu_sva_unmap(struct iommu_domain *domain,
+				     struct io_mm *io_mm, unsigned long iova,
+				     size_t size)
+{
+	return 0;
+}
+
+static inline size_t iommu_sva_unmap_fast(struct iommu_domain *domain,
+					  struct io_mm *io_mm,
+					  unsigned long iova, size_t size)
+{
+	return 0;
+}
+
+static inline phys_addr_t iommu_sva_iova_to_phys(struct iommu_domain *domain,
+						 struct io_mm *io_mm,
+						 dma_addr_t iova)
+{
+	return 0;
+}
+
+static inline void iommu_sva_tlb_range_add(struct iommu_domain *domain,
+					   struct io_mm *io_mm,
+					   unsigned long iova, size_t size)
+{
+}
+
 static inline struct mm_struct *iommu_sva_find(int pasid)
 {
 	return NULL;
-- 
2.18.0


