Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB0CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3773F21878
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="h/UAntAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3773F21878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeHQRem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:34:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39662 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbeHQRem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:34:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so6525000lji.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 07:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/kR/V0uiHDE3vnzot8fT2uW3Dslbc2tMlqx8gtrQTwQ=;
        b=h/UAntAV43hz2JOlGH350Fo/0NmR0petlND0EBfaxWTDGOBx6xCsGoIQnw7qztlOtw
         x375C20C6xBS4JO9TgrEPY1E4kY18ngMJR2ZOF6G/ILLiTc0dZBEZCSIty67F/oZSofj
         P1akSzCHolOj+Yz/80UZwF0Z95fbXCJr6LkGslRHtQbErjGrMHwpSwL08TC69WKWVWP4
         tF4vwkN+m89sJGXVeXxteML1RD4m4nlNlhhq0Mgchv58EfnBKfCe2letSRXI05kMyyMa
         SGbrB6Z/rXfVmwzn7dUaZlTMpdOZzOkKCgK5FRI33Isg8lY9pBxy2wrvFXCccYXii+tw
         CEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/kR/V0uiHDE3vnzot8fT2uW3Dslbc2tMlqx8gtrQTwQ=;
        b=FAJoiumLbYUtYSBZN3uYlwH2ruluQeTJQ3uQDl6m/U80WROLqyHvuJSNhTJcUWt175
         poKOTJaC34lOsgB3ccYaXBAj8VlwK8qOHgiUIvvWegdvINHkh7RPB7AEv0GrtS24v+zo
         SIonhEAJF37Pqu7NZBB8dgQUYZwaEP7zToIfwU7AdWgGk67mwZdGf3D3vZ4qFCnhGew4
         eihRDig4fyDvKWTcRkNC5cRmypPT6OaA+iACUezi+F66L6ta9ByhnWMr655Sz4XjaQIl
         fhPo4/DioDGCDoUaYLmUffhylAi7QxT19n8+moJsIUPZmXbhnNPjyw1GAjalVLlmMX1a
         8VdQ==
X-Gm-Message-State: AOUpUlEb27fXMexV4lhMnqBlMgIsOHTZVvylR/IrQG+Kn1QCUrprylT8
        NRg8RF+50e8AE99HjPRqL/2B/Q==
X-Google-Smtp-Source: AA+uWPxviRIRtNz8z2Y9ueGWWHekFlOvV5xNOmgFtyOY/oIoAPxYUD3s1Joa9H6AteCd7+TT/Yu7TA==
X-Received: by 2002:a2e:2d2:: with SMTP id y79-v6mr23730261lje.100.1534516264843;
        Fri, 17 Aug 2018 07:31:04 -0700 (PDT)
