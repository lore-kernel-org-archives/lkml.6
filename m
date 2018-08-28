Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AEAC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F702088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZN0zuKvR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZN0zuKvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F702088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeH1My6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:54:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51804 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeH1My6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:54:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C2FE060452; Tue, 28 Aug 2018 09:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535447056;
        bh=RkVyU7knWHgWrUifsxsVBVg8gwMt4R10IG3RJ/yNm1U=;
        h=From:To:Cc:Subject:Date:From;
        b=ZN0zuKvRwWcr/v1gRldb6kM2o2tf8d8aAmkuZZame5TCWwBZyYEO4gi9pmnTx4b/y
         VPgB7Py7CGqQ6K7hM8VHWOT4Dt2oBjDJk1hRPtgBTQTa8n8oMuo4VT5yLpbGYh8CNO
         Zy9EipXIle4QrNvfKKjA6urMjutQIMrMdubVyFGI=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97D3760385;
        Tue, 28 Aug 2018 09:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535447056;
        bh=RkVyU7knWHgWrUifsxsVBVg8gwMt4R10IG3RJ/yNm1U=;
        h=From:To:Cc:Subject:Date:From;
        b=ZN0zuKvRwWcr/v1gRldb6kM2o2tf8d8aAmkuZZame5TCWwBZyYEO4gi9pmnTx4b/y
         VPgB7Py7CGqQ6K7hM8VHWOT4Dt2oBjDJk1hRPtgBTQTa8n8oMuo4VT5yLpbGYh8CNO
         Zy9EipXIle4QrNvfKKjA6urMjutQIMrMdubVyFGI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97D3760385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     asutoshd@codeaurora.org
Cc:     Sayali Lokhande <sayalil@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-scsi@vger.kernel.org (open list:UNIVERSAL FLASH STORAGE HOST
        CONTROLLER DRIVER)
Subject: [PATCH V10.1 2/2] scsi: ufs: Add configfs support for UFS provisioning
Date:   Tue, 28 Aug 2018 14:33:46 +0530
Message-Id: <1535447040-1768-1-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
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
CONFIG_CONFIGFS_FS needs to be enabled for using this feature.

Usage:
1) To read current configuration descriptor with index X :
   echo X > /config/XXXX.ufshc/ufs_config_desc_index
   cat /config/XXXX.ufshc/ufs_provision
2) To write configuration descriptor with index X :
   echo X > /config/XXXX.ufshc/ufs_config_desc_index
   echo <config_desc_buf> > /config/XXXX.ufshc/ufs_provision

Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 Documentation/ABI/testing/configfs-driver-ufs |  35 +++++
 drivers/scsi/ufs/Kconfig                      |  10 ++
 drivers/scsi/ufs/Makefile                     |   1 +
 drivers/scsi/ufs/ufs-configfs.c               | 208 ++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd.c                     |   5 +-
 drivers/scsi/ufs/ufshcd.h                     |  22 +++
 6 files changed, 279 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/configfs-driver-ufs
 create mode 100644 drivers/scsi/ufs/ufs-configfs.c

