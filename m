Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5659EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5452184C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217516;
	bh=aO1Fj+mgd9xaXg84yk/DB9Mt2V7diTxfbwT6stjCLSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a/UzhnCpjdP9dNFiPbfWW70GlWC9QRAao3ydKhHQqr7Ys9WrCLc7NRRIgw3F8JyST
	 1Jsow21niF+WW0IlWNSeWQ4v3ji6l8kBrcvRKqb2yr52MLNXkNKVJ+5oQn67NGJHyi
	 wrLi3/DluQnLOHm1NvsI7lfeigsQiT9Ml6R7xqrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390869AbfAKOif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:38:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390834AbfAKOib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:38:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3B3821848;
        Fri, 11 Jan 2019 14:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217510;
        bh=aO1Fj+mgd9xaXg84yk/DB9Mt2V7diTxfbwT6stjCLSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LRDRx/wO78/Q0tAXg9jxChfZc2+6ddsmDjQaOCut3NKD5qj4OGJTRtr2PpI+eqWSF
         sTFOlc4RsqkP1FF84PXrCluwB/IFflV/qvF3SJBhBqc1FDKI4vT8rGqukwbSMUg/Ks
         J31oyC28gzmNtu56ajpBVCdCkRDscC3k5KQXaTPg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH 4.19 087/148] mm, hmm: mark hmm_devmem_{add, add_resource} EXPORT_SYMBOL_GPL
Date:   Fri, 11 Jan 2019 15:14:25 +0100
Message-Id: <20190111131117.679588180@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 02917e9f8676207a4c577d4d94eae12bf348e9d7 upstream.

At Maintainer Summit, Greg brought up a topic I proposed around
EXPORT_SYMBOL_GPL usage.  The motivation was considerations for when
EXPORT_SYMBOL_GPL is warranted and the criteria for taking the exceptional
step of reclassifying an existing export.  Specifically, I wanted to make
the case that although the line is fuzzy and hard to specify in abstract
terms, it is nonetheless clear that devm_memremap_pages() and HMM
(Heterogeneous Memory Management) have crossed it.  The
devm_memremap_pages() facility should have been EXPORT_SYMBOL_GPL from the
beginning, and HMM as a derivative of that functionality should have
naturally picked up that designation as well.

Contrary to typical rules, the HMM infrastructure was merged upstream with
zero in-tree consumers.  There was a promise at the time that those users
would be merged "soon", but it has been over a year with no drivers
arriving.  While the Nouveau driver is about to belatedly make good on
that promise it is clear that HMM was targeted first and foremost at an
out-of-tree consumer.

HMM is derived from devm_memremap_pages(), a facility Christoph and I
spearheaded to support persistent memory.  It combines a device lifetime
model with a dynamically created 'struct page' / memmap array for any
physical address range.  It enables coordination and control of the many
code paths in the kernel built to interact with memory via 'struct page'
objects.  With HMM the integration goes even deeper by allowing device
drivers to hook and manipulate page fault and page free events.

One interpretation of when EXPORT_SYMBOL is suitable is when it is
exporting stable and generic leaf functionality.  The
devm_memremap_pages() facility continues to see expanding use cases,
peer-to-peer DMA being the most recent, with no clear end date when it
will stop attracting reworks and semantic changes.  It is not suitable to
export devm_memremap_pages() as a stable 3rd party driver API due to the
fact that it is still changing and manipulates core behavior.  Moreover,
it is not in the best interest of the long term development of the core
memory management subsystem to permit any external driver to effectively
define its own system-wide memory management policies with no
encouragement to engage with upstream.

I am also concerned that HMM was designed in a way to minimize further
engagement with the core-MM.  That, with these hooks in place,
device-drivers are free to implement their own policies without much
consideration for whether and how the core-MM could grow to meet that
need.  Going forward not only should HMM be EXPORT_SYMBOL_GPL, but the
core-MM should be allowed the opportunity and stimulus to change and
address these new use cases as first class functionality.

Original changelog:

hmm_devmem_add(), and hmm_devmem_add_resource() duplicated
devm_memremap_pages() and are now simple now wrappers around the core
facility to inject a dev_pagemap instance into the global pgmap_radix and
hook page-idle events.  The devm_memremap_pages() interface is base
infrastructure for HMM.  HMM has more and deeper ties into the kernel
memory management implementation than base ZONE_DEVICE which is itself a
EXPORT_SYMBOL_GPL facility.

Originally, the HMM page structure creation routines copied the
devm_memremap_pages() code and reused ZONE_DEVICE.  A cleanup to unify the
implementations was discussed during the initial review:
http://lkml.iu.edu/hypermail/linux/kernel/1701.2/00812.html Recent work to
extend devm_memremap_pages() for the peer-to-peer-DMA facility enabled
this cleanup to move forward.

In addition to the integration with devm_memremap_pages() HMM depends on
other GPL-only symbols:

    mmu_notifier_unregister_no_release
    percpu_ref
    region_intersects
    __class_create

It goes further to consume / indirectly expose functionality that is not
exported to any other driver:

    alloc_pages_vma
    walk_page_range

HMM is derived from devm_memremap_pages(), and extends deep core-kernel
fundamentals. Similar to devm_memremap_pages(), mark its entry points
EXPORT_SYMBOL_GPL().

[logang@deltatee.com: PCI/P2PDMA: match interface changes to devm_memremap_pages()]
  Link: http://lkml.kernel.org/r/20181130225911.2900-1-logang@deltatee.com
Link: http://lkml.kernel.org/r/154275560565.76910.15919297436557795278.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Balbir Singh <bsingharora@gmail.com>,
Cc: Michal Hocko <mhocko@suse.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/hmm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1210,7 +1210,7 @@ struct hmm_devmem *hmm_devmem_add(const
 
 	return devmem;
 }
-EXPORT_SYMBOL(hmm_devmem_add);
+EXPORT_SYMBOL_GPL(hmm_devmem_add);
 
 struct hmm_devmem *hmm_devmem_add_resource(const struct hmm_devmem_ops *ops,
 					   struct device *device,
@@ -1264,7 +1264,7 @@ struct hmm_devmem *hmm_devmem_add_resour
 
 	return devmem;
 }
-EXPORT_SYMBOL(hmm_devmem_add_resource);
+EXPORT_SYMBOL_GPL(hmm_devmem_add_resource);
 
 /*
  * A device driver that wants to handle multiple devices memory through a


