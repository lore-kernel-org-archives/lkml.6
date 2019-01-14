Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65B3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A812120651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofpEuWDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfANTSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:18:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46479 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANTSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:18:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so38036pgp.13;
        Mon, 14 Jan 2019 11:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h+sbqrLenk60F3eDSH1lBbRS/HpdojEGX59+/RMk3xw=;
        b=ofpEuWDh8iVbXpfpnZTDbkvUkcyWwJdR3CNDcCMArhhmSnAS+RGVyjaz06CMtNRZ6K
         y9h7bQRSd11Tp4lgO0dKQgGgsQaSSl+J3IMR51CpmKb4dG3i2SjNFiZ/0btMxvKYewse
         pjupwmDIfVooI6GFqE4f92cZGHcK5AlGz9rIQBF47gnme/MVGJBsR7N/jMsUxLkOWCUg
         kscO9w+WuNV5/6qp+6UdsqlJEIde+p5L9RHzFGOVf2n/tdaOuCXKRS2C0oelKMwsHFr4
         l1RbfIjPpdFWZJIRvbnjCA3aRpwgjcLOJXuBsa4kLEP8DDcB9GhB68JQAsyZ1t1bFa81
         xSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h+sbqrLenk60F3eDSH1lBbRS/HpdojEGX59+/RMk3xw=;
        b=bbhv47XY/vuZrLx0YX8HIgjCCotLv2ODu9ldFHcG7YzEZSozHsQXm/QMrjjt9f4dNY
         T8DM9a7gWTdXcy00xC/1sjap2oL196Y1020HMCEBgqDSP7iOM52X8UyjuXvehqMZUpAs
         UpP3pigVMiNWBNBuL2UDuU8DArN+ayOCSbuXhsEE0oBjnLlaYunxo64gcckZeo0jNJQJ
         lmqYiuou0tIgWfZ2UTShXiGmPlpTJZHNuX45RavvuDp6Y3khmtfnnSEIkIZN7lNmGiOC
         3LzeTkBVAvd2ROJBghWwhnTqeUjm6byxBame6Q6W1MjbNmqt6/LYacK/zvspLfwFx/pX
         Q9jw==
X-Gm-Message-State: AJcUukcpEnY91YoPBn1hXcj07KEuAIOdR2/I54ZDwb1J/zlFcLAbTggU
        8ZVZCxBIZdY42FgRuRBCDZ8=
X-Google-Smtp-Source: ALg8bN79DnmFa88eYecS7YjlGHwMgeH99MXWpQHppNqjY/JMQmhayxToewLEOGUuPU3x69oYahUMGA==
X-Received: by 2002:a62:3c1:: with SMTP id 184mr30042pfd.56.1547493488702;
        Mon, 14 Jan 2019 11:18:08 -0800 (PST)
Received: from localhost.localdomain ([216.13.234.27])
        by smtp.gmail.com with ESMTPSA id b2sm2672771pgg.87.2019.01.14.11.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 11:18:08 -0800 (PST)
From:   Alamy Liu <alamy.liu@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Alamy Liu <alamy.liu@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: cqhci: replace DCMD_SLOT with cq_host->dcmd_slot
Date:   Mon, 14 Jan 2019 11:17:22 -0800
Message-Id: <20190114191724.29960-2-alamy.liu@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114191724.29960-1-alamy.liu@gmail.com>
References: <20190114191724.29960-1-alamy.liu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent to use fixed value (DCMD_SLOT) after it had been determined
and saved in a variable (cq_host->dcmd).

Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
---
 drivers/mmc/host/cqhci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 26d63594b7..4cc7863c13 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -76,7 +76,8 @@ static void setup_trans_desc(struct cqhci_host *cq_host, u8 tag)
 	if (cq_host->link_desc_len > 8)
 		*(link_temp + 8) = 0;
 
-	if (tag == DCMD_SLOT && (cq_host->mmc->caps2 & MMC_CAP2_CQE_DCMD)) {
+	if ((tag == cq_host->dcmd_slot)
+	    && (cq_host->mmc->caps2 & MMC_CAP2_CQE_DCMD)) {
 		*link_temp = CQHCI_VALID(0) | CQHCI_ACT(0) | CQHCI_END(1);
 		return;
 	}
@@ -548,9 +549,9 @@ static void cqhci_post_req(struct mmc_host *host, struct mmc_request *mrq)
 	}
 }
 
-static inline int cqhci_tag(struct mmc_request *mrq)
+static inline int cqhci_tag(struct mmc_request *mrq, struct cqhci_host *cq_host)
 {
-	return mrq->cmd ? DCMD_SLOT : mrq->tag;
+	return mrq->cmd ? cq_host->dcmd_slot : mrq->tag;
 }
 
 static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -558,8 +559,8 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	int err = 0;
 	u64 data = 0;
 	u64 *task_desc = NULL;
-	int tag = cqhci_tag(mrq);
 	struct cqhci_host *cq_host = mmc->cqe_private;
+	int tag = cqhci_tag(mrq, cq_host);
 	unsigned long flags;
 
 	if (!cq_host->enabled) {
@@ -824,7 +825,7 @@ static bool cqhci_timeout(struct mmc_host *mmc, struct mmc_request *mrq,
 			  bool *recovery_needed)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
-	int tag = cqhci_tag(mrq);
+	int tag = cqhci_tag(mrq, cq_host);
 	struct cqhci_slot *slot = &cq_host->slot[tag];
 	unsigned long flags;
 	bool timed_out;
-- 
2.17.1

