Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CF5C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C032320858
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C032320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733228AbeITVgZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:36:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:16104 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731025AbeITVgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:36:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 08:52:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,399,1531810800"; 
   d="scan'208";a="92266669"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 20 Sep 2018 08:52:17 -0700
Date:   Thu, 20 Sep 2018 08:53:39 -0700
From:   Jacob Pan <jacob.jun.pan@intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>, jacob.jun.pan@intel.com
Subject: Re: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
Message-ID: <20180920085339.2ea67e72@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19130ED5B@SHSMSX101.ccr.corp.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
        <380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
        <aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com>
        <3602f8c1-df17-4894-1bcc-4d779f9aa7fd@arm.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D191300D06@SHSMSX101.ccr.corp.intel.com>
        <03d496b0-84c2-b3ca-5be5-d4540c6d8ec7@arm.com>
        <20180914140433.6891a90c@jacob-builder>
        <a92a6077-226f-5d38-cdfa-ec5e06a5d532@arm.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19130ED5B@SHSMSX101.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 02:22:03 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
> > Sent: Tuesday, September 18, 2018 11:47 PM
> > 
> > On 14/09/2018 22:04, Jacob Pan wrote:  
> > >> This example only needs to modify first-level translation, and
> > >> works with SMMUv3. The kernel here could be the host, in which
> > >> case second-level translation is disabled in the SMMU, or it
> > >> could be the guest, in which case second-level mappings are
> > >> created by QEMU and first-level translation is managed by
> > >> assigning PASID tables to the guest.  
> > > There is a difference in case of guest SVA. VT-d v3 will bind
> > > guest PASID and guest CR3 instead of the guest PASID table. Then
> > > turn on nesting. In case of mdev, the second level is obtained
> > > from the aux domain which was setup for the default PASID. Or in
> > > case of PCI device, second level is harvested from RID2PASID.  
> > 
> > Right, though I wasn't talking about the host managing guest SVA
> > here, but a kernel binding the address space of one of its
> > userspace drivers to the mdev.
> >   
> > >> So (2) would use iommu_sva_bind_device(),  
> > > We would need something different than that for guest bind, just
> > > to show the two cases:>
> > > int iommu_sva_bind_device(struct device *dev, struct mm_struct
> > > *mm,  
> > int  
> > > *pasid, unsigned long flags, void *drvdata)
> > >
> > > (WIP)
> > > int sva_bind_gpasid(struct device *dev, struct gpasid_bind_data
> > > *data) where:
> > > /**
> > >  * struct gpasid_bind_data - Information about device and guest
> > > PASID binding
> > >  * @pasid:       Process address space ID used for the guest mm
> > >  * @addr_width:  Guest address width. Paging mode can also be
> > > derived.
> > >  * @gcr3:        Guest CR3 value from guest mm
> > >  */
> > > struct gpasid_bind_data {
> > >         __u32 pasid;
> > >         __u64 gcr3;
> > >         __u32 addr_width;
> > >         __u32 flags;
> > > #define IOMMU_SVA_GPASID_SRE    BIT(0) /* supervisor request */
> > > };
> > > Perhaps there is room to merge with io_mm but the life cycle  
> > management  
> > > of guest PASID and host PASID will be different if you rely on mm
> > > release callback than FD.  
> 
> let's not calling gpasid here - which makes sense only in
> bind_pasid_table proposal where pasid table thus pasid space is
> managed by guest. In above context it is always about host pasid
> (allocated in system-wide), which could point to a host cr3 (user
> process) or a guest cr3 (vm case).
> 
I agree this gpasid is confusing, we have a system wide PASID
name space. Just a way to differentiate different bind, perhaps
just a flag indicating the PASID is used for guest.
i.e.
struct pasid_bind_data {
         __u32 pasid;
         __u64 gcr3;
         __u32 addr_width;
         __u32 flags;
#define IOMMU_SVA_GPASID_SRE    BIT(0) /* supervisor request */
#define IOMMU_SVA_PASID_GUEST   BIT(0) /* host pasid used by guest */
};

> > I think gpasid management should stay separate from io_mm, since in
> > your case VFIO mechanisms are used for life cycle management of the
> > VM, similarly to the former bind_pasid_table proposal. For example
> > closing the container fd would unbind all guest page tables. The
> > QEMU process' address space lifetime seems like the wrong thing to
> > track for gpasid.  
> 
> I sort of agree (though not thinking through all the flow carefully).
> PASIDs are allocated per iommu domain, thus release also happens when
> domain is detached (along with container fd close).
> 
I also prefer to keep gpasid separate.

But I don't think we need to have per iommu domain per PASID for guest
SVA case. Assuming you are talking about host IOMMU domain. The PASID
bind call is a result of guest PASID cache flush with a PASID
previously allocated. The host just need to put gcr3 into the PASID
entry then harvest the second level from the existing domain.
> >   
> > >> but (1) needs something
> > >> else. Aren't auxiliary domains suitable for (1)? Why limit
> > >> auxiliary domain to second-level or nested translation? It seems
> > >> silly to use a different API for first-level, since the flow in
> > >> userspace and VFIO is the same as your second-level case as far
> > >> as MAP_DMA ioctl goes. The difference is that in your case the
> > >> auxiliary domain supports an additional operation which binds
> > >> first-level page tables. An auxiliary domain that only supports
> > >> first-level wouldn't support this operation, but it can still
> > >> implement iommu_map/unmap/etc. 
> > > I think the intention is that when a mdev is created, we don;t
> > > know whether it will be used for SVA or IOVA. So aux domain is
> > > here to "hold a spot" for the default PASID such that MAP_DMA
> > > calls can work as usual, which is second level only. Later, if
> > > SVA is used on the mdev there will be another PASID allocated for
> > > that purpose. Do we need to create an aux domain for each PASID?
> > > the translation can be looked up by the combination of parent dev
> > > and pasid.  
> > 
> > When allocating a new PASID for the guest, I suppose you need to
> > clone the second-level translation config? In which case a single
> > aux domain for the mdev might be easier to implement in the IOMMU
> > driver. Entirely up to you since we don't have this case on SMMUv3
> >   
> 
> One thing to highlight in related discussions (also mentioned in other
> thread). There is not a new iommu domain type called 'aux'. 'aux'
> matters only to a specific device when a domain is attached to that
> device which has aux capability enabled. Same domain can be attached
> to other device as normal domain. In that case multiple PASIDs
> allocated on same mdev are tied to same aux domain, same bare metal
> SVA case, i.e. any domain (normal or aux) can include 2nd level
> structure and multiple 1st level structures. Jean is correct - all
> PASIDs in same domain then share 2nd level translation, and there are
> io_mm or similar tracking structures to associate each PASID to a 1st
> level translation structure.
> 
I think we are all talking about the same thing :)
yes, 2nd level is cloned from aux domain/default PASID for mdev, and
pdev similarly from DMA_MAP domain.

> Thanks
> Kevin
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

[Jacob Pan]
