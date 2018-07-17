Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B272ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB44208EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB44208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbeGQCRy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:17:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:28118 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbeGQCRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:17:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 18:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,363,1526367600"; 
   d="scan'208";a="57402406"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga008.jf.intel.com with ESMTP; 16 Jul 2018 18:47:44 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 16 Jul 2018 18:47:44 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.81]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.100]) with mapi id 14.03.0319.002;
 Tue, 17 Jul 2018 09:47:42 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 00/10] iommu/vt-d: Add scalable mode support
Thread-Topic: [PATCH 00/10] iommu/vt-d: Add scalable mode support
Thread-Index: AQHUHNKwcraSkaOKck+AIZ8QpxXZFaSRJkaAgAF/GdA=
Date:   Tue, 17 Jul 2018 01:47:42 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439C9DAB8@SHSMSX104.ccr.corp.intel.com>
References: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
 <07fe2e3f-4f4a-58db-ee2a-2620183d93b2@arm.com>
In-Reply-To: <07fe2e3f-4f4a-58db-ee2a-2620183d93b2@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzY2N2JkZTUtZTVkNy00MzNjLTlkNGEtNzNiN2E5YjNlOTM2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicTNQVGYxRVJkMVdzaHczMkFLZWIzeFwvYllCVTl5V2VWMjRWdHF5Tzl3Y3pKdExwMDBoR0pSdkdFd0Z3ZG5FMmYifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

> From: Jean-Philippe Brucker
> Sent: Monday, July 16, 2018 6:52 PM
> On 16/07/18 07:49, Lu Baolu wrote:
> > Intel vt-d rev3.0 [1] introduces a new translation mode called
> > 'scalable mode', which enables PASID-granular translations for first
> > level, second level, nested and pass-through modes. The vt-d scalable
> > mode is the key ingredient to enable Scalable I/O Virtualization
> > (Scalable IOV) [2] [3], which allows sharing a device in minimal
> > possible granularity (ADI - Assignable Device Interface). It also
> > includes all the capabilities required to enable Shared Virtual
> > Addressing (SVA). As a result, previous Extended Context (ECS) mode is
> > deprecated (no production ever implements ECS).
> >
> > Each scalable mode pasid table entry is 64 bytes in length, with
> > fields point to the first level page table and the second level page
> > table. The PGTT (Pasid Granular Translation Type) field is used by
> > hardware to determine the translation type.
> 
> Looks promising! Since the 2nd level page tables are in the PASID entry, the
> hypervisor traps guest accesses to the PASID tables instead of passing through the
> whole PASID directory? Are you still planning to use the VFIO BIND_PASID_TABLE
> interface in this mode, or a slightly different one for individual PASIDs?

You are right. For Intel VT-d, we don't need to give the access to the whole guest
PASID table in Scalable Mode. However, VFIO BIND_PASID_TABLE may still needed
for other vendor. So it may still in the proposed list. This would be covered in the
new vSVA patchset from Jacob and me.

Thanks,
Yi Liu
