Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E3DC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B7624051
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UdHBZh3Y";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jeJs1ac3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B7624051
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753755AbeGFGVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:21:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49924 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753653AbeGFGVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:21:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 617C360B28; Fri,  6 Jul 2018 06:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530858080;
        bh=zxXlGbde+iY7L/t+11X3NbnoZIXDRMuA9KIi2lPUvMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UdHBZh3YzofP2/5IxMAoNhdFMibohU2myL3eadgfTcrrQlOV+vq/jaQRHlti/gAmK
         jfyuDdffXi7SR9Y950j0hdJ4G1GRhmEQyAEmvyv/IzFdBgtzM6VO8rE3MtUEfQP7Im
         A0TeufoMtIMddLJH9bv7G06V4mzESHG8yG5BalD0=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BAE7A607EB;
        Fri,  6 Jul 2018 06:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530858079;
        bh=zxXlGbde+iY7L/t+11X3NbnoZIXDRMuA9KIi2lPUvMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jeJs1ac3qFtF3IexDs1krhtkCq/wkNdx7rY0Q7MAl3bkkQJ83dVl3ZL+rGAdPr5E6
         +bZlri1m1O0hQa6AH574VK1rIV3qmJ5+2aB50/TDwxy0vDUn8AzzhGqKXhuXfwcqlz
         cxgnEvNW1PnJzB5AdzG4/npoj07I5IPdGTBOkakk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BAE7A607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        evgreen@chromium.org, riteshh@codeaurora.org
Cc:     linux-scsi@vger.kernel.org,
        Sayali Lokhande <sayalil@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V5 2/2] scsi: ufs: Add configfs support for ufs provisioning
Date:   Fri,  6 Jul 2018 11:50:40 +0530
Message-Id: <1530858040-13971-3-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530858040-13971-1-git-send-email-sayalil@codeaurora.org>
References: <1530858040-13971-1-git-send-email-sayalil@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds configfs support to provision ufs device at
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
1) To read current configuration descriptor :
   cat /config/ufshcd/ufs_provision
2) To provision ufs device:
   echo <config_desc_buf> > /config/ufshcd/ufs_provision

Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 Documentation/ABI/testing/configfs-driver-ufs |  18 +++
 drivers/scsi/ufs/Makefile                     |   1 +
 drivers/scsi/ufs/ufs-configfs.c               | 172 ++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd.c                     |   2 +
 drivers/scsi/ufs/ufshcd.h                     |  19 +++
 5 files changed, 212 insertions(+)
 create mode 100644 Documentation/ABI/testing/configfs-driver-ufs
 create mode 100644 drivers/scsi/ufs/ufs-configfs.c

diff --git a/Documentation/ABI/testing/configfs-driver-ufs b/Documentation/ABI/testing/configfs-driver-ufs
new file mode 100644
index 0000000..dd16842
--- /dev/null
+++ b/Documentation/ABI/testing/configfs-driver-ufs
@@ -0,0 +1,18 @@
+What:		/config/ufshcd/ufs_provision
+Date:		Jun 2018
+KernelVersion:	4.14
+Description:
+		This file shows the current ufs configuration descriptor set in device.
+		This can be used to provision ufs device if bConfigDescrLock is 0.
+		For more details, refer 14.1.6.3 Configuration Descriptor and
+		Table 14-12 — Unit Descriptor configurable parameters from specs for
+		description of each configuration descriptor parameter.
+		Configuration descriptor buffer needs to be passed in space separated
+		format specificied as below:
+		echo <bLength> <bDescriptorIDN> <bConfDescContinue> <bBootEnable>
+		<bDescrAccessEn> <bInitPowerMode> <bHighPriorityLUN>
+		<bSecureRemovalType> <bInitActiveICCLevel> <wPeriodicRTCUpdate>
+		<0Bh:0Fh_ReservedAs_0> <bLUEnable> <bBootLunID> <bLUWriteProtect>
+		<bMemoryType> <dNumAllocUnits> <bDataReliability> <bLogicalBlockSize>
+		<bProvisioningType> <wContextCapabilities> <0Dh:0Fh_ReservedAs_0>
+		> /config/ufshcd/ufs_provision
diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index 918f579..d438e74 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -5,5 +5,6 @@ obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) += tc-dwc-g210-pltfrm.o ufshcd-dwc.o tc-d
 obj-$(CONFIG_SCSI_UFS_QCOM) += ufs-qcom.o
 obj-$(CONFIG_SCSI_UFSHCD) += ufshcd-core.o
 ufshcd-core-objs := ufshcd.o ufs-sysfs.o
