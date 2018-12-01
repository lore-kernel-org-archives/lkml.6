Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B3EC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3E32082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmPaAnU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3E32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeLANpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 08:45:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32815 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLANpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 08:45:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so3296325pgu.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 18:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kCKnsU0CZhWrYsQyelUnCcrXZV30pwlu3QOQPKBMRIo=;
        b=JmPaAnU8e+pSrfRl0/t5XBZPk244HTbZcrge/5sZ6OGufxOjgAGNPrZSGzyhrDIPnQ
         iY2JWBeAcMoDPTe1CSM3A7r7ptehdp2peOE5pqyV5Q7ZmewUSY1Yn6+WnQGBzA/EKaLc
         PGC5bNzlvoGSEuNLOQI8rWs+scUPKGAZTcuYMSqKSMxCOpMn0ofjANiGm+IxmMBCx4Mx
         PIQn1X43UUdgegKmnpWdP339Xaaugnv8I9zZG5QHFCio+JG6kOujt+eXAJMgmw0P63ma
         kHC5wqkJ9YoDIXfcwia2/RJIfIQOqplBJttSgdYtTRAYUjQcnglc2eJtjpJ7a+NL3FNP
         0Tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kCKnsU0CZhWrYsQyelUnCcrXZV30pwlu3QOQPKBMRIo=;
        b=hRgUgNd+5dyPF9ztESr6yt9tpVezkIgNfK9QKzNRIw8H/IBJyrQxaEAvtxou6HF5ZR
         jLXsE8bPSy5gjqP/JkNwgmJ2SlxoGNh8tdat7ltDlrySB6QBSLUdaVwo5Up1Gnd0i7DT
         NNyhRlyW+Ab/WvnKTWkeZ6xr4qtU1A3kq/0jAF6yHpR56WNmFFnAj3VgZoaXoGo3yFd7
         scsMYZFbX+eUFq+qMR+E3b21pboNG9a8cHP5cycZGi7grpeEefyWVOk6nnNOniklTPcP
         5dmez9Z3LaGgmkuwYOMsEa25fF+omU4cuh2VddL3Vmex7jYBFcYXjkVsEawTD3WBwmRP
         7t2g==
X-Gm-Message-State: AA+aEWaQTz3y3rrSEyh9JWxk+/v1DslSeeGSWSdKgW9TeeFIHvvPDlU/
        v/GIenSgGE8STY6KNbP0nHWs1UAKE0U=
X-Google-Smtp-Source: AFSGD/VAqHvKOSn7C8gtspd9TmWsJX71/CXgSrPZsNazDHK3K/YDKRts0Bz1oIUwzcA/Xj4VEYH9Yw==
X-Received: by 2002:a63:5026:: with SMTP id e38mr6769086pgb.123.1543631638103;
        Fri, 30 Nov 2018 18:33:58 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id p2sm8453736pfb.28.2018.11.30.18.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 18:33:57 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     sre@kernel.org, gregkh@linuxfoundation.org, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] HSI: omap_ssi: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Fri, 30 Nov 2018 21:33:55 -0500
Message-Id: <20181201023355.5280-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/hsi/controllers/omap_ssi_core.c | 29 ++++---------------------
 drivers/hsi/controllers/omap_ssi_port.c | 14 ++----------
 2 files changed, 6 insertions(+), 37 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 41a09f506803..a2a35319f7a5 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -48,7 +48,7 @@
 static DEFINE_IDA(platform_omap_ssi_ida);
 
 #ifdef CONFIG_DEBUG_FS
-static int ssi_debug_show(struct seq_file *m, void *p __maybe_unused)
+static int ssi_regs_show(struct seq_file *m, void *p __maybe_unused)
 {
 	struct hsi_controller *ssi = m->private;
 	struct omap_ssi_controller *omap_ssi = hsi_controller_drvdata(ssi);
@@ -63,7 +63,7 @@ static int ssi_debug_show(struct seq_file *m, void *p __maybe_unused)
 	return 0;
 }
 
-static int ssi_debug_gdd_show(struct seq_file *m, void *p __maybe_unused)
+static int ssi_gdd_regs_show(struct seq_file *m, void *p __maybe_unused)
 {
 	struct hsi_controller *ssi = m->private;
 	struct omap_ssi_controller *omap_ssi = hsi_controller_drvdata(ssi);
@@ -117,29 +117,8 @@ static int ssi_debug_gdd_show(struct seq_file *m, void *p __maybe_unused)
 	return 0;
 }
 
-static int ssi_regs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ssi_debug_show, inode->i_private);
-}
-
-static int ssi_gdd_regs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ssi_debug_gdd_show, inode->i_private);
-}
-
-static const struct file_operations ssi_regs_fops = {
-	.open		= ssi_regs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations ssi_gdd_regs_fops = {
-	.open		= ssi_gdd_regs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ssi_regs);
+DEFINE_SHOW_ATTRIBUTE(ssi_gdd_regs);
 
 static int ssi_debug_add_ctrl(struct hsi_controller *ssi)
 {
diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index 2ada82d2ec8c..b2b3989ccfd2 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -57,7 +57,7 @@ static void ssi_debug_remove_port(struct hsi_port *port)
 	debugfs_remove_recursive(omap_port->dir);
 }
 
-static int ssi_debug_port_show(struct seq_file *m, void *p __maybe_unused)
+static int ssi_port_regs_show(struct seq_file *m, void *p __maybe_unused)
 {
 	struct hsi_port *port = m->private;
 	struct omap_ssi_port *omap_port = hsi_port_drvdata(port);
@@ -132,17 +132,7 @@ static int ssi_debug_port_show(struct seq_file *m, void *p __maybe_unused)
 	return 0;
 }
 
-static int ssi_port_regs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ssi_debug_port_show, inode->i_private);
-}
-
-static const struct file_operations ssi_port_regs_fops = {
-	.open		= ssi_port_regs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ssi_port_regs);
 
 static int ssi_div_get(void *data, u64 *val)
 {
-- 
2.17.0

