Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3F5C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D77F21477
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D77F21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeHYMWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 08:22:48 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:47501 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbeHYMWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 08:22:48 -0400
Received: from belgarion.home ([90.89.234.36])
        by mwinf5d41 with ME
        id TLkR1y00h0nnJME03LkXDn; Sat, 25 Aug 2018 10:44:31 +0200
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 25 Aug 2018 10:44:31 +0200
X-ME-IP: 90.89.234.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: pxa: handle corner case of unprobed device
Date:   Sat, 25 Aug 2018 10:44:17 +0200
Message-Id: <20180825084417.13526-1-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the corner case where the gpio driver probe fails, for whatever
reason, the suspend and resume handlers will still be called as they
have to be registered as syscore operations. This applies as well when
no probe was called while the driver has been built in the kernel.

Nicolas tracked this in :
https://bugzilla.kernel.org/show_bug.cgi?id=200905

Therefore, add a failsafe in these function, and test if a proper probe
succeeded and the driver is functional.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Reported-by: Nicolas Chauvet <kwizart@gmail.com>
---
 drivers/gpio/gpio-pxa.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index c18712dabf93..bfe4c5c9f41c 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -776,6 +776,9 @@ static int pxa_gpio_suspend(void)
 	struct pxa_gpio_bank *c;
 	int gpio;
 
+	if (!pchip)
+		return 0;
+
 	for_each_gpio_bank(gpio, c, pchip) {
 		c->saved_gplr = readl_relaxed(c->regbase + GPLR_OFFSET);
 		c->saved_gpdr = readl_relaxed(c->regbase + GPDR_OFFSET);
@@ -794,6 +797,9 @@ static void pxa_gpio_resume(void)
 	struct pxa_gpio_bank *c;
 	int gpio;
 
+	if (!pchip)
+		return;
+
 	for_each_gpio_bank(gpio, c, pchip) {
 		/* restore level with set/clear */
 		writel_relaxed(c->saved_gplr, c->regbase + GPSR_OFFSET);
-- 
2.11.0

