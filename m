Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA8DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A792B222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMK4Kcn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395408AbfBNDmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:42:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44537 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395383AbfBNDmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:42:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so2326245pfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 19:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a2V1jnvFMgLl6Lz0njStHM5JTJuI4W2yZndCgLSfHUE=;
        b=fMK4Kcn/qHfGkrG8QXl4FzsuMVKShlnPABuApQXOfdESFDx9bWllRRGOiBJowuOOp6
         8Bx4+oWS2Odho8l7Uy0iLjom+OG3tN+TeO4jMY+Fk0OQmlLCYGRrMW3da/I0DtVjKh1W
         lYcYb5j3sFIn5KyR38mYue20Olt/l8L5eDd4dYueUw0nrK8OpZazfai4whUefiO/vxMr
         LzD4BULzQnyld4sbtzecgIL/3vpHBhofVtSIRsk/5alYK3e845ApJ+PPKXUazmko3sXW
         22N3EMZmvoBvpWSTJUQEG4H6CHsYGzSo1CdxoBQrrR5GIA4t42OHVVb0FS34FMcRGYD8
         Si2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a2V1jnvFMgLl6Lz0njStHM5JTJuI4W2yZndCgLSfHUE=;
        b=W1m8jwcbDn6//WpQDCehJg8yycBCtGZBY2V7I4ORVu+TSsG+gAwpiS/XJUxygRs7pD
         N0hdaarUFwE7aIcMXzyCfdQibuWkQLo4b6yKKslmZBfGZceOqOTanYOqFZ4LnIXLcz/l
         dE14ro+HQHib/WayZonp7CcivF58iwwMKz6ELXu48SPcflEHN/R9bp0VHqzaqWVbL92H
         +TgeYIGKWWNAicsa7xrySLrU8BE5J5kO8e5RPVc/X/wq696rshh/RxEIdZqKHxvSpB2h
         dGq72tTaa/33mNWtvh0yc0pXdhorBwTbLiY5Tv2+zfmw8pkZ1sDH2WoW3eMUYu+E7+BF
         /jbw==
X-Gm-Message-State: AHQUAuaC1v/Bhl5hOX89aGs7arvTKaKagcV6tjb7d/8OrZhC6qwkzBHs
        q2ez1+C2c3zYFnbrghYMSyNUuw==
X-Google-Smtp-Source: AHgI3IYbY4k2R6sHKO9Hr5ATak4bE5XHG70iyP93oYYERYjmHGV9ROi8nkljf5pQTBDXBW6CcoODGQ==
X-Received: by 2002:a63:d84b:: with SMTP id k11mr1720024pgj.142.1550115720382;
        Wed, 13 Feb 2019 19:42:00 -0800 (PST)
Received: from localhost.localdomain ([103.240.171.178])
        by smtp.gmail.com with ESMTPSA id k129sm928179pgk.29.2019.02.13.19.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 19:41:59 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH 3/5] soc: qcom: socinfo: Expose custom attributes
Date:   Thu, 14 Feb 2019 09:11:49 +0530
Message-Id: <297ee5e7840077f0330d4ae02dcd13c2ad97f910.1550114271.git.vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550114271.git.vaishali.thakkar@linaro.org>
References: <cover.1550114271.git.vaishali.thakkar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm socinfo provides a number of additional attributes,
add these to the socinfo driver and expose them via debugfs
functionality.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
---
Note that this may have some 80 char checkpatch warnings as
fixing them makes code less readable.
---
 drivers/soc/qcom/socinfo.c | 203 +++++++++++++++++++++++++++++++++++++
 1 file changed, 203 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 02078049fac7..58665067beb8 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2017-2019, Linaro Ltd.
  */
 
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -29,6 +30,28 @@
  */
 #define SMEM_HW_SW_BUILD_ID            137
 
