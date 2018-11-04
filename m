Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7CDECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CEA2085A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9Z0DD4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CEA2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbeKDXJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:09:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731695AbeKDXJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:09:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83B522085A;
        Sun,  4 Nov 2018 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339661;
        bh=4yz+H6yCMY6hvEdFnbqCuw5Yp9MXp7hlNfxn1OGqh5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u9Z0DD4C/p1YTDquwVkXl30bEtnobDpyBy0jBiWvH6HnvN6odvez1Zo+08Cub4CT0
         ChtPA7mrzqhbybsn38SVyJirOx/pUPgy0T8dQi6qi/y2yYBaNQtYUv4Pq+wWYnjqPV
         6CAgMByHvWGcYGVMk74B2vj+b6DFwNJU2b+ug9bk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 02/15] mm: don't warn about large allocations for slab
Date:   Sun,  4 Nov 2018 08:54:04 -0500
Message-Id: <20181104135417.88671-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135417.88671-1-sashal@kernel.org>
References: <20181104135417.88671-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>

[ Upstream commit 61448479a9f2c954cde0cfe778cb6bec5d0a748d ]

Slub does not call kmalloc_slab() for sizes > KMALLOC_MAX_CACHE_SIZE,
instead it falls back to kmalloc_large().

For slab KMALLOC_MAX_CACHE_SIZE == KMALLOC_MAX_SIZE and it calls
kmalloc_slab() for all allocations relying on NULL return value for
over-sized allocations.

This inconsistency leads to unwanted warnings from kmalloc_slab() for
over-sized allocations for slab.  Returning NULL for failed allocations is
the expected behavior.

Make slub and slab code consistent by checking size >
KMALLOC_MAX_CACHE_SIZE in slab before calling kmalloc_slab().

While we are here also fix the check in kmalloc_slab().  We should check
against KMALLOC_MAX_CACHE_SIZE rather than KMALLOC_MAX_SIZE.  It all kinda
worked because for slab the constants are the same, and slub always checks
the size against KMALLOC_MAX_CACHE_SIZE before kmalloc_slab().  But if we
get there with size > KMALLOC_MAX_CACHE_SIZE anyhow bad things will
happen.  For example, in case of a newly introduced bug in slub code.

Also move the check in kmalloc_slab() from function entry to the size >
192 case.  This partially compensates for the additional check in slab
code and makes slub code a bit faster (at least theoretically).

Also drop __GFP_NOWARN in the warning check.  This warning means a bug in
slab code itself, user-passed flags have nothing to do with it.

Nothing of this affects slob.

Link: http://lkml.kernel.org/r/20180927171502.226522-1-dvyukov@gmail.com
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: syzbot+87829a10073277282ad1@syzkaller.appspotmail.com
Reported-by: syzbot+ef4e8fc3a06e9019bb40@syzkaller.appspotmail.com
Reported-by: syzbot+6e438f4036df52cbb863@syzkaller.appspotmail.com
Reported-by: syzbot+8574471d8734457d98aa@syzkaller.appspotmail.com
Reported-by: syzbot+af1504df0807a083dbd9@syzkaller.appspotmail.com
Acked-by: Christoph Lameter <cl@linux.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slab.c        |  4 ++++
 mm/slab_common.c | 12 ++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index fa49c01225a7..49a64b8c3606 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3488,6 +3488,8 @@ __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
 {
 	struct kmem_cache *cachep;
 
+	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
+		return NULL;
 	cachep = kmalloc_slab(size, flags);
 	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
 		return cachep;
@@ -3520,6 +3522,8 @@ static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
 	struct kmem_cache *cachep;
 	void *ret;
 
+	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
+		return NULL;
 	cachep = kmalloc_slab(size, flags);
 	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
 		return cachep;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 01e7246de8df..2e7c960d6a06 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -852,18 +852,18 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
 {
 	int index;
 
-	if (unlikely(size > KMALLOC_MAX_SIZE)) {
-		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
-		return NULL;
-	}
-
 	if (size <= 192) {
 		if (!size)
 			return ZERO_SIZE_PTR;
 
 		index = size_index[size_index_elem(size)];
-	} else
+	} else {
+		if (unlikely(size > KMALLOC_MAX_CACHE_SIZE)) {
+			WARN_ON(1);
+			return NULL;
+		}
 		index = fls(size - 1);
+	}
 
 #ifdef CONFIG_ZONE_DMA
 	if (unlikely((flags & GFP_DMA)))
-- 
2.17.1

