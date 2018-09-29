Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C461DC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2F9206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XezMXmNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2F9206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeI2MRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:17:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35850 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbeI2MRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:17:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id f18-v6so2382002pgv.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 22:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Ig1u0SVMDYDTOMNzrGMHK+hoBj16/oLyBxKtaJt37JU=;
        b=XezMXmNaRKQSJ6O7CK0Mc2+4mFLPQOgXEpsEsnVB2F5WItgYc+VNlacf3o5VCqZ3fZ
         elgzCOz+EIsJuwUJRO8e04u0P/T/zGFB8JU4R62W9ITRWYlnVAr6Azz4CvLNV64/FPsa
         si1S4opSex+TcxopZgf4dsOrYXQq5Up/JCEnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Ig1u0SVMDYDTOMNzrGMHK+hoBj16/oLyBxKtaJt37JU=;
        b=gcvk2tVMVZAl+5P0/cw+WAFpXqwVcTfyK5cUYixJolmT8vUXcWTt7R4B/RnScUolOc
         Z3eXRU/MxrmYL5PwzIxS5w46+DD7WuLllb3pcTgdAYfqtyNe4tjrZ4jsHnowNL0X6BI4
         a6ILRcuhmartVUsLQRp2anyl+kiSUnL5UQV7Hg47JcrIxalIHJmWqyP5kvFvDv7tDeRt
         VG/gm31fNIBqRdBQOaMoQzgVZHwqCBMTSJ9Y2cjCJL9eXZwnwZr4Mti0SeQGD/qlwRvP
         KnzK+cDWgLRvzX1j/GHAGeiSMxHDvl5qXQhFJNwqvEbLA94iQxe/KSDfKl/oIvFX3U0/
         uW0g==
X-Gm-Message-State: ABuFfojE/Qg14DDmr1xcQwBtr4Jh42Gf2WjKcklscslyYvlBNpQZEiVA
        56cfvIGav5rwJVFYjZx8wfUXpg==
X-Google-Smtp-Source: ACcGV602hcoPUC/oDitWjzapQhAeOiaAMD+SKwH+lgtaZXmIr/i5M0+IfNqW7cotmYfdef4NDLMGjw==
X-Received: by 2002:a17:902:585:: with SMTP id f5-v6mr1718464plf.7.1538200215637;
        Fri, 28 Sep 2018 22:50:15 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i80-v6sm11118049pfi.87.2018.09.28.22.50.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 22:50:14 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org,
        eric.long@spreadtrum.com
Cc:     broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] dmaengine: sprd: Support DMA link-list cyclic callback
Date:   Sat, 29 Sep 2018 13:49:03 +0800
Message-Id: <5512ed9fc0c63cd05a56defd79ab3b6a60a8acb1.1538199697.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1538199697.git.baolin.wang@linaro.org>
References: <cover.1538199697.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1538199697.git.baolin.wang@linaro.org>
References: <cover.1538199697.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@spreadtrum.com>

The Spreadtrum DMA link-list mode is always one cyclic transfer,
so we should clear the SPRD_DMA_LLIST_END flag for the link-list
configuration. Moreover add cyclic callback support for the cyclic
transfer.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 1b39661..cefe42f 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -463,7 +463,7 @@ static irqreturn_t dma_irq_handle(int irq, void *dev_id)
 	struct sprd_dma_desc *sdesc;
 	enum sprd_dma_req_mode req_type;
 	enum sprd_dma_int_type int_type;
-	bool trans_done = false;
+	bool trans_done = false, cyclic = false;
 	u32 i;
 
 	while (irq_status) {
@@ -478,13 +478,19 @@ static irqreturn_t dma_irq_handle(int irq, void *dev_id)
 
 		sdesc = schan->cur_desc;
 
-		/* Check if the dma request descriptor is done. */
-		trans_done = sprd_dma_check_trans_done(sdesc, int_type,
-						       req_type);
-		if (trans_done == true) {
-			vchan_cookie_complete(&sdesc->vd);
-			schan->cur_desc = NULL;
-			sprd_dma_start(schan);
+		/* cyclic mode schedule callback */
+		cyclic = schan->linklist.phy_addr ? true : false;
+		if (cyclic == true) {
+			vchan_cyclic_callback(&sdesc->vd);
+		} else {
+			/* Check if the dma request descriptor is done. */
+			trans_done = sprd_dma_check_trans_done(sdesc, int_type,
+							       req_type);
+			if (trans_done == true) {
+				vchan_cookie_complete(&sdesc->vd);
+				schan->cur_desc = NULL;
+				sprd_dma_start(schan);
+			}
 		}
 		spin_unlock(&schan->vc.lock);
 	}
@@ -692,9 +698,6 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 
 	/* link-list configuration */
 	if (schan->linklist.phy_addr) {
-		if (sg_index == sglen - 1)
-			hw->frg_len |= SPRD_DMA_LLIST_END;
-
 		hw->cfg |= SPRD_DMA_LINKLIST_EN;
 
 		/* link-list index */
-- 
1.7.9.5

