Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA2DC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19123214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="QOfkiyQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19123214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeJISaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:30:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43799 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeJISai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:30:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so659799plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AmFRqrNAlDrl6j89zyFw74SjJSrmvoigvbv7ouBR6SI=;
        b=QOfkiyQ9fVINpvKsv9zGV63BpJV/WL9bBl+HbpwZOerwm067gd9nWp7QrhiIOojeNJ
         KlBRuPl6G3YknkBO2tXuQZwL7XIu8RWSw4Uq7wsuqTPW7wCzEUSkpzYWzsAh+1jHpTco
         LqniOI9Zm2glzuZYjjlIW69RTq5CAMPRnEREZUxNTVxFT6xloUOatHnYRQkb9LhHBLwT
         QLKASGCx8Sn9mho5ZglFVZrgbWvlwDRCM6QwMTzb41LoC0BuiAH6AwedAukqo8LVM2e4
         ut83llZhdI5ZOtGZCZOpo9rbURCUu5sq7L4FAcXXjyRGSPHocAZfl1faU4wdJwgs2zj/
         Y1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmFRqrNAlDrl6j89zyFw74SjJSrmvoigvbv7ouBR6SI=;
        b=Me4qEdAnnpqBKverLvOLO5d/ZEfwqfl4iUt5oB4W/v9WK+FYzfMalTPW+JbtnQAR43
         BT+x1RW5ynkTnr3ObELQw61Mj2v6+OqC6jOqRekEZjOCocOWSQ79ZrGaEpB2XU2Hw/sG
         /xbOw6wubm8+7rmfqYPj7e2UtHdpglm6s/4Vl9is/PsPxZAAu1QT9F4FppwfaXz9BiyL
         YAVP5aVQxQn/3baF9MsBUGm4lHr4YOnbQLEA+skt+mkBwytsQ3R3S73h/i07leQnDsrU
         PqNGky/sWXo43QLhxDaHYfDa1RN+8uHg7Ye8WViQ+ziL+IoCkaAylX6biPduM3xO7yFQ
         W79A==
X-Gm-Message-State: ABuFfogUEk2etdOxfdcVmrJVM4AUTiwFc/dns6vN9jr8NmR4rwcUjqga
        d4x0JKvwSLwY209QJNC9e2pImg==
X-Google-Smtp-Source: ACcGV62VbQ5vKp+vBY0Na8XqHjCauXjR3EYryMWqcvrMBiQYjAXEpxRQcDDfBDC178rtDrZhg6KnSg==
X-Received: by 2002:a17:902:3341:: with SMTP id a59-v6mr16828620plc.138.1539083651576;
        Tue, 09 Oct 2018 04:14:11 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:14:10 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 17/45] lightnvm: pblk: allocate line map bitmaps using a mempool
Date:   Tue,  9 Oct 2018 13:11:47 +0200
Message-Id: <20181009111215.7653-18-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Line map bitmap allocations are fairly large and can fail. Allocation
failures are fatal to pblk, stopping the write pipeline. To avoid this,
allocate the bitmaps using a mempool instead.

