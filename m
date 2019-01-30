Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B347FC282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B23521473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbfA3ERS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 23:17:18 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:46667 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727527AbfA3ERS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 23:17:18 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 30 Jan 2019 14:47:14 +1030
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gohJJ-0000dT-MN; Wed, 30 Jan 2019 15:17:13 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92-RC4)
        (envelope-from <david@fromorbit.com>)
        id 1gohJJ-0007eI-Kc; Wed, 30 Jan 2019 15:17:13 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     guro@fb.com, akpm@linux-foundation.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com
Subject: [PATCH 2/2] Revert "mm: slowly shrink slabs with a relatively small number of objects"
Date:   Wed, 30 Jan 2019 15:17:07 +1100
Message-Id: <20190130041707.27750-3-david@fromorbit.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130041707.27750-1-david@fromorbit.com>
References: <20190130041707.27750-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

This reverts commit 172b06c32b949759fe6313abec514bc4f15014f4.

This change changes the agressiveness of shrinker reclaim, causing
small cache and low priority reclaim to greatly increase
scanning pressure on small caches. As a result, light memory
pressure has a disproportionate affect on small caches, and causes
large caches to be reclaimed much faster than previously.

As a result, it greatly perturbs the delicate balance of the VFS
caches (dentry/inode vs file page cache) such that the inode/dentry
caches are reclaimed much, much faster than the page cache and this
drives us into several other caching imbalance related problems.

As such, this is a bad change and needs to be reverted.

[ Needs some massaging to retain the later seekless shrinker
modifications. ]

cc: <stable@vger.kernel.org>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 mm/vmscan.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a714c4f800e9..e979705bbf32 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -491,16 +491,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		delta = freeable / 2;
 	}
 
-	/*
-	 * Make sure we apply some minimal pressure on default priority
-	 * even on small cgroups. Stale objects are not only consuming memory
-	 * by themselves, but can also hold a reference to a dying cgroup,
-	 * preventing it from being reclaimed. A dying cgroup with all
-	 * corresponding structures like per-cpu stats and kmem caches
-	 * can be really big, so it may lead to a significant waste of memory.
-	 */
-	delta = max_t(unsigned long long, delta, min(freeable, batch_size));
-
 	total_scan += delta;
 	if (total_scan < 0) {
 		pr_err("shrink_slab: %pF negative objects to delete nr=%ld\n",
-- 
2.20.1

