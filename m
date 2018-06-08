Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9xUSA1LwGVsJaQAAmS7hNA
	; Fri, 08 Jun 2018 02:56:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EE01A607DC; Fri,  8 Jun 2018 02:56:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6DB9C606DD;
	Fri,  8 Jun 2018 02:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DB9C606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeFHC4O convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Thu, 7 Jun 2018 22:56:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:41830 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752428AbeFHC4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 22:56:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 19:56:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,489,1520924400";
   d="scan'208";a="65296367"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga002.jf.intel.com with ESMTP; 07 Jun 2018 19:56:11 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 7 Jun 2018 19:56:11 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX152.amr.corp.intel.com (10.18.125.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 7 Jun 2018 19:56:11 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.82]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.116]) with mapi id 14.03.0319.002;
 Fri, 8 Jun 2018 10:56:08 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shameerali.kolothum.thodi@huawei.com"
        <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [RFC PATCH] iommu/vt-d: Exclude known RMRRs from reserved ranges
Thread-Topic: [RFC PATCH] iommu/vt-d: Exclude known RMRRs from reserved
 ranges
Thread-Index: AQHT/QBl3FLhGzQJLU2PykJ/hFk0XaRSs5lwgAGtP4CAAUxdkA==
Date: Fri, 8 Jun 2018 02:56:08 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1911FD12E@SHSMSX101.ccr.corp.intel.com>
References: <20180605190400.22732.2998.stgit@gimli.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D1911F88AD@SHSMSX101.ccr.corp.intel.com>
 <20180607090157.5458a2ae@w520.home>
In-Reply-To: <20180607090157.5458a2ae@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTQ0YTlmZDYtOTFiNS00OGIzLTliMmYtNDFhNzJjNTBkMWYzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6IjVRam41Qzl3TEV6cnhpODA5SlQwUXl6enNuR1FcL2k0SmlHZ3ZaNTM2NDRNPSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Thursday, June 7, 2018 11:02 PM
> 
> On Wed, 6 Jun 2018 05:29:58 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Alex Williamson
> > > Sent: Wednesday, June 6, 2018 3:07 AM
> > >
> > > device_is_rmrr_locked() allows graphics and USB devices to participate
> > > in the IOMMU API despite, and ignoring their RMRR association,
> however
> > > intel_iommu_get_resv_regions() still includes the RMRRs as unavailable
> > > IOVA space for the device.  Are we ignoring the RMRR for these devices
> > > or are we not?  If vfio starts consuming reserved regions, perhaps we
> > > no longer need to consider devices with RMRRs excluded from the
> IOMMU
> > > API interface, but we have a transitional problem that these allowed
> > > devices still impose incompatible IOVA restrictions per the reserved
> > > region reporting.  Dive further down the rabbit hole by also ignoring
> > > RMRRs for "known" devices in the reserved region reporting.
> >
> > intel_iommu_get_resv_regions is used not just for IOMMU API. I'm
> > afraid doing so will make RMRR completely ignored, even in normal
> > DMA API path...
> 
> Well, I'm a bit stuck then, we have existing IOMMU API users that
> ignore these ranges and in fact conflict with these ranges blocking us
> from restricting mappings within these ranges.  My impression is that
> IOMMU reserved ranges should only be ranges which have some
> fundamental
> limitation in the IOMMU, not simply mappings for which firmware has
> requested an identity mapped range.  The latter should simply be a
> pre-allocation of the IOVA space, for the cases where we choose to
> honor the RMRR.  Thanks,
> 

Then possibly need introduce a different interface for pre-allocation
scenario, if above definition of reserved ranges is agreed. Currently
two categories are both called reserved resources, e.g. IOMMU_RESV
_DIRECT for rmrr and IOMMU_RESV_MSI for MSI...

Thanks
Kevin
