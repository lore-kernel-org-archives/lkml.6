Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2E7C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16B02146F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvuibO9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16B02146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeLBChr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:37:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46919 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeLBChq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:37:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so4244857pfe.13;
        Sat, 01 Dec 2018 07:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EagGsPYdCLnMlqKHPTjHkSD04BBZGNDeFtpRHybwRDM=;
        b=OvuibO9vC9CWgQIhtMy1sH2MzeBAh+KCkK5bIoZdaRaCDUJRWV+zUS1jdHCMF6wLuv
         KosuG3f1Rm65kf+FgTNJp45DqEh5WewqJVJU2HHVg0VsWfvYF6XJW6t470bowaHlKsO9
         KgEnof/IloqxuX8LzxKuJu4DNSlab7QqduHGjDksqnqUT8Lr/jj0ADeMxaHW9KhuQwju
         YfY6A6h/i6DJQaK1TWxxGB2owpDOFvdbLoKxV2B+oH0d2VcdSlAWdPrSpnnPD0JtWsKN
         1eUkvG+6ZK9wM7Z2WEJfn+xjSPTnxWzhZOYQ/2NhTj7fC/jFjH2J3koMCsQu6zJstQbj
         k/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EagGsPYdCLnMlqKHPTjHkSD04BBZGNDeFtpRHybwRDM=;
        b=MmBoBdLdNtEFIIXBuUUu6h3Foc8A9asQC29Ie6m5dvtm8jtD0wKQmxT+6qMonQHPKY
         Ykwthuo/uofeTXKOQvhxGamzCn/DFoxAu8h0WnMAjIkS9h8SPUPam3iOuPgcvBts1pHW
         vCD47ubbmDZvlvkTEC0jAeJif3KlHNZhxfOKyfOl+wK0k2TMfaijognL7H+G1YbDGFC3
         iqP8O6cfj5dOXuOPUBtlvzKUepn9LBYxLXVzxENJkLSgnF0R98ZdJTArGFNGviUf61fG
         CVTOC3qJT6Uj0IRmuzL8dckfgWNLmZJrMm75bcEZgKP5tVJXp4WdQRSTLjyWZs5S/qyP
         eIfA==
X-Gm-Message-State: AA+aEWY57BztZo15/DfDqZWf0F0JeJZ8MotQpzq1UKCnUbaDAbb804S1
        HWoXmNjR3VAluMHQabJTim8=
X-Google-Smtp-Source: AFSGD/UcsgPpvG8ONAD/nmtKrVtMh+Nd+V4jvdDj+Gyvy7dhK6ypz29LLb64DyKkspCKiPqPcMJb5A==
X-Received: by 2002:a65:50c1:: with SMTP id s1mr7958328pgp.350.1543677900937;
        Sat, 01 Dec 2018 07:25:00 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id c23sm12092777pfi.83.2018.12.01.07.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 07:25:00 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ulf.hansson@linaro.org, ludovic.desroches@microchip.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ben-linux@fluff.org, adrian.hunter@intel.com,
        linus.walleij@linaro.org, arnd@arndb.de, tony@atomide.com,
        andreas@kemnade.info, kishon@ti.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] mmc: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat,  1 Dec 2018 10:24:57 -0500
Message-Id: <20181201152457.8252-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/mmc/core/mmc_test.c   | 14 ++------------
 drivers/mmc/host/atmel-mci.c  | 31 +++++--------------------------
 drivers/mmc/host/omap_hsmmc.c | 14 ++------------
 drivers/mmc/host/s3cmci.c     | 30 ++++--------------------------
 4 files changed, 13 insertions(+), 76 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index ef18daeaa4cc..eabb1cab1765 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -3145,17 +3145,7 @@ static int mtf_testlist_show(struct seq_file *sf, void *data)
 	return 0;
 }
 
