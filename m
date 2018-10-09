Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C308C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D37214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="zZhzZCnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D37214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeJISaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:30:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38639 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeJISaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:30:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id b5-v6so673855plr.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2AqHuBnBGGbfQ4wL88cV03m1jyCWk8fudCdcrqw7drg=;
        b=zZhzZCnFqEBW+sAbm8GQ9Pn2ejOzl+bDhZWsGKxdYLeAZC5YLLFSPJ1/ueIdY9ACLA
         g6p+rfSUClMSVq8DJneGlfaaZVNF0XYoakwPDD9v6TuH/NoOLLvDsmslhoOn5soBrDxs
         xtN26IDgBAF+geuGYWHzhnTGgDdz8ziBMjtkuVU12E3ww0vJZb7WVEI+4fSp+DQVnk1N
         iAxkj6XsARmS6/jKzIxSE39DbgkSQeyhMbNEMd1612nnk0dCWsXYYJtGdErBlpkUO8Y5
         a5kjdy+Qdg1MWbWerwTbh/huXdLAkl0vM6uQVk61ikp0XNP+m+ylfONX1S4KenpEdrMq
         sSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2AqHuBnBGGbfQ4wL88cV03m1jyCWk8fudCdcrqw7drg=;
        b=bIGUDGHVG33pbV0X7KNHYt/lnSasxqcFW0QExmU4UMwENBn3QY4OLp2m6L/QRMdg/G
         arVWYmrHV3SQyWWh8vpTzjV0xIxkzK/gIpDsRMMByTIUZt5tagYNs2tVBmXQm9VZi3Ft
         p775Ljcc0o0LGcQlK77Iqj3DdVssVoT/4qpqpcFWiF+69hjviZRnu3iLQj1vUpeUgyZ3
         GomTK+aDqm83ESv38W0DsRBWSeJw3EFMRjj3xrKiqnFenKxwigtsk4HbqpXQ56Ol9uWt
         VSUORRCryG0RwsEXhrMmSv5gQibBeSOO4HrQeWjxoGQT5/SH5yhxpAtIyJvtfSj5VjTU
         S2rg==
X-Gm-Message-State: ABuFfojmaIfzUj36yOt4VaMBu147iaE9xyT13efQVdxIjveKU22Z+XD8
        Q2afxcuSXLCx3pE3zm2Qnfs+4Q==
X-Google-Smtp-Source: ACcGV61q/A1l9bqbp3ADHQnNvnmCqBRxPWBU4K9ol+mh/Dnq4NqZbbtPNeqHl9vKTFs5v52uL70Gsw==
X-Received: by 2002:a17:902:62:: with SMTP id 89-v6mr28057245pla.298.1539083648325;
        Tue, 09 Oct 2018 04:14:08 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:14:06 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 16/45] lightnvm: introduce nvm_rq_to_ppa_list
Date:   Tue,  9 Oct 2018 13:11:46 +0200
Message-Id: <20181009111215.7653-17-mb@lightnvm.io>
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

There is a number of places in the lightnvm subsystem where the user
iterates over the ppa list. Before iterating, the user must know if it
is a single or multiple LBAs due to vector commands using either the
nvm_rq ->ppa_addr or ->ppa_list fields on command submission, which
leads to open-coding the if/else statement.

Instead of having multiple if/else's, move it into a function that can
be called by its users.

