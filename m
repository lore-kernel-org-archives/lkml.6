Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8F7C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6D2214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="MFl4aBFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6D2214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeJISb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:31:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36444 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeJISb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:31:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id f18-v6so658690pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hhZMOBt+etJmzoljDfUFclUZmx5OjjxpGbkDtdly3IU=;
        b=MFl4aBFZUkr/cymxGdjny2oXEv7Q3ByL6NsKGpeh6fJeRPKnEWKAOryYHvNSAoeR7I
         Z8GETwsXhMRAOdNGIGzJlShQRZbToU/lBg+vQj9TQeF9hAogLowXdEGQlbaVWE6hWYrG
         utqR6v9l4olsBDvrQoUYYV3IZIPs192r66Dq4i/CrOFQrYBBd0AKGZXy6C4Z56JWE/Qj
         ThekWrSxAY3to3VO77gLRaJ95xT5IjFiPqe1re926GADEOCcGsw/kyC/QBAn6SuhOUQo
         mH6xSgfP96C9PmtW20IaZMlguaXfSng3kHeiKSepLcon/w88fYmHjT2wS5NpgPcikvDS
         qxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hhZMOBt+etJmzoljDfUFclUZmx5OjjxpGbkDtdly3IU=;
        b=I1lvlnWCt3e1X6M4yqsBWRuwoO7DDhTS1x2Uz3FlFeCTrvdxJYRux1JtSlQeh4ZKpP
         UEuj9irpOO/CFhCLcW4JwShowjLxxGPIBX8zj0EfKKmycd6on05kKeY1EYzO6sODkoU/
         gRF4MKxNMQH4kD5R5PKfOIOMNNdcjSullvgtAYlgXB9d+Iyp/9GneMSjVLth+BTg9tCE
         rsfCamxWkl6y2Y++w1zh2uZWzNCZEJf+lk5JKTpCeZXKjcwOnoqKeRCI+cuE3HjwHHM8
         yL8/vva9a0Xp+UMv88Pm9YEGfuk5ZGRSPlwtFus+aYRe3KLlBGkJ9vDnmgL1z/rep19c
         Kwhg==
X-Gm-Message-State: ABuFfoiA1y2RZM/URyZmwAabjAMaiw/3u/0dH3xxHqNJ5LnhMps2XbYl
        sPiTLq3bCD6moEQbDXuBuRg4wg==
X-Google-Smtp-Source: ACcGV60A+NXsJ/JAkYo0tMwBkby3KOeeOfDgIeivy+jphD1GjCRoB5vhFIyRKcHl+YeMpJHUyTg40w==
X-Received: by 2002:a63:e47:: with SMTP id 7-v6mr21373086pgo.320.1539083701237;
        Tue, 09 Oct 2018 04:15:01 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:15:00 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 32/45] lightnvm: pblk: encapsulate rqd dma allocations
Date:   Tue,  9 Oct 2018 13:12:02 +0200
Message-Id: <20181009111215.7653-33-mb@lightnvm.io>
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

From: Javier González <javier@javigon.com>

dma allocations for ppa_list and meta_list in rqd are replicated in
several places across the pblk codebase. Make helpers to encapsulate
creation and deletion to simplify the code.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c     | 51 ++++++++++++++++++++++----------
 drivers/lightnvm/pblk-read.c     | 31 +++++++------------
 drivers/lightnvm/pblk-recovery.c | 30 +++++++------------
 drivers/lightnvm/pblk-write.c    | 15 ++--------
 drivers/lightnvm/pblk.h          |  2 ++
 5 files changed, 59 insertions(+), 70 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 875f3cf615ac..8ae40855d4c9 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -237,6 +237,33 @@ static void pblk_invalidate_range(struct pblk *pblk, sector_t slba,
 	spin_unlock(&pblk->trans_lock);
 }
 
