Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BE8C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA26C214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="mCiCLmif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA26C214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeJISbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:31:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43056 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeJISbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:31:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id 80-v6so644304pgh.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2KQ7a6V+QsZjnp+mY5Qv4Wwwbkm6jegrv59uu4jR/iM=;
        b=mCiCLmifVBrOZCqiOfVLGUdaX1QWi8lqD1VPARcZPnBC02VEpoZOuV67nS9Lol7Vpr
         jq6DiFrGw+Recv4MMORTqb2Q6r4oT5F41EwSdTa7OWpl01vGB2Rj0oUHNs3kKapZq6Ni
         CC+eEqlok8s8GKuhWv0S3QNiTUcipTLtasffBB2PLf2PGPTpANDsdfDJSOeI+aOnFVnF
         qwEXkKFCY+sXT3LOwYTS7u1NQizTxmrsW+n0n7kvaC1nrlKBwlGdqrnXtrc5iEypwTmm
         MIA+FZJpjzECV+1c+Quq7A7RG9p7olYg1l7igIU4cK2vq155VGqXxXDP2OV/ZE/Y6UvT
         2XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2KQ7a6V+QsZjnp+mY5Qv4Wwwbkm6jegrv59uu4jR/iM=;
        b=Bg6m3q5n/N0wpCl04Llyme36PoxQn0X6yKrpp2iyoQbyULBZguBPROi0yaT5cIGqIy
         qWYnNYKAM0qpxyuaqYQ/7OjTifHmX698oaSuJ1+lIf0XJqCDwLYYfTC+okhl206fGC74
         7YQ14kyOtUpX9w9r/gmMrQ8scJ+wq1lMhL6xnk/dS/UQdC8K8jf4FHZOGC/lMedGSzQv
         R4OxZAvEhCSeL0AXZu6UUkx9q+7uGFFtH/boVIpbGS5IAX05Z0St5+saOS7JRQ/btdqp
         EU7F0r4JL8PZL47rZaMqxoOf5+mqDQH12ANequq8W5HqDjISk0ZGOkCA8i7u4Quvkn6j
         82pA==
X-Gm-Message-State: ABuFfoicxBb6Eyvh+zJOhDKgABC+FMQZjPe6+ndURVvAQ+tevhz+vVBx
        hwIDM4mAaHMNxn0TY4JrSIvlSQ==
X-Google-Smtp-Source: ACcGV61F1PoA4hRqWYK1IAGYsOAzEC62z/q1Z+g4JaA3omWYDC0saH+ySb71I2ONOkfxYYXsIFxTeQ==
X-Received: by 2002:a62:d713:: with SMTP id b19-v6mr29557442pfh.238.1539083681128;
        Tue, 09 Oct 2018 04:14:41 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:14:39 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 26/45] lightnvm: move ppa transformations to core
Date:   Tue,  9 Oct 2018 13:11:56 +0200
Message-Id: <20181009111215.7653-27-mb@lightnvm.io>
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

