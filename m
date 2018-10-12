Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A46DC67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FD12087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FD12087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeJMBfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:35:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:9233 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbeJMBfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:35:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 11:01:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,373,1534834800"; 
   d="scan'208";a="91502647"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003.jf.intel.com with ESMTP; 12 Oct 2018 11:01:56 -0700
Subject: [PATCH v7 7/7] mm, hmm: Mark hmm_devmem_{add,
 add_resource} EXPORT_SYMBOL_GPL
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 12 Oct 2018 10:50:08 -0700
Message-ID: <153936660850.1198040.13706829678231288085.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153936657159.1198040.4489957977352276272.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153936657159.1198040.4489957977352276272.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routines hmm_devmem_add(), and hmm_devmem_add_resource() duplicated
devm_memremap_pages() and are now simple now wrappers around the core
facility to inject a dev_pagemap instance into the global pgmap_radix
and hook page-idle events. The devm_memremap_pages() interface is base
infrastructure for HMM. HMM has more and deeper ties into the kernel
memory management implementation than base ZONE_DEVICE which is itself a
EXPORT_SYMBOL_GPL facility.

Originally, the HMM page structure creation routines copied the
devm_memremap_pages() code and reused ZONE_DEVICE. A cleanup to unify
the implementations was discussed during the initial review:
http://lkml.iu.edu/hypermail/linux/kernel/1701.2/00812.html
Recent work to extend devm_memremap_pages() for the peer-to-peer-DMA
facility enabled this cleanup to move forward.

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

Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/hmm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 2e72cb4188ca..90d1383c7e24 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1062,7 +1062,7 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
 		return result;
 	return devmem;
 }
-EXPORT_SYMBOL(hmm_devmem_add);
+EXPORT_SYMBOL_GPL(hmm_devmem_add);
 
 struct hmm_devmem *hmm_devmem_add_resource(const struct hmm_devmem_ops *ops,
 					   struct device *device,
@@ -1116,7 +1116,7 @@ struct hmm_devmem *hmm_devmem_add_resource(const struct hmm_devmem_ops *ops,
 		return result;
 	return devmem;
 }
-EXPORT_SYMBOL(hmm_devmem_add_resource);
+EXPORT_SYMBOL_GPL(hmm_devmem_add_resource);
 
 /*
  * A device driver that wants to handle multiple devices memory through a

