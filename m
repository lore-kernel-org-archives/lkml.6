Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE214C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E6D214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="ZY3vPO1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E6D214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbeJISda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:33:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36426 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbeJISal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:30:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id y11-v6so671537plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=obBBG+/vjhkx2sjBc8D/J/RQKkavutEZvS8nBnwz9NQ=;
        b=ZY3vPO1P9XcgjiE8poykd+e3chkQOCCFPcPXCkQr2j30j+1ZfPxRmc5WqXkGGn06Yr
         P0Ab/EAxMHoZv7qFkpxoS1uxs+g9gRWYGKfDxVVlRy3V5Psm7FVB2q44cyJyWFbXtDCe
         PUgn0FVLnl25OqU6V5+Sz8LZb75THbtKKrbrffsusgs6NcsTXf7XooDIgfAmpPzA45lV
         864H5J3HA1IDS7MjtcdpaKaTPsSNgah93EExoF0t0W8XtNg+kz/lMnU6N7hsXYh72q1p
         kQI4ztaJCTDTgCO5mX/ThaK9MCPB6o7ggzp7ZvbTcDz0fLUDlcZ+1oKOS5VrrQqQdfEP
         8vJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=obBBG+/vjhkx2sjBc8D/J/RQKkavutEZvS8nBnwz9NQ=;
        b=KpUFRT92q4w71xp+jUds+NGfOx+iyhkrfLauheWqLKMAH8toRgx45l9WQwTG00ppZa
         OB6f65BZnt3hPOUAgiO783GYBzAv9/t7yrUwQpY3ms7PAkI0zYxBfJNu4nbEVMLpkCEr
         wLJzHES4GBNPeaBYviE/y7HavVQW4F1ToAqTGEXF6CTdADfXvuzakKAm7DLRn3YbU+oL
         kkcuDs25uGDuzA+fyBqtZVEYcTOUpwTKlTT2a4tABGs01F5jnqitVin4oI7ottjHL3jK
         hSUWTUTVnF6GV17H71+4tnMNkKhFxMT+GXFutFgFZCJ5a3ilcKCrddeg7TR0A4rRDIAQ
         LNrA==
X-Gm-Message-State: ABuFfoiob68GOG/WipgbH8ygbUQJ8zZ1CxzzXmBxuXxwE9Cp9aq4CeVq
        2MFQiWcpFnPYFXs70H6Hoko5yA==
X-Google-Smtp-Source: ACcGV60MnDvnJPyfUm1/JoYkdcfOSpjUsccNN7VcldwO7uYNC7QyTKv75Q3JXj6aAyxw4x5FqHqUzQ==
X-Received: by 2002:a17:902:6a8b:: with SMTP id n11-v6mr27620538plk.16.1539083655085;
        Tue, 09 Oct 2018 04:14:15 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:14:13 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 18/45] lightnvm: pblk: remove unused parameters in pblk_up_rq
Date:   Tue,  9 Oct 2018 13:11:48 +0200
Message-Id: <20181009111215.7653-19-mb@lightnvm.io>
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

The parameters nr_ppas and ppa_list are not used, so remove them.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c  | 3 +--
 drivers/lightnvm/pblk-write.c | 5 ++---
 drivers/lightnvm/pblk.h       | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index e1207a4f9d54..bb1a7cc24cbb 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1929,8 +1929,7 @@ void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas)
 	up(&rlun->wr_sem);
 }
 
-void pblk_up_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
-		unsigned long *lun_bitmap)
+void pblk_up_rq(struct pblk *pblk, unsigned long *lun_bitmap)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index c20bb7f6d703..cd579b440b56 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -81,8 +81,7 @@ static void pblk_complete_write(struct pblk *pblk, struct nvm_rq *rqd,
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	atomic_long_sub(c_ctx->nr_valid, &pblk->inflight_writes);
 #endif
-
-	pblk_up_rq(pblk, rqd->ppa_list, rqd->nr_ppas, c_ctx->lun_bitmap);
+	pblk_up_rq(pblk, c_ctx->lun_bitmap);
 
 	pos = pblk_rb_sync_init(&pblk->rwb, &flags);
 	if (pos == c_ctx->sentry) {
@@ -215,7 +214,7 @@ static void pblk_submit_rec(struct work_struct *work)
 	pblk_map_remaining(pblk, ppa_list);
 	pblk_queue_resubmit(pblk, c_ctx);
 
-	pblk_up_rq(pblk, rqd->ppa_list, rqd->nr_ppas, c_ctx->lun_bitmap);
+	pblk_up_rq(pblk, c_ctx->lun_bitmap);
 	if (c_ctx->nr_padded)
 		pblk_bio_free_pages(pblk, rqd->bio, c_ctx->nr_valid,
 							c_ctx->nr_padded);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 9068b158de22..0ca67e8f99d5 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -827,8 +827,7 @@ void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas);
 void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
 		  unsigned long *lun_bitmap);
 void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas);
-void pblk_up_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
-		unsigned long *lun_bitmap);
+void pblk_up_rq(struct pblk *pblk, unsigned long *lun_bitmap);
 int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
 		       int nr_pages);
 void pblk_bio_free_pages(struct pblk *pblk, struct bio *bio, int off,
-- 
2.17.1

