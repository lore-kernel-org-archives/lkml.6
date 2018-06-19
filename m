Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0AFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAE020661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AAE020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965549AbeFSGPR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:15:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:13028 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965317AbeFSGPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:15:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 23:15:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="51007447"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006.jf.intel.com with ESMTP; 18 Jun 2018 23:15:12 -0700
Subject: [PATCH v3 7/8] mm, hmm: Mark hmm_devmem_{add,
 add_resource} EXPORT_SYMBOL_GPL
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Jun 2018 23:05:15 -0700
Message-ID: <152938831573.17797.15264540938029137916.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152938827880.17797.439879736804291936.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152938827880.17797.439879736804291936.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routines hmm_devmem_add(), and hmm_devmem_add_resource() are
now wrappers around the functionality provided by devm_memremap_pages() to
inject a dev_pagemap instance and hook page-idle events. The
devm_memremap_pages() interface is base infrastructure for HMM which has
more and deeper ties into the kernel memory management implementation
than base ZONE_DEVICE.

Originally, the HMM page structure creation routines copied the
devm_memremap_pages() code and reused ZONE_DEVICE. A cleanup to unify
the implementations was discussed during the initial review:
http://lkml.iu.edu/hypermail/linux/kernel/1701.2/00812.html

Given that devm_memremap_pages() is marked EXPORT_SYMBOL_GPL by its
authors and the hmm_devmem_{add,add_resource} routines are simple
wrappers around that base, mark these routines as EXPORT_SYMBOL_GPL as
well.

Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/hmm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index b019d67a610e..481a7a5f6f46 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1054,7 +1054,7 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
 		return result;
 	return devmem;
 }
-EXPORT_SYMBOL(hmm_devmem_add);
+EXPORT_SYMBOL_GPL(hmm_devmem_add);
 
 struct hmm_devmem *hmm_devmem_add_resource(const struct hmm_devmem_ops *ops,
 					   struct device *device,
@@ -1108,7 +1108,7 @@ struct hmm_devmem *hmm_devmem_add_resource(const struct hmm_devmem_ops *ops,
 		return result;
 	return devmem;
 }
-EXPORT_SYMBOL(hmm_devmem_add_resource);
+EXPORT_SYMBOL_GPL(hmm_devmem_add_resource);
 
 /*
  * A device driver that wants to handle multiple devices memory through a

