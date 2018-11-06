Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E82C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1E22083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="An5a6era"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1E22083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbeKFOZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 09:25:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44716 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbeKFOZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 09:25:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id j13-v6so5515382pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 21:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Ig1u0SVMDYDTOMNzrGMHK+hoBj16/oLyBxKtaJt37JU=;
        b=An5a6eraHBGxYnTEnYSGMSvJom+BfCzLpM/xs8uLYjgucl2r1i+avUxJxJy1IhaTCo
         dis9DzuoqlpgedC8n3Hl66n2OZHtyVZVec8W4yQsZK3iBJg804l4GYJnE8zQ/luHWuG+
         cj/XqQjPHZrN7wrF9VErJP6wViuwoIvYgy3WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Ig1u0SVMDYDTOMNzrGMHK+hoBj16/oLyBxKtaJt37JU=;
        b=hWBzcNLcG24Si7ND3YgZxmdG9jD/CxzpqXxYrJQ/4C65dee/Tg+8lSQquWGc0vRZmF
         8Hndh313d2z8+Eex9LB31X/1jD1ijPhm2z6bq+88krFVgKYEPnEJMzkFAB66CoCnH0c2
         g0/W95Q9fel8LEFeLtyCaDTOUKCLYisVaTBqCJgg7+vm345A2ft0SUPjl1ajzyJcjRWn
         EKBu+F/CJ1SNBWSwwscbSBYGwCJrZxgskR03ojkAqrw7KON2K0+92Ph/+BwL9FPBC5zZ
         3bYO/M2D3qDut7VqPBD1ZAUaOndQvZigexrtdYEKgqWL/WYt5UrDyt5Z17RN49vSaV5e
         lsnA==
X-Gm-Message-State: AGRZ1gKp8bDxgp1hC2wZY75HWOGHJW+3DRryENJ8EMJaM+RmMdV2uquw
        +ml4m5BJk8k7yyZWDx8gZJoUvQ==
X-Google-Smtp-Source: AJdET5dvBKAnHb67r0s6mpcLRbrYJQH0L+XsOIks/k74LWc/D6SbP0S8Mbg/dq7fCM1TU62ZoyDPUw==
X-Received: by 2002:a63:d157:: with SMTP id c23mr6593019pgj.170.1541480534703;
        Mon, 05 Nov 2018 21:02:14 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id o7-v6sm55735416pfb.23.2018.11.05.21.02.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 21:02:14 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org, eric.long@unisoc.com
Cc:     broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 5/7] dmaengine: sprd: Support DMA link-list cyclic callback
Date:   Tue,  6 Nov 2018 13:01:35 +0800
Message-Id: <ffb2cbf122833bd4dfd4715b7ebae663b303b909.1541480353.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1541480353.git.baolin.wang@linaro.org>
References: <cover.1541480353.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1541480353.git.baolin.wang@linaro.org>
References: <cover.1541480353.git.baolin.wang@linaro.org>
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