A nice side effect of this cleanup is that this patch fixes up a
bunch of cases where we don't consider the single-ppa case in pblk.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c          | 14 ++++----------
 drivers/lightnvm/pblk-map.c      | 10 ++++++----
 drivers/lightnvm/pblk-read.c     | 11 ++++-------
 drivers/lightnvm/pblk-recovery.c |  9 ++++++---
 drivers/lightnvm/pblk-write.c    | 18 ++++++++----------
 drivers/lightnvm/pblk.h          |  4 +---
 include/linux/lightnvm.h         |  5 +++++
 7 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 8df188e0767e..efb976a863d2 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -603,22 +603,16 @@ static void nvm_ppa_dev_to_tgt(struct nvm_tgt_dev *tgt_dev,
 
 static void nvm_rq_tgt_to_dev(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 {
-	if (rqd->nr_ppas == 1) {
-		nvm_ppa_tgt_to_dev(tgt_dev, &rqd->ppa_addr, 1);
-		return;
-	}
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 
-	nvm_ppa_tgt_to_dev(tgt_dev, rqd->ppa_list, rqd->nr_ppas);
+	nvm_ppa_tgt_to_dev(tgt_dev, ppa_list, rqd->nr_ppas);
 }
 
 static void nvm_rq_dev_to_tgt(struct nvm_tgt_dev *tgt_dev, struct nvm_rq *rqd)
 {
-	if (rqd->nr_ppas == 1) {
-		nvm_ppa_dev_to_tgt(tgt_dev, &rqd->ppa_addr, 1);
-		return;
-	}
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 
-	nvm_ppa_dev_to_tgt(tgt_dev, rqd->ppa_list, rqd->nr_ppas);
+	nvm_ppa_dev_to_tgt(tgt_dev, ppa_list, rqd->nr_ppas);
 }
 
 int nvm_register_tgt_type(struct nvm_tgt_type *tt)
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 953ca31dda68..dc0efb852475 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -88,13 +88,14 @@ void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sentry,
 		 unsigned int off)
 {
 	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	unsigned int map_secs;
 	int min = pblk->min_write_pgs;
 	int i;
 
 	for (i = off; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
-		if (pblk_map_page_data(pblk, sentry + i, &rqd->ppa_list[i],
+		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
 					lun_bitmap, &meta_list[i], map_secs)) {
 			bio_put(rqd->bio);
 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
@@ -112,6 +113,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	struct pblk_line *e_line, *d_line;
 	unsigned int map_secs;
 	int min = pblk->min_write_pgs;
@@ -119,14 +121,14 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 
 	for (i = 0; i < rqd->nr_ppas; i += min) {
 		map_secs = (i + min > valid_secs) ? (valid_secs % min) : min;
-		if (pblk_map_page_data(pblk, sentry + i, &rqd->ppa_list[i],
+		if (pblk_map_page_data(pblk, sentry + i, &ppa_list[i],
 					lun_bitmap, &meta_list[i], map_secs)) {
 			bio_put(rqd->bio);
 			pblk_free_rqd(pblk, rqd, PBLK_WRITE);
 			pblk_pipeline_stop(pblk);
 		}
 
-		erase_lun = pblk_ppa_to_pos(geo, rqd->ppa_list[i]);
+		erase_lun = pblk_ppa_to_pos(geo, ppa_list[i]);
 
 		/* line can change after page map. We might also be writing the
 		 * last line.
@@ -141,7 +143,7 @@ void pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
 			set_bit(erase_lun, e_line->erase_bitmap);
 			atomic_dec(&e_line->left_eblks);
 
-			*erase_ppa = rqd->ppa_list[i];
+			*erase_ppa = ppa_list[i];
 			erase_ppa->a.blk = e_line->id;
 
 			spin_unlock(&e_line->lock);
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 49744caaa300..d3ff8c3e9010 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -116,10 +116,9 @@ static void pblk_read_check_seq(struct pblk *pblk, struct nvm_rq *rqd,
 
 		if (lba != blba + i) {
 #ifdef CONFIG_NVM_PBLK_DEBUG
-			struct ppa_addr *p;
+			struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 
-			p = (nr_lbas == 1) ? &rqd->ppa_list[i] : &rqd->ppa_addr;
-			print_ppa(pblk, p, "seq", i);
+			print_ppa(pblk, &ppa_list[i], "seq", i);
 #endif
 			pblk_err(pblk, "corrupted read LBA (%llu/%llu)\n",
 							lba, (u64)blba + i);
@@ -148,11 +147,9 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 
 		if (lba != meta_lba) {
 #ifdef CONFIG_NVM_PBLK_DEBUG
-			struct ppa_addr *p;
-			int nr_ppas = rqd->nr_ppas;
+			struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 
-			p = (nr_ppas == 1) ? &rqd->ppa_list[j] : &rqd->ppa_addr;
-			print_ppa(pblk, p, "seq", j);
+			print_ppa(pblk, &ppa_list[j], "seq", j);
 #endif
 			pblk_err(pblk, "corrupted read LBA (%llu/%llu)\n",
 								lba, meta_lba);
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index cf629ab016ba..3bd2b6b0a359 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -161,6 +161,8 @@ static int pblk_recov_read_oob(struct pblk *pblk, struct pblk_line *line,
 	if (pblk_io_aligned(pblk, rq_ppas))
 		rqd->is_seq = 1;
 
+	ppa_list = nvm_rq_to_ppa_list(rqd);
+
 	for (i = 0; i < rqd->nr_ppas; ) {
 		struct ppa_addr ppa;
 		int pos;
@@ -175,7 +177,7 @@ static int pblk_recov_read_oob(struct pblk *pblk, struct pblk_line *line,
 		}
 
 		for (j = 0; j < pblk->min_write_pgs; j++, i++, r_ptr_int++)
-			rqd->ppa_list[i] =
+			ppa_list[i] =
 				addr_to_gen_ppa(pblk, r_ptr_int, line->id);
 	}
 
@@ -202,7 +204,7 @@ static int pblk_recov_read_oob(struct pblk *pblk, struct pblk_line *line,
 		if (lba == ADDR_EMPTY || lba > pblk->rl.nr_secs)
 			continue;
 
-		pblk_update_map(pblk, lba, rqd->ppa_list[i]);
+		pblk_update_map(pblk, lba, ppa_list[i]);
 	}
 
 	left_ppas -= rq_ppas;
@@ -221,10 +223,11 @@ static void pblk_recov_complete(struct kref *ref)
 
 static void pblk_end_io_recov(struct nvm_rq *rqd)
 {
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	struct pblk_pad_rq *pad_rq = rqd->private;
 	struct pblk *pblk = pad_rq->pblk;
 
-	pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
 
 	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
 
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 625ed5a3a020..c20bb7f6d703 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -208,15 +208,10 @@ static void pblk_submit_rec(struct work_struct *work)
 	struct pblk *pblk = recovery->pblk;
 	struct nvm_rq *rqd = recovery->rqd;
 	struct pblk_c_ctx *c_ctx = nvm_rq_to_pdu(rqd);
-	struct ppa_addr *ppa_list;
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 
 	pblk_log_write_err(pblk, rqd);
 
-	if (rqd->nr_ppas == 1)
-		ppa_list = &rqd->ppa_addr;
-	else
-		ppa_list = rqd->ppa_list;
-
 	pblk_map_remaining(pblk, ppa_list);
 	pblk_queue_resubmit(pblk, c_ctx);
 
@@ -273,9 +268,10 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
 	struct pblk_g_ctx *m_ctx = nvm_rq_to_pdu(rqd);
 	struct pblk_line *line = m_ctx->private;
 	struct pblk_emeta *emeta = line->emeta;
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	int sync;
 
-	pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
 
 	if (rqd->error) {
 		pblk_log_write_err(pblk, rqd);
@@ -375,6 +371,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_emeta *emeta = meta_line->emeta;
+	struct ppa_addr *ppa_list;
 	struct pblk_g_ctx *m_ctx;
 	struct bio *bio;
 	struct nvm_rq *rqd;
@@ -409,12 +406,13 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	if (ret)
 		goto fail_free_bio;
 
+	ppa_list = nvm_rq_to_ppa_list(rqd);
 	for (i = 0; i < rqd->nr_ppas; ) {
 		spin_lock(&meta_line->lock);
 		paddr = __pblk_alloc_page(pblk, meta_line, rq_ppas);
 		spin_unlock(&meta_line->lock);
 		for (j = 0; j < rq_ppas; j++, i++, paddr++)
-			rqd->ppa_list[i] = addr_to_gen_ppa(pblk, paddr, id);
+			ppa_list[i] = addr_to_gen_ppa(pblk, paddr, id);
 	}
 
 	spin_lock(&l_mg->close_lock);
@@ -423,7 +421,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 		list_del(&meta_line->list);
 	spin_unlock(&l_mg->close_lock);
 
-	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);
 
 	ret = pblk_submit_io(pblk, rqd);
 	if (ret) {
@@ -434,7 +432,7 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 	return NVM_IO_OK;
 
 fail_rollback:
-	pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
 	spin_lock(&l_mg->close_lock);
 	pblk_dealloc_page(pblk, meta_line, rq_ppas);
 	list_add(&meta_line->list, &meta_line->list);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 1865ac1560fa..60c509a00574 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1362,9 +1362,7 @@ static inline int pblk_boundary_ppa_checks(struct nvm_tgt_dev *tgt_dev,
 static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
-	struct ppa_addr *ppa_list;
-
-	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 
 	if (pblk_boundary_ppa_checks(dev, ppa_list, rqd->nr_ppas)) {
 		WARN_ON(1);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 77743a02ec0d..50ac5b21297c 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -320,6 +320,11 @@ static inline void *nvm_rq_to_pdu(struct nvm_rq *rqdata)
 	return rqdata + 1;
 }
 
+static inline struct ppa_addr *nvm_rq_to_ppa_list(struct nvm_rq *rqd)
+{
+	return (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
+}
+
 enum {
 	NVM_BLK_ST_FREE =	0x1,	/* Free block */
 	NVM_BLK_ST_TGT =	0x2,	/* Block in use by target */
-- 
2.17.1