+int pblk_alloc_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+
+	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
+							&rqd->dma_meta_list);
+	if (!rqd->meta_list)
+		return -ENOMEM;
+
+	if (rqd->nr_ppas == 1)
+		return 0;
+
+	rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
+	rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
+
+	return 0;
+}
+
+void pblk_free_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+
+	if (rqd->meta_list)
+		nvm_dev_dma_free(dev->parent, rqd->meta_list,
+				rqd->dma_meta_list);
+}
+
 /* Caller must guarantee that the request is a valid type */
 struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int type)
 {
@@ -268,7 +295,6 @@ struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int type)
 /* Typically used on completion path. Cannot guarantee request consistency */
 void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
 {
-	struct nvm_tgt_dev *dev = pblk->dev;
 	mempool_t *pool;
 
 	switch (type) {
@@ -289,9 +315,7 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
 		return;
 	}
 
-	if (rqd->meta_list)
-		nvm_dev_dma_free(dev->parent, rqd->meta_list,
-				rqd->dma_meta_list);
+	pblk_free_rqd_meta(pblk, rqd);
 	mempool_free(rqd, pool);
 }
 
@@ -838,18 +862,14 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
-	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
-							&rqd.dma_meta_list);
-	if (!rqd.meta_list)
-		return -ENOMEM;
-
-	rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
-	rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
+	ret = pblk_alloc_rqd_meta(pblk, &rqd);
+	if (ret)
+		return ret;
 
 	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
-		goto free_ppa_list;
+		goto clear_rqd;
 	}
 
 	bio->bi_iter.bi_sector = 0; /* internal bio */
@@ -881,7 +901,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 	if (ret) {
 		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
 		bio_put(bio);
-		goto free_ppa_list;
+		goto clear_rqd;
 	}
 
 	atomic_dec(&pblk->inflight_io);
@@ -894,9 +914,8 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 			pblk_log_read_err(pblk, &rqd);
 	}
 
-free_ppa_list:
-	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
-
+clear_rqd:
+	pblk_free_rqd_meta(pblk, &rqd);
 	return ret;
 }
 
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 829e92857289..f5fe01d3a07f 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -453,21 +453,13 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	 */
 	bio_init_idx = pblk_get_bi_idx(bio);
 
-	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
-							&rqd->dma_meta_list);
-	if (!rqd->meta_list) {
-		pblk_err(pblk, "not able to allocate ppa list\n");
+	if (pblk_alloc_rqd_meta(pblk, rqd))
 		goto fail_rqd_free;
-	}
-
-	if (nr_secs > 1) {
-		rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
-		rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
 
+	if (nr_secs > 1)
 		pblk_read_ppalist_rq(pblk, rqd, bio, blba, read_bitmap);
-	} else {
+	else
 		pblk_read_rq(pblk, rqd, bio, blba, read_bitmap);
-	}
 
 	if (bitmap_full(read_bitmap, nr_secs)) {
 		atomic_inc(&pblk->inflight_io);
@@ -594,15 +586,11 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
-	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
-							&rqd.dma_meta_list);
-	if (!rqd.meta_list)
-		return -ENOMEM;
+	ret = pblk_alloc_rqd_meta(pblk, &rqd);
+	if (ret)
+		return ret;
 
 	if (gc_rq->nr_secs > 1) {
-		rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
-		rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
-
 		gc_rq->secs_to_gc = read_ppalist_rq_gc(pblk, &rqd, gc_rq->line,
 							gc_rq->lba_list,
 							gc_rq->paddr_list,
@@ -623,7 +611,8 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 						PBLK_VMALLOC_META, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		pblk_err(pblk, "could not allocate GC bio (%lu)\n",
-				PTR_ERR(bio));
+								PTR_ERR(bio));
+		ret = PTR_ERR(bio);
 		goto err_free_dma;
 	}
 
@@ -658,12 +647,12 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 #endif
 
 out:
-	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
+	pblk_free_rqd_meta(pblk, &rqd);
 	return ret;
 
 err_free_bio:
 	bio_put(bio);
 err_free_dma:
-	nvm_dev_dma_free(dev->parent, rqd.meta_list, rqd.dma_meta_list);
+	pblk_free_rqd_meta(pblk, &rqd);
 	return ret;
 }
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 2526722304bb..218292979953 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -241,13 +241,11 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct ppa_addr *ppa_list;
 	struct pblk_sec_meta *meta_list;
 	struct pblk_pad_rq *pad_rq;
 	struct nvm_rq *rqd;
 	struct bio *bio;
 	void *data;
