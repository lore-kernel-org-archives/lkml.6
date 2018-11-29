Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832E1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420D021104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420D021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeK2S6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:58:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:55844 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726651AbeK2S6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 13:58:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 858A5ADE0;
        Thu, 29 Nov 2018 07:53:31 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Keith Busch <keith.busch@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org
Subject: [PATCH 1/2] mm: Move lru_to_page to mm.h
Date:   Thu, 29 Nov 2018 09:52:56 +0200
Message-Id: <20181129075301.29087-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple places in the kernel which opencode this helper,
this patch moves it to the more generic mm.h header in preparation for
using it. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 include/linux/mm.h        | 2 ++
 include/linux/mm_inline.h | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5411de93a363..47b4aa5bba93 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -146,6 +146,8 @@ extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
 /* test whether an address (unsigned long or pointer) is aligned to PAGE_SIZE */
 #define PAGE_ALIGNED(addr)	IS_ALIGNED((unsigned long)(addr), PAGE_SIZE)
 
+#define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
+
 /*
  * Linux kernel virtual memory manager primitives.
  * The idea being to have a "virtual" mm in the same way
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 10191c28fc04..04ec454d44ce 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -124,7 +124,4 @@ static __always_inline enum lru_list page_lru(struct page *page)
 	}
 	return lru;
 }
-
-#define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
-
 #endif
-- 
2.17.1

