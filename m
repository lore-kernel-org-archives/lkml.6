Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC8BECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14DE20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14DE20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeIOCWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 22:22:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:17026 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbeIOCWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 22:22:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 14:06:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,374,1531810800"; 
   d="scan'208";a="90580670"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 14 Sep 2018 14:02:30 -0700
Date:   Fri, 14 Sep 2018 14:04:33 -0700
From:   Jacob Pan <jacob.jun.pan@intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        jacob.jun.pan@intel.com
Subject: Re: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
Message-ID: <20180914140433.6891a90c@jacob-builder>
In-Reply-To: <03d496b0-84c2-b3ca-5be5-d4540c6d8ec7@arm.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
        <380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
        <aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com>
        <3602f8c1-df17-4894-1bcc-4d779f9aa7fd@arm.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D191300D06@SHSMSX101.ccr.corp.intel.com>
        <03d496b0-84c2-b3ca-5be5-d4540c6d8ec7@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018 16:03:01 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 13/09/2018 01:19, Tian, Kevin wrote:
> >>> This is proposed for architectures which support finer granularity
> >>> second level translation with no impact on architectures which
> >>> only support Source ID or the similar granularity.  
> >>
> >> Just to be clear, in this paragraph you're only referring to the
> >> Nested/second-level translation for mdev, which is specific to vt-d
> >> rev3? Other architectures can still do first-level translation with
> >> PASID, to support some use-cases of IOMMU aware mediated device
> >> (assigning mdevs to userspace drivers, for example)  
> > 
> > yes. aux domain concept applies only to vt-d rev3 which introduces
> > scalable mode. Care is taken to avoid breaking usages on existing
> > architectures.
> > 
> > one note. Assigning mdevs to user space alone doesn't imply IOMMU
> > aware. All existing mdev usages use software or proprietary methods
> > to isolate DMA. There is only one potential IOMMU aware mdev usage 
> > which we talked not rely on vt-d rev3 scalable mode - wrap a random 
> > PCI device into a single mdev instance (no sharing). In that case
> > mdev inherits RID from parent PCI device, thus is isolated by IOMMU
> > in RID granular. Our RFC supports this usage too. In VFIO two
> > usages (PASID- based and RID-based) use same code path, i.e. always
> > binding domain to the parent device of mdev. But within IOMMU they
> > go different paths. PASID-based will go to aux-domain as
> > iommu_enable_aux_domain has been called on that device. RID-based
> > will follow existing unmanaged domain path, as if it is parent
> > device assignment.  
> 
> For Arm SMMU we're more interested in the PASID-granular case than the
> RID-granular one. It doesn't necessarily require vt-d rev3 scalable
> mode, the following example can be implemented with an SMMUv3, since
> it only needs PASID-granular first-level translation:
> 
> We have a PCI function that supports PASID, and can be partitioned
> into multiple isolated entities, mdevs. Each mdev has an MMIO frame,
> an MSI vector and a PASID.
> 
> Different processes (userspace drivers, not QEMU) each open one mdev.
> A process controlling one mdev has two ways of doing DMA:
> 
> (1) Classically, the process uses a VFIO_TYPE1v2_IOMMU container. This
> creates an auxiliary domain for the mdev, with PASID #35. The process
> creates DMA mappings with VFIO_IOMMU_MAP_DMA. VFIO calls iommu_map on
> the auxiliary domain. The IOMMU driver populates the pgtables
> associated with PASID #35.
> 
> (2) SVA. One way of doing it: the process uses a new
> "VFIO_TYPE1_SVA_IOMMU" type of container. VFIO binds the process
> address space to the device, gets PASID #35. Simpler, but not
> everyone wants to use SVA, especially not userspace drivers which
> need the highest performance.
> 
> 
> This example only needs to modify first-level translation, and works
> with SMMUv3. The kernel here could be the host, in which case
> second-level translation is disabled in the SMMU, or it could be the
> guest, in which case second-level mappings are created by QEMU and
> first-level translation is managed by assigning PASID tables to the
> guest.
There is a difference in case of guest SVA. VT-d v3 will bind guest
PASID and guest CR3 instead of the guest PASID table. Then turn on
nesting. In case of mdev, the second level is obtained from the aux
domain which was setup for the default PASID. Or in case of PCI device,
second level is harvested from RID2PASID.

