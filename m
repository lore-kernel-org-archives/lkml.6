Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C49CC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2902086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LqvtNC8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2902086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeIKTrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:47:25 -0400
Received: from m12-13.163.com ([220.181.12.13]:33929 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbeIKTrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=HJtsXsi2QZvVyVn6GB
        NAfDJF1SqPVzzBIW5pabVn9lA=; b=LqvtNC8vqA1guIlY/ccnmwA5CjDSqYr8eP
        E0If3kyywy3zLWRcNKgNrHEp+g6VrB7QYH+S5uAl5RIO9Vd3Hcm1YNAzOM1E1zHb
        5MdEQcmMFjlG4jR5FXKuEIAiW8ZoKce0U5e3WVOszHmt483vheKYC3TUbe39SbaO
        7/y4WhewY=
Received: from localhost (unknown [183.134.187.192])
        by smtp9 (Coremail) with SMTP id DcCowAAHZVln1ZdbFG_OJA--.24665S5;
        Tue, 11 Sep 2018 22:47:04 +0800 (CST)
From:   jun qian <hangdianqj@163.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kees Cook <keescook@chromium.org>, Allen <allen.lkml@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jun qian <hangdianqj@163.com>
Subject: [PATCH] mmc: mxcmmc: replace spin_lock_irqsave with spin_lock in ISR
Date:   Tue, 11 Sep 2018 07:47:01 -0700
Message-Id: <20180911144701.53383-1-hangdianqj@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DcCowAAHZVln1ZdbFG_OJA--.24665S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1rAF4xAFWUJr4kAF4DCFg_yoWkCFX_ur
        W5Wr97Ww45JryjgF10kw4fCa4jyw4DXw1fKF4xtFWSyrZag3W3Z34xZ3s8J34UuF4rCFZ3
        Cr1YyFWrG342kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbnqXJUUUUU==
X-Originating-IP: [183.134.187.192]
X-CM-SenderInfo: pkdqwvpldq1yi6rwjhhfrp/xtbBiAi+R1aDzhwSAgAAsu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As you are already in ISR, it is unnecessary to call spin_lock_irqsave.

Signed-off-by: jun qian <hangdianqj@163.com>
---
 drivers/mmc/host/mxcmmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index de4e6e5bf304..4d17032d15ee 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -728,7 +728,6 @@ static void mxcmci_cmd_done(struct mxcmci_host *host, unsigned int stat)
 static irqreturn_t mxcmci_irq(int irq, void *devid)
 {
 	struct mxcmci_host *host = devid;
-	unsigned long flags;
 	bool sdio_irq;
 	u32 stat;
 
@@ -740,9 +739,9 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
 
 	dev_dbg(mmc_dev(host->mmc), "%s: 0x%08x\n", __func__, stat);
 
-	spin_lock_irqsave(&host->lock, flags);
+	spin_lock(&host->lock);
 	sdio_irq = (stat & STATUS_SDIO_INT_ACTIVE) && host->use_sdio;
-	spin_unlock_irqrestore(&host->lock, flags);
+	spin_unlock(&host->lock);
 
 	if (mxcmci_use_dma(host) && (stat & (STATUS_WRITE_OP_DONE)))
 		mxcmci_writel(host, STATUS_WRITE_OP_DONE, MMC_REG_STATUS);
-- 
2.17.1



