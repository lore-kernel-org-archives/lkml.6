Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4F7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7496B20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ETvBshlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbfBTE6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:58:48 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35687 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730506AbfBTE6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 23:58:47 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so11245274pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 20:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4k7w8KA/m54X1mmrQAk65eiH/VFnsV46J3ND7vZF1hI=;
        b=ETvBshlxDPUM6xY7P4S+MVbogGVMkTtKJzKzT4IulQ1I6d9kWQat+tBwZjnyW3oWUU
         ATyVlxj/gA7EIigcu2fg+4nmB2E2/XKxPzNaOAXBaIvIIPXsr+gATF3gDXU+EaDuWZe5
         Qr5DN1JKc8QWLy/8cPX2eDjpPDONr5ggqfYNXY9I1FDy5VOo4GgzkpvuTHvz34tFm6l7
         SY3zVXTQ9IXuWKB5QaT4s4bannCSFuk+3G+KIxxWEIwwmZkL09wPd8cyqoBJuCYwG5Tb
         1hP4iaOzW8QSFQoeJyoUOzxBWXpfO4kjIAQ4AH1zhXlY0BprHaHQnL1brHkUIpkTmUUK
         icDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4k7w8KA/m54X1mmrQAk65eiH/VFnsV46J3ND7vZF1hI=;
        b=T1nvV8EKM2NtD/HRgSwPxE558K2lV6NwD4rvf9Q3xirlxI+LiikqP31eIxF3HkKZhb
         fPOskbnJ82U21MSySLAzCLkome5n2HXt9LjwRkqcZPqindBNMNtfj8g6FdPERHgM1ek1
         bweAr2JN9j7xIojucFNLTyNRNNAEzwVH3GNlbUd8eKnw8BYKj5csJtSoxekmA5hoitrv
         4DbRVNNU4PRE4X+xvGi/59YuB2Du7caR/xdOGO3jbnTRHTl8WPR38ETr7rRVP9Yv1gHQ
         Ti2I5lrbVWdi+idFeq7r7H/VHQ04VvdWlFziPqgefNnXJdUX4pRIoM4EGUTV4aamW6gY
         OJyQ==
X-Gm-Message-State: AHQUAuYUJqGscbVN3U2Pg3U71uNf5puOssgVJtsue8jfcIJFoQLIapRl
        thZaeL4RpXHj9ylp3S6T1hi33A==
X-Google-Smtp-Source: AHgI3IaRYtysrHREBmYtAyGUfjSjZqDIfPoR6sCfrMD5L2RYM+pNvpcZ4CizU0KgaFDL7nW9W83dPA==
X-Received: by 2002:a65:6684:: with SMTP id b4mr27564185pgw.55.1550638726357;
        Tue, 19 Feb 2019 20:58:46 -0800 (PST)
Received: from localhost.localdomain ([116.75.87.120])
        by smtp.gmail.com with ESMTPSA id e63sm16898756pfa.116.2019.02.19.20.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 20:58:45 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v2 4/5] soc: qcom: socinfo: Expose image information
Date:   Wed, 20 Feb 2019 10:28:39 +0530
Message-Id: <20190220045839.6902-1-vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The socinfo driver provides information about version of the various
images loaded in the system. Expose this to user space for debugging
purpose.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
---
Changes since v1:
	- None
---
 drivers/soc/qcom/socinfo.c | 210 +++++++++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 5f4bef216ae1..f6a931ca8953 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -31,6 +31,25 @@
 #define SMEM_HW_SW_BUILD_ID            137
 
 #ifdef CONFIG_DEBUG_FS
