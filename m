Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55975ECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A33A2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A33A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbeGSB0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 21:26:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:49672 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729230AbeGSB0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 21:26:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 17:45:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,371,1526367600"; 
   d="scan'208";a="241418705"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 18 Jul 2018 17:45:30 -0700
Date:   Wed, 18 Jul 2018 17:47:02 -0700
From:   Jacob Pan <jacob.jun.pan@intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH 00/10] iommu/vt-d: Add scalable mode support
Message-ID: <20180718174702.31e1c1d6@jacob-builder>
In-Reply-To: <07fe2e3f-4f4a-58db-ee2a-2620183d93b2@arm.com>
References: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
        <07fe2e3f-4f4a-58db-ee2a-2620183d93b2@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018 11:51:57 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Hi,
> 
> On 16/07/18 07:49, Lu Baolu wrote:
> > Intel vt-d rev3.0 [1] introduces a new translation mode called
> > 'scalable mode', which enables PASID-granular translations for
> > first level, second level, nested and pass-through modes. The
> > vt-d scalable mode is the key ingredient to enable Scalable I/O
> > Virtualization (Scalable IOV) [2] [3], which allows sharing a
> > device in minimal possible granularity (ADI - Assignable Device
> > Interface). It also includes all the capabilities required to
> > enable Shared Virtual Addressing (SVA). As a result, previous
> > Extended Context (ECS) mode is deprecated (no production ever
> > implements ECS).
> > 
> > Each scalable mode pasid table entry is 64 bytes in length, with
> > fields point to the first level page table and the second level
> > page table. The PGTT (Pasid Granular Translation Type) field is
> > used by hardware to determine the translation type.  
> 
> Looks promising! Since the 2nd level page tables are in the PASID
> entry, the hypervisor traps guest accesses to the PASID tables
> instead of passing through the whole PASID directory? Are you still
> planning to use the VFIO BIND_PASID_TABLE interface in this mode, or
> a slightly different one for individual PASIDs?
> 
Since we deprecated ECS mode, there is no need for VT-d to bind guest
pasid table in scalable mode. We are planning on adding another flag for
bind guest pasid and guest CR3, Perhaps call it
VFIO_IOMMU_BIND_GUEST_SVA.
> Thanks,
> Jean
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

[Jacob Pan]
