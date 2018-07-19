Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A87ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BDE20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="fiNgZt0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BDE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbeGTAf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:35:59 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:60379 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbeGTAfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:35:53 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 356FE8365F;
        Fri, 20 Jul 2018 11:50:22 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1532044222;
        bh=d7Zq3KdnRzs5/bzq7D/gl41p3G+03wOCg8YjFYqGRxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fiNgZt0yaex9XVgEaEZLfdozrdGYkP9S87vqRcQoyz1aADVXolvIWUYm1EhH2COfz
         KZ9Lb4iace3DgnjNrgjDmdTftvOoMRphsqrD0vYSmSL8BOiM/tYrVwpSosgSPeWKsk
         aSTkVR+5ucnexY0al3EYleOCMFAR4cIFwnA7b7zc=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b5123be0002>; Fri, 20 Jul 2018 11:50:22 +1200
Received: from theunsv-dl.ws.atlnz.lc (theunsv-dl.ws.atlnz.lc [10.33.14.29])
        by smtp (Postfix) with ESMTP id 08F1413EED3;
        Fri, 20 Jul 2018 11:50:23 +1200 (NZST)
Received: by theunsv-dl.ws.atlnz.lc (Postfix, from userid 1451)
        id EA8535A04AF; Fri, 20 Jul 2018 11:50:21 +1200 (NZST)
From:   Theuns Verwoerd <theuns.verwoerd@alliedtelesis.co.nz>
To:     dwmw2@infradead.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Theuns Verwoerd <theuns.verwoerd@alliedtelesis.co.nz>
Subject: [PATCH 1/2] jffs2: Provide forced dirty node cleanup via POLL signal
Date:   Fri, 20 Jul 2018 11:50:11 +1200
Message-Id: <bcf5bf66a41e73c0e8608b9cd386d8152ee2a15e.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
References: <cover.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Secure deletion under JFFS2 is complicated by the log of dirty nodes
that may contain obsoleted versions of sensitive data.  There is an
existing mechanism to trigger a single gc step via -HUP signal;
extend this to trigger gc collection of all currently-dirty data via
a -POLL signal.

On receipt of -POLL, the gc will retire the current nextblock, store
the last dirty list entry, and keep continuously cycling collection
until that entry has been cleaned.

Signed-off-by: Theuns Verwoerd <theuns.verwoerd@alliedtelesis.co.nz>
---
 fs/jffs2/background.c  | 31 ++++++++++++++++++++++++++++++-
 fs/jffs2/build.c       |  1 +
 fs/jffs2/jffs2_fs_sb.h |  2 ++
 fs/jffs2/nodelist.h    |  1 +
 fs/jffs2/nodemgmt.c    |  6 +++++-
 5 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/fs/jffs2/background.c b/fs/jffs2/background.c
index 453a6a1fff34..4c29e2d323c4 100644
--- a/fs/jffs2/background.c
+++ b/fs/jffs2/background.c
@@ -72,15 +72,27 @@ void jffs2_stop_garbage_collect_thread(struct jffs2_sb_info *c)
 		wait_for_completion(&c->gc_thread_exit);
 }
 
+static int list_contains(struct list_head *list, struct list_head *entry)
+{
+	struct list_head *ptr;
+
+	list_for_each(ptr, list) {
+		if (ptr == entry)
+			return 1;
+	}
+	return 0;
+}
+
 static int jffs2_garbage_collect_thread(void *_c)
 {
 	struct jffs2_sb_info *c = _c;
 	sigset_t hupmask;
 
-	siginitset(&hupmask, sigmask(SIGHUP));
+	siginitset(&hupmask, sigmask(SIGHUP) | sigmask(SIGPOLL));
 	allow_signal(SIGKILL);
 	allow_signal(SIGSTOP);
 	allow_signal(SIGHUP);
+	allow_signal(SIGPOLL);
 
 	c->gc_task = current;
 	complete(&c->gc_thread_start);
@@ -143,6 +155,15 @@ static int jffs2_garbage_collect_thread(void *_c)
 				jffs2_dbg(1, "%s(): SIGHUP received\n",
 					  __func__);
 				break;
+			case SIGPOLL:
+				if (!c->tidemark) {
+					/* Force retire current half-used block */
+					if (c->nextblock)
+						jffs2_close_nextblock(c, c->nextblock);
+					/* Keep going until we hit the last element in the (now) current dirty list */
+					c->tidemark = c->dirty_list.prev;
+				}
+				break;
 			default:
 				jffs2_dbg(1, "%s(): signal %ld received\n",
 					  __func__, signr);
@@ -156,6 +177,14 @@ static int jffs2_garbage_collect_thread(void *_c)
 			pr_notice("No space for garbage collection. Aborting GC thread\n");
 			goto die;
 		}