Mempool allocations never fail if called from a process context,
and pblk *should* only allocate map bitmaps in process context,
but keep the failure handling for robustness sake.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c     | 22 +++++++++++++++-------
 drivers/lightnvm/pblk-init.c     | 18 ++++++++++++++++++
 drivers/lightnvm/pblk-recovery.c |  2 +-
 drivers/lightnvm/pblk.h          |  4 ++++
 4 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index a31417682c90..e1207a4f9d54 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1049,15 +1049,18 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
 static int pblk_line_alloc_bitmaps(struct pblk *pblk, struct pblk_line *line)
 {
 	struct pblk_line_meta *lm = &pblk->lm;
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 
-	line->map_bitmap = kzalloc(lm->sec_bitmap_len, GFP_KERNEL);
+	line->map_bitmap = mempool_alloc(l_mg->bitmap_pool, GFP_KERNEL);
 	if (!line->map_bitmap)
 		return -ENOMEM;
 
+	memset(line->map_bitmap, 0, lm->sec_bitmap_len);
+
 	/* will be initialized using bb info from map_bitmap */
-	line->invalid_bitmap = kmalloc(lm->sec_bitmap_len, GFP_KERNEL);
+	line->invalid_bitmap = mempool_alloc(l_mg->bitmap_pool, GFP_KERNEL);
 	if (!line->invalid_bitmap) {
-		kfree(line->map_bitmap);
+		mempool_free(line->map_bitmap, l_mg->bitmap_pool);
 		line->map_bitmap = NULL;
 		return -ENOMEM;
 	}
@@ -1243,7 +1246,9 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
 
 void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line)
 {
-	kfree(line->map_bitmap);
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+
+	mempool_free(line->map_bitmap, l_mg->bitmap_pool);
 	line->map_bitmap = NULL;
 	line->smeta = NULL;
 	line->emeta = NULL;
@@ -1261,8 +1266,11 @@ static void pblk_line_reinit(struct pblk_line *line)
 
 void pblk_line_free(struct pblk_line *line)
 {
-	kfree(line->map_bitmap);
-	kfree(line->invalid_bitmap);
+	struct pblk *pblk = line->pblk;
+	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
+
+	mempool_free(line->map_bitmap, l_mg->bitmap_pool);
+	mempool_free(line->invalid_bitmap, l_mg->bitmap_pool);
 
 	pblk_line_reinit(line);
 }
@@ -1741,7 +1749,7 @@ void pblk_line_close(struct pblk *pblk, struct pblk_line *line)
 
 	list_add_tail(&line->list, move_list);
 
-	kfree(line->map_bitmap);
+	mempool_free(line->map_bitmap, l_mg->bitmap_pool);
 	line->map_bitmap = NULL;
 	line->smeta = NULL;
 	line->emeta = NULL;
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 8adc8ac8b03c..76a4a271b9cf 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -498,6 +498,9 @@ static void pblk_line_mg_free(struct pblk *pblk)
 		pblk_mfree(l_mg->eline_meta[i]->buf, l_mg->emeta_alloc_type);
 		kfree(l_mg->eline_meta[i]);
 	}
+
+	mempool_destroy(l_mg->bitmap_pool);
+	kmem_cache_destroy(l_mg->bitmap_cache);
 }
 
 static void pblk_line_meta_free(struct pblk_line_mgmt *l_mg,
@@ -797,6 +800,17 @@ static int pblk_line_mg_init(struct pblk *pblk)
 			goto fail_free_smeta;
 	}
 
+	l_mg->bitmap_cache = kmem_cache_create("pblk_lm_bitmap",
+			lm->sec_bitmap_len, 0, 0, NULL);
+	if (!l_mg->bitmap_cache)
+		goto fail_free_smeta;
+
+	/* the bitmap pool is used for both valid and map bitmaps */
+	l_mg->bitmap_pool = mempool_create_slab_pool(PBLK_DATA_LINES * 2,
+				l_mg->bitmap_cache);
+	if (!l_mg->bitmap_pool)
+		goto fail_destroy_bitmap_cache;
+
 	/* emeta allocates three different buffers for managing metadata with
 	 * in-memory and in-media layouts
 	 */
@@ -849,6 +863,10 @@ static int pblk_line_mg_init(struct pblk *pblk)
 			kfree(l_mg->eline_meta[i]->buf);
 		kfree(l_mg->eline_meta[i]);
 	}
+
+	mempool_destroy(l_mg->bitmap_pool);
+fail_destroy_bitmap_cache:
+	kmem_cache_destroy(l_mg->bitmap_cache);
 fail_free_smeta:
 	for (i = 0; i < PBLK_DATA_LINES; i++)
 		kfree(l_mg->sline_meta[i]);
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 3bd2b6b0a359..eea901d7cebc 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -939,7 +939,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			list_move_tail(&line->list, move_list);
 			spin_unlock(&l_mg->gc_lock);
 
-			kfree(line->map_bitmap);
+			mempool_free(line->map_bitmap, l_mg->bitmap_pool);
 			line->map_bitmap = NULL;
 			line->smeta = NULL;
 			line->emeta = NULL;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 60c509a00574..9068b158de22 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -530,6 +530,10 @@ struct pblk_line_mgmt {
 	struct pblk_emeta *eline_meta[PBLK_DATA_LINES];
 	unsigned long meta_bitmap;
 
+	/* Cache and mempool for map/invalid bitmaps */
+	struct kmem_cache *bitmap_cache;
+	mempool_t *bitmap_pool;
+
 	/* Helpers for fast bitmap calculations */
 	unsigned long *bb_template;
 	unsigned long *bb_aux;
-- 
2.17.1

