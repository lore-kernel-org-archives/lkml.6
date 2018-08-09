Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E48C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D71921B31
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D71921B31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbeHILRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:17:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:35072 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727601AbeHILRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:17:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1AE7CAEBD;
        Thu,  9 Aug 2018 08:53:23 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Paul Menzel <pmenzel+linux-mm@molgen.mpg.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH] mm, slub: restore the original intention of prefetch_freepointer()
Date:   Thu,  9 Aug 2018 10:52:45 +0200
Message-Id: <20180809085245.22448-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cc93080f-2d22-71fe-a1fb-d55d1fcc2441@suse.cz>
References: <cc93080f-2d22-71fe-a1fb-d55d1fcc2441@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In SLUB, prefetch_freepointer() is used when allocating an object from cache's
freelist, to make sure the next object in the list is cache-hot, since it's
probable it will be allocated soon.

Commit 2482ddec670f ("mm: add SLUB free list pointer obfuscation") has
unintentionally changed the prefetch in a way where the prefetch is turned to a
real fetch, and only the next->next pointer is prefetched. In case there is not
a stream of allocations that would benefit from prefetching, the extra real
fetch might add a useless cache miss to the allocation. Restore the previous
behavior.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>
Cc: Daniel Micay <danielmicay@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
While I don't expect this to be causing the bug at hand, it's worth fixing.
For the bug it might mean that the page fault moves elsewhere.

 mm/slub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 51258eff4178..ce2b9e5cea77 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -271,8 +271,7 @@ static inline void *get_freepointer(struct kmem_cache *s, void *object)
 
 static void prefetch_freepointer(const struct kmem_cache *s, void *object)
 {
-	if (object)
-		prefetch(freelist_dereference(s, object + s->offset));
+	prefetch(object + s->offset);
 }
 
 static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
-- 
2.18.0