+		/* If we're working towards a tidemark, keep going until it's clean */
+		if (c->tidemark && (
+			!list_empty(&c->very_dirty_list) ||
+			list_contains(&c->dirty_list, c->tidemark) ||
+			(&c->gcblock->list) == c->tidemark))
+			goto again;
+		else if (c->tidemark)
+			c->tidemark = NULL;
 	}
  die:
 	spin_lock(&c->erase_completion_lock);
diff --git a/fs/jffs2/build.c b/fs/jffs2/build.c
index b288c8ae1236..7d128705648f 100644
--- a/fs/jffs2/build.c
+++ b/fs/jffs2/build.c
@@ -405,6 +405,7 @@ int jffs2_do_mount_fs(struct jffs2_sb_info *c)
 	INIT_LIST_HEAD(&c->bad_used_list);
 	c->highest_ino = 1;
 	c->summary = NULL;
+	c->tidemark = NULL;
 
 	ret = jffs2_sum_init(c);
 	if (ret)
diff --git a/fs/jffs2/jffs2_fs_sb.h b/fs/jffs2/jffs2_fs_sb.h
index 778275f48a87..25960589e3c0 100644
--- a/fs/jffs2/jffs2_fs_sb.h
+++ b/fs/jffs2/jffs2_fs_sb.h
@@ -87,6 +87,8 @@ struct jffs2_sb_info {
 
 	uint32_t nospc_dirty_size;
 
+	struct list_head *tidemark;		/* Last dirty block at the time a full sync started */
+
 	uint32_t nr_blocks;
 	struct jffs2_eraseblock *blocks;	/* The whole array of blocks. Used for getting blocks
 						 * from the offset (blocks[ofs / sector_size]) */
diff --git a/fs/jffs2/nodelist.h b/fs/jffs2/nodelist.h
index 0637271f3770..73348bc7f545 100644
--- a/fs/jffs2/nodelist.h
+++ b/fs/jffs2/nodelist.h
@@ -386,6 +386,7 @@ int jffs2_reserve_space(struct jffs2_sb_info *c, uint32_t minsize,
 			uint32_t *len, int prio, uint32_t sumsize);
 int jffs2_reserve_space_gc(struct jffs2_sb_info *c, uint32_t minsize,
 			uint32_t *len, uint32_t sumsize);
+void jffs2_close_nextblock(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb);
 struct jffs2_raw_node_ref *jffs2_add_physical_node_ref(struct jffs2_sb_info *c, 
 						       uint32_t ofs, uint32_t len,
 						       struct jffs2_inode_cache *ic);
diff --git a/fs/jffs2/nodemgmt.c b/fs/jffs2/nodemgmt.c
index a7bbe879cfc3..c07c53f69516 100644
--- a/fs/jffs2/nodemgmt.c
+++ b/fs/jffs2/nodemgmt.c
@@ -240,7 +240,7 @@ int jffs2_reserve_space_gc(struct jffs2_sb_info *c, uint32_t minsize,
 
 /* Classify nextblock (clean, dirty of verydirty) and force to select an other one */
 
-static void jffs2_close_nextblock(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb)
+void jffs2_close_nextblock(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb)
 {
 
 	if (c->nextblock == NULL) {
@@ -875,6 +875,10 @@ int jffs2_thread_should_wake(struct jffs2_sb_info *c)
 		}
 	}
 
+	/* Pending cleanup, always wake */
+	if (c->tidemark)
+		ret = 1;
+
 	jffs2_dbg(1, "%s(): nr_free_blocks %d, nr_erasing_blocks %d, dirty_size 0x%x, vdirty_blocks %d: %s\n",
 		  __func__, c->nr_free_blocks, c->nr_erasing_blocks,
 		  c->dirty_size, nr_very_dirty, ret ? "yes" : "no");
-- 
2.18.0

