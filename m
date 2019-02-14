Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D752BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A2E20675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sYFeD6TH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502614AbfBNQEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:04:02 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:59685 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407712AbfBNQEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:04:00 -0500
Received: by mail-it1-f201.google.com with SMTP id m136so9583378ita.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LMMCuwulD/4U8krzNsFeJe/3gdpanzjXyzK8S2//JGE=;
        b=sYFeD6THGVUp5WphhWTj1Ubt/fdAYefIIH++4LXXYYHZD+T88HZIwTslFAMpi3MQDE
         DY2SuwPu8hWWzDRJ3GDmA+O2/ZbrHmR26sRL45JKqqqMKiyiimyeeHoFTDuuT3Ccbkpj
         29UPAnOO5IZ3GiHcxZQaaLlB/uhP3kRznkQHpdjLTk7N0u7eg2m93CWCUrNnv05LwQ4Z
         HNTB+/GAE6sWq7rRvpfoMOVjBYXnCvGDJHfOYl+EEl3Xk7XPjjh+2zhq0qVSe11J4KR7
         G1SXinUEoYGbWhtsLgeUQAmy81PurKEE3cgr5vJMoe+47MDvsY7VppV/2MQB4XY6LHac
         OPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LMMCuwulD/4U8krzNsFeJe/3gdpanzjXyzK8S2//JGE=;
        b=iR+/mtUbrh3D+dD9kAqaxkeUphokcsW6lJO08cRY+LcMYlerZJXZLsOl1CGWp2iS4o
         Z+WIG13pKKMfzOEsJivw/Oxk22STHgnBOWKZLPTaN5o1O1RToJh3stcXbNr+zXVQQv5r
         BfzjslHsBmowwdhig2CGJpKUn81sBZWPpBIzRrDZ8lf77kIHvLnvuCw028SBpe1ap9nU
         8CtFJtwlgsbB1FQMl3Z20wFatnOVK/DKnP8bDF1hyoUs7bLtDuWeyrGN/g/PFeU/HnkU
         qwCjbWiwfAJTvUCbPC/FGp4jGQ8tMmlvIei0OfaMW1IvSzyT5HAkyzswRBl0b16Os/le
         NZxw==
X-Gm-Message-State: AHQUAuZnxoal2KwAMRjIrOQN7y9VzPphBlwZqrZ6EbO/cp0EopMt608M
        dnR4oOV3SFTWDkp1ycrrQcEPvLO0AQ==
X-Google-Smtp-Source: AHgI3IYn2V6oFFy2kAe3b//vB9567tnSNHvUsoy5juN0lM0WfW1jir1J3r8aK4geTP5uVA1GoJWcIyo6Vg==
X-Received: by 2002:a24:d82:: with SMTP id 124mr2780889itx.10.1550160239377;
 Thu, 14 Feb 2019 08:03:59 -0800 (PST)
Date:   Thu, 14 Feb 2019 17:03:47 +0100
Message-Id: <20190214160347.13647-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH net v2] mm: page_alloc: fix ref bias in page_frag_alloc() for
 1-byte allocs
From:   Jann Horn <jannh@google.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        jannh@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        alexander.duyck@gmail.com
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

Per Alexander Duyck's request, use PAGE_FRAG_CACHE_MAX_SIZE instead of
nc->size for the bias in the hope of making the generated code slightly
faster.

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
sending to davem as specified by akpm

changed in v2:
 - use PAGE_FRAG_CACHE_MAX_SIZE instead of nc->size for refcount bias
   (Alexander Duyck)

 mm/page_alloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 35fdde041f5c..7f79b78bc829 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4675,11 +4675,11 @@ void *page_frag_alloc(struct page_frag_cache *nc,
 		/* Even if we own the page, we do not use atomic_set().
 		 * This would break get_page_unless_zero() users.
 		 */
-		page_ref_add(page, size - 1);
+		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
 
 		/* reset page count bias and offset to start of new frag */
 		nc->pfmemalloc = page_is_pfmemalloc(page);
-		nc->pagecnt_bias = size;
+		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 		nc->offset = size;
 	}
 
@@ -4695,10 +4695,10 @@ void *page_frag_alloc(struct page_frag_cache *nc,
 		size = nc->size;
 #endif
 		/* OK, page count is 0, we can safely set it */
-		set_page_count(page, size);
+		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
 
 		/* reset page count bias and offset to start of new frag */
-		nc->pagecnt_bias = size;
+		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 		offset = size - fragsz;
 	}
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog

