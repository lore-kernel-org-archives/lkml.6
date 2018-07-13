Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC06CECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2022147C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="FNZK6o81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2022147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbeGMJD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:03:28 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46673 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730848AbeGMJD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:03:27 -0400
Received: by mail-pf0-f196.google.com with SMTP id l123-v6so22264194pfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 01:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V8YwsRDARdJFlr/frZPMZAvq3DE7PLVYkFr5ANRboxE=;
        b=FNZK6o81ZuFcpWACgmtSlNaZt/H3NPuZR8jIT0PsDyoH/C94T8crwg24IYPrZq335r
         HlcwetBHbEPbbK8ABP6LvMJDIxHiMSObq8AocCebODFixdlYhCOaJTvjwqgmTIXXTiaO
         0loF8bkvtSmIk7y9oD8cdQUzuKc8x/z26J3z6IbhaacnH+r74ikdgQyNkubVO52VzCMt
         ALXP7RT0IDF6QMLz8mOPpFVUqGaFuO8bymtuS8b6rk9NbfZvol2rC2BYi7IsjyVhS2dl
         0SFj+FjQ7gCyBackIQM5ncfu6bhz0Td556bN9Ka+SXJAMilFi6caGWc19ASsTjLK3DCX
         43MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V8YwsRDARdJFlr/frZPMZAvq3DE7PLVYkFr5ANRboxE=;
        b=Tn2Qco5X8scouJAWnMaNKTmfwQn1ksB/IJwnSbpCFleHBJnQt251z1k9Tlc0GRhxsx
         fQKCJ5NAFIBqN6QZZIDRJoZnQS+h6j5hmvHxtHiVgC719lH3C1k5iq4hdshWANMmKGTa
         FnZp3zVcNOScYiWTQuVK9miQqRuMYqSylbM4TkEeZfWjMp761wvRf29OUppBsizaYt2O
         +XO4fP4LYT4I1qn9ZE6amZjYhxnoRI4XrW6YvbqBAyrY+agH0K6n0u7k3fEjP6jbwsy+
         bbVLofRWtToPZ6TtHP98pEpCHNLr+x8YkwHPYooThnftWjsYF1lQq8HFa2sdyOaaLAOb
         Xdew==
X-Gm-Message-State: AOUpUlH0l/nJLjfNrSo+vhNzF8xEsMr93+JiyPzmRdB/OTQ3uWYjDpjH
        MqqZp6AQN2ULCO8aCEDg+3Fliw==
X-Google-Smtp-Source: AAOMgpcYS6jraY9ZZBnEST4vehKKN5qNqoFPEyophQv+U7LT/kvUmM6at0R2SyDEZqx5YpjsUlx9rw==
X-Received: by 2002:a62:d1b:: with SMTP id v27-v6mr6159696pfi.87.1531471787355;
        Fri, 13 Jul 2018 01:49:47 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id d18-v6sm569357pgo.74.2018.07.13.01.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 01:49:46 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, hans.holmberg@cnexlabs.com,
        javier@cnexlabs.com, hlitz@ucsc.edu, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 09/10] lightnvm: pblk: add asynchronous partial read
Date:   Fri, 13 Jul 2018 10:48:44 +0200
Message-Id: <20180713084845.19511-10-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180713084845.19511-1-mb@lightnvm.io>
References: <20180713084845.19511-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Litz <hlitz@ucsc.edu>

In the read path, partial reads are currently performed synchronously
which affects performance for workloads that generate many partial
reads. This patch adds an asynchronous partial read path as well as
the required partial read ctx.

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
Reviewed-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-read.c | 183 ++++++++++++++++++++++++++++---------------
 drivers/lightnvm/pblk.h      |  10 +++
 2 files changed, 130 insertions(+), 63 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 9c9362b20861..26d414ae25b6 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -231,74 +231,36 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
 	__pblk_end_io_read(pblk, rqd, true);
 }
 