+#define SMEM_IMAGE_VERSION_BLOCKS_COUNT        32
+#define SMEM_IMAGE_VERSION_SIZE                4096
+#define SMEM_IMAGE_VERSION_NAME_SIZE           75
+#define SMEM_IMAGE_VERSION_VARIANT_SIZE        20
+#define SMEM_IMAGE_VERSION_OEM_SIZE            32
+
+/*
+ * SMEM Image table indices
+ */
+#define SMEM_IMAGE_TABLE_BOOT_INDEX     0
+#define SMEM_IMAGE_TABLE_TZ_INDEX       1
+#define SMEM_IMAGE_TABLE_RPM_INDEX      3
+#define SMEM_IMAGE_TABLE_APPS_INDEX     10
+#define SMEM_IMAGE_TABLE_MPSS_INDEX     11
+#define SMEM_IMAGE_TABLE_ADSP_INDEX     12
+#define SMEM_IMAGE_TABLE_CNSS_INDEX     13
+#define SMEM_IMAGE_TABLE_VIDEO_INDEX    14
+#define SMEM_IMAGE_VERSION_TABLE       469
+
 /* pmic model info */
 static const char *const pmic_model[] = {
 	[0]  = "Unknown PMIC model",
@@ -90,11 +109,21 @@ struct socinfo {
 	__le32 raw_device_num;
 };
 
+#ifdef CONFIG_DEBUG_FS
+struct smem_image_version {
+	char name[SMEM_IMAGE_VERSION_NAME_SIZE];
+	char variant[SMEM_IMAGE_VERSION_VARIANT_SIZE];
+	char pad;
+	char oem[SMEM_IMAGE_VERSION_OEM_SIZE];
+};
+#endif /* CONFIG_DEBUG_FS */
+
 struct qcom_socinfo {
 	struct soc_device *soc_dev;
 	struct soc_device_attribute attr;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dbg_root;
+	struct dentry *boot, *tz, *rpm, *apps, *mpss, *adsp, *cnss, *video;
 #endif /* CONFIG_DEBUG_FS */
 	struct socinfo *socinfo;
 };
@@ -298,8 +327,97 @@ QCOM_OPEN(pmic_model, qcom_show_pmic_model);
 QCOM_OPEN(platform_subtype, qcom_show_platform_subtype);
 QCOM_OPEN(pmic_die_revision, qcom_show_pmic_die_revision);
 
+#define IMAGE_SHOW_NAME(attr)						  \
+static int show_ ##attr## _name(struct seq_file *seq, void *p)		  \
+{									  \
+	struct smem_image_version *image_version = seq->private;	  \
+	seq_puts(seq, image_version->name);				  \
+	seq_puts(seq, "\n");						  \
+	return 0;							  \
+}									  \
+static int open_ ##attr## _name(struct inode *inode, struct file *file)	  \
+{									  \
+	return single_open(file, show_ ##attr## _name, inode->i_private); \
+}									  \
+									  \
+static const struct file_operations qcom_ ##attr## _name_ops = {	  \
+	.open = open_ ##attr## _name,					  \
+	.read = seq_read,						  \
+	.llseek = seq_lseek,						  \
+	.release = single_release,					  \
+}									  \
+
+#define DEBUGFS_IMAGE_NAME(fname, attr, index)				  \
+debugfs_create_file(__stringify(fname), 0400, qcom_socinfo->attr,	  \
+		    &smem_image_version[index], &qcom_ ##attr## _name_ops)
+
+#define IMAGE_SHOW_VARIANT(attr)					     \
+static int show_ ##attr## _variant(struct seq_file *seq, void *p)	     \
+{									     \
+	struct smem_image_version *image_version = seq->private;	     \
+	seq_puts(seq, image_version->variant);				     \
+	seq_puts(seq, "\n");						     \
+	return 0;							     \
+}									     \
+static int open_ ##attr## _variant(struct inode *inode, struct file *file)   \
+{                                                                            \
+	return single_open(file, show_ ##attr## _variant, inode->i_private); \
+}									     \
+									     \
+static const struct file_operations qcom_ ##attr## _variant_ops = {	     \
+	.open = open_ ##attr## _variant,				     \
+	.read = seq_read,						     \
+	.llseek = seq_lseek,						     \
+	.release = single_release,					     \
+}
+
+#define DEBUGFS_IMAGE_VARIANT(fname, attr, index)			    \
+debugfs_create_file(__stringify(fname), 0400, qcom_socinfo->attr,	    \
+		    &smem_image_version[index], &qcom_ ##attr## _variant_ops)
+
+#define IMAGE_SHOW_OEM(attr)						 \
+static int show_ ##attr## _oem(struct seq_file *seq, void *p)		 \
+{									 \
+	struct smem_image_version *image_version = seq->private;	 \
+	seq_puts(seq, image_version->oem);				 \
+	seq_puts(seq, "\n");						 \
+	return 0;							 \
+}									 \
+static int open_ ##attr## _oem(struct inode *inode, struct file *file)	 \
+{									 \
+	return single_open(file, show_ ##attr## _oem, inode->i_private); \
+}									 \
+									 \
+static const struct file_operations qcom_ ##attr## _oem_ops = {		 \
+	.open = open_ ##attr## _oem,					 \
+	.read = seq_read,						 \
+	.llseek = seq_lseek,						 \
+	.release = single_release,					 \
+}
+
+#define DEBUGFS_IMAGE_OEM(fname, attr, index)				 \
+debugfs_create_file(__stringify(fname), 0400, qcom_socinfo->attr,	 \
+		    &smem_image_version[index], &qcom_ ##attr## _oem_ops)
+
+#define IMAGE_SHOW(name)	  \
+	IMAGE_SHOW_NAME(name);    \
+	IMAGE_SHOW_VARIANT(name); \
+	IMAGE_SHOW_OEM(name)	  \
+
+IMAGE_SHOW(boot);
+IMAGE_SHOW(tz);
+IMAGE_SHOW(rpm);
+IMAGE_SHOW(apps);
+IMAGE_SHOW(mpss);
+IMAGE_SHOW(adsp);
+IMAGE_SHOW(cnss);
+IMAGE_SHOW(video);
+
 static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo)
 {
+	struct smem_image_version *smem_image_version;
+	size_t size;
+
 	qcom_socinfo->dbg_root = debugfs_create_dir("qcom_socinfo", NULL);
 
 	DEBUGFS_UINT_ADD(raw_version);
@@ -314,6 +432,98 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo)
 	DEBUGFS_ADD(pmic_model);
 	DEBUGFS_ADD(platform_subtype);
 	DEBUGFS_ADD(pmic_die_revision);
+
+	smem_image_version = qcom_smem_get(QCOM_SMEM_HOST_ANY,
+					   SMEM_IMAGE_VERSION_TABLE,
+					   &size);
+
+	qcom_socinfo->boot = debugfs_create_dir("boot",
+						qcom_socinfo->dbg_root);
+	if (!qcom_socinfo->boot) {
+		pr_err("Cannot create boot image directory\n");
+		return;
+	}
+
+	DEBUGFS_IMAGE_NAME(name, boot, SMEM_IMAGE_TABLE_BOOT_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, boot, SMEM_IMAGE_TABLE_BOOT_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, boot, SMEM_IMAGE_TABLE_BOOT_INDEX);
+
+	qcom_socinfo->tz = debugfs_create_dir("tz",
+					      qcom_socinfo->dbg_root);
+	if (!qcom_socinfo->tz) {
+		pr_err("Cannot create tz image directory\n");
+		return;
+	}
+
+	DEBUGFS_IMAGE_NAME(name, tz, SMEM_IMAGE_TABLE_TZ_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, tz, SMEM_IMAGE_TABLE_TZ_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, tz, SMEM_IMAGE_TABLE_TZ_INDEX);
+
+	qcom_socinfo->rpm = debugfs_create_dir("rpm",
+					       qcom_socinfo->dbg_root);
+	if (!qcom_socinfo->rpm) {
+		pr_err("Cannot create rpm image directory\n");
+		return;
+	}
+
+	DEBUGFS_IMAGE_NAME(name, rpm, SMEM_IMAGE_TABLE_RPM_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, rpm, SMEM_IMAGE_TABLE_RPM_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, rpm, SMEM_IMAGE_TABLE_RPM_INDEX);
+
+	qcom_socinfo->apps = debugfs_create_dir("apps",
+						qcom_socinfo->dbg_root);
+	if (!qcom_socinfo->apps) {
+		pr_err("Cannot create apps image directory\n");
+		return;
+	}
+
+	DEBUGFS_IMAGE_NAME(name, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
+
+	qcom_socinfo->mpss = debugfs_create_dir("mpss",
+						qcom_socinfo->dbg_root);
+	if (!qcom_socinfo->mpss) {
+		pr_err("Cannot create mpss image directory\n");
+		return;
+	}
+
+	DEBUGFS_IMAGE_NAME(name, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
+
+	qcom_socinfo->adsp = debugfs_create_dir("adsp",
+						qcom_socinfo->dbg_root);
+	if (!qcom_socinfo->adsp) {
+		pr_err("Cannot create adsp image directory\n");
+		return;
+	}
+
+	DEBUGFS_IMAGE_NAME(name, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
+
+	qcom_socinfo->cnss = debugfs_create_dir("cnss",
+						qcom_socinfo->dbg_root);
+	if (!qcom_socinfo->cnss) {
+		pr_err("Cannot create cnss image directory\n");
+		return;
+	}
+
+	DEBUGFS_IMAGE_NAME(name, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
+
+	qcom_socinfo->video = debugfs_create_dir("video",
+						 qcom_socinfo->dbg_root);
+	if (!qcom_socinfo->video) {
+		pr_err("Cannot create video image directory\n");
+		return;
+	}
+
+	DEBUGFS_IMAGE_NAME(name, video, SMEM_IMAGE_TABLE_VIDEO_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, video, SMEM_IMAGE_TABLE_VIDEO_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, video, SMEM_IMAGE_TABLE_VIDEO_INDEX);
 }
 
 static void socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo)
-- 
2.17.1