+#ifdef CONFIG_DEBUG_FS
+/* pmic model info */
+static const char *const pmic_model[] = {
+	[0]  = "Unknown PMIC model",
+	[9]  = "PM8994",
+	[11] = "PM8916",
+	[13] = "PM8058",
+	[14] = "PM8028",
+	[15] = "PM8901",
+	[16] = "PM8027",
+	[17] = "ISL9519",
+	[18] = "PM8921",
+	[19] = "PM8018",
+	[20] = "PM8015",
+	[21] = "PM8014",
+	[22] = "PM8821",
+	[23] = "PM8038",
+	[24] = "PM8922",
+	[25] = "PM8917",
+};
+#endif /* CONFIG_DEBUG_FS */
+
 /* Socinfo SMEM item structure */
 struct socinfo {
 	__le32 fmt;
@@ -70,6 +93,10 @@ struct socinfo {
 struct qcom_socinfo {
 	struct soc_device *soc_dev;
 	struct soc_device_attribute attr;
+	#ifdef CONFIG_DEBUG_FS
+	struct dentry *dbg_root;
+	#endif /* CONFIG_DEBUG_FS */
+	struct socinfo *socinfo;
 };
 
 struct soc_of_id {
@@ -133,6 +160,176 @@ static const char *socinfo_machine(struct device *dev, unsigned int id)
 	return NULL;
 }
 
+#ifdef CONFIG_DEBUG_FS
+
+#define UINT_SHOW(name, attr)						\
+static int qcom_show_##name(struct seq_file *seq, void *p)		\
+{									\
+	struct socinfo *socinfo = seq->private;				\
+	seq_printf(seq, "%u\n", le32_to_cpu(socinfo->attr));		\
+	return 0;							\
+}									\
+static int qcom_open_##name(struct inode *inode, struct file *file)	\
+{									\
+	return single_open(file, qcom_show_##name, inode->i_private);	\
+}									\
+									\
+static const struct file_operations qcom_ ##name## _ops = {		\
+	.open = qcom_open_##name,					\
+	.read = seq_read,						\
+	.llseek = seq_lseek,						\
+	.release = single_release,					\
+}
+
+#define DEBUGFS_UINT_ADD(name)						\
+	debugfs_create_file(__stringify(name), 0400,			\
+			    qcom_socinfo->dbg_root,			\
+			    qcom_socinfo->socinfo, &qcom_ ##name## _ops)
+
+#define HEX_SHOW(name, attr)						\
+static int qcom_show_##name(struct seq_file *seq, void *p)		\
+{									\
+	struct socinfo *socinfo = seq->private;				\
+	seq_printf(seq, "0x%x\n", le32_to_cpu(socinfo->attr));		\
+	return 0;							\
+}									\
+static int qcom_open_##name(struct inode *inode, struct file *file)	\
+{									\
+	return single_open(file, qcom_show_##name, inode->i_private);	\
+}									\
+									\
+static const struct file_operations qcom_ ##name## _ops = {		\
+	.open = qcom_open_##name,					\
+	.read = seq_read,						\
+	.llseek = seq_lseek,						\
+	.release = single_release,					\
+}
+
+#define DEBUGFS_HEX_ADD(name)						\
+	debugfs_create_file(__stringify(name), 0400,			\
+			    qcom_socinfo->dbg_root,			\
+			    qcom_socinfo->socinfo, &qcom_ ##name## _ops)
+
+
+#define QCOM_OPEN(name, _func)						\
+static int qcom_open_##name(struct inode *inode, struct file *file)	\
+{									\
+	return single_open(file, _func, inode->i_private);		\
+}									\
+									\
+static const struct file_operations qcom_ ##name## _ops = {		\
+	.open = qcom_open_##name,					\
+	.read = seq_read,						\
+	.llseek = seq_lseek,						\
+	.release = single_release,					\
+}
+
+#define DEBUGFS_ADD(name)						\
+	debugfs_create_file(__stringify(name), 0400,			\
+			    qcom_socinfo->dbg_root,			\
+			    qcom_socinfo->socinfo, &qcom_ ##name## _ops)
+
+
+static int qcom_show_build_id(struct seq_file *seq, void *p)
+{
+	struct socinfo *socinfo = seq->private;
+
+	seq_printf(seq, "%s\n", socinfo->build_id);
+
+	return 0;
+}
+
+static int qcom_show_accessory_chip(struct seq_file *seq, void *p)
+{
+	struct socinfo *socinfo = seq->private;
+
+	seq_printf(seq, "%d\n", le32_to_cpu(socinfo->accessory_chip));
+
+	return 0;
+}
+
+static int qcom_show_platform_subtype(struct seq_file *seq, void *p)
+{
+	struct socinfo *socinfo = seq->private;
+	int subtype = le32_to_cpu(socinfo->hw_plat_subtype);
+
+	if (subtype < 0)
+		return -EINVAL;
+
+	seq_printf(seq, "%u\n", subtype);
+
+	return 0;
+}
+
+static int qcom_show_pmic_model(struct seq_file *seq, void *p)
+{
+	struct socinfo *socinfo = seq->private;
+	int model = SOCINFO_MINOR(le32_to_cpu(socinfo->pmic_model));
+
+	if (model < 0)
+		return -EINVAL;
+
+	seq_printf(seq, "%s\n", pmic_model[model]);
+
+	return 0;
+}
+
+static int qcom_show_pmic_die_revision(struct seq_file *seq, void *p)
+{
+	struct socinfo *socinfo = seq->private;
+
+	seq_printf(seq, "%u.%u\n",
+		   SOCINFO_MAJOR(le32_to_cpu(socinfo->pmic_die_rev)),
+		   SOCINFO_MINOR(le32_to_cpu(socinfo->pmic_die_rev)));
+
+	return 0;
+}
+
+UINT_SHOW(raw_version, raw_ver);
+UINT_SHOW(hardware_platform, hw_plat);
+UINT_SHOW(platform_version, plat_ver);
+UINT_SHOW(foundry_id, foundry_id);
+HEX_SHOW(chip_family, chip_family);
+HEX_SHOW(raw_device_family, raw_device_family);
+HEX_SHOW(raw_device_number, raw_device_num);
+QCOM_OPEN(build_id, qcom_show_build_id);
+QCOM_OPEN(accessory_chip, qcom_show_accessory_chip);
+QCOM_OPEN(pmic_model, qcom_show_pmic_model);
+QCOM_OPEN(platform_subtype, qcom_show_platform_subtype);
+QCOM_OPEN(pmic_die_revision, qcom_show_pmic_die_revision);
+
+static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo)
+{
+	qcom_socinfo->dbg_root = debugfs_create_dir("qcom_socinfo", NULL);
+
+	if (!qcom_socinfo->dbg_root) {
+		pr_err("Cannot create debugfs directory\n");
+		return;
+	}
+
+	DEBUGFS_UINT_ADD(raw_version);
+	DEBUGFS_UINT_ADD(hardware_platform);
+	DEBUGFS_UINT_ADD(platform_version);
+	DEBUGFS_UINT_ADD(foundry_id);
+	DEBUGFS_HEX_ADD(chip_family);
+	DEBUGFS_HEX_ADD(raw_device_family);
+	DEBUGFS_HEX_ADD(raw_device_number);
+	DEBUGFS_ADD(build_id);
+	DEBUGFS_ADD(accessory_chip);
+	DEBUGFS_ADD(pmic_model);
+	DEBUGFS_ADD(platform_subtype);
+	DEBUGFS_ADD(pmic_die_revision);
+}
+
+static void socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo)
+{
+	debugfs_remove_recursive(qcom_socinfo->dbg_root);
+}
+#else
+socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo) { return 0; }
+socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo) { return 0; }
+#endif /* CONFIG_DEBUG_FS */
+
 static int qcom_socinfo_probe(struct platform_device *pdev)
 {
 	struct qcom_socinfo *qs;
@@ -165,6 +362,10 @@ static int qcom_socinfo_probe(struct platform_device *pdev)
 	if (IS_ERR(qs->soc_dev))
 		return PTR_ERR(qs->soc_dev);
 
+	qs->socinfo = info;
+
+	socinfo_debugfs_init(qs);
+
 	/* Feed the soc specific unique data into entropy pool */
 	add_device_randomness(info, item_size);
 
@@ -179,6 +380,8 @@ static int qcom_socinfo_remove(struct platform_device *pdev)
 
 	soc_device_unregister(qs->soc_dev);
 
+	socinfo_debugfs_exit(qs);
+
 	return 0;
 }
 
-- 
2.17.1