Received: from localhost.localdomain (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id f4-v6sm424501lfa.9.2018.08.17.07.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 07:31:03 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: pblk: unify vector max req constants
Date:   Fri, 17 Aug 2018 16:30:55 +0200
Message-Id: <20180817143055.26032-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both NVM_MAX_VLBA and PBLK_MAX_REQ_ADDRS define how many LBAs that
are available in a vector command. pblk uses them interchangeably
in its implementation. Use NVM_MAX_VLBA as the main one and remove
usages of PBLK_MAX_REQ_ADDRS.

Also remove the power representation that only has one user, and
instead calculate it at runtime.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c |  6 ------
 drivers/lightnvm/pblk-read.c |  6 +++---
 drivers/lightnvm/pblk-rl.c   |  4 ++--
 drivers/lightnvm/pblk.h      | 10 ++++------
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 53bd52114aee..9119c64d6f62 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -376,12 +376,6 @@ static int pblk_core_init(struct pblk *pblk)
 	pblk->max_write_pgs = min_t(int, max_write_ppas, NVM_MAX_VLBA);
 	pblk_set_sec_per_write(pblk, pblk->min_write_pgs);
 
-	if (pblk->max_write_pgs > PBLK_MAX_REQ_ADDRS) {
-		pblk_err(pblk, "vector list too big(%u > %u)\n",
-				pblk->max_write_pgs, PBLK_MAX_REQ_ADDRS);
-		return -EINVAL;
-	}
-
 	pblk->pad_dist = kcalloc(pblk->min_write_pgs - 1, sizeof(atomic64_t),
 								GFP_KERNEL);
 	if (!pblk->pad_dist)
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 48739f6c0417..cd2f61eed6a0 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -43,7 +43,7 @@ static void pblk_read_ppalist_rq(struct pblk *pblk, struct nvm_rq *rqd,
 				 unsigned long *read_bitmap)
 {
 	struct pblk_sec_meta *meta_list = rqd->meta_list;
-	struct ppa_addr ppas[PBLK_MAX_REQ_ADDRS];
+	struct ppa_addr ppas[NVM_MAX_VLBA];
 	int nr_secs = rqd->nr_ppas;
 	bool advanced_bio = false;
 	int i, j = 0;
@@ -450,7 +450,7 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
 	int ret = NVM_IO_ERR;
 
 	/* logic error: lba out-of-bounds. Ignore read request */
-	if (blba >= pblk->rl.nr_secs || nr_secs > PBLK_MAX_REQ_ADDRS) {
+	if (blba >= pblk->rl.nr_secs || nr_secs > NVM_MAX_VLBA) {
 		WARN(1, "pblk: read lba out of bounds (lba:%llu, nr:%d)\n",
 					(unsigned long long)blba, nr_secs);
 		return NVM_IO_ERR;
@@ -546,7 +546,7 @@ static int read_ppalist_rq_gc(struct pblk *pblk, struct nvm_rq *rqd,
 			      struct pblk_line *line, u64 *lba_list,
 			      u64 *paddr_list_gc, unsigned int nr_secs)
 {
-	struct ppa_addr ppa_list_l2p[PBLK_MAX_REQ_ADDRS];
+	struct ppa_addr ppa_list_l2p[NVM_MAX_VLBA];
 	struct ppa_addr ppa_gc;
 	int valid_secs = 0;
 	int i;
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index 6a0616a6fcaf..a32790f7b7fc 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -127,7 +127,7 @@ static void __pblk_rl_update_rates(struct pblk_rl *rl,
 	} else if (free_blocks < rl->high) {
 		int shift = rl->high_pw - rl->rb_windows_pw;
 		int user_windows = free_blocks >> shift;
-		int user_max = user_windows << PBLK_MAX_REQ_ADDRS_PW;
+		int user_max = user_windows << ilog2(NVM_MAX_VLBA);
 
 		rl->rb_user_max = user_max;
 		rl->rb_gc_max = max - user_max;
@@ -228,7 +228,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
 	rl->rsv_blocks = min_blocks;
 
 	/* This will always be a power-of-2 */
-	rb_windows = budget / PBLK_MAX_REQ_ADDRS;
+	rb_windows = budget / NVM_MAX_VLBA;
 	rl->rb_windows_pw = get_count_order(rb_windows);
 
 	/* To start with, all buffer is available to user I/O writers */
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 579b4ea9716c..64ae0c7ed3bb 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -37,8 +37,6 @@
 
 #define PBLK_SECTOR (512)
 #define PBLK_EXPOSED_PAGE_SIZE (4096)
-#define PBLK_MAX_REQ_ADDRS (64)
-#define PBLK_MAX_REQ_ADDRS_PW (6)
 
 #define PBLK_NR_CLOSE_JOBS (4)
 
@@ -99,8 +97,8 @@ enum {
 	PBLK_RL_LOW = 4
 };
 
-#define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * PBLK_MAX_REQ_ADDRS)
-#define pblk_dma_ppa_size (sizeof(u64) * PBLK_MAX_REQ_ADDRS)
+#define pblk_dma_meta_size (sizeof(struct pblk_sec_meta) * NVM_MAX_VLBA)
+#define pblk_dma_ppa_size (sizeof(u64) * NVM_MAX_VLBA)
 
 /* write buffer completion context */
 struct pblk_c_ctx {
@@ -218,8 +216,8 @@ struct pblk_lun {
 struct pblk_gc_rq {
 	struct pblk_line *line;
 	void *data;
-	u64 paddr_list[PBLK_MAX_REQ_ADDRS];
-	u64 lba_list[PBLK_MAX_REQ_ADDRS];
+	u64 paddr_list[NVM_MAX_VLBA];
+	u64 lba_list[NVM_MAX_VLBA];
 	int nr_secs;
 	int secs_to_gc;
 	struct list_head list;
-- 
2.11.0

