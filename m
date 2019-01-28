Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E949BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3402171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfA1TgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:36:14 -0500
Received: from shelob.surriel.com ([96.67.55.147]:42906 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfA1TgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:36:11 -0500
Received: from [2001:470:1f07:12aa:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1goChS-0006oM-NH; Mon, 28 Jan 2019 14:36:06 -0500
Date:   Mon, 28 Jan 2019 14:35:35 -0500
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>, Chris Mason <clm@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm,slab,vmscan: accumulate gradual pressure on small slabs
Message-ID: <20190128143535.7767c397@imladris.surriel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few issues with the way the number of slab objects to
scan is calculated in do_shrink_slab.  First, for zero-seek slabs,
we could leave the last object around forever. That could result
in pinning a dying cgroup into memory, instead of reclaiming it.
The fix for that is trivial.

Secondly, small slabs receive much more pressure, relative to their
size, than larger slabs, due to "rounding up" the minimum number of
scanned objects to batch_size.

We can keep the pressure on all slabs equal relative to their size
by accumulating the scan pressure on small slabs over time, resulting
in sometimes scanning an object, instead of always scanning several.

This results in lower system CPU use, and a lower major fault rate,
as actively used entries from smaller caches get reclaimed less
aggressively, and need to be reloaded/recreated less often.

Fixes: 4b85afbdacd2 ("mm: zero-seek shrinkers")
Fixes: 172b06c32b94 ("mm: slowly shrink slabs with a relatively small number of objects")
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Chris Mason <clm@fb.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: kernel-team@fb.com
Tested-by: Chris Mason <clm@fb.com>
---
 include/linux/shrinker.h |  1 +
 mm/vmscan.c              | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 9443cafd1969..7a9a1a0f935c 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -65,6 +65,7 @@ struct shrinker {
 
 	long batch;	/* reclaim batch size, 0 = default */
 	int seeks;	/* seeks to recreate an obj */
+	int small_scan;	/* accumulate pressure on slabs with few objects */
 	unsigned flags;
 
 	/* These are for internal use */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a714c4f800e9..0e375bd7a8b6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -488,18 +488,28 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		 * them aggressively under memory pressure to keep
 		 * them from causing refetches in the IO caches.
 		 */
-		delta = freeable / 2;
+		delta = (freeable + 1)/ 2;
 	}
 
 	/*
 	 * Make sure we apply some minimal pressure on default priority
-	 * even on small cgroups. Stale objects are not only consuming memory
+	 * even on small cgroups, by accumulating pressure across multiple
+	 * slab shrinker runs. Stale objects are not only consuming memory
 	 * by themselves, but can also hold a reference to a dying cgroup,
 	 * preventing it from being reclaimed. A dying cgroup with all
 	 * corresponding structures like per-cpu stats and kmem caches
 	 * can be really big, so it may lead to a significant waste of memory.
 	 */
-	delta = max_t(unsigned long long, delta, min(freeable, batch_size));
+	if (!delta) {
+		shrinker->small_scan += freeable;
+
+		delta = shrinker->small_scan >> priority;
+		shrinker->small_scan -= delta << priority;
+
+		delta *= 4;
+		do_div(delta, shrinker->seeks);
+
+	}
 
 	total_scan += delta;
 	if (total_scan < 0) {

