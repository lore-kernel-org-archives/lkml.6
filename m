Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49406C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83902086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PdekQRhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83902086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeIKTye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:54:34 -0400
Received: from m12-15.163.com ([220.181.12.15]:38899 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbeIKTye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=IT2fj+Ts6vAYZSMAC4
        J7058Hi64sfKtjDNC9p+i7Smw=; b=PdekQRhrLwlUW7CW35mWU3XVbMcBxHSefz
        PpuQxAMgUHmG50yvRSkltCDPpWKJxIOuICRYTJPCvAJhriveEnKduNbTGyZW0UEC
        Z66tqVFe6Eeq8AClkPtIovQkW3E6cqQWChFnR4kzIawUfJnnRxCDRkvWsRG4AGwG
        WzfOPCA4M=
Received: from localhost (unknown [183.134.187.192])
        by smtp11 (Coremail) with SMTP id D8CowAC3Nco315dbQ+qNGw--.31967S5;
        Tue, 11 Sep 2018 22:54:49 +0800 (CST)
From:   jun qian <hangdianqj@163.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, jun qian <hangdianqj@163.com>
Subject: [PATCH] i2c: i2c-tegra: replace spin_lock_irqsave with spin_lock in ISR
Date:   Tue, 11 Sep 2018 07:54:46 -0700
Message-Id: <20180911145446.53621-1-hangdianqj@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: D8CowAC3Nco315dbQ+qNGw--.31967S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1rAF4xAFWUKr17CryfWFg_yoWkKFX_tw
        4Uu3srZF1jywn8Ar17JryfZryjgFnYgr1xWrZ2yasIk34jq3WDJF4DZryfCrWUX3ZFka1a
        q34q9F1xursxtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbeOJ5UUUUU==
X-Originating-IP: [183.134.187.192]
X-CM-SenderInfo: pkdqwvpldq1yi6rwjhhfrp/1tbiJxm+R1XloCtc8AAAsQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As you are already in ISR, it is unnecessary to call spin_lock_irqsave.

Signed-off-by: jun qian <hangdianqj@163.com>
---
 drivers/i2c/busses/i2c-tegra.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 60c8561fbe65..59f31d3a508f 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -608,11 +608,10 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 	u32 status;
 	const u32 status_err = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
 	struct tegra_i2c_dev *i2c_dev = dev_id;
-	unsigned long flags;
 
 	status = i2c_readl(i2c_dev, I2C_INT_STATUS);
 
-	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
+	spin_lock(&i2c_dev->xfer_lock);
 	if (status == 0) {
 		dev_warn(i2c_dev->dev, "irq status 0 %08x %08x %08x\n",
 			 i2c_readl(i2c_dev, I2C_PACKET_TRANSFER_STATUS),
@@ -670,7 +669,7 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 
 	complete(&i2c_dev->msg_complete);
 done:
-	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
+	spin_unlock(&i2c_dev->xfer_lock);
 	return IRQ_HANDLED;
 }
 
-- 
2.17.1