diff --git a/Documentation/ABI/testing/configfs-driver-ufs b/Documentation/ABI/testing/configfs-driver-ufs
new file mode 100644
index 0000000..71df18e
--- /dev/null
+++ b/Documentation/ABI/testing/configfs-driver-ufs
@@ -0,0 +1,35 @@
+What:		/config/*/ufs_config_desc_index
+Date:		Jun 2018
+KernelVersion:	4.19
+Description:
+		This file shows the current ufs configuration descriptor index.
+		For more details, refer 14.1.6.3 Configuration Descriptor.
+		Once index is set, respective Configuration Descriptor can be written
+		using ufs_provision entry (refer /config/*/ufs_provision below).
+		Usage:
+		echo <Index> > /config/XXXX.ufshc/ufs_config_desc_index
+
+What:		/config/*/ufs_provision
+Date:		Jun 2018
+KernelVersion:	4.19
+Description:
+		This file shows the current ufs configuration descriptor set in device.
+		This can be used to provision ufs device if bConfigDescrLock is 0.
+		For more details, refer 14.1.6.3 Configuration Descriptor and
+		Table 14-12 - Unit Descriptor configurable parameters from specs for
+		description and format to be passed for respective index of configuration
+		descriptor. Please note each parameter must be passed in space separated
+		format.
+		Usage:
+		echo <Configuration_Descriptor_for_Index> /config/XXXX.ufshc/ufs_provision
+
+		For example: To write Configuration Descriptor with Index 0
+		echo 0 > /config/XXXX.ufshc/ufs_config_desc_index
+
+		echo <bLength> <bDescriptorIDN> <bConfDescContinue> <bBootEnable>
+		<bDescrAccessEn> <bInitPowerMode> <bHighPriorityLUN>
+		<bSecureRemovalType> <bInitActiveICCLevel> <wPeriodicRTCUpdate>
+		<0Bh:0Fh_ReservedAs_0> <bLUEnable> <bBootLunID> <bLUWriteProtect>
+		<bMemoryType> <dNumAllocUnits> <bDataReliability> <bLogicalBlockSize>
+		<bProvisioningType> <wContextCapabilities> <0Dh:0Fh_ReservedAs_0>
+		> /config/XXXX.ufshc/ufs_provision
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
index 0000000..950f879
--- /dev/null
+++ b/drivers/scsi/ufs/ufs-configfs.c
@@ -0,0 +1,208 @@
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
+static ssize_t ufs_provision_show(struct config_item *item, char *buf)
+{
+	u8 *desc_buf = NULL;
+	int desc_buf_len;
+	int i, ret, curr_len = 0;
+	struct ufs_hba *hba = config_item_to_hba(item);
+
+	ret = ufshcd_read_desc_length(hba, QUERY_DESC_IDN_CONFIGURATION,
+		hba->config_desc_index, &desc_buf_len);
+	if (!ret && desc_buf_len) {
+		desc_buf = kmalloc(desc_buf_len, GFP_KERNEL);
+		if (!desc_buf)
+			return -ENOMEM;
+	} else
+		return -EINVAL;
+
+	ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_READ_DESC,
+		QUERY_DESC_IDN_CONFIGURATION, hba->config_desc_index,
+		0, desc_buf, &desc_buf_len);
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
+ssize_t ufshcd_desc_configfs_store(struct ufs_hba *hba,
+		const char *buf, size_t count)
+{
+	char *strbuf;
+	char *strbuf_copy;
+	u8 *desc_buf = NULL;
+	int desc_buf_len;
+	char *token;
+	int i, ret, value;
+	u32 config_desc_lock = 0;
+
+	ret = ufshcd_read_desc_length(hba, QUERY_DESC_IDN_CONFIGURATION,
+		hba->config_desc_index, &desc_buf_len);
+	if (!ret && desc_buf_len) {
+		desc_buf = kmalloc(desc_buf_len, GFP_KERNEL);
+		if (!desc_buf)
+			return -ENOMEM;
+	} else
+		return -EINVAL;
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
+		QUERY_DESC_IDN_CONFIGURATION, hba->config_desc_index, 0, desc_buf, &desc_buf_len);
+
+	if (!ret)
+		dev_info(hba->dev, "%s: UFS Configuration Descriptor %u written\n",
+		__func__, hba->config_desc_index);
+
+out:
+	kfree(strbuf_copy);
+	if (ret)
+		return ret;
+	return count;
+}
+
+static ssize_t ufs_provision_store(struct config_item *item,
+		const char *buf, size_t count)
+{
+	struct ufs_hba *hba = config_item_to_hba(item);
+
+	return ufshcd_desc_configfs_store(hba, buf, count);
+}
+
+static ssize_t ufs_config_index_show(struct config_item *item, char *buf)
+{
+	struct ufs_hba *hba = config_item_to_hba(item);
+
+	return sprintf(buf, "%u\n", hba->config_desc_index);
+}
+
+static ssize_t ufs_config_index_store(struct config_item *item,
+		const char *buf, size_t count)
+{
+	struct ufs_hba *hba = config_item_to_hba(item);
+	u8 index;
+	int ret;
+
+	ret = kstrtou8(buf, 0, &index);
+	if (ret) {
+		dev_err(hba->dev, "%s: kstrtou8 failed %d %s\n",
+			__func__, ret, buf);
+			return -EINVAL;
+		}
+	hba->config_desc_index = index;
+
+	return count;
+}
+
+static struct configfs_attribute ufshcd_attr_provision = {
+	.ca_name	= "ufs_provision",
+	.ca_mode	= 0644,
+	.ca_owner	= THIS_MODULE,
+	.show		= ufs_provision_show,
+	.store		= ufs_provision_store,
+};
+
+static struct configfs_attribute ufshcd_attr_index = {
+	.ca_name	= "ufs_config_desc_index",
+	.ca_mode	= 0644,
+	.ca_owner	= THIS_MODULE,
+	.show		= ufs_config_index_show,
+	.store		= ufs_config_index_store,
+};
+
+static struct configfs_attribute *ufshcd_attrs[] = {
+	&ufshcd_attr_provision,
+	&ufshcd_attr_index,
+	NULL,
+};
+
+static struct config_item_type ufscfg_type = {
+	.ct_attrs	= ufshcd_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct configfs_subsystem ufscfg_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_type = &ufscfg_type,
+		},
+	},
+};
+
+void ufshcd_configfs_init(struct ufs_hba *hba, const char *name)
+{
+	int ret;
+	struct configfs_subsystem *subsys = &hba->subsys;
+
+	strncpy(ufscfg_subsys.su_group.cg_item.ci_namebuf, name, strlen(name));
+	subsys->su_group = ufscfg_subsys.su_group;
+	config_group_init(&subsys->su_group);
+	mutex_init(&subsys->su_mutex);
+	ret = configfs_register_subsystem(subsys);
+	if (ret)
+		pr_err("Error %d while registering subsystem %s\n",
+		       ret,
+		       subsys->su_group.cg_item.ci_namebuf);
+}
+
+void ufshcd_configfs_exit(void)
+{
+	configfs_unregister_subsystem(&ufscfg_subsys);
+}
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index e01cdc0..6be98bc 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2887,7 +2887,7 @@ int ufshcd_query_descriptor_retry(struct ufs_hba *hba,
  *
  * Return 0 in case of success, non-zero otherwise
  */