Continuing the effort of moving 1.2 and 2.0 specific code to core, move
64_to_32 and 32_to_64 ppa helpers from pblk to core.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk.h  | 78 ++-----------------------------------
 include/linux/lightnvm.h | 83 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 74 deletions(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 7f4e46dfb0d7..a2cc581951ef 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1102,86 +1102,16 @@ static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
 
 static inline struct ppa_addr pblk_ppa32_to_ppa64(struct pblk *pblk, u32 ppa32)
 {
-	struct ppa_addr ppa64;
+	struct nvm_tgt_dev *dev = pblk->dev;
 
-	ppa64.ppa = 0;
-
-	if (ppa32 == -1) {
-		ppa64.ppa = ADDR_EMPTY;
-	} else if (ppa32 & (1U << 31)) {
-		ppa64.c.line = ppa32 & ((~0U) >> 1);
-		ppa64.c.is_cached = 1;
-	} else {
-		struct nvm_tgt_dev *dev = pblk->dev;
-		struct nvm_geo *geo = &dev->geo;
-
-		if (geo->version == NVM_OCSSD_SPEC_12) {
-			struct nvm_addrf_12 *ppaf =
-					(struct nvm_addrf_12 *)&pblk->addrf;
-
-			ppa64.g.ch = (ppa32 & ppaf->ch_mask) >>
-							ppaf->ch_offset;
-			ppa64.g.lun = (ppa32 & ppaf->lun_mask) >>
-							ppaf->lun_offset;
-			ppa64.g.blk = (ppa32 & ppaf->blk_mask) >>
-							ppaf->blk_offset;
-			ppa64.g.pg = (ppa32 & ppaf->pg_mask) >>
-							ppaf->pg_offset;
-			ppa64.g.pl = (ppa32 & ppaf->pln_mask) >>
-							ppaf->pln_offset;
-			ppa64.g.sec = (ppa32 & ppaf->sec_mask) >>
-							ppaf->sec_offset;
-		} else {
-			struct nvm_addrf *lbaf = &pblk->addrf;
-
-			ppa64.m.grp = (ppa32 & lbaf->ch_mask) >>
-							lbaf->ch_offset;
-			ppa64.m.pu = (ppa32 & lbaf->lun_mask) >>
-							lbaf->lun_offset;
-			ppa64.m.chk = (ppa32 & lbaf->chk_mask) >>
-							lbaf->chk_offset;
-			ppa64.m.sec = (ppa32 & lbaf->sec_mask) >>
-							lbaf->sec_offset;
-		}
-	}
-
-	return ppa64;
+	return nvm_ppa32_to_ppa64(dev->parent, &pblk->addrf, ppa32);
 }
 
 static inline u32 pblk_ppa64_to_ppa32(struct pblk *pblk, struct ppa_addr ppa64)
 {
-	u32 ppa32 = 0;
+	struct nvm_tgt_dev *dev = pblk->dev;
 
-	if (ppa64.ppa == ADDR_EMPTY) {
-		ppa32 = ~0U;
-	} else if (ppa64.c.is_cached) {
-		ppa32 |= ppa64.c.line;
-		ppa32 |= 1U << 31;
-	} else {
-		struct nvm_tgt_dev *dev = pblk->dev;
-		struct nvm_geo *geo = &dev->geo;
-
-		if (geo->version == NVM_OCSSD_SPEC_12) {
-			struct nvm_addrf_12 *ppaf =
-					(struct nvm_addrf_12 *)&pblk->addrf;
-
-			ppa32 |= ppa64.g.ch << ppaf->ch_offset;
-			ppa32 |= ppa64.g.lun << ppaf->lun_offset;
-			ppa32 |= ppa64.g.blk << ppaf->blk_offset;
-			ppa32 |= ppa64.g.pg << ppaf->pg_offset;
-			ppa32 |= ppa64.g.pl << ppaf->pln_offset;
-			ppa32 |= ppa64.g.sec << ppaf->sec_offset;
-		} else {
-			struct nvm_addrf *lbaf = &pblk->addrf;
-
-			ppa32 |= ppa64.m.grp << lbaf->ch_offset;
-			ppa32 |= ppa64.m.pu << lbaf->lun_offset;
-			ppa32 |= ppa64.m.chk << lbaf->chk_offset;
-			ppa32 |= ppa64.m.sec << lbaf->sec_offset;
-		}
-	}
-
-	return ppa32;
+	return nvm_ppa64_to_ppa32(dev->parent, &pblk->addrf, ppa64);
 }
 
 static inline struct ppa_addr pblk_trans_map_get(struct pblk *pblk,
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 50ac5b21297c..eb7300c20f24 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -511,6 +511,89 @@ static inline u64 dev_to_chunk_addr(struct nvm_dev *dev, void *addrf,
 	return caddr;
 }
 
+static inline struct ppa_addr nvm_ppa32_to_ppa64(struct nvm_dev *dev,
+						 void *addrf, u32 ppa32)
+{
+	struct ppa_addr ppa64;
+
+	ppa64.ppa = 0;
+
+	if (ppa32 == -1) {
+		ppa64.ppa = ADDR_EMPTY;
+	} else if (ppa32 & (1U << 31)) {
+		ppa64.c.line = ppa32 & ((~0U) >> 1);
+		ppa64.c.is_cached = 1;
+	} else {
+		struct nvm_geo *geo = &dev->geo;
+
+		if (geo->version == NVM_OCSSD_SPEC_12) {
+			struct nvm_addrf_12 *ppaf = addrf;
+
+			ppa64.g.ch = (ppa32 & ppaf->ch_mask) >>
+							ppaf->ch_offset;
+			ppa64.g.lun = (ppa32 & ppaf->lun_mask) >>
+							ppaf->lun_offset;
+			ppa64.g.blk = (ppa32 & ppaf->blk_mask) >>
+							ppaf->blk_offset;
+			ppa64.g.pg = (ppa32 & ppaf->pg_mask) >>
+							ppaf->pg_offset;
+			ppa64.g.pl = (ppa32 & ppaf->pln_mask) >>
+							ppaf->pln_offset;
+			ppa64.g.sec = (ppa32 & ppaf->sec_mask) >>
+							ppaf->sec_offset;
+		} else {
+			struct nvm_addrf *lbaf = addrf;
+
+			ppa64.m.grp = (ppa32 & lbaf->ch_mask) >>
+							lbaf->ch_offset;
+			ppa64.m.pu = (ppa32 & lbaf->lun_mask) >>
+							lbaf->lun_offset;
+			ppa64.m.chk = (ppa32 & lbaf->chk_mask) >>
+							lbaf->chk_offset;
+			ppa64.m.sec = (ppa32 & lbaf->sec_mask) >>
+							lbaf->sec_offset;
+		}
+	}
+
+	return ppa64;
+}
+
+static inline u32 nvm_ppa64_to_ppa32(struct nvm_dev *dev,
+				     void *addrf, struct ppa_addr ppa64)
+{
+	u32 ppa32 = 0;
+
+	if (ppa64.ppa == ADDR_EMPTY) {
+		ppa32 = ~0U;
+	} else if (ppa64.c.is_cached) {
+		ppa32 |= ppa64.c.line;
+		ppa32 |= 1U << 31;
+	} else {
+		struct nvm_geo *geo = &dev->geo;
+
+		if (geo->version == NVM_OCSSD_SPEC_12) {
+			struct nvm_addrf_12 *ppaf = addrf;
+
+			ppa32 |= ppa64.g.ch << ppaf->ch_offset;
+			ppa32 |= ppa64.g.lun << ppaf->lun_offset;
+			ppa32 |= ppa64.g.blk << ppaf->blk_offset;
+			ppa32 |= ppa64.g.pg << ppaf->pg_offset;
+			ppa32 |= ppa64.g.pl << ppaf->pln_offset;
+			ppa32 |= ppa64.g.sec << ppaf->sec_offset;
+		} else {
+			struct nvm_addrf *lbaf = addrf;
+
+			ppa32 |= ppa64.m.grp << lbaf->ch_offset;
+			ppa32 |= ppa64.m.pu << lbaf->lun_offset;
+			ppa32 |= ppa64.m.chk << lbaf->chk_offset;
+			ppa32 |= ppa64.m.sec << lbaf->sec_offset;
+		}
+	}
+
+	return ppa32;
+}
+
+
 typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
 typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
-- 
2.17.1

