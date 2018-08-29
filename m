Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522D0C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 04:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94A72086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 04:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Rx/x4//I";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qhtw6oOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94A72086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeH2IbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 04:31:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36574 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeH2IbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 04:31:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 54C1360452; Wed, 29 Aug 2018 04:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535517385;
        bh=oROkZsOkUbH81MViJ+tdX/WAcC4RorrJyY8wfZhjxUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rx/x4//IEN3KOJe+YtS+rNzSPoj/e5YNkRriPtEhthKxcLn5LLcFd/QKeqVbcUIye
         NjQS/J8pbuSX/cB3u5QWWI20Zg5hqImeXy47jqTf6aruggRWNrMhOO3+XRwFFYGFDv
         BMQhkSk4g4BFBbK4INlyTT9usyCY6SLAjRgD4TJg=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BA3E60385;
        Wed, 29 Aug 2018 04:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535517384;
        bh=oROkZsOkUbH81MViJ+tdX/WAcC4RorrJyY8wfZhjxUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qhtw6oOSVYuBwm544e1sLf3QBH8Pm43oLDt38mPlM0ye/V2yNURreml/IesKjU3+a
         IaXktJFMKv2CG9T/9ayOwjSFJnBxkVupTzZPlJs5FoRDw6wUJVm/+x+zkrMWiu9RWH
         5AGZPP5UWYx7OaTrPZd5kdrwTkO7UrNo+fRJA9mg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BA3E60385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        evgreen@chromium.org, riteshh@codeaurora.org
Cc:     stummala@codeaurora.org, adrian.hunter@intel.com,
        linux-scsi@vger.kernel.org,
        Sayali Lokhande <sayalil@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V11 2/2] scsi: ufs: Add configfs support for UFS provisioning
Date:   Wed, 29 Aug 2018 10:05:38 +0530
Message-Id: <1535517338-26077-3-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535517338-26077-1-git-send-email-sayalil@codeaurora.org>
References: <1535517338-26077-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds configfs support to provision UFS device at
runtime. This feature can be primarily useful in factory or
assembly line as some devices may be required to be configured
multiple times during initial system development phase.
Configuration Descriptors can be written multiple times until
bConfigDescrLock attribute is zero.

Configuration descriptor buffer consists of Device and Unit
descriptor configurable parameters which are parsed from vendor
specific provisioning file and then passed via configfs node at
runtime to provision ufs device.
CONFIG_CONFIGFS_FS and CONFIG_UFS_PROVISION needs to be enabled
for using this feature.

Usage:
1) To read current configuration descriptor with index X
   (where index X can be 0/1/2/3) :
   cat /config/XXXX.ufshc/ufs_config_desc_X

2) To write configuration descriptor with index X :
   echo <config_desc_buf> > /config/XXXX.ufshc/ufs_config_desc_X

Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 Documentation/ABI/testing/configfs-driver-ufs |  12 ++
 drivers/scsi/ufs/Kconfig                      |  10 ++
 drivers/scsi/ufs/Makefile                     |   1 +
 drivers/scsi/ufs/ufs-configfs.c               | 228 ++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd.c                     |   3 +-
 drivers/scsi/ufs/ufshcd.h                     |  17 ++
 6 files changed, 270 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/configfs-driver-ufs
 create mode 100644 drivers/scsi/ufs/ufs-configfs.c