> So (2) would use iommu_sva_bind_device(), 
We would need something different than that for guest bind, just to show
the two cases:

int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int
*pasid, unsigned long flags, void *drvdata)

(WIP)
int sva_bind_gpasid(struct device *dev, struct gpasid_bind_data *data)
where:
/**
 * struct gpasid_bind_data - Information about device and guest PASID binding
 * @pasid:	Process address space ID used for the guest mm
 * @addr_width:	Guest address width. Paging mode can also be derived.
 * @gcr3:	Guest CR3 value from guest mm
 */
struct gpasid_bind_data {
	__u32 pasid;
	__u64 gcr3;
	__u32 addr_width;
	__u32 flags;
#define	IOMMU_SVA_GPASID_SRE	BIT(0) /* supervisor request */
};
Perhaps there is room to merge with io_mm but the life cycle management
of guest PASID and host PASID will be different if you rely on mm
release callback than FD.

> but (1) needs something
> else. Aren't auxiliary domains suitable for (1)? Why limit auxiliary
> domain to second-level or nested translation? It seems silly to use a
> different API for first-level, since the flow in userspace and VFIO
> is the same as your second-level case as far as MAP_DMA ioctl goes.
> The difference is that in your case the auxiliary domain supports an
> additional operation which binds first-level page tables. An
> auxiliary domain that only supports first-level wouldn't support this
> operation, but it can still implement iommu_map/unmap/etc.
> 
I think the intention is that when a mdev is created, we don;t
know whether it will be used for SVA or IOVA. So aux domain is here to
"hold a spot" for the default PASID such that MAP_DMA calls can work as
usual, which is second level only. Later, if SVA is used on the mdev
there will be another PASID allocated for that purpose.
Do we need to create an aux domain for each PASID? the translation can
be looked up by the combination of parent dev and pasid.

> 
> Another note: if for some reason you did want to allow userspace to
> choose between first-level or second-level, you could implement the
> VFIO_TYPE1_NESTING_IOMMU container. It acts like a VFIO_TYPE1v2_IOMMU,
> but also sets the DOMAIN_ATTR_NESTING on the IOMMU domain. So DMA_MAP
> ioctl on a NESTING container would populate second-level, and DMA_MAP
> on a normal container populates first-level. But if you're always
> going to use second-level by default, the distinction isn't necessary.
> 
In case of guest SVA, the second level is always there.
> 
> >> Sounds good, I'll drop the private PASID patch if we can figure
> >> out a solution to the attach/detach_dev problem discussed on patch
> >> 8/10 
> > 
> > Can you elaborate a bit on private PASID usage? what is the
> > high level flow on it? 
> > 
> > Again based on earlier explanation, aux domain is specific to IOMMU
> > architecture supporting vtd scalable mode-like capability, which
> > allows separate 2nd/1st level translations per PASID. Need a better
> > understanding how private PASID is relevant here.  
> 
> Private PASIDs are used for doing iommu_map/iommu_unmap on PASIDs
> (first-level translation):
> https://www.spinics.net/lists/dri-devel/msg177003.html As above, some
> people don't want SVA, some can't do it, some may even want a few
> private address spaces just for their kernel driver. They need a way
> to allocate PASIDs and do iommu_map/iommu_unmap on them, without
> binding to a process. I was planning to add the private PASID patch
> to my SVA series, but in my opinion the feature overlaps with
> auxiliary domains.
> 
> Thanks,
> Jean
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

[Jacob Pan]
