Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA21C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05DD20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xjt8Rj/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05DD20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeIGBsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:48:23 -0400
Received: from mail-yb1-f176.google.com ([209.85.219.176]:41095 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbeIGBsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:48:20 -0400
Received: by mail-yb1-f176.google.com with SMTP id u33-v6so4683033ybi.8;
        Thu, 06 Sep 2018 14:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9fSjYS7pH7B4/venjHfFij4498k8UtH7vgHaNhOEgTg=;
        b=Xjt8Rj/caMChxbPw8MAFk1iciOcYFIbH1Uoudk1BTOmfck0imc0XJrUveUUvC9FGBX
         Ngi3dHn5xZ3YBbQnNkoQYEL2g3r1Hl9Bmu/1Q3lSoPf7F61foGyN5dfUls1HHKNpBTLI
         43vrPeSZZxde0ju6p2aJFW7vG5zNfNQzD8krlsiJSQpWyPqoXfDgB0ZJGkPhHiC66ahu
         oCLWIX/1XAn9Qn1ap3blBx7MYf5IJHir0/ccdINYAy+8XPkNukPTJ2zdKoaqPNSvPIeb
         TDAaJoKLlJ4e0NZsD/00XUQRocrNnQXPOxS2iEn9db6g27Z0VHtMEh9yiNEHj60H1e84
         rnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9fSjYS7pH7B4/venjHfFij4498k8UtH7vgHaNhOEgTg=;
        b=c7ugj1MZafcCmR7CDjuFEu5Tb51HzJ8IMoiM8G3IOthGuwAaMKJl+bLrNT8Mr9TMZZ
         RsG4hbDmdBqR/E0+TS9KB68QR2Bp0+Y5j+OP7vYXFd3zXanTjt5z6qUysWkQzdihap21
         ml8GRWZjPLhd7y8EkehyLbVMuog2dOWNkCyI24b2v9/Z3Ic1ornXFYqZ53uR2oOyZ88y
         rCkrGhLMpky/89ZaIZ6wT7ZNrDgQLD8k32SScJoSbNwBH0j8iZtLtic32yfBamexoEll
         K4RRLeXJIcRBUki6uI9yt7TbhWzVukSyyx9Nnduxep3jVS5B9aLwwSrJvOmdHw3SKM2g
         vFdQ==
X-Gm-Message-State: APzg51CSwr7ySy2VANYCWL0hZBOk4cgNn+15mD4c7odqmcZelVrmdmsE
        ol1iuS+CiDrsr8T15BVehgraFxNgCZM=
X-Google-Smtp-Source: ANB0VdZHP3bMN/t9iXcNGARIAuXSlMaYNaD3+B9jNqoOG3dovXAU8wSIlrYpjt3sOBZktQuKsQM2JA==
X-Received: by 2002:a25:a568:: with SMTP id h95-v6mr2561551ybi.303.1536268261962;
        Thu, 06 Sep 2018 14:11:01 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id u67-v6sm2032802ywa.56.2018.09.06.14.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:11:01 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 04/12] blkcg: always associate a bio with a blkg
Date:   Thu,  6 Sep 2018 17:10:37 -0400
Message-Id: <20180906211045.29055-5-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180906211045.29055-1-dennisszhou@gmail.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

Previously, blkg's were only assigned as needed by blk-iolatency and
blk-throttle. bio->css was also always being associated while blkg was
being looked up and then thrown away in blkcg_bio_issue_check.

This patch begins the cleanup of bio->css and bio->bi_blkg by always
associating a blkg in blkcg_bio_issue_check. This tries to create the
blkg, but if it is not possible, falls back to using the root_blkg of
the request_queue. Therefore, a bio will always be associated with a
blkg. The duplicate association logic is removed from blk-throttle and
blk-iolatency.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/bio.c                | 38 ++++++++++++++++++++++++++++++++++++++
 block/blk-iolatency.c      | 24 ++----------------------
 block/blk-throttle.c       |  5 +----
 include/linux/bio.h        |  3 +++
 include/linux/blk-cgroup.h | 16 ++--------------
 5 files changed, 46 insertions(+), 40 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index cd947ad4cf08..b2b3fddfcd6f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2025,6 +2025,41 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
 	return 0;
 }
 
