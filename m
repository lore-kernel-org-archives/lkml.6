Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5A2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8912084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1aEjV1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbeLOJIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 04:08:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45627 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbeLOJIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 04:08:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so3783990pgc.12;
        Sat, 15 Dec 2018 01:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fETn72DP6fOAab4oSieTDD9e4OnUueg7AExePTvGDtI=;
        b=N1aEjV1zb/UW8eQwHM3sB4WaBzKdJtawatTbp2cc3tf96Bl5Q7riBoS6aQyXMg+Qe6
         U6ng/O9FK4rOgWOEyrlED5vabvuQKjbxC1y45CGm63v0E34g9hmFMZImOd4iYyzBYPZm
         Wm9atk2kIsqPlqqGLEYgz3Y1EasEHLBLYU8wmOPqziKAznMsUxLJvHArCpIKMDPjqZeE
         5Ep0dICKJJllvziRsSugoS9qTaBNkIVpXf3BdzkouDJxG0w1SyQVSY3xjzeNLRDCE7hp
         Pk7FlfocM+eVxJQG1QK9a9CRZ9gLgqzqB3OEUR26ByqWTrQIvSR05Nuq/+n+AcNfRnFZ
         9lhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fETn72DP6fOAab4oSieTDD9e4OnUueg7AExePTvGDtI=;
        b=EyGYEmo+MuxrVvpzlDx/vjwbUzIR6Br9MKCENpOQqhAlx808VOEiEwo0nS6hilOGf7
         YdWMlIOqe6C6zvMTMwy1e2VDI995GHPs+uumdRnOLEY/HK7z3O5Vwr1uADnlArrtL16U
         raQ2YJkwhWQryj5lZ3Qy3zH6cCNfjN+BBpk7qqfahd8w207CrcUApYJs8W1H1zLUv/+0
         /MaoYE6RwsH8tdQ+oS4J78RUH/t8zCaqiXJJfpJPt1Tk1MzqOp0HQIR6HqNcW/PV23wk
         /xq9ugOboE12RH3HLMUx+DLp+lkpyHb7gAl+n5BeCElGue8odMuag/LWDD3Uwp4ebqZb
         Jqrw==
X-Gm-Message-State: AA+aEWb/guCZ1QfOKCtzImwCmb2b9XhTslXQTsQ+ads4QM4Dg8op90AV
        q6FQgqE0VrrLu3tiXQ9rvMA=
X-Google-Smtp-Source: AFSGD/UtxwILYXh+81PB2uzKDw5bUJiwMw5bY+0z0lr7QEzLLEZv4wPzkPF4IlnBeHnqZP/M5ulMJA==
X-Received: by 2002:a63:8441:: with SMTP id k62mr5495691pgd.392.1544864929302;
        Sat, 15 Dec 2018 01:08:49 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id g2sm9054375pfi.95.2018.12.15.01.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 01:08:48 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     tiny.windzz@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] Input: i8042 add i8042_is_mr_coffee() helper to avoid refconut leak
Date:   Sat, 15 Dec 2018 04:08:46 -0500
Message-Id: <20181215090846.28009-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node returned by
it and that reference needs to be dropped by its caller. Add
i8042_is_mr_coffee() helper to avoid refconut leak.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
changes in v5:
-fix typo

changes in v4:
-fix typo

changes in v3:
-add i8042_is_mr_coffee
---
 drivers/input/serio/i8042-sparcio.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index 796289846204..9e9e512bc432 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -106,11 +106,23 @@ static struct platform_driver sparc_i8042_driver = {
 	.remove		= sparc_i8042_remove,
 };
 
+static inline bool i8042_is_mr_coffee(void)
+{
+	struct device_node *root;
+	bool is_mr_coffee;
+
+	root = of_find_node_by_path("/");
+	is_mr_coffee = !strcmp(root->name, "SUNW,JavaStation-1");
+	of_node_put(root);
+
+	return is_mr_coffee;
+}
+
 static int __init i8042_platform_init(void)
 {
-	struct device_node *root = of_find_node_by_path("/");
+	bool match = i8042_is_mr_coffee();
 
-	if (!strcmp(root->name, "SUNW,JavaStation-1")) {
+	if (match) {
 		/* Hardcoded values for MrCoffee.  */
 		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
 		kbd_iobase = ioremap(0x71300060, 8);
@@ -138,9 +150,9 @@ static int __init i8042_platform_init(void)
 
 static inline void i8042_platform_exit(void)
 {
-	struct device_node *root = of_find_node_by_path("/");
+	bool match = i8042_is_mr_coffee();
 
-	if (strcmp(root->name, "SUNW,JavaStation-1"))
+	if (!match)
 		platform_driver_unregister(&sparc_i8042_driver);
 }
 
-- 
2.17.0

