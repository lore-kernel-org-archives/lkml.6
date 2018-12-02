Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A149C04EB9
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 02:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B19F2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 02:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGJaLXGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B19F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725750AbeLBNbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 08:31:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42780 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725727AbeLBNbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 08:31:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id x21-v6so4679395pln.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 18:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=74FtgDJCxbK06huEL3MZAZ7K0y7aPnoVSsRLCnp83Ec=;
        b=EGJaLXGG7Jll2uq2jTGzWkE8djO+6X7yw0TdMuT2i8V6sQ887ptkAWGY6FRKCDqecC
         JrjiVRsswyItHgLPbliKP7UA7Ug2y0E9jxa321BATtAX8yRKkA4NDBpqa/UMip3OKwKa
         dIiN9x3QrhUFeLK+IDP8ZiUM7+5XutMVpuzxF5mCN8fu1FGGVJ2IQazGP4Qe3V2fJ3HD
         hsgcvGUm5dTUcYfMJD952Bi+484Qyko78a/AigsmaSkLtHvlV+6lpCbD3fQMmVLKHuXa
         bmU6CZ55Lf1Q6bqRFFlr2bThs8HFCbN4+IBoQJ+lnZzk4Nz1wsIhLLtLL8ts9mvDtmPy
         hKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=74FtgDJCxbK06huEL3MZAZ7K0y7aPnoVSsRLCnp83Ec=;
        b=YKOuXnP8ro0qN8Sd0J19Uj+IzMmUNx9MUH9oRy7Nbj+o3RfEnj6ocvtldBFWVtyG3o
         eqLAocXBUpbRRmhRj11oEDtgs+Eh7AdIYam4DPuHp5uruf9gUx7xZF65XwxCjlL3uPIa
         BvfJdo+W2K+FtTGd0HXugqNE6NKhPArkreY9n6ay0xtN24IV8hS3Sv2DFVvNG0RyJWBg
         PPlcVMUHkpsIsiJ73ltnCrnLd3QrMr9LrWCPPZ9uy0OcTDMZpcbug6p5NBTNF2141nY8
         Bx7FNAUyqamW7b6pfNSFxIwJrIak+RNeApw3pCehQiyTVrKT5Vq8oYcGUe2c6ESIPtKU
         D+TA==
X-Gm-Message-State: AA+aEWa3zCjrU+YhgRTwfneIX/PtuZlPoMveFzzN4q1grqn9eT1Om9a5
        1oI6BKvVllFco+Q52Yafl6s=
X-Google-Smtp-Source: AFSGD/U60wrNZPIKrxzonQI8BBmQ39wcKYN3FCZcRYCL3ZtVt4qTXvQH/dx/frJ5rSnvDqcRt4qcRg==
X-Received: by 2002:a17:902:704b:: with SMTP id h11mr11177183plt.157.1543717032500;
        Sat, 01 Dec 2018 18:17:12 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v76sm24947293pfj.145.2018.12.01.18.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 18:17:11 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     linus.walleij@linaro.org, lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] mfd: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat,  1 Dec 2018 21:17:10 -0500
Message-Id: <20181202021710.9307-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/mfd/ab3100-core.c | 15 ++-------------
 drivers/mfd/ab3100-otp.c  | 16 +++-------------
 drivers/mfd/tps65010.c    | 14 ++------------
 3 files changed, 7 insertions(+), 38 deletions(-)

diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index 099635bed188..3fe448a29389 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -451,7 +451,7 @@ static irqreturn_t ab3100_irq_handler(int irq, void *data)
 /*
  * Some debugfs entries only exposed if we're using debug
  */
-static int ab3100_registers_print(struct seq_file *s, void *p)
+static int ab3100_registers_show(struct seq_file *s, void *p)
 {
 	struct ab3100 *ab3100 = s->private;
 	u8 value;
@@ -466,18 +466,7 @@ static int ab3100_registers_print(struct seq_file *s, void *p)
 	return 0;
 }
 
-static int ab3100_registers_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ab3100_registers_print, inode->i_private);
-}
-
-static const struct file_operations ab3100_registers_fops = {
-	.open = ab3100_registers_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(ab3100_registers);
 
 struct ab3100_get_set_reg_priv {
 	struct ab3100 *ab3100;
diff --git a/drivers/mfd/ab3100-otp.c b/drivers/mfd/ab3100-otp.c
index 55b207a4b336..24873e1ae865 100644
--- a/drivers/mfd/ab3100-otp.c
+++ b/drivers/mfd/ab3100-otp.c
@@ -96,7 +96,7 @@ static int __init ab3100_otp_read(struct ab3100_otp *otp)
  * the contents of the OTP.
  */
 #ifdef CONFIG_DEBUG_FS
-static int ab3100_show_otp(struct seq_file *s, void *v)
+static int ab3100_otp_show(struct seq_file *s, void *v)
 {
 	struct ab3100_otp *otp = s->private;
 
@@ -110,24 +110,14 @@ static int ab3100_show_otp(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int ab3100_otp_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ab3100_show_otp, inode->i_private);
-}
-
-static const struct file_operations ab3100_otp_operations = {
-	.open		= ab3100_otp_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ab3100_otp);
 
 static int __init ab3100_otp_init_debugfs(struct device *dev,
 					  struct ab3100_otp *otp)
 {
 	otp->debugfs = debugfs_create_file("ab3100_otp", S_IFREG | S_IRUGO,
 					   NULL, otp,
-					   &ab3100_otp_operations);
+					   &ab3100_otp_fops);
 	if (!otp->debugfs) {
 		dev_err(dev, "AB3100 debugfs OTP file registration failed!\n");
 		return -ENOENT;
diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index 2ab67386b4ef..4202b5c40f18 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -192,7 +192,7 @@ static inline void show_chgconfig(int por, const char *label, u8 chgconfig) { }
 
 #ifdef	CONFIG_DEBUG_FS
 
-static int dbg_show(struct seq_file *s, void *_)
+static int debug_show(struct seq_file *s, void *_)
 {
 	struct tps65010	*tps = s->private;
 	u8		value, v2;
@@ -296,17 +296,7 @@ static int dbg_show(struct seq_file *s, void *_)
 	return 0;
 }
 
-static int dbg_tps_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, dbg_show, inode->i_private);
-}
-
-static const struct file_operations debug_fops = {
-	.open		= dbg_tps_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(debug);
 
 #define	DEBUG_FOPS	&debug_fops
 
-- 
2.17.0

