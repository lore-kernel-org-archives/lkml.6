Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A432CECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F652146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F652146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbeISH5l convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:57:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:33041 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730651AbeISH5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:57:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 19:22:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,392,1531810800"; 
   d="scan'208";a="264747122"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga006.fm.intel.com with ESMTP; 18 Sep 2018 19:22:06 -0700
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 18 Sep 2018 19:22:06 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx122.amr.corp.intel.com (10.18.125.37) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 18 Sep 2018 19:22:06 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.205]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.240]) with mapi id 14.03.0319.002;
 Wed, 19 Sep 2018 10:22:03 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
Thread-Topic: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
Thread-Index: AQHUQBd63AINefsFr0WaDhgLiguCyqTpPryAgAI/kgCAAP6ogIAA7miAgAB0EYCAAfdXgIAF8HiAgAEyrvA=
Date:   Wed, 19 Sep 2018 02:22:03 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19130ED5B@SHSMSX101.ccr.corp.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
 <aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com>
 <3602f8c1-df17-4894-1bcc-4d779f9aa7fd@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191300D06@SHSMSX101.ccr.corp.intel.com>
 <03d496b0-84c2-b3ca-5be5-d4540c6d8ec7@arm.com>
 <20180914140433.6891a90c@jacob-builder>
 <a92a6077-226f-5d38-cdfa-ec5e06a5d532@arm.com>
In-Reply-To: <a92a6077-226f-5d38-cdfa-ec5e06a5d532@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjc3ODhiZDYtY2MyNy00ZjRkLWE5ZTYtYTJiN2ExZjFmODYyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiR0hOK25SRytualp6SWE2MlwvZFZoajhNMEtUblp5dEpzRnh2MWxPT2NRakE1VlRncFBHVlRlNDNDakk3WFFCOFwvIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
> Sent: Tuesday, September 18, 2018 11:47 PM
> 
> On 14/09/2018 22:04, Jacob Pan wrote:
> >> This example only needs to modify first-level translation, and works
> >> with SMMUv3. The kernel here could be the host, in which case
> >> second-level translation is disabled in the SMMU, or it could be the
> >> guest, in which case second-level mappings are created by QEMU and
> >> first-level translation is managed by assigning PASID tables to the
> >> guest.
> > There is a difference in case of guest SVA. VT-d v3 will bind guest
> > PASID and guest CR3 instead of the guest PASID table. Then turn on
> > nesting. In case of mdev, the second level is obtained from the aux
> > domain which was setup for the default PASID. Or in case of PCI device,
> > second level is harvested from RID2PASID.
> 
> Right, though I wasn't talking about the host managing guest SVA here,
> but a kernel binding the address space of one of its userspace drivers
> to the mdev.
> 
> >> So (2) would use iommu_sva_bind_device(),
> > We would need something different than that for guest bind, just to show
> > the two cases:>
> > int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
> int
> > *pasid, unsigned long flags, void *drvdata)
> >
> > (WIP)
> > int sva_bind_gpasid(struct device *dev, struct gpasid_bind_data *data)
> > where:
> > /**
> >  * struct gpasid_bind_data - Information about device and guest PASID
> > binding
> >  * @pasid:       Process address space ID used for the guest mm
> >  * @addr_width:  Guest address width. Paging mode can also be derived.
> >  * @gcr3:        Guest CR3 value from guest mm
> >  */
> > struct gpasid_bind_data {
> >         __u32 pasid;
> >         __u64 gcr3;
> >         __u32 addr_width;
> >         __u32 flags;
> > #define IOMMU_SVA_GPASID_SRE    BIT(0) /* supervisor request */
> > };
> > Perhaps there is room to merge with io_mm but the life cycle
> management
> > of guest PASID and host PASID will be different if you rely on mm
> > release callback than FD.

let's not calling gpasid here - which makes sense only in bind_pasid_table
proposal where pasid table thus pasid space is managed by guest. In above
context it is always about host pasid (allocated in system-wide), which
could point to a host cr3 (user process) or a guest cr3 (vm case).

> 
> I think gpasid management should stay separate from io_mm, since in your
> case VFIO mechanisms are used for life cycle management of the VM,
> similarly to the former bind_pasid_table proposal. For example closing
> the container fd would unbind all guest page tables. The QEMU process'
> address space lifetime seems like the wrong thing to track for gpasid.

I sort of agree (though not thinking through all the flow carefully). PASIDs
are allocated per iommu domain, thus release also happens when domain
is detached (along with container fd close).

> 
> >> but (1) needs something
> >> else. Aren't auxiliary domains suitable for (1)? Why limit auxiliary
> >> domain to second-level or nested translation? It seems silly to use a
> >> different API for first-level, since the flow in userspace and VFIO
> >> is the same as your second-level case as far as MAP_DMA ioctl goes.
> >> The difference is that in your case the auxiliary domain supports an
> >> additional operation which binds first-level page tables. An
> >> auxiliary domain that only supports first-level wouldn't support this
> >> operation, but it can still implement iommu_map/unmap/etc.
> >>
> > I think the intention is that when a mdev is created, we don;t
> > know whether it will be used for SVA or IOVA. So aux domain is here to
> > "hold a spot" for the default PASID such that MAP_DMA calls can work as
> > usual, which is second level only. Later, if SVA is used on the mdev
> > there will be another PASID allocated for that purpose.
> > Do we need to create an aux domain for each PASID? the translation can
> > be looked up by the combination of parent dev and pasid.
> 
> When allocating a new PASID for the guest, I suppose you need to clone
> the second-level translation config? In which case a single aux domain
> for the mdev might be easier to implement in the IOMMU driver. Entirely
> up to you since we don't have this case on SMMUv3
> 

One thing to highlight in related discussions (also mentioned in other
thread). There is not a new iommu domain type called 'aux'. 'aux' matters
only to a specific device when a domain is attached to that device which
has aux capability enabled. Same domain can be attached to other device
as normal domain. In that case multiple PASIDs allocated on same mdev
are tied to same aux domain, same bare metal SVA case, i.e. any domain
(normal or aux) can include 2nd level structure and multiple 1st level 
structures. Jean is correct - all PASIDs in same domain then share 2nd 
level translation, and there are io_mm or similar tracking structures to 
associate each PASID to a 1st level translation structure.

Thanks
Kevin
