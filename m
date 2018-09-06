Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1633C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7355D20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeZpxhh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7355D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbeIGBsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:48:30 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37342 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbeIGBs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:48:29 -0400
Received: by mail-yw1-f66.google.com with SMTP id x83-v6so4639316ywd.4;
        Thu, 06 Sep 2018 14:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kr3LadMM0rKDZvlg+vJ7kD1QWB4QzxFif1xXQ0yMxjc=;
        b=ZeZpxhh4NEZv4hYBp68PyrfCC0g+1qTP3Rhy+NXhcSydhMm0GfmM87ZAPdoUTGSJZi
         Z6W5mzx0bvD20f3HhwNvVjLOdnAshBVo6hEuEcmNNi87Fm/1iHc3Q/nh7rDac5c5ivkQ
         uzWv/A39qHqXhs452FOg9BxGf74DSfo4D/2h7nTA2O+xF5dd87oYbblLLdJHmkhX8m3h
         TnKSxZJQVS/Dhjdvx0NbMe6AJZaUYq9kqdfqb36Un6sOt9/I51U4WqW9bowgkx2VpURi
         1fcRNwBMHiQjZpJ4NtzaChphgnLKR8wrUa94z9puMbuxJH8CTn7a9CWu0lqdOU16W54J
         9yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kr3LadMM0rKDZvlg+vJ7kD1QWB4QzxFif1xXQ0yMxjc=;
        b=JJe6i3Gb1FR7GLx3ewPOLH7MKXZsLni8eqc+LywJBIJVWdlKqrZel9vSMJYVZDIzVn
         IGMCGtktNsnNqCt0E0Vxihlr7VSYUXMmTYw3/RQBigIUPJ6EShq6pM0T87TNcWSFky8J
         BupgpLc6WNxVbPj4kmLJdC9ayStxML4VExeZ3jb7eb1YMc3i8ZBr31LPS4ck0ZWJesG4
         rjZYOe1jmwb8PrWTMU7bRlmqbHhSNfQPe9DhP15tWUfSVDTE6W+NNBmSX+r9kV9q3Dhk
         ffSngE+w4fECqikuoXB5VxxxiwMO4Wf2BLTkilRBTWdyUR/ZLT2mV6ra4Dyh6pQXW6Kb
         niBg==
X-Gm-Message-State: APzg51CQjvCdsFYdit6yH/mCB93kzMVbvfDaGPTk3M+cPW41Fn0ylsWT
        uUO80BQ2fk2h8CofRrOSnEg=
X-Google-Smtp-Source: ANB0VdYDHc19O4W3rLfcByE/9+VxOkRc5rraWB2zcF2Hu0LkpReLcrg9TQevJHDmCYjfXT83uiRKCA==
X-Received: by 2002:a81:a1d7:: with SMTP id y206-v6mr2549628ywg.212.1536268270871;
        Thu, 06 Sep 2018 14:11:10 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id u67-v6sm2032802ywa.56.2018.09.06.14.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:11:10 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 11/12] blkcg: change blkg reference counting to use percpu_ref
Date:   Thu,  6 Sep 2018 17:10:44 -0400
Message-Id: <20180906211045.29055-12-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180906211045.29055-1-dennisszhou@gmail.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

Now that every bio is associated with a blkg, this puts the use of
blkg_get, blkg_try_get, and blkg_put on the hot path. This switches over
the refcnt in blkg to use percpu_ref.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
---
v2: add call_rcu to blkg_release path.

 block/blk-cgroup.c         | 64 +++++++++++++++++++++++---------------
 include/linux/blk-cgroup.h | 15 +++------
 2 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 9f8aba29b7c1..1efd697c9019 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -84,6 +84,37 @@ static void blkg_free(struct blkcg_gq *blkg)
 	kfree(blkg);
 }
 
+static void __blkg_release(struct rcu_head *rcu)
+{
+	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
+
+	percpu_ref_exit(&blkg->refcnt);
+
+	/* release the blkcg and parent blkg refs this blkg has been holding */
+	css_put(&blkg->blkcg->css);
+	if (blkg->parent)
+		blkg_put(blkg->parent);
+
+	wb_congested_put(blkg->wb_congested);
+
+	blkg_free(blkg);
+}
+
+/*
+ * A group is RCU protected, but having an rcu lock does not mean that one
+ * can access all the fields of blkg and assume these are valid.  For
+ * example, don't try to follow throtl_data and request queue links.
+ *
+ * Having a reference to blkg under an rcu allows accesses to only values
+ * local to groups like group stats and group rate limits.
+ */
+static void blkg_release(struct percpu_ref *ref)
+{
+	struct blkcg_gq *blkg = container_of(ref, struct blkcg_gq, refcnt);
+
+	call_rcu(&blkg->rcu_head, __blkg_release);
+}
+
 /**
  * blkg_alloc - allocate a blkg
  * @blkcg: block cgroup the new blkg is associated with
@@ -110,7 +141,6 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	blkg->q = q;
 	INIT_LIST_HEAD(&blkg->q_node);
 	blkg->blkcg = blkcg;
-	atomic_set(&blkg->refcnt, 1);
 
 	/* root blkg uses @q->root_rl, init rl only for !root blkgs */
 	if (blkcg != &blkcg_root) {
@@ -217,6 +247,11 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 		blkg_get(blkg->parent);
 	}
 