+obj-$(CONFIG_CONFIGFS_FS) += ufs-configfs.o
 obj-$(CONFIG_SCSI_UFSHCD_PCI) += ufshcd-pci.o
 obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
diff --git a/drivers/scsi/ufs/ufs-configfs.c b/drivers/scsi/ufs/ufs-configfs.c
new file mode 100644
index 0000000..7d207fc
--- /dev/null
+++ b/drivers/scsi/ufs/ufs-configfs.c
@@ -0,0 +1,172 @@
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
+	return hba ? hba : NULL;
+}
+
+static ssize_t ufs_provision_show(struct config_item *item, char *buf)
+{
+	u8 desc_buf[QUERY_DESC_CONFIGURATION_DEF_SIZE] = {0};
+	int buff_len = QUERY_DESC_CONFIGURATION_DEF_SIZE;
+	int i, ret, curr_len = 0;
+	struct ufs_hba *hba = config_item_to_hba(item);
+
+	if (!hba)
+		return snprintf(buf, PAGE_SIZE, "ufs hba is NULL!\n");
+
+	ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_READ_DESC,
+		QUERY_DESC_IDN_CONFIGURATION, 0, 0, desc_buf, &buff_len);
+
+	if (ret)
+		return snprintf(buf, PAGE_SIZE,
+		"Failed reading descriptor. desc_idn %d, opcode %x ret %d\n",
+		QUERY_DESC_IDN_CONFIGURATION,
+		UPIU_QUERY_OPCODE_READ_DESC, ret);
+
+	for (i = 0; i < buff_len; i++)
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
+	u8 desc_buf[QUERY_DESC_CONFIGURATION_DEF_SIZE] = {0};
+	int buff_len = QUERY_DESC_CONFIGURATION_DEF_SIZE;
+	char *token;
+	int i, ret, value;
+	u32 bConfigDescrLock = 0;
+
+	/* reserve one byte for null termination */
+	strbuf = kmalloc(count + 1, GFP_KERNEL);
+	if (!strbuf)
+		return -ENOMEM;
+
+	strbuf_copy = strbuf;
+	strlcpy(strbuf, buf, count + 1);
+
+	if (!hba)
+		goto out;
+
+	/* Just return if bConfigDescrLock is already set */
+	ret = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+		QUERY_ATTR_IDN_CONF_DESC_LOCK, 0, 0, &bConfigDescrLock);
+	if (ret) {
+		dev_err(hba->dev, "%s: Failed reading bConfigDescrLock %d, cannot re-provision device!\n",
+			__func__, ret);
+		goto out;
+	}
+	if (bConfigDescrLock) {
+		dev_err(hba->dev, "%s: bConfigDescrLock already set to %u, cannot re-provision device!\n",
+		__func__, bConfigDescrLock);
+		goto out;
+	}
+
+	for (i = 0; i < QUERY_DESC_CONFIGURATION_DEF_SIZE; i++) {
+		token = strsep(&strbuf, " ");
+		if (!token && i) {
+			dev_dbg(hba->dev, "%s: token %s, i %d\n",
+				__func__, token, i);
+			break;
+		}
+
+		ret = kstrtoint(token, 0, &value);
+		if (ret) {
+			dev_err(hba->dev, "%s: kstrtoint failed %d %s\n",
+				__func__, ret, token);
+			break;
+		}
+		desc_buf[i] = (u8)value;
+		dev_dbg(hba->dev, " desc_buf[%d] 0x%x", i, desc_buf[i]);
+	}
+
+	/* Write configuration descriptor to provision ufs */
+	ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_WRITE_DESC,
+		QUERY_DESC_IDN_CONFIGURATION, 0, 0, desc_buf, &buff_len);
+
+	if (ret)
+		dev_err(hba->dev, "%s: Failed writing descriptor. desc_idn %d, opcode %x ret %d\n",
+		__func__, QUERY_DESC_IDN_CONFIGURATION,
+		UPIU_QUERY_OPCODE_WRITE_DESC, ret);
+	else
+		dev_err(hba->dev, "%s: UFS Provisioning done, reboot now!\n",
+		__func__);
+
+out:
+	kfree(strbuf_copy);
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
+static struct configfs_attribute ufshcd_attr_provision = {
+	.ca_name	= "ufs_provision",
+	.ca_mode	= 0666,
+	.ca_owner	= THIS_MODULE,
+	.show		= ufs_provision_show,
+	.store		= ufs_provision_store,
+};
+
+static struct configfs_attribute *ufshcd_attrs[] = {
+	&ufshcd_attr_provision,
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
+			.ci_namebuf = "ufshcd",
+			.ci_type = &ufscfg_type,
+		},
+	},
+};
+
+int ufshcd_configfs_init(struct ufs_hba *hba)
+{
+	int ret;
+	struct configfs_subsystem *subsys = &hba->subsys;
+
+	subsys->su_group = ufscfg_subsys.su_group;
+	config_group_init(&subsys->su_group);
+	mutex_init(&subsys->su_mutex);
+	ret = configfs_register_subsystem(subsys);
+	if (ret)
+		pr_err("Error %d while registering subsystem %s\n",
+		       ret,
+		       subsys->su_group.cg_item.ci_namebuf);
+
+	return ret;
+}
+
+void ufshcd_configfs_exit(void)
+{
+	configfs_unregister_subsystem(&ufscfg_subsys);
+}
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 455a6ad..fb97a42 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7684,6 +7684,7 @@ int ufshcd_shutdown(struct ufs_hba *hba)
 void ufshcd_remove(struct ufs_hba *hba)
 {
 	ufs_sysfs_remove_nodes(hba->dev);
+	ufshcd_configfs_exit();
 	scsi_remove_host(hba->host);
 	/* disable interrupts */
 	ufshcd_disable_intr(hba, hba->intr_mask);
@@ -7937,6 +7938,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 
 	async_schedule(ufshcd_async_scan, hba);
 	ufs_sysfs_add_nodes(hba->dev);
+	ufshcd_configfs_init(hba);
 
 	return 0;
 
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 101a75c..e9081de 100644
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
+#ifdef CONFIG_CONFIGFS_FS
+	struct configfs_subsystem subsys;
+#endif
 	/*
 	 * This field is to keep a reference to "scsi_device" corresponding to
 	 * "UFS device" W-LU.
@@ -868,6 +872,21 @@ int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
 int ufshcd_hold(struct ufs_hba *hba, bool async);
 void ufshcd_release(struct ufs_hba *hba);
 
+/* Expose UFS configfs API's */
+#ifdef CONFIG_CONFIGFS_FS
+int ufshcd_configfs_init(struct ufs_hba *hba);
+void ufshcd_configfs_exit(void);
+#else /* CONFIG_CONFIGFS_FS */
+int ufshcd_configfs_init(struct ufs_hba *hba)
+{
+	return 0;
+}
+
+void ufshcd_configfs_exit(void)
+{
+}
+#endif /* CONFIG_CONFIGFS_FS */
+
 int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
 	int *desc_length);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