-static int mtf_testlist_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mtf_testlist_show, inode->i_private);
-}
-
-static const struct file_operations mmc_test_fops_testlist = {
-	.open		= mtf_testlist_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mtf_testlist);
 
 static void mmc_test_free_dbgfs_file(struct mmc_card *card)
 {
@@ -3216,7 +3206,7 @@ static int mmc_test_register_dbgfs_file(struct mmc_card *card)
 		goto err;
 
 	ret = __mmc_test_register_dbgfs_file(card, "testlist", S_IRUGO,
-		&mmc_test_fops_testlist);
+		&mtf_testlist_fops);
 	if (ret)
 		goto err;
 
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index be53044086c7..7469a7e369c0 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -446,18 +446,7 @@ static int atmci_req_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int atmci_req_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, atmci_req_show, inode->i_private);
-}
-
-static const struct file_operations atmci_req_fops = {
-	.owner		= THIS_MODULE,
-	.open		= atmci_req_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(atmci_req);
 
 static void atmci_show_status_reg(struct seq_file *s,
 		const char *regname, u32 value)
@@ -583,18 +572,7 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 	return ret;
 }
 
-static int atmci_regs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, atmci_regs_show, inode->i_private);
-}
-
-static const struct file_operations atmci_regs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= atmci_regs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(atmci_regs);
 
 static void atmci_init_debugfs(struct atmel_mci_slot *slot)
 {
@@ -608,13 +586,14 @@ static void atmci_init_debugfs(struct atmel_mci_slot *slot)
 		return;
 
 	node = debugfs_create_file("regs", S_IRUSR, root, host,
-			&atmci_regs_fops);
+				   &atmci_regs_fops);
 	if (IS_ERR(node))
 		return;
 	if (!node)
 		goto err;
 
-	node = debugfs_create_file("req", S_IRUSR, root, slot, &atmci_req_fops);
+	node = debugfs_create_file("req", S_IRUSR, root, slot,
+				   &atmci_req_fops);
 	if (!node)
 		goto err;
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 467d889a1638..6094e9e687b1 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1652,7 +1652,7 @@ static struct mmc_host_ops omap_hsmmc_ops = {
 
 #ifdef CONFIG_DEBUG_FS
 
-static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
+static int mmc_regs_show(struct seq_file *s, void *data)
 {
 	struct mmc_host *mmc = s->private;
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
@@ -1691,17 +1691,7 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int omap_hsmmc_regs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, omap_hsmmc_regs_show, inode->i_private);
-}
-
-static const struct file_operations mmc_regs_fops = {
-	.open           = omap_hsmmc_regs_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(mmc_regs);
 
 static void omap_hsmmc_debugfs(struct mmc_host *mmc)
 {
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index f77493604312..51069a43d609 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1406,18 +1406,7 @@ static int s3cmci_state_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int s3cmci_state_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, s3cmci_state_show, inode->i_private);
-}
-
-static const struct file_operations s3cmci_fops_state = {
-	.owner		= THIS_MODULE,
-	.open		= s3cmci_state_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(s3cmci_state);
 
 #define DBG_REG(_r) { .addr = S3C2410_SDI##_r, .name = #_r }
 
@@ -1459,18 +1448,7 @@ static int s3cmci_regs_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-static int s3cmci_regs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, s3cmci_regs_show, inode->i_private);
-}
-
-static const struct file_operations s3cmci_fops_regs = {
-	.owner		= THIS_MODULE,
-	.open		= s3cmci_regs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(s3cmci_regs);
 
 static void s3cmci_debugfs_attach(struct s3cmci_host *host)
 {
@@ -1484,14 +1462,14 @@ static void s3cmci_debugfs_attach(struct s3cmci_host *host)
 
 	host->debug_state = debugfs_create_file("state", 0444,
 						host->debug_root, host,
-						&s3cmci_fops_state);
+						&s3cmci_state_fops);
 
 	if (IS_ERR(host->debug_state))
 		dev_err(dev, "failed to create debug state file\n");
 
 	host->debug_regs = debugfs_create_file("regs", 0444,
 					       host->debug_root, host,
-					       &s3cmci_fops_regs);
+					       &s3cmci_regs_fops);
 
 	if (IS_ERR(host->debug_regs))
 		dev_err(dev, "failed to create debug regs file\n");
-- 
2.17.0