+	ret = percpu_ref_init(&blkg->refcnt, blkg_release, 0,
+			      GFP_NOWAIT | __GFP_NOWARN);
+	if (ret)
+		goto err_cancel_ref;
+
 	/* invoke per-policy init */
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
@@ -249,6 +284,8 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 	blkg_put(blkg);
 	return ERR_PTR(ret);
 
+err_cancel_ref:
+	percpu_ref_exit(&blkg->refcnt);
 err_put_congested:
 	wb_congested_put(wb_congested);
 err_put_css:
@@ -386,7 +423,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	 * Put the reference taken at the time of creation so that when all
 	 * queues are gone, group can be destroyed.
 	 */
-	blkg_put(blkg);
+	percpu_ref_kill(&blkg->refcnt);
 }
 
 /**
@@ -413,29 +450,6 @@ static void blkg_destroy_all(struct request_queue *q)
 	q->root_rl.blkg = NULL;
 }
 
-/*
- * A group is RCU protected, but having an rcu lock does not mean that one
- * can access all the fields of blkg and assume these are valid.  For
- * example, don't try to follow throtl_data and request queue links.
- *
- * Having a reference to blkg under an rcu allows accesses to only values
- * local to groups like group stats and group rate limits.
- */
-void __blkg_release_rcu(struct rcu_head *rcu_head)
-{
-	struct blkcg_gq *blkg = container_of(rcu_head, struct blkcg_gq, rcu_head);
-
-	/* release the blkcg and parent blkg refs this blkg has been holding */
-	css_put(&blkg->blkcg->css);
-	if (blkg->parent)
-		blkg_put(blkg->parent);
-
-	wb_congested_put(blkg->wb_congested);
-
-	blkg_free(blkg);
-}
-EXPORT_SYMBOL_GPL(__blkg_release_rcu);
-
 /*
  * The next function used by blk_queue_for_each_rl().  It's a bit tricky
  * because the root blkg uses @q->root_rl instead of its own rl.
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 7964e7fc6521..f8edff271a17 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -126,7 +126,7 @@ struct blkcg_gq {
 	struct request_list		rl;
 
 	/* reference count */
-	atomic_t			refcnt;
+	struct percpu_ref		refcnt;
 
 	/* is this blkg online? protected by both blkcg and q locks */
 	bool				online;
@@ -490,8 +490,7 @@ static inline int blkg_path(struct blkcg_gq *blkg, char *buf, int buflen)
  */
 static inline void blkg_get(struct blkcg_gq *blkg)
 {
-	WARN_ON_ONCE(atomic_read(&blkg->refcnt) <= 0);
-	atomic_inc(&blkg->refcnt);
+	percpu_ref_get(&blkg->refcnt);
 }
 
 /**
@@ -503,7 +502,7 @@ static inline void blkg_get(struct blkcg_gq *blkg)
  */
 static inline struct blkcg_gq *blkg_try_get(struct blkcg_gq *blkg)
 {
-	if (atomic_inc_not_zero(&blkg->refcnt))
+	if (percpu_ref_tryget(&blkg->refcnt))
 		return blkg;
 	return NULL;
 }
@@ -517,23 +516,19 @@ static inline struct blkcg_gq *blkg_try_get(struct blkcg_gq *blkg)
  */
 static inline struct blkcg_gq *blkg_try_get_closest(struct blkcg_gq *blkg)
 {
-	while (!atomic_inc_not_zero(&blkg->refcnt))
+	while (!percpu_ref_tryget(&blkg->refcnt))
 		blkg = blkg->parent;
 
 	return blkg;
 }
 
-void __blkg_release_rcu(struct rcu_head *rcu);
-
 /**
  * blkg_put - put a blkg reference
  * @blkg: blkg to put
  */
 static inline void blkg_put(struct blkcg_gq *blkg)
 {
-	WARN_ON_ONCE(atomic_read(&blkg->refcnt) <= 0);
-	if (atomic_dec_and_test(&blkg->refcnt))
-		call_rcu(&blkg->rcu_head, __blkg_release_rcu);
+	percpu_ref_put(&blkg->refcnt);
 }
 
 /**
-- 
2.17.1