-static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
-			     struct bio *orig_bio, unsigned int bio_init_idx,
-			     unsigned long *read_bitmap)
+static void pblk_end_partial_read(struct nvm_rq *rqd)
 {
-	struct pblk_sec_meta *meta_list = rqd->meta_list;
-	struct bio *new_bio;
+	struct pblk *pblk = rqd->private;
+	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
+	struct pblk_pr_ctx *pr_ctx = r_ctx->private;
+	struct bio *new_bio = rqd->bio;
+	struct bio *bio = pr_ctx->orig_bio;
 	struct bio_vec src_bv, dst_bv;
-	void *ppa_ptr = NULL;
-	void *src_p, *dst_p;
-	dma_addr_t dma_ppa_list = 0;
-	__le64 *lba_list_mem, *lba_list_media;
-	int nr_secs = rqd->nr_ppas;
+	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	int bio_init_idx = pr_ctx->bio_init_idx;
+	unsigned long *read_bitmap = pr_ctx->bitmap;
+	int nr_secs = pr_ctx->orig_nr_secs;
 	int nr_holes = nr_secs - bitmap_weight(read_bitmap, nr_secs);
-	int i, ret, hole;
-
-	/* Re-use allocated memory for intermediate lbas */
-	lba_list_mem = (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
-	lba_list_media = (((void *)rqd->ppa_list) + 2 * pblk_dma_ppa_size);
-
-	new_bio = bio_alloc(GFP_KERNEL, nr_holes);
-
-	if (pblk_bio_add_pages(pblk, new_bio, GFP_KERNEL, nr_holes))
-		goto fail_add_pages;
-
-	if (nr_holes != new_bio->bi_vcnt) {
-		pblk_err(pblk, "malformed bio\n");
-		goto fail;
-	}
-
-	for (i = 0; i < nr_secs; i++)
-		lba_list_mem[i] = meta_list[i].lba;
-
-	new_bio->bi_iter.bi_sector = 0; /* internal bio */
-	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
-
-	rqd->bio = new_bio;
-	rqd->nr_ppas = nr_holes;
-	rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
-
-	if (unlikely(nr_holes == 1)) {
-		ppa_ptr = rqd->ppa_list;
-		dma_ppa_list = rqd->dma_ppa_list;
-		rqd->ppa_addr = rqd->ppa_list[0];
-	}
-
-	ret = pblk_submit_io_sync(pblk, rqd);
-	if (ret) {
-		bio_put(rqd->bio);
-		pblk_err(pblk, "sync read IO submission failed\n");
-		goto fail;
-	}
-
-	if (rqd->error) {
-		atomic_long_inc(&pblk->read_failed);
-#ifdef CONFIG_NVM_PBLK_DEBUG
-		pblk_print_failed_rqd(pblk, rqd, rqd->error);
-#endif
-	}
+	__le64 *lba_list_mem, *lba_list_media;
+	void *src_p, *dst_p;
+	int hole, i;
 
 	if (unlikely(nr_holes == 1)) {
 		struct ppa_addr ppa;
 
 		ppa = rqd->ppa_addr;
-		rqd->ppa_list = ppa_ptr;
-		rqd->dma_ppa_list = dma_ppa_list;
+		rqd->ppa_list = pr_ctx->ppa_ptr;
+		rqd->dma_ppa_list = pr_ctx->dma_ppa_list;
 		rqd->ppa_list[0] = ppa;
 	}
 
+	/* Re-use allocated memory for intermediate lbas */
+	lba_list_mem = (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
+	lba_list_media = (((void *)rqd->ppa_list) + 2 * pblk_dma_ppa_size);
+
 	for (i = 0; i < nr_secs; i++) {
 		lba_list_media[i] = meta_list[i].lba;
 		meta_list[i].lba = lba_list_mem[i];
@@ -316,7 +278,7 @@ static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 		meta_list[hole].lba = lba_list_media[i];
 
 		src_bv = new_bio->bi_io_vec[i++];
-		dst_bv = orig_bio->bi_io_vec[bio_init_idx + hole];
+		dst_bv = bio->bi_io_vec[bio_init_idx + hole];
 
 		src_p = kmap_atomic(src_bv.bv_page);
 		dst_p = kmap_atomic(dst_bv.bv_page);
@@ -334,19 +296,107 @@ static int pblk_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
 	} while (hole < nr_secs);
 
 	bio_put(new_bio);
+	kfree(pr_ctx);
 
 	/* restore original request */
 	rqd->bio = NULL;
 	rqd->nr_ppas = nr_secs;
 
+	bio_endio(bio);
 	__pblk_end_io_read(pblk, rqd, false);
-	return NVM_IO_DONE;
+}
 
-fail:
-	/* Free allocated pages in new bio */
+static int pblk_setup_partial_read(struct pblk *pblk, struct nvm_rq *rqd,
+			    unsigned int bio_init_idx,
+			    unsigned long *read_bitmap,
+			    int nr_holes)
+{
+	struct pblk_sec_meta *meta_list = rqd->meta_list;
+	struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
+	struct pblk_pr_ctx *pr_ctx;
+	struct bio *new_bio, *bio = r_ctx->private;
+	__le64 *lba_list_mem;
+	int nr_secs = rqd->nr_ppas;
+	int i;
+
+	/* Re-use allocated memory for intermediate lbas */
+	lba_list_mem = (((void *)rqd->ppa_list) + pblk_dma_ppa_size);
+
+	new_bio = bio_alloc(GFP_KERNEL, nr_holes);
+
+	if (pblk_bio_add_pages(pblk, new_bio, GFP_KERNEL, nr_holes))
+		goto fail_bio_put;
+
+	if (nr_holes != new_bio->bi_vcnt) {
+		WARN_ONCE(1, "pblk: malformed bio\n");
+		goto fail_free_pages;
+	}
+
+	pr_ctx = kmalloc(sizeof(struct pblk_pr_ctx), GFP_KERNEL);
+	if (!pr_ctx)
+		goto fail_free_pages;
+
+	for (i = 0; i < nr_secs; i++)
+		lba_list_mem[i] = meta_list[i].lba;
+
+	new_bio->bi_iter.bi_sector = 0; /* internal bio */
+	bio_set_op_attrs(new_bio, REQ_OP_READ, 0);
+
+	rqd->bio = new_bio;
+	rqd->nr_ppas = nr_holes;
+	rqd->flags = pblk_set_read_mode(pblk, PBLK_READ_RANDOM);
+
+	pr_ctx->ppa_ptr = NULL;
+	pr_ctx->orig_bio = bio;
+	bitmap_copy(pr_ctx->bitmap, read_bitmap, NVM_MAX_VLBA);
+	pr_ctx->bio_init_idx = bio_init_idx;
+	pr_ctx->orig_nr_secs = nr_secs;
+	r_ctx->private = pr_ctx;
+
+	if (unlikely(nr_holes == 1)) {
+		pr_ctx->ppa_ptr = rqd->ppa_list;
+		pr_ctx->dma_ppa_list = rqd->dma_ppa_list;
+		rqd->ppa_addr = rqd->ppa_list[0];
+	}
+	return 0;
+
+fail_free_pages:
 	pblk_bio_free_pages(pblk, new_bio, 0, new_bio->bi_vcnt);
-fail_add_pages:
+fail_bio_put:
+	bio_put(new_bio);
+
+	return -ENOMEM;
+}
+
+static int pblk_partial_read_bio(struct pblk *pblk, struct nvm_rq *rqd,
+				 unsigned int bio_init_idx,
+				 unsigned long *read_bitmap, int nr_secs)
+{
+	int nr_holes;
+	int ret;
+
+	nr_holes = nr_secs - bitmap_weight(read_bitmap, nr_secs);
+
+	if (pblk_setup_partial_read(pblk, rqd, bio_init_idx, read_bitmap,
+				    nr_holes))
+		return NVM_IO_ERR;
+
+	rqd->end_io = pblk_end_partial_read;
+
+	ret = pblk_submit_io(pblk, rqd);
+	if (ret) {
+		bio_put(rqd->bio);
+		pblk_err(pblk, "partial read IO submission failed\n");
+		goto err;
+	}
+
+	return NVM_IO_OK;
+
+err:
 	pblk_err(pblk, "failed to perform partial read\n");
+
+	/* Free allocated pages in new bio */
+	pblk_bio_free_pages(pblk, rqd->bio, 0, rqd->bio->bi_vcnt);
 	__pblk_end_io_read(pblk, rqd, false);
 	return NVM_IO_ERR;
 }
@@ -480,8 +530,15 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	/* The read bio request could be partially filled by the write buffer,
 	 * but there are some holes that need to be read from the drive.
 	 */
-	return pblk_partial_read(pblk, rqd, bio, bio_init_idx, read_bitmap);
+	ret = pblk_partial_read_bio(pblk, rqd, bio_init_idx, read_bitmap,
+				    nr_secs);
+	if (ret)
+		goto fail_meta_free;
 
+	return NVM_IO_OK;
+
+fail_meta_free:
+	nvm_dev_dma_free(dev->parent, rqd->meta_list, rqd->dma_meta_list);
 fail_rqd_free:
 	pblk_free_rqd(pblk, rqd, PBLK_READ);
 	return ret;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 5c6904eb8557..4760af7b6499 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -119,6 +119,16 @@ struct pblk_g_ctx {
 	u64 lba;
 };
 
+/* partial read context */
+struct pblk_pr_ctx {
+	struct bio *orig_bio;
+	DECLARE_BITMAP(bitmap, NVM_MAX_VLBA);
+	unsigned int orig_nr_secs;
+	unsigned int bio_init_idx;
+	void *ppa_ptr;
+	dma_addr_t dma_ppa_list;
+};
+
 /* Pad context */
 struct pblk_pad_rq {
 	struct pblk *pblk;
-- 
2.11.0

