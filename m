Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C22C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9098A20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039466;
	bh=zZuOOzmGmA6S6ZPyE8dx/SuEOnystPN7UIUwSmBk2HI=;
	h=From:To:Subject:Date:List-ID:From;
	b=PxFGLXmWCg1Lq41yAcgP3/IWxWxylNyf1iMeEbO223ZrpwgvmEurSIdrPHTncMU2e
	 KoChpzi4B53byFJMSl2zNX9FP3HLx2kkJhZ1HZ44Rlsts/A2Q7n9PKrImU6CFPBXMa
	 wacFHWxzYm8H4tS2fNxAuzFt17+peYeuH1Lm4Q2w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9098A20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbeLETvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:51:05 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35871 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbeLETvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:03 -0500
Received: by mail-oi1-f196.google.com with SMTP id x23so18635397oix.3;
        Wed, 05 Dec 2018 11:51:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1YaWklIJnfN3jgLPotdewoR9rQO3OXEUYSjAKzJB9tk=;
        b=cIRVgyErFdKqPEahB3GZ3PlfWmHd7Dkm8kw7aQaJ+wE+AOWtDscve/Myz1J6hu6Odg
         J/7uDixw/EW2XnnnQKLpHWzMZgo4uYiZT96ccNKuwgJD39pFrgWokfS0eOf6CpN/+GRu
         RQt/CHVpD02dRhQ/MYtw5hSdo+y4wJ0rEyVPauTZDmZZeznA2bf4EkOt13YilQIu800q
         VsNLkh1166vfgeFkVAHnUDNTb2yf9Ipfj2p/5rDULdktRxHfVEzq2UZJw+5eVCk6bhfp
         wqzcwKF86AqHf/rVVXhfYNzp0VKOaDwiyYrYnEuMP4gVlIwT4mfvEtnOxot5XlSgO11V
         N5WA==
X-Gm-Message-State: AA+aEWbUddMJ+vQZlZpCMfKJ6oZcH+n4QpNTt5/mwdIojszc3SS4AaUG
        KdcGJpbECQfB9HmIH8N+uUg1Rm0=
X-Google-Smtp-Source: AFSGD/Xd38B+oDF9+h7aJuCGX4C0IxFMiDza2WTdBX4JTOBHLEAirfZhuaSvX4tRf2ylMA03vsCTBw==
X-Received: by 2002:aca:aad8:: with SMTP id t207mr14705099oie.90.1544039461975;
        Wed, 05 Dec 2018 11:51:01 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:01 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: i8042 - Rework DT node name comparisons
Date:   Wed,  5 Dec 2018 13:50:26 -0600
Message-Id: <20181205195050.4759-10-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/input/serio/i8042-sparcio.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index 796289846204..fce76812843b 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -53,12 +53,11 @@ static struct resource *kbd_res;
 
 static int sparc_i8042_probe(struct platform_device *op)
 {
-	struct device_node *dp = op->dev.of_node;
+	struct device_node *dp;
 
-	dp = dp->child;
-	while (dp) {
-		if (!strcmp(dp->name, OBP_PS2KBD_NAME1) ||
-		    !strcmp(dp->name, OBP_PS2KBD_NAME2)) {
+	for_each_child_of_node(op->dev.of_node, dp) {
+		if (of_node_name_eq(dp, OBP_PS2KBD_NAME1) ||
+		    of_node_name_eq(dp, OBP_PS2KBD_NAME2)) {
 			struct platform_device *kbd = of_find_device_by_node(dp);
 			unsigned int irq = kbd->archdata.irqs[0];
 			if (irq == 0xffffffff)
@@ -67,16 +66,14 @@ static int sparc_i8042_probe(struct platform_device *op)
 			kbd_iobase = of_ioremap(&kbd->resource[0],
 						0, 8, "kbd");
 			kbd_res = &kbd->resource[0];
-		} else if (!strcmp(dp->name, OBP_PS2MS_NAME1) ||
-			   !strcmp(dp->name, OBP_PS2MS_NAME2)) {
+		} else if (of_node_name_eq(dp, OBP_PS2MS_NAME1) ||
+			   of_node_name_eq(dp, OBP_PS2MS_NAME2)) {
 			struct platform_device *ms = of_find_device_by_node(dp);
 			unsigned int irq = ms->archdata.irqs[0];
 			if (irq == 0xffffffff)
 				irq = op->archdata.irqs[0];
 			i8042_aux_irq = irq;
 		}
-
-		dp = dp->sibling;
 	}
 
 	return 0;
@@ -109,8 +106,9 @@ static struct platform_driver sparc_i8042_driver = {
 static int __init i8042_platform_init(void)
 {
 	struct device_node *root = of_find_node_by_path("/");
+	const char *name = of_get_property(root, "name", NULL);
 
-	if (!strcmp(root->name, "SUNW,JavaStation-1")) {
+	if (name && !strcmp(name, "SUNW,JavaStation-1")) {
 		/* Hardcoded values for MrCoffee.  */
 		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
 		kbd_iobase = ioremap(0x71300060, 8);
@@ -139,8 +137,9 @@ static int __init i8042_platform_init(void)
 static inline void i8042_platform_exit(void)
 {
 	struct device_node *root = of_find_node_by_path("/");
+	const char *name = of_get_property(root, "name", NULL);
 
-	if (strcmp(root->name, "SUNW,JavaStation-1"))
+	if (!name || strcmp(name, "SUNW,JavaStation-1"))
 		platform_driver_unregister(&sparc_i8042_driver);
 }
 
-- 
2.19.1

