Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B1EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A14208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R80VThEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A14208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeH0Sgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:36:42 -0400
Received: from m12-16.163.com ([220.181.12.16]:58345 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbeH0Sgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=oDV97ST5iYIUv/lX/R
        4XxNfXy8mPA/thIhlYZSIDEQI=; b=R80VThEETXW1b/jc954xzXStDFkEpjj122
        QkvG7UpAwDEmnRRzFbhJiv5SlHIYZ2IwOIMXYrzID6+JvAPD2d4HubIfgVxLI4in
        Iy4MvUKEy8R9eoFW1v+ZpEDpGsiJ5EZZDw0Pnh/vlB+KbRxR5SVfUUrjz60cirEn
        JYwmN5Myc=
Received: from localhost (unknown [36.24.137.174])
        by smtp12 (Coremail) with SMTP id EMCowAA31W1iD4RbQBn_DQ--.19550S5;
        Mon, 27 Aug 2018 22:49:08 +0800 (CST)
From:   jun qian <hangdianqj@163.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Barry song <21cnbao@gmail.com>, Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        jun qian <hangdianqj@163.com>
Subject: [PATCH] tty:serial:imx: use spin_lock instead of spin_lock_irqsave in isr
Date:   Mon, 27 Aug 2018 07:49:04 -0700
Message-Id: <20180827144904.17226-1-hangdianqj@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EMCowAA31W1iD4RbQBn_DQ--.19550S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4xtF1xAryfWr15WFy7GFg_yoW5Jw1rpF
        4DtFZIyFWUZF4jqa1DJr1UWr45u34kZ34UGr4xJa4xCrZ5J3sIqrn3Kayq9FWYyr47urZY
        vF45t342yr48Jw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UC0PhUUUUU=
X-Originating-IP: [36.24.137.174]
X-CM-SenderInfo: pkdqwvpldq1yi6rwjhhfrp/1tbiURSvR1WBHm3qKQAAsJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the program enters the uart ISR, the local interrupt has been
disabled by the system, so it's not appropriate to use spin_lock_irqsave
interface in the ISR.

Signed-off-by: jun qian <hangdianqj@163.com>
---
 drivers/tty/serial/imx.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 239c0fa2e981..3069ee93583e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -706,27 +706,25 @@ static irqreturn_t imx_uart_rtsint(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
 	u32 usr1;
-	unsigned long flags;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	spin_lock(&sport->port.lock);
 
 	imx_uart_writel(sport, USR1_RTSD, USR1);
 	usr1 = imx_uart_readl(sport, USR1) & USR1_RTSS;
 	uart_handle_cts_change(&sport->port, !!usr1);
 	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	spin_unlock(&sport->port.lock);
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t imx_uart_txint(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
-	unsigned long flags;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	spin_lock(&sport->port.lock);
 	imx_uart_transmit_buffer(sport);
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	spin_unlock(&sport->port.lock);
 	return IRQ_HANDLED;
 }
 
@@ -735,9 +733,8 @@ static irqreturn_t imx_uart_rxint(int irq, void *dev_id)
 	struct imx_port *sport = dev_id;
 	unsigned int rx, flg, ignored = 0;
 	struct tty_port *port = &sport->port.state->port;
-	unsigned long flags;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	spin_lock(&sport->port.lock);
 
 	while (imx_uart_readl(sport, USR2) & USR2_RDR) {
 		u32 usr2;
@@ -797,7 +794,7 @@ static irqreturn_t imx_uart_rxint(int irq, void *dev_id)
 	}
 
 out:
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	spin_unlock(&sport->port.lock);
 	tty_flip_buffer_push(port);
 	return IRQ_HANDLED;
 }
@@ -903,13 +900,11 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
 	}
 
 	if (usr1 & USR1_DTRD) {
-		unsigned long flags;
-
 		imx_uart_writel(sport, USR1_DTRD, USR1);
 
-		spin_lock_irqsave(&sport->port.lock, flags);
+		spin_lock(&sport->port.lock);
 		imx_uart_mctrl_check(sport);
-		spin_unlock_irqrestore(&sport->port.lock, flags);
+		spin_unlock(&sport->port.lock);
 
 		ret = IRQ_HANDLED;
 	}
-- 
2.17.1



