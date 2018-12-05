Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CFFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DAD20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DAD20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeLEP4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:56:48 -0500
Received: from 8bytes.org ([81.169.241.247]:51920 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbeLEP4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:56:47 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 67A8B345; Wed,  5 Dec 2018 16:56:46 +0100 (CET)
Date:   Wed, 5 Dec 2018 16:56:46 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 04/12] iommu/vt-d: Add 256-bit invalidation descriptor
 support
Message-ID: <20181205155646.GD16835@8bytes.org>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
 <20181128035449.10226-5-baolu.lu@linux.intel.com>
 <20181203134856.lui4us4ejm4d5avz@8bytes.org>
 <A2975661238FB949B60364EF0F2C257439D838AB@SHSMSX104.ccr.corp.intel.com>
 <3b0eadd2-b99f-98d6-594f-0419f0542789@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b0eadd2-b99f-98d6-594f-0419f0542789@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 02:13:31PM +0800, Lu Baolu wrote:
> The existing code uses GFP_ATOMIC, this patch only changes the size of
> the allocated desc_page.
> 
> I don't think we really need GFP_ATOMIC here (and also for some other
> places). I will clean up them in a separated patch.

Okay, thanks.

> > In this patch, there is some code like the code below. It calculates
> > destination address of memcpy with qi->desc. If it's still struct qi_desc
> > pointer, the calculation result would be wrong.
> > 
> > +			memcpy(desc, qi->desc + (wait_index << shift),
> > +			       1 << shift);
> > 
> > The change of the calculation method is to support 128 bits invalidation
> > descriptors and 256 invalidation descriptors in this unified code logic.
> > 
> > Also, the conversation between Baolu and me may help.
> > 
> > https://lore.kernel.org/patchwork/patch/1006756/
> 
> Yes. We need to support different descriptor size.

Okay, pointer arithmetic on void* isn't well defined in the C standard,
afaik. But it should work with GCC, so it's probably fine.

Unrelated to this patch-set, the whole qi management code needs some
cleanups, it queues a sync after every command and has very tricky
locking. This patch-set further complicates matters there, so it is
probably time for a clean re-write of that part?

Regards,

	Joerg
