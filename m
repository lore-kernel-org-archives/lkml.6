Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FC6C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFB421581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="Y3sY7yNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFB421581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeHTP1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:27:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34786 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbeHTP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:27:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id g9-v6so5481401lfh.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 05:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4LwPXvtdaVa3i3cEIwJaHlYeEKt1eJ1OUJI3KrDw3F4=;
        b=Y3sY7yNJ8ofm+aBVvt04PTaA/mYOyXV7EDuePaHfn6DSClmPo6mS/uhjiRJsQvUR3c
         M6E4YjtQBLm1JgZTjVRBcaLH2E44dRSVPkvUWYDpj2ES95xsiczrwyx2+KiE5ZJNf6CO
         wOuzFnJ4wXGcYg8RoI8M/BJjXZS//camNCj1LRCL7f21GSTRJnO/A5V4s53e7fLWEl1B
         MPRE2+HrGW4jAsMf5CanffWFgSb2hCcu5doyIJhuFIZmd3yU1oeSY4ix0W+JWaLOenly
         WorAHmHDhbz/QFFGybmlIWAp/3F6u/xRu+Ura/DS7SvwOIda84PFkL2WqRvsPDM+7+mf
         0f1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4LwPXvtdaVa3i3cEIwJaHlYeEKt1eJ1OUJI3KrDw3F4=;
        b=NQbsCrq0uDAM63/hk4RuqBaCNgLkXj34PoUw6NySVg+LzcNHKXJ1kymFf0CrsuB6fZ
         JaDSYX5gFX6coLs0Y9COsu84U6EvukGUozgs/kXxp9rVP8RLDIKtJ0PG7GI51sV/aOUl
         TAM+ETt6VUcWAHPAxqqhtfIdvVtM6sJmbGLJCfcOFJUVH/7gBLqpm8tUBRFfLd77BlqB
         i6saP1dGTTfSuffuvyI4yT7BjwDFPqSL123X+xkzc6XHWjknFr5ngaKAGJz1+AZOuWKm
         9VNu78PsMQN+Qvlettr01bE2ElUm+Xkn0L65+F05aLYW+JZ/hUQgfjZZ1efOaTqxG+zX
         crPA==
X-Gm-Message-State: AOUpUlF/+wTT1wZ9KxRYiPeVCFCxTi+jpX286zbpPn1HRXSeL8dxv5N0
        SpRHgwwx36+nVna3SyPeHm0VoA==
X-Google-Smtp-Source: AA+uWPxT4SDZLgOERg1Pd/EMWBorA3lHHKQF3p25X1zw+8zd6Wr3KKpaX15WHs2HWtEHXAz/dErbrA==
X-Received: by 2002:a19:e51a:: with SMTP id c26-v6mr1372414lfh.78.1534767143439;
        Mon, 20 Aug 2018 05:12:23 -0700 (PDT)
Received: from localhost.localdomain (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id z10-v6sm1577869ljh.57.2018.08.20.05.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 05:12:22 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: introduce nvm_rq_to_ppa_list
Date:   Mon, 20 Aug 2018 14:12:17 +0200
Message-Id: <20180820121217.11393-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a number of places in the lightnvm subsystem where the user
iterates over the ppa list. Before iterating, the user must know if it
is a single or multiple LBAs due to vector commands using either the
nvm_rq ->ppa_addr or ->ppa_list fields on command submission, which
leads to open-coding the if/else statement.

Instead of having multiple if/else's, move it into a function that can
be called by its users.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-read.c  | 4 +---
 drivers/lightnvm/pblk-write.c | 5 +----
 drivers/lightnvm/pblk.h       | 4 +---
 include/linux/lightnvm.h      | 5 +++++
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index f275c7e5abe4..696d3a9c9cf0 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -175,11 +175,9 @@ static void __pblk_read_put_line(struct pblk *pblk, struct ppa_addr ppa)
 
 static void pblk_read_put_line(struct pblk *pblk, struct nvm_rq *rqd)
 {
-	struct ppa_addr *ppa_list;
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
 	int i;
 
-	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
-
 	for (i = 0; i < rqd->nr_ppas; i++)
 		__pblk_read_put_line(pblk, ppa_list[i]);
 }
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index df99c45778d4..a92450ec7698 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -212,10 +212,7 @@ static void pblk_submit_rec(struct work_struct *work)
 
 	pblk_log_write_err(pblk, rqd);
 
-	if (rqd->nr_ppas == 1)
-		ppa_list = &rqd->ppa_addr;
-	else
-		ppa_list = rqd->ppa_list;
+	ppa_list = nvm_rq_to_ppa_list(rqd);
 
 	pblk_map_remaining(pblk, ppa_list);
 	pblk_queue_resubmit(pblk, c_ctx);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 64ae0c7ed3bb..bda098c7cc3b 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1335,9 +1335,7 @@ static inline int pblk_boundary_ppa_checks(struct nvm_tgt_dev *tgt_dev,
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
index 0106984400bc..1497e275f90f 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -487,6 +487,11 @@ static inline struct ppa_addr dev_to_generic_addr(struct nvm_dev *dev,
 	return l;
 }
 
+static inline struct ppa_addr *nvm_rq_to_ppa_list(struct nvm_rq *rqd)
+{
+	return (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
+}
+
 typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
 typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
-- 
2.11.0

