Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D165EECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A81020882
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A81020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeIOHyW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:54:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:26758 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbeIOHyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 03:54:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 19:37:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,375,1531810800"; 
   d="scan'208";a="74436309"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga006.jf.intel.com with ESMTP; 14 Sep 2018 19:37:00 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 14 Sep 2018 19:37:00 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.205]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.226]) with mapi id 14.03.0319.002;
 Sat, 15 Sep 2018 10:36:58 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Kirti Wankhede" <kwankhede@nvidia.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [RFC PATCH v2 08/10] vfio/type1: Add domain at(de)taching group
        helpers
Thread-Topic: [RFC PATCH v2 08/10] vfio/type1: Add domain at(de)taching
 group  helpers
Thread-Index: AQHUTDmz2DK6gLUaCEuyWwJujHYhpaTwnb8A
Date:   Sat, 15 Sep 2018 02:36:57 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191305A74@SHSMSX101.ccr.corp.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
        <20180830040922.30426-9-baolu.lu@linux.intel.com>
        <c5124ac1-65fe-7f89-265c-bef229bc5ce9@arm.com>
        <a97c8f75-ff49-5b87-198f-d3c8950d4e90@linux.intel.com>
        <04f5dc9d-71b1-37ec-402b-fae5f9e08664@arm.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D191300D35@SHSMSX101.ccr.corp.intel.com>
 <c285871d-2ea0-5878-c7ac-ffa4ba8256ee@arm.com>
In-Reply-To: <c285871d-2ea0-5878-c7ac-ffa4ba8256ee@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjc3OTFlOTItOGRmMC00NTFkLWE2YjYtNWJjZTg0MDc5YzIxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNzJqWDFOOEVDanFaUllCZkdzbnJUd092RWlCN2srTU4rUUtaME5vVitIYmdwUnFZQmVmNnd2T2NNWkpOd1dqeCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jean-Philippe Brucker
> Sent: Friday, September 14, 2018 10:46 PM
> 
> On 13/09/2018 01:35, Tian, Kevin wrote:
> >>> Let's consider it from the API point of view.
> >>>
> >>> We have iommu_a(de)ttach_device() APIs to attach or detach a domain
> >>> to/from a device. We should avoid applying a limitation of "these are
> >>> only for single domain case, for multiple domains, use another API".
> >>
> >> That's an idealized view of the API, the actual semantics aren't as
> >> simple. For IOMMU drivers that implement IOMMU_DOMAIN_DMA in
> their
> >> domain_alloc operation (Arm SMMU, AMD IOMMU, ...), attach_dev
> >> attaches
> >> an unmanaged domain, detach_dev reattaches the default DMA domain,
> >> and
> >> the detach_dev IOMMU op is not called. We can't change that now, so
> it's
> >> difficult to add more functionality to attach_dev and detach_dev.
> >>
> >
> > Now we have four possible usages on a(de)ttach_device:
> >
> > 1) Normal DMA API path i.e. IOMMU_DOMAIN_DMA, for DMA
> operations
> > in host/parent device driver;
> >
> > 2) VFIO passthru path, when the physical device is assigned to user space
> > or guest driver
> >
> > 3) mdev passthru path 1, when mdev is assigned to user space or guest
> > driver. Here mdev is a wrap on random PCI device
> >
> > 4) mdev passthru path 2, when mdev is assigned to user space or guest
> > driver. Here mdev is in a smaller granularity (e.g. tagged by PASID) as
> > supported by vt-d scalable mode
> >
> > 1) and 2) are existing usages. What you described (unmanaged vs. default)
> > falls into this category.
> >
> > 3) is actually same as 2) in IOMMU layer. sort of passing through DMA
> > capability to guest. Though there is still a parent driver, the parent driver
> > itself should not do DMA - i.e. unmanaged in host side.
> >
> > 4) is a new code path introduced in IOMMU layer, which is what
> > vfio_a(de)tach_aux_domain is trying to address. In this case parent
> device
> > can still have its own DMA capability, using existing code path 1) (thus
> > default domain still applies). and the parent device can have multiple
> > aux domains (and associated structures), using code path 4).
> 
> We still have the problem that detach() doesn't propagate to the IOMMU
> driver. Here's the current flow, without mdev:
> 
> 1) At boot, the PF's (parent device) driver is probed, and the IOMMU
> core sets up a default DMA domain, to be used by dma_alloc by the PF's
> driver.
> -> iommu.c calls default_domain->ops->attach_dev(default_domain, dev)
> 
> 2) or 3) Later userspace wants to control the PF, replaces the PF's
> driver with vfio-pci. When userspace creates a container, VFIO allocates
> a new IOMMU domain, and calls iommu_attach_group.
> -> iommu.c calls domain->ops->attach_dev(domain, dev)
> This detaches the PF from the default domain, and attaches it to the new
> domain.
> 
> 1) When the container is closed, VFIO calls iommu_detach_group. This
> detaches the PF from its current domain, and attaches it back to the
> default domain.
> -> iommu.c calls default_domain->ops->attach_dev(default_domain, dev)
> 
> -----
> Now with mdev, we still attach the DMA domain in 1). Then:
> 
> 4) Userspace opens an mdev and creates a container. VFIO enables aux
> domain for the device. VFIO allocates a new IOMMU domain, and calls
> iommu_attach_device(domain1, parent_dev).
> -> iommu.c calls domain->ops->attach_dev(domain1, dev)
> Because the device is in "aux domain" state, the IOMMU driver does not
> detach from the default domain, but instead allocates a PASID and
> attaches the aux domain. (Side note: for SMMU we couldn't detach from
> the default domain, because we need it for MSI mappings.)

same for vtd. We don't require parent driver to detach its domain in 1).
Parent driver can have its own DMA capability when aux domain is
enabled in parallel

> 
> 4) Userspace opens another mdev.
> -> iommu.c calls domain->ops->attach_dev(domain2, dev)

another mdev in same VFIO container or different? I assume the
latter since you mentioned a new domain2.

> 
> 1)? When the container is closed, VFIO calls
> iommu_detach_device(domain2, parent_dev)
> -> iommu.c calls default_domain->ops->attach_dev(default_domain, dev)
> Given that auxiliary domains are attached, the IOMMU driver could deduce
> that this actually means "detach an auxiliary domain". But which one?

I didn't get this one. There is no need to stick to 1) behavior for
4), i.e. below is expected:
	domain2->ops->detach_dev(domain2, dev)

why cannot ARM implement a detach_dev for aux_domain too? My
feeling is that default domain twist is only for switch between 1/2/3
in concept. 

> 
> So the proposed interface doesn't seem to work as is. If we want to use
> iommu_attach/detach_device for auxiliary domains, the existing behavior
> of iommu.c, and IOMMU drivers that rely on it, have to change. Any
> change I can think of right now seems more daunting than introducing a
> different path for auxiliary domains, like iommu_attach_aux_domain for
> example.
> 

introducing *aux* specific API will cause different VFIO code path to
handle RID-based and PASID-based mdev, since RID-based still needs
to use normal attach_domain that way. well, this argument is not very strong
in itself, if indeed proposed way doesn't work for ARM. But let's see
whether it is the case with more understanding of your actual concern.

Thanks
Kevin
