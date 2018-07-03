Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825AAC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1172254D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1172254D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbeGCKqi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:46:38 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:39112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752067AbeGCKqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:46:36 -0400
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 2EFABAA7766FE;
        Tue,  3 Jul 2018 11:46:32 +0100 (IST)
Received: from FRAEMA706-CHM.china.huawei.com (10.206.14.55) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.382.0; Tue, 3 Jul 2018 11:46:34 +0100
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.176]) by
 FRAEMA706-CHM.china.huawei.com ([169.254.6.146]) with mapi id 14.03.0382.000;
 Tue, 3 Jul 2018 12:46:28 +0200
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] iommu/vt-d: Exclude known RMRRs from reserved ranges
Thread-Topic: [RFC PATCH] iommu/vt-d: Exclude known RMRRs from reserved
 ranges
Thread-Index: AQHT/QBoOoMtjHHVmEmzfBoxn+vmBaRSk0gAgAIyJYCAAMeKAIAn7CUQ
Date:   Tue, 3 Jul 2018 10:46:28 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83870DFE9@FRAEML521-MBX.china.huawei.com>
References: <20180605190400.22732.2998.stgit@gimli.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D1911F88AD@SHSMSX101.ccr.corp.intel.com>
 <20180607090157.5458a2ae@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D1911FD12E@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1911FD12E@SHSMSX101.ccr.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> -----Original Message-----
> From: Tian, Kevin [mailto:kevin.tian@intel.com]
> Sent: 08 June 2018 03:56
> To: Alex Williamson <alex.williamson@redhat.com>
> Cc: dwmw2@infradead.org; iommu@lists.linux-foundation.org;
> kvm@vger.kernel.org; linux-kernel@vger.kernel.org; Shameerali Kolothum
> Thodi <shameerali.kolothum.thodi@huawei.com>
> Subject: RE: [RFC PATCH] iommu/vt-d: Exclude known RMRRs from reserved
> ranges
> 
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Thursday, June 7, 2018 11:02 PM
> >
> > On Wed, 6 Jun 2018 05:29:58 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >
> > > > From: Alex Williamson
> > > > Sent: Wednesday, June 6, 2018 3:07 AM
> > > >
> > > > device_is_rmrr_locked() allows graphics and USB devices to participate
> > > > in the IOMMU API despite, and ignoring their RMRR association,
> > however
> > > > intel_iommu_get_resv_regions() still includes the RMRRs as unavailable
> > > > IOVA space for the device.  Are we ignoring the RMRR for these devices
> > > > or are we not?  If vfio starts consuming reserved regions, perhaps we
> > > > no longer need to consider devices with RMRRs excluded from the
> > IOMMU
> > > > API interface, but we have a transitional problem that these allowed
> > > > devices still impose incompatible IOVA restrictions per the reserved
> > > > region reporting.  Dive further down the rabbit hole by also ignoring
> > > > RMRRs for "known" devices in the reserved region reporting.
> > >
> > > intel_iommu_get_resv_regions is used not just for IOMMU API. I'm
> > > afraid doing so will make RMRR completely ignored, even in normal
> > > DMA API path...
> >
> > Well, I'm a bit stuck then, we have existing IOMMU API users that
> > ignore these ranges and in fact conflict with these ranges blocking us
> > from restricting mappings within these ranges.  My impression is that
> > IOMMU reserved ranges should only be ranges which have some
> > fundamental
> > limitation in the IOMMU, not simply mappings for which firmware has
> > requested an identity mapped range.  The latter should simply be a
> > pre-allocation of the IOVA space, for the cases where we choose to
> > honor the RMRR.  Thanks,
> >
> 
> Then possibly need introduce a different interface for pre-allocation
> scenario, if above definition of reserved ranges is agreed. Currently
> two categories are both called reserved resources, e.g. IOMMU_RESV
> _DIRECT for rmrr and IOMMU_RESV_MSI for MSI...

Sorry, but I just thought of checking on the future plans/directions for solving
this issue(Unfortunately vfio iova list series depends on this).

Please let me know if there is any plans for a v2 soon.

Much appreciated,
Shameer