-static int ufshcd_read_desc_length(struct ufs_hba *hba,
+int ufshcd_read_desc_length(struct ufs_hba *hba,
 	enum desc_idn desc_id,
 	int desc_index,
 	int *desc_length)
@@ -7711,6 +7711,7 @@ int ufshcd_shutdown(struct ufs_hba *hba)
 void ufshcd_remove(struct ufs_hba *hba)
 {
 	ufs_sysfs_remove_nodes(hba->dev);
+	ufshcd_configfs_exit();
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
index 45013b6..b14d900 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -37,6 +37,7 @@
 #ifndef _UFSHCD_H
 #define _UFSHCD_H
 
+#include <linux/configfs.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -515,6 +516,10 @@ struct ufs_hba {
 
 	struct Scsi_Host *host;
 	struct device *dev;
+#ifdef CONFIG_UFS_PROVISION
+	struct configfs_subsystem subsys;
+	u8 config_desc_index;
+#endif
 	/*
 	 * This field is to keep a reference to "scsi_device" corresponding to
 	 * "UFS device" W-LU.
@@ -867,6 +872,23 @@ int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
 
 int ufshcd_hold(struct ufs_hba *hba, bool async);
 void ufshcd_release(struct ufs_hba *hba);
+int ufshcd_read_desc_length(struct ufs_hba *hba,
+	enum desc_idn desc_id,
+	int desc_index,
+	int *desc_length);
+
+/* Expose UFS configfs API's */
+#ifndef CONFIG_UFS_PROVISION
+static inline void ufshcd_configfs_init(struct ufs_hba *hba, const char *name)
+{
+}
+static inline void ufshcd_configfs_exit(void)
+{
+}
+#else
+void ufshcd_configfs_init(struct ufs_hba *hba, const char *name);
+void ufshcd_configfs_exit(void);
+#endif
 
 int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
 	int *desc_length);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