-	dma_addr_t dma_ppa_list, dma_meta_list;
 	__le64 *lba_list = emeta_to_lbas(pblk, line->emeta->buf);
 	u64 w_ptr = line->cur_sec;
 	int left_line_ppas, rq_ppas, rq_len;
@@ -281,20 +279,11 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 
 	rq_len = rq_ppas * geo->csecs;
 
-	meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL, &dma_meta_list);
-	if (!meta_list) {
-		ret = -ENOMEM;
-		goto fail_free_pad;
-	}
-
-	ppa_list = (void *)(meta_list) + pblk_dma_meta_size;
-	dma_ppa_list = dma_meta_list + pblk_dma_meta_size;
-
 	bio = pblk_bio_map_addr(pblk, data, rq_ppas, rq_len,
 						PBLK_VMALLOC_META, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
-		goto fail_free_meta;
+		goto fail_free_pad;
 	}
 
 	bio->bi_iter.bi_sector = 0; /* internal bio */
@@ -302,17 +291,19 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 
 	rqd = pblk_alloc_rqd(pblk, PBLK_WRITE_INT);
 
+	ret = pblk_alloc_rqd_meta(pblk, rqd);
+	if (ret)
+		goto fail_free_rqd;
+
 	rqd->bio = bio;
 	rqd->opcode = NVM_OP_PWRITE;
 	rqd->is_seq = 1;
-	rqd->meta_list = meta_list;
 	rqd->nr_ppas = rq_ppas;
-	rqd->ppa_list = ppa_list;
-	rqd->dma_ppa_list = dma_ppa_list;
-	rqd->dma_meta_list = dma_meta_list;
 	rqd->end_io = pblk_end_io_recov;
 	rqd->private = pad_rq;
 
+	meta_list = rqd->meta_list;
+
 	for (i = 0; i < rqd->nr_ppas; ) {
 		struct ppa_addr ppa;
 		int pos;
@@ -346,7 +337,7 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 	if (ret) {
 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
 		pblk_up_chunk(pblk, rqd->ppa_list[0]);
-		goto fail_free_bio;
+		goto fail_free_rqd;
 	}
 
 	left_line_ppas -= rq_ppas;
@@ -370,10 +361,9 @@ static int pblk_recov_pad_oob(struct pblk *pblk, struct pblk_line *line,
 	kfree(pad_rq);
 	return ret;
 
-fail_free_bio:
+fail_free_rqd:
+	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
 	bio_put(bio);
-fail_free_meta:
-	nvm_dev_dma_free(dev->parent, meta_list, dma_meta_list);
 fail_free_pad:
 	kfree(pad_rq);
 	vfree(data);
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 9554febee480..a276f25d3931 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -285,11 +285,8 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
 }
 
 static int pblk_alloc_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
-			   unsigned int nr_secs,
-			   nvm_end_io_fn(*end_io))
+			   unsigned int nr_secs, nvm_end_io_fn(*end_io))
 {
-	struct nvm_tgt_dev *dev = pblk->dev;
-
 	/* Setup write request */
 	rqd->opcode = NVM_OP_PWRITE;
 	rqd->nr_ppas = nr_secs;
@@ -297,15 +294,7 @@ static int pblk_alloc_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	rqd->private = pblk;
 	rqd->end_io = end_io;
 
-	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
-							&rqd->dma_meta_list);
-	if (!rqd->meta_list)
-		return -ENOMEM;
-
-	rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
-	rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
-
-	return 0;
+	return pblk_alloc_rqd_meta(pblk, rqd);
 }
 
 static int pblk_setup_w_rq(struct pblk *pblk, struct nvm_rq *rqd,
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index d123cff82589..b06ab0edab69 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -778,6 +778,8 @@ ssize_t pblk_rb_sysfs(struct pblk_rb *rb, char *buf);
  */
 struct nvm_rq *pblk_alloc_rqd(struct pblk *pblk, int type);
 void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type);
+int pblk_alloc_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd);
+void pblk_free_rqd_meta(struct pblk *pblk, struct nvm_rq *rqd);
 void pblk_set_sec_per_write(struct pblk *pblk, int sec_per_write);
 int pblk_setup_w_rec_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			struct pblk_c_ctx *c_ctx);
-- 
2.17.1