+/**
+ * bio_associate_create_blkg - associate a bio with a blkg from q
+ * @q: request_queue where bio is going
+ * @bio: target bio
+ *
+ * Associate @bio with the blkg found from the bio's css and the request_queue.
+ * If one is not found, bio_lookup_blkg creates the blkg.
+ */
+int bio_associate_create_blkg(struct request_queue *q, struct bio *bio)
+{
+	struct blkcg *blkcg;
+	struct blkcg_gq *blkg;
+	int ret = 0;
+
+	/* someone has already associated this bio with a blkg */
+	if (bio->bi_blkg)
+		return ret;
+
+	rcu_read_lock();
+
+	bio_associate_blkcg(bio, NULL);
+	blkcg = bio_blkcg(bio);
+
+	if (!blkcg->css.parent) {
+		ret = bio_associate_blkg(bio, q->root_blkg);
+	} else {
+		blkg = blkg_lookup_create(blkcg, q);
+
+		ret = bio_associate_blkg(bio, blkg);
+	}
+
+	rcu_read_unlock();
+	return ret;
+}
+
 /**
  * bio_disassociate_task - undo bio_associate_current()
  * @bio: target bio
@@ -2054,6 +2089,9 @@ void bio_clone_blkcg_association(struct bio *dst, struct bio *src)
 {
 	if (src->bi_css)
 		WARN_ON(bio_associate_blkcg(dst, src->bi_css));
+
+	if (src->bi_blkg)
+		bio_associate_blkg(dst, src->bi_blkg);
 }
 EXPORT_SYMBOL_GPL(bio_clone_blkcg_association);
 #endif /* CONFIG_BLK_CGROUP */
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 22b2ff0440cc..79a7549e2062 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -395,34 +395,14 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio,
 				     spinlock_t *lock)
 {
 	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
-	struct blkcg *blkcg;
-	struct blkcg_gq *blkg;
-	struct request_queue *q = rqos->q;
+	struct blkcg_gq *blkg = bio->bi_blkg;
 	bool issue_as_root = bio_issue_as_root_blkg(bio);
 
 	if (!blk_iolatency_enabled(blkiolat))
 		return;
 
-	rcu_read_lock();
-	bio_associate_blkcg(bio, NULL);
-	blkcg = bio_blkcg(bio);
-	blkg = blkg_lookup(blkcg, q);
-	if (unlikely(!blkg)) {
-		if (!lock)
-			spin_lock_irq(q->queue_lock);
-		blkg = __blkg_lookup_create(blkcg, q);
-		if (IS_ERR(blkg))
-			blkg = NULL;
-		if (!lock)
-			spin_unlock_irq(q->queue_lock);
-	}
-	if (!blkg)
-		goto out;
-
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
-	bio_associate_blkg(bio, blkg);
-out:
-	rcu_read_unlock();
+
 	while (blkg && blkg->parent) {
 		struct iolatency_grp *iolat = blkg_to_lat(blkg);
 		if (!iolat) {
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 01d0620a4e4a..b7b5cc4defc2 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2129,9 +2129,6 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
 {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	/* fallback to root_blkg if we fail to get a blkg ref */
-	if (bio->bi_css && (bio_associate_blkg(bio, tg_to_blkg(tg)) == -ENODEV))
-		bio_associate_blkg(bio, bio->bi_disk->queue->root_blkg);
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
 #endif
 }
@@ -2140,7 +2137,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		    struct bio *bio)
 {
 	struct throtl_qnode *qn = NULL;
-	struct throtl_grp *tg = blkg_to_tg(blkg ?: q->root_blkg);
+	struct throtl_grp *tg = blkg_to_tg(blkg);
 	struct throtl_service_queue *sq;
 	bool rw = bio_data_dir(bio);
 	bool throttled = false;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 51371740d2a8..d1435643f5b7 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -556,11 +556,14 @@ static inline int bio_associate_blkcg_from_page(struct bio *bio,
 #ifdef CONFIG_BLK_CGROUP
 int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
 int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg);
+int bio_associate_create_blkg(struct request_queue *q, struct bio *bio);
 void bio_disassociate_task(struct bio *bio);
 void bio_clone_blkcg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
 static inline int bio_associate_blkcg(struct bio *bio,
 			struct cgroup_subsys_state *blkcg_css) { return 0; }
+static inline int bio_associate_create_blkg(struct request_queue *q,
+					    struct bio *bio) { return 0; }
 static inline void bio_disassociate_task(struct bio *bio) { }
 static inline void bio_clone_blkcg_association(struct bio *dst,
 			struct bio *src) { }
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 1fbff1bbb651..6e33ad1d92b4 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -900,29 +900,17 @@ static inline bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio)
 {
-	struct blkcg *blkcg;
 	struct blkcg_gq *blkg;
 	bool throtl = false;
 
 	rcu_read_lock();
 
-	/* associate blkcg if bio hasn't attached one */
-	bio_associate_blkcg(bio, NULL);
-	blkcg = bio_blkcg(bio);
-
-	blkg = blkg_lookup(blkcg, q);
-	if (unlikely(!blkg)) {
-		spin_lock_irq(q->queue_lock);
-		blkg = __blkg_lookup_create(blkcg, q);
-		if (IS_ERR(blkg))
-			blkg = NULL;
-		spin_unlock_irq(q->queue_lock);
-	}
+	bio_associate_create_blkg(q, bio);
+	blkg = bio->bi_blkg;
 
 	throtl = blk_throtl_bio(q, blkg, bio);
 
 	if (!throtl) {
-		blkg = blkg ?: q->root_blkg;
 		/*
 		 * If the bio is flagged with BIO_QUEUE_ENTERED it means this
 		 * is a split bio and we would have already accounted for the
-- 
2.17.1

