Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CA0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10136222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nmSN7x4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395014AbfBMVqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:46:12 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:38665 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732481AbfBMVqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:46:11 -0500
Received: by mail-it1-f201.google.com with SMTP id m128so6365294itd.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FNhxP8JN/aOogF64x1RdI276bG+FvUjSYc/h3hGis10=;
        b=nmSN7x4f0dFsz2f8CmOy0DSZEVYELcvMbs3qFQceL8JHg4uPw7v3hsrtQFyLw9sE5X
         K3+ltokbjOLnlDMKXcOKKCOxKs5urZWEJmGd7HmcyAcanVs7dh0Hb+XIT6mehoPOHu1z
         c0KH48taiqX05DvKw2KMQDIa+P5Iky7RvtdBpMnRXl1xtahZSCjHg0ryL3QpeEfSNy7n
         1Jxu74dVhDvvJF/jLy64FaZnxTo88JDD7+vqhn4Oqv214x+MzdzUXP6mwVozZrCTCvDX
         VNBrpaIh/tsmsJ0HLMKHyWPFXwtTsDKh39OoHk3xwKBdfASz/7QgvfdSBoToyD1iQi1H
         K9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FNhxP8JN/aOogF64x1RdI276bG+FvUjSYc/h3hGis10=;
        b=WrXlRUzPy6X37gk7uXiuCthJtN5gVehOxnysJL5NbLOWaZ/oqy4dVmiua9BAsU7ENz
         DSuSjzUmBZlTph1Oh88n4DJAGvWnm1Pl0llwj3kbF40dsd7j0uK4HfKrw2h6mZE3AY8C
         HxeOxmkmqHajYUkryMCd6W2ogBAHwaFNQKf5iMlJMKX8H9hJnZ+A2jO3Y4Ltm3cIEWuk
         wzVBFWE4YM/TAfowrA8U2o/Z2VA84rGkRvbK/NRy1tdD7XIXqz2IkUJ/s/0nfTjqWBPy
         uPglGSvPcnAq+wxx2+KXO9cR6arqmoSmhmgH9ofnCsW9TJqD+rauimK/Dur2EMGKwvRj
         jmdQ==
X-Gm-Message-State: AHQUAubLzMcFKkbMrEhhHH15HIF/HOg5mhcLmq+b82ba+3/YrNV/2zI7
        Ehs5C/YeVE4Ahxd4VMTm2kFErt9X1Q==
X-Google-Smtp-Source: AHgI3IYHqsYwFvWOqst/rKom/+dGsarTpRUx/qbL+/QdEt9tRubhgZrB/16HNXoxImLIXoRQ9XJseh71SA==
X-Received: by 2002:a24:5311:: with SMTP id n17mr187606itb.39.1550094371114;
 Wed, 13 Feb 2019 13:46:11 -0800 (PST)
Date:   Wed, 13 Feb 2019 22:45:59 +0100
Message-Id: <20190213214559.125666-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [RESEND PATCH net] mm: page_alloc: fix ref bias in page_frag_alloc()
 for 1-byte allocs
From:   Jann Horn <jannh@google.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        jannh@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Aaron Lu <aaron.lu@intel.com>,
        Alexander Duyck <alexander.h.duyck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The basic idea behind ->pagecnt_bias is: If we pre-allocate the maximum
number of references that we might need to create in the fastpath later,
the bump-allocation fastpath only has to modify the non-atomic bias value
that tracks the number of extra references we hold instead of the atomic
refcount. The maximum number of allocations we can serve (under the
assumption that no allocation is made with size 0) is nc->size, so that's
the bias used.

However, even when all memory in the allocation has been given away, a
reference to the page is still held; and in the `offset < 0` slowpath, the
page may be reused if everyone else has dropped their references.
This means that the necessary number of references is actually
`nc->size+1`.

Luckily, from a quick grep, it looks like the only path that can call
page_frag_alloc(fragsz=1) is TAP with the IFF_NAPI_FRAGS flag, which
requires CAP_NET_ADMIN in the init namespace and is only intended to be
used for kernel testing and fuzzing.

To test for this issue, put a `WARN_ON(page_ref_count(page) == 0)` in the
`offset < 0` path, below the virt_to_page() call, and then repeatedly call
writev() on a TAP device with IFF_TAP|IFF_NO_PI|IFF_NAPI_FRAGS|IFF_NAPI,
with a vector consisting of 15 elements containing 1 byte each.

Signed-off-by: Jann Horn <jannh@google.com>
---
Resending to davem at the request of akpm.

 mm/page_alloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 35fdde041f5c..46285d28e43b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4675,11 +4675,11 @@ void *page_frag_alloc(struct page_frag_cache *nc,
 		/* Even if we own the page, we do not use atomic_set().
 		 * This would break get_page_unless_zero() users.
 		 */
-		page_ref_add(page, size - 1);
+		page_ref_add(page, size);
 
 		/* reset page count bias and offset to start of new frag */
 		nc->pfmemalloc = page_is_pfmemalloc(page);
-		nc->pagecnt_bias = size;
+		nc->pagecnt_bias = size + 1;
 		nc->offset = size;
 	}
 
@@ -4695,10 +4695,10 @@ void *page_frag_alloc(struct page_frag_cache *nc,
 		size = nc->size;
 #endif
 		/* OK, page count is 0, we can safely set it */
-		set_page_count(page, size);
+		set_page_count(page, size + 1);
 
 		/* reset page count bias and offset to start of new frag */
-		nc->pagecnt_bias = size;
+		nc->pagecnt_bias = size + 1;
 		offset = size - fragsz;
 	}
 
-- 
2.20.1.791.gb4d0f1c61a-goog

