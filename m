Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEA1C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 15:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40315208EB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 15:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GQHTrBHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40315208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeHZSoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 14:44:11 -0400
Received: from m12-13.163.com ([220.181.12.13]:52829 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbeHZSoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 14:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=Bgw1/
        glztYrFsjVOQlewPXLgQFwxhT1btg/iQ6GTX9E=; b=GQHTrBHHDgW/ERlSSckAq
        86YiRbygCqixWbq34bntAC+NkXbDe4ZyUm1Eq1pXc60XrojZNLosBVniVsqTmoog
        uRMtj7VOJHeiL1uyMtbZZiIJJC014iMpiZo05VaVqhbUf7rxoUuaIIq1bhRsLxLA
        UWmKTBPWy0TdTsYuimdAHg=
Received: from localhost (unknown [36.24.137.174])
        by smtp9 (Coremail) with SMTP id DcCowAA3jZGawIJbUDzNHA--.56275S5;
        Sun, 26 Aug 2018 23:00:43 +0800 (CST)
Date:   Sun, 26 Aug 2018 08:00:42 -0700
From:   QIANJUN <hangdianqj@163.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: spin_lock instead of spin_lock_irqsave in imx uart interuput
Message-ID: <20180826150042.GA7972@ubuntu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CM-TRANSID: DcCowAA3jZGawIJbUDzNHA--.56275S5
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUaS_MDUUUU
X-Originating-IP: [36.24.137.174]
X-CM-SenderInfo: pkdqwvpldq1yi6rwjhhfrp/1tbiNxyuR1WBY25ubgAAsb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

spin_lock instead of spin_lock_irqsave in imx uart interuput

--3V7upXqbjpZ4EhLz
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-before-the-programe-into-the-uart-interuput-s-handle.patch"

From 6580790d7be51a78d1376b90df49b04019a1f944 Mon Sep 17 00:00:00 2001
From: jun qian <hangdianqj@163.com>
Date: Sun, 26 Aug 2018 06:58:35 -0700
Subject: [PATCH] before the programe into the uart interuput's handler, the
 system has already disabled the local cpu interuput. so the spin_lock
 interface is More suitable for here.

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


--3V7upXqbjpZ4EhLz--


