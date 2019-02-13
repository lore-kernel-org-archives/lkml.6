Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0387C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8732F21902
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550074597;
	bh=gaiq+O+KzKPZRg3GURgiy4EoKjbBBMM2ECLa5PILyiw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VW/6YAmZakMzmCbqRbA5XsFImQp2cL9aeDXZdSqZU37+xsWBUJaOqw7swr2WxtISy
	 +/b9wRcF8XCm4aIUCsUgZhUYEbtWhfxdUV2NEMOy6CgwKLgrWrRdu6Pc403gpT7bwR
	 uxa6ykO/8Nr9P9483Ezp0EH0uRMzoB/dg7hfLdDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404205AbfBMQQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:16:36 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32988 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfBMQQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:16:33 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so5141725otl.0;
        Wed, 13 Feb 2019 08:16:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ef6YWFv9ktS3j0kmb/zu0v9p90wlI3LS1ze8Nq7OUNc=;
        b=pm6V9gw3o4y7DWO0+/wlQKxFZLGvGJ+HrFkYNzx6mersMSW6CoLl9ij6WxktavoIAn
         LHlFTrV3RGekeXZp7Sx1JAFAWS+c5SYFLyiBhn9QcgIBdBleoHM8m2yZPefA2WcH3FB6
         iL+m2q3oKuGX0qKr9BNw8q/7QBUzSkatUb85iZCPEcDZshE/+mGnaZWp+eh/NHfgeeM8
         1nr9duk3M5GPv3M2OhqcW+xuE9rcxAqLjCpmkFkhyuozaLCj+61/66zn0cGqWoJySxJb
         J22ZpPKfLwdNmDm2KyKhxup/2Wto/IwISOUmcXKFLuoajIwiWCiVYwVsx6hlYrXh1K4p
         8FDA==
X-Gm-Message-State: AHQUAuavxGrSb5aq9IiZkImcOCuf72BugopotFlF+ykxSkAI2zuRljM3
        cEmSmh/Ks5IDlCR3rz27gLCBRm0=
X-Google-Smtp-Source: AHgI3IbWvfS3Je56sPPDd/4nZ3gkZKutz0n/pO7g3cFo+GrSMFASbJJDh6idigtxgWbYXn3+v73A0g==
X-Received: by 2002:aca:cd:: with SMTP id 196mr666731oia.42.1550074592811;
        Wed, 13 Feb 2019 08:16:32 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id 187sm433969oid.22.2019.02.13.08.16.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 13 Feb 2019 08:16:32 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH] Input: i8042 - Rework DT node name comparisons
Date:   Wed, 13 Feb 2019 10:16:31 -0600
Message-Id: <20190213161631.17028-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. For the root node on SUN DT, we need to retrieve the 'name'
property as it is the rare case where the 'name' property and node name
differ. With both changes, it removes direct access to the node name
pointer.

While at it, comvert the open coded loop to use
for_each_child_of_node().

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
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

