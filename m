Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D169C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 18:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F062157C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 18:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F062157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeJUDHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 23:07:50 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37775 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJUDHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 23:07:49 -0400
Received: by mail-yb1-f196.google.com with SMTP id d18-v6so470230yba.4;
        Sat, 20 Oct 2018 11:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KkdtuFX2uavZKvEtnUbKPx2Udp2W7+C0YOnpZnMzffg=;
        b=DKSrhHiJS4mvR9NdPn9v9oGbYp6v91srxFUJvwrWd71K1FJX9xtszL7T33eI6USNM5
         i3yRIoRwx/ULw1rr/s3fXmw0xJAgn7rbIqW0D5apWoADOQE+Mod06nTbn+orhpvuzbGs
         w7x6uQDQo6M4e53OslCejlN8kFoOKSnttzkYDG8Jk0D73ijSBdp/yrZOOHFmCMZlePoe
         m9EwYl97FKFxi/5claUTTi0mW4mm27FgiIxBXizZUptKq+ZI+V1TCoIIcIOq4Gd0abpH
         Al/pEe/MZXI+5G0MGK5h7R4J63PwgkCNTA2BS8hTR7k1uSNOVxEOEHeHSPsGLZpW9zrF
         LrXg==
X-Gm-Message-State: ABuFfoi3j75wj0gUzBDvq5hi6SPgvLJkvSUUOeFNHHAMbgR5/7Z9F4mN
        1Eft0cEdoYVBnr3b9k0/XHk=
X-Google-Smtp-Source: ACcGV61iqM4jLAZJMdJnAzbS+++7R/6Q/sfZEV3s0jVPmljHLnR6EUnrgmw7olZnY2WDxTmpBXCxQQ==
X-Received: by 2002:a25:51c7:: with SMTP id f190-v6mr27659736ybb.426.1540061786997;
        Sat, 20 Oct 2018 11:56:26 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.3])
        by smtp.gmail.com with ESMTPSA id h63-v6sm1977456ywb.110.2018.10.20.11.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Oct 2018 11:56:26 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>, kernel-team@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 2/2] blkcg: reassociate bios when make_request() is called recursively
Date:   Sat, 20 Oct 2018 14:56:12 -0400
Message-Id: <20181020185612.51587-3-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181020185612.51587-1-dennis@kernel.org>
References: <20181020185612.51587-1-dennis@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When submitting a bio, multiple recursive calls to make_request() may
occur. This causes the initial associate done in blkcg_bio_issue_check()
to be incorrect and reference the prior request_queue. This introduces
a helper to do reassociation when make_request() is recursively called.

Fixes: a7b39b4e961c ("blkcg: always associate a bio with a blkg")
Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
Tested-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
 block/bio.c         | 20 ++++++++++++++++++++
 block/blk-core.c    |  1 +
 include/linux/bio.h |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 17a8b0aa7050..bbfeb4ee2892 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2083,6 +2083,26 @@ int bio_associate_create_blkg(struct request_queue *q, struct bio *bio)
 	return ret;
 }
 
+/**
+ * bio_reassociate_blkg - reassociate a bio with a blkg from q
+ * @q: request_queue where bio is going
+ * @bio: target bio
+ *
+ * When submitting a bio, multiple recursive calls to make_request() may occur.
+ * This causes the initial associate done in blkcg_bio_issue_check() to be
+ * incorrect and reference the prior request_queue.  This performs reassociation
+ * when this situation happens.
+ */
+int bio_reassociate_blkg(struct request_queue *q, struct bio *bio)
+{
+	if (bio->bi_blkg) {
+		blkg_put(bio->bi_blkg);
+		bio->bi_blkg = NULL;
+	}
+
+	return bio_associate_create_blkg(q, bio);
+}
+
 /**
  * bio_disassociate_task - undo bio_associate_current()
  * @bio: target bio
diff --git a/block/blk-core.c b/block/blk-core.c
index cdfabc5646da..3ed60723e242 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2433,6 +2433,7 @@ blk_qc_t generic_make_request(struct bio *bio)
 			if (q)
 				blk_queue_exit(q);
 			q = bio->bi_disk->queue;
+			bio_reassociate_blkg(q, bio);
 			flags = 0;
 			if (bio->bi_opf & REQ_NOWAIT)
 				flags = BLK_MQ_REQ_NOWAIT;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f447b0ebb288..b47c7f716731 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -514,6 +514,7 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg);
 int bio_associate_blkg_from_css(struct bio *bio,
 				struct cgroup_subsys_state *css);
 int bio_associate_create_blkg(struct request_queue *q, struct bio *bio);
+int bio_reassociate_blkg(struct request_queue *q, struct bio *bio);
 void bio_disassociate_task(struct bio *bio);
 void bio_clone_blkg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
@@ -522,6 +523,8 @@ static inline int bio_associate_blkg_from_css(struct bio *bio,
 { return 0; }
 static inline int bio_associate_create_blkg(struct request_queue *q,
 					    struct bio *bio) { return 0; }
+static inline int bio_reassociate_blkg(struct request_queue *q, struct bio *bio)
+{ return 0; }
 static inline void bio_disassociate_task(struct bio *bio) { }
 static inline void bio_clone_blkg_association(struct bio *dst,
 					      struct bio *src) { }
-- 
2.17.1