diff --git a/Documentation/ABI/testing/configfs-driver-ufs b/Documentation/ABI/testing/configfs-driver-ufs
new file mode 100644
index 0000000..75cfc9e
--- /dev/null
+++ b/Documentation/ABI/testing/configfs-driver-ufs
@@ -0,0 +1,12 @@
+What:		/config/*/ufs_config_desc_X
+Date:		Jun 2018
+KernelVersion:	4.19
+Description:
+		This file shows the current ufs configuration descriptor with
+		index X (where X = 0/1/2/3) set in device. This can be used to
+		provision ufs device if bConfigDescrLock is 0.
+		For more details, refer 14.1.6.3 Configuration Descriptor and
+		table 14-12 - Unit Descriptor configurable parameters from specs for
+		description and format of each configuration descriptor parameter.
+		Parameters of Configuration descriptor buffer for respective index
+		needs to be passed in space separated format.
diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index e27b4d4..a9a0a58 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -100,3 +100,13 @@ config SCSI_UFS_QCOM
 
 	  Select this if you have UFS controller on QCOM chipset.
 	  If unsure, say N.
+
+config UFS_PROVISION
+	tristate "Runtime UFS Provisioning support"
+	depends on SCSI_UFSHCD && CONFIGFS_FS
+	help
+	  This enables runtime UFS provisioning support. This can be used
+	  primarily during assembly line as some devices may be required to
+	  be configured multiple times during initial development phase.
+
+	  If unsure, say N.
diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index 918f579..00110ea 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -5,5 +5,6 @@ obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) += tc-dwc-g210-pltfrm.o ufshcd-dwc.o tc-d
 obj-$(CONFIG_SCSI_UFS_QCOM) += ufs-qcom.o
 obj-$(CONFIG_SCSI_UFSHCD) += ufshcd-core.o
 ufshcd-core-objs := ufshcd.o ufs-sysfs.o
+obj-$(CONFIG_UFS_PROVISION) += ufs-configfs.o
 obj-$(CONFIG_SCSI_UFSHCD_PCI) += ufshcd-pci.o
 obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
diff --git a/drivers/scsi/ufs/ufs-configfs.c b/drivers/scsi/ufs/ufs-configfs.c
new file mode 100644
index 0000000..a4d26b7
--- /dev/null
+++ b/drivers/scsi/ufs/ufs-configfs.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2018, Linux Foundation.
+
+#include <linux/configfs.h>
+#include <linux/err.h>
+#include <linux/string.h>
+
+#include "ufs.h"
+#include "ufshcd.h"
+
+static inline struct ufs_hba *config_item_to_hba(struct config_item *item)
+{
+	struct config_group *group = to_config_group(item);
+	struct configfs_subsystem *subsys = to_configfs_subsystem(group);
+	struct ufs_hba *hba = container_of(subsys, struct ufs_hba, subsys);
+
+	return subsys ? hba : NULL;
+}
+
+static ssize_t ufs_config_desc_show(struct config_item *item, char *buf,
+		u8 index)
+{
+	struct ufs_hba *hba = config_item_to_hba(item);
+	u8 *desc_buf = NULL;
+	int desc_buf_len = hba->desc_size.conf_desc;
+	int i, ret, curr_len = 0;
+
+	desc_buf = kmalloc(desc_buf_len, GFP_KERNEL);
+	if (!desc_buf)
+		return -ENOMEM;
+
+	memset(desc_buf, 0, desc_buf_len);
+
+	ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_READ_DESC,
+	QUERY_DESC_IDN_CONFIGURATION, index, 0, desc_buf, &desc_buf_len);
+
+	if (ret)
+		return ret;
+
+	for (i = 0; i < desc_buf_len; i++)
+		curr_len += snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
+				"0x%x ", desc_buf[i]);
+
+	return curr_len;
+}
+
+ssize_t ufshcd_desc_configfs_store(struct config_item *item,
+		const char *buf, size_t count, u8 index)
+{
+	char *strbuf;
+	char *strbuf_copy;
+	struct ufs_hba *hba = config_item_to_hba(item);
+	u8 *desc_buf = NULL;
+	int desc_buf_len = hba->desc_size.conf_desc;
+	char *token;
+	int i, ret, value;
+	u32 config_desc_lock = 0;
+
+	desc_buf = kmalloc(desc_buf_len, GFP_KERNEL);
+	if (!desc_buf)
+		return -ENOMEM;
+
+	memset(desc_buf, 0, desc_buf_len);
+
+	/* reserve one byte for null termination */
+	strbuf = kmalloc(count + 1, GFP_KERNEL);
+	if (!strbuf)
+		return -ENOMEM;
+
+	strbuf_copy = strbuf;
+	strlcpy(strbuf, buf, count + 1);
+
+	/* Just return if bConfigDescrLock is already set */
+	ret = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+		QUERY_ATTR_IDN_CONF_DESC_LOCK, 0, 0, &config_desc_lock);
+	if (ret)
+		goto out;
+
+	if (config_desc_lock) {
+		dev_err(hba->dev, "%s: bConfigDescrLock already set to %u, cannot re-provision device!\n",
+		__func__, config_desc_lock);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (i = 0; i < desc_buf_len; i++) {
+		token = strsep(&strbuf, " ");
+		if (!token && i)
+			break;
+
+		ret = kstrtoint(token, 0, &value);
+		if (ret) {
+			dev_err(hba->dev, "%s: kstrtoint failed %d %s\n",
+				__func__, ret, token);
+			ret = -EINVAL;
+			goto out;
+		}
+		desc_buf[i] = (u8)value;
+	}
+
+	/* Write configuration descriptor to provision ufs */
+	ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_WRITE_DESC,
+	QUERY_DESC_IDN_CONFIGURATION, index, 0, desc_buf, &desc_buf_len);
+
+	if (!ret)
+		dev_info(hba->dev, "%s: UFS Configuration Descriptor %u written\n",
+		__func__, index);
+
+out:
+	kfree(strbuf_copy);
+	if (ret)
+		return ret;
+	return count;
+}
+
+static ssize_t ufs_config_desc_0_show(struct config_item *item, char *buf)
+{
+	return ufs_config_desc_show(item, buf, 0);
+}
+
+static ssize_t ufs_config_desc_0_store(struct config_item *item,
+		const char *buf, size_t count)
+{
+	return ufshcd_desc_configfs_store(item, buf, count, 0);
+}
+
+static ssize_t ufs_config_desc_1_show(struct config_item *item, char *buf)
+{
+	return ufs_config_desc_show(item, buf, 1);
+}
+
+static ssize_t ufs_config_desc_1_store(struct config_item *item,
+		const char *buf, size_t count)
+{
+	return ufshcd_desc_configfs_store(item, buf, count, 1);
+}
+
+static ssize_t ufs_config_desc_2_show(struct config_item *item, char *buf)
+{
+	return ufs_config_desc_show(item, buf, 2);
+}
+
+static ssize_t ufs_config_desc_2_store(struct config_item *item,
+		const char *buf, size_t count)
+{
+	return ufshcd_desc_configfs_store(item, buf, count, 2);
+}
+
+static ssize_t ufs_config_desc_3_show(struct config_item *item, char *buf)
+{
+	return ufs_config_desc_show(item, buf, 3);
+}
+
+static ssize_t ufs_config_desc_3_store(struct config_item *item,
+		const char *buf, size_t count)
+{
+	return ufshcd_desc_configfs_store(item, buf, count, 3);
+}
+
+static struct configfs_attribute ufshcd_attr_provision_0 = {
+	.ca_name	= "ufs_config_desc_0",
+	.ca_mode	= 0644,
+	.ca_owner	= THIS_MODULE,
+	.show		= ufs_config_desc_0_show,
+	.store		= ufs_config_desc_0_store,
+};
+
+static struct configfs_attribute ufshcd_attr_provision_1 = {
+	.ca_name	= "ufs_config_desc_1",
+	.ca_mode	= 0644,
+	.ca_owner	= THIS_MODULE,
+	.show		= ufs_config_desc_1_show,
+	.store		= ufs_config_desc_1_store,
+};
+
+static struct configfs_attribute ufshcd_attr_provision_2 = {
+	.ca_name	= "ufs_config_desc_2",
+	.ca_mode	= 0644,
+	.ca_owner	= THIS_MODULE,
+	.show		= ufs_config_desc_2_show,
+	.store		= ufs_config_desc_2_store,
+};
+
+static struct configfs_attribute ufshcd_attr_provision_3 = {
+	.ca_name	= "ufs_config_desc_3",
+	.ca_mode	= 0644,
+	.ca_owner	= THIS_MODULE,
+	.show		= ufs_config_desc_3_show,
+	.store		= ufs_config_desc_3_store,
+};
+
+static struct configfs_attribute *ufshcd_attrs[] = {
+	&ufshcd_attr_provision_0,
+	&ufshcd_attr_provision_1,
+	&ufshcd_attr_provision_2,
+	&ufshcd_attr_provision_3,
+	NULL,
+};
+
+static struct config_item_type ufscfg_type = {
+	.ct_attrs	= ufshcd_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+void ufshcd_configfs_init(struct ufs_hba *hba, const char *name)
+{
+	int ret;
+	struct config_item *cg_item;
+	struct configfs_subsystem *subsys;
+
+	cg_item = &hba->subsys.su_group.cg_item;
+	sprintf(cg_item->ci_namebuf, "%s", name);
+	cg_item->ci_type = &ufscfg_type;
+
+	subsys = &hba->subsys;
+	config_group_init(&subsys->su_group);
+	mutex_init(&subsys->su_mutex);
+	ret = configfs_register_subsystem(subsys);
+	if (ret)
+		pr_err("Error %d while registering subsystem %s\n",
+		       ret,
+		       subsys->su_group.cg_item.ci_namebuf);
+}
+
+void ufshcd_configfs_exit(struct ufs_hba *hba)
+{
+	configfs_unregister_subsystem(&hba->subsys);
+}
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index e01cdc0..608e23e 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7711,6 +7711,7 @@ int ufshcd_shutdown(struct ufs_hba *hba)
 void ufshcd_remove(struct ufs_hba *hba)
 {
 	ufs_sysfs_remove_nodes(hba->dev);
+	ufshcd_configfs_exit(hba);
 	scsi_remove_host(hba->host);
 	/* disable interrupts */
 	ufshcd_disable_intr(hba, hba->intr_mask);
@@ -7965,7 +7966,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 
 	async_schedule(ufshcd_async_scan, hba);
 	ufs_sysfs_add_nodes(hba->dev);
-
+	ufshcd_configfs_init(hba, dev_name(hba->dev));
 	return 0;
 
 out_remove_scsi_host:
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 45013b6..a340ca8 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -37,6 +37,7 @@
 #ifndef _UFSHCD_H
 #define _UFSHCD_H
 
+#include <linux/configfs.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -515,6 +516,9 @@ struct ufs_hba {
 
 	struct Scsi_Host *host;
 	struct device *dev;
+#ifdef CONFIG_UFS_PROVISION
+	struct configfs_subsystem subsys;
+#endif
 	/*
 	 * This field is to keep a reference to "scsi_device" corresponding to
 	 * "UFS device" W-LU.
@@ -868,6 +872,19 @@ int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
 int ufshcd_hold(struct ufs_hba *hba, bool async);
 void ufshcd_release(struct ufs_hba *hba);
 
+/* Expose UFS configfs API's */
+#ifndef CONFIG_UFS_PROVISION
+static inline void ufshcd_configfs_init(struct ufs_hba *hba, const char *name)
+{
+}
+static inline void ufshcd_configfs_exit(struct ufs_hba *hba)
+{
+}
+#else
+void ufshcd_configfs_init(struct ufs_hba *hba, const char *name);
+void ufshcd_configfs_exit(struct ufs_hba *hba);
+#endif
+
 int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
 	int *desc_length);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

