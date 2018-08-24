Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD6CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D03421567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D03421567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeHXQV6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:21:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:55037 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbeHXQV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:21:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Aug 2018 05:47:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,281,1531810800"; 
   d="scan'208";a="83101450"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2018 05:47:27 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 24 Aug 2018 05:47:27 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 24 Aug 2018 05:47:26 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.143]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.150]) with mapi id 14.03.0319.002;
 Fri, 24 Aug 2018 20:47:24 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Auger Eric <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
CC:     "Liu@mail.linuxfoundation.org" <Liu@mail.linuxfoundation.org>,
        Yi L <yi.l.liu@linux.intel.com>,
        Jean Delvare <khali@linux-fr.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: RE: [PATCH v5 01/23] iommu: introduce bind_pasid_table API function
Thread-Topic: [PATCH v5 01/23] iommu: introduce bind_pasid_table API function
Thread-Index: AQHT6Wnaa11JtTxwb0q8A24skrBz4qTNpYUAgAHSePA=
Date:   Fri, 24 Aug 2018 12:47:24 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439CCE9CC@SHSMSX104.ccr.corp.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1526072055-86990-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <e9ddb745-9cfb-1d40-05e0-7bd75292a41f@redhat.com>
In-Reply-To: <e9ddb745-9cfb-1d40-05e0-7bd75292a41f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjZmODM2OTUtZjhkNC00ODg3LTg0YTktY2YzZGVkYjE4MjZiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNUROdWg5eCtPRGJlSE9lMVpGRG0xdDh3STZjNWtEMTQ0VHhKSGRMczZFTlc2R2VkNXFndEJwcEFjcEpxOFVuNiJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> bounces@lists.linux-foundation.org] On Behalf Of Auger Eric
> Sent: Friday, August 24, 2018 12:35 AM
> 
> Hi Jacob,
> 
> On 05/11/2018 10:53 PM, Jacob Pan wrote:
> > Virtual IOMMU was proposed to support Shared Virtual Memory (SVM)
> > use in the guest:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05311.html
> >
> > As part of the proposed architecture, when an SVM capable PCI
> > device is assigned to a guest, nested mode is turned on. Guest owns the
> > first level page tables (request with PASID) which performs GVA->GPA
> > translation. Second level page tables are owned by the host for GPA->HPA
> > translation for both request with and without PASID.
> >
> > A new IOMMU driver interface is therefore needed to perform tasks as
> > follows:
> > * Enable nested translation and appropriate translation type
> > * Assign guest PASID table pointer (in GPA) and size to host IOMMU
> >
> > This patch introduces new API functions to perform bind/unbind guest PASID
> > tables. Based on common data, model specific IOMMU drivers can be extended
> > to perform the specific steps for binding pasid table of assigned devices.
> >
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---

[...]

> > +#ifndef _UAPI_IOMMU_H
> > +#define _UAPI_IOMMU_H
> > +
> > +#include <linux/types.h>
> > +
> > +/**
> > + * PASID table data used to bind guest PASID table to the host IOMMU. This will
> > + * enable guest managed first level page tables.
> > + * @version: for future extensions and identification of the data format
> > + * @bytes: size of this structure
> > + * @base_ptr:	PASID table pointer
> > + * @pasid_bits:	number of bits supported in the guest PASID table, must be
> less
> > + *		or equal than the host supported PASID size.
> > + */
> > +struct pasid_table_config {
> > +	__u32 version;
> > +#define PASID_TABLE_CFG_VERSION_1 1
> > +	__u32 bytes;
> > +	__u64 base_ptr;
> > +	__u8 pasid_bits;
> 
> As reported in "[RFC 00/13] SMMUv3 Nested Stage Setup" thread, this API
> could be used for ARM SMMUv3 nested stage enablement without many
> changes. Assuming SMMUv3 nested stage is confirmed to be interesting for
> vendors and maintainers, we could try to unify the APIs.

Just a quick question on nested stage on SMMUv3. If virtualizer wants to
enable nested stage on SMMUv3, does it link the whole guest CD table to
host or do it in other manner?

> As far as I understand the VTD PASID table is equivalent to the ARM
> SMMUv3 context descriptor table (CD). This corresponds to the stage 1
> context table with one or more entries, each corresponding to one PASID.

PASID table is index by PASID, and have multiple entries. A PASID table
would have 2^PASID_BITS entries.

> maybe using the s1ctx_table_config terminology instead of
> pasid_table_config would be more generic, the pasid table being Intel
> naming.
>
> on top of pasid_bits, I think an "asid_bits" field may be needed too.
> The guest IOMMU might support a different number of asid bits from the
> host one.

Maybe needed for SMMUv3. I've noticed you've placed it in
struct iommu_smmu_s1_config.

> 
> Although without having skimmed through the whole series yet, I wonder
> how you handle the case where stage1 is bypassed or disabled? The guest
> may define the S1 context entries but bypass or abort stage 1
> translations globally. Looks something missing to me at first sight.

Sorry, I didn't quite follow here. What usage is case such for? like stage 1 is
bypassed or disabled. IOVA or SVA?

Thanks,
Yi Liu
