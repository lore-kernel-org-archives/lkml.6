Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28F3C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 04:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46909264CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 04:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IyDjSzuT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MXBILQBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46909264CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeFZEEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 00:04:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbeFZEEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 00:04:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 976176081B; Tue, 26 Jun 2018 04:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529985873;
        bh=on4Nki5MadikfUgoywnBX6cPf6LZUbDMNEDbJ6pjnZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IyDjSzuT6eMr+SJClR6nEPlhUmQ/sSlC7kkQ7BYEO97b2rjgD3LCTi8UDPxYveFkL
         9iqpLjWi8mMHAKUY85mqzGw+4S5A0VpBVPtMxvG8kCzC5huLZne4TSqXkN2rleegnN
         fiCmCVMVmie8lNuIfAj8viVF1GUCaUJ3P1Czb1SQ=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6F0A60376;
        Tue, 26 Jun 2018 04:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529985872;
        bh=on4Nki5MadikfUgoywnBX6cPf6LZUbDMNEDbJ6pjnZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXBILQBM193kpAQdzoqT//T6gY6pa/tVkvb4nNVoU/QsBaTUw1N8PdyeP+gkCyhnb
         NzER/nhJroYPVRIt4XlVqK6+yESX7JW6bCXd5+NKxTB2wMSQ7F10PaKFz9Vbx/rXEe
         5/vpJ47f/YvHe+xYT1rOYA5Gebb2RBZ6eKj78wFI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6F0A60376
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
Subject: [PATCH V4 3/3] scsi: ufs: Add configfs support for ufs provisioning
Date:   Tue, 26 Jun 2018 09:33:49 +0530
Message-Id: <1529985829-18689-4-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529985829-18689-1-git-send-email-sayalil@codeaurora.org>
References: <1529985829-18689-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add configfs support to provision ufs device at runtime.
Usage:
echo <desc_buf> > /config/ufshcd/ufs_provision
To check provisioning status:
cat /config/ufshcd/ufs_provision
1 -> Success (Reboot device to check updated provisioning)

Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 Documentation/ABI/testing/configfs-driver-ufs |  15 ++
 drivers/scsi/ufs/Makefile                     |   1 +
 drivers/scsi/ufs/ufs-configfs.c               | 198 ++++++++++++++++++++++++++
 drivers/scsi/ufs/ufs.h                        |   2 +
 drivers/scsi/ufs/ufshcd.c                     |   2 +
 drivers/scsi/ufs/ufshcd.h                     |  18 +++
 6 files changed, 236 insertions(+)
 create mode 100644 Documentation/ABI/testing/configfs-driver-ufs
 create mode 100644 drivers/scsi/ufs/ufs-configfs.c

diff --git a/Documentation/ABI/testing/configfs-driver-ufs b/Documentation/ABI/testing/configfs-driver-ufs
new file mode 100644
index 0000000..f6ef38e
--- /dev/null
+++ b/Documentation/ABI/testing/configfs-driver-ufs
@@ -0,0 +1,15 @@
+What:		/config/ufshcd/ufs_provision
+Date:		Jun 2018
+KernelVersion:	4.14
+Description:
+		This file shows the status of runtime ufs provisioning.
+		This can be used to provision ufs device if bConfigDescrLock is 0.
+		Configuration buffer needs to be written in space separated format
+		specificied as below:
+		echo <bNumberLU> <bBootEnable> <bDescrAccessEn> <bInitPowerMode>
+		<bHighPriorityLUN> <bSecureRemovalType> <bInitActiveICCLevel>
+		<wPeriodicRTCUpdate> <bConfigDescrLock> <LUNum> <bLUEnable>
+		<bBootLunID> <size_in_kb> <bDataReliability> <bLUWriteProtect>
+		<bMemoryType> <bLogicalBlockSize> <bProvisioningType>
+		<wContextCapabilities> <LUNtoGrow> <commit> <NumofLUNs>
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
index 0000000..614b017
--- /dev/null
+++ b/drivers/scsi/ufs/ufs-configfs.c
@@ -0,0 +1,198 @@
+/*
+ * Copyright (c) 2018, Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/string.h>
+#include <asm/unaligned.h>
+#include <linux/configfs.h>
+
+#include "ufs.h"
+#include "ufshcd.h"
+
+struct ufs_hba *hba;
+
+static ssize_t ufs_provision_show(struct config_item *item, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "provision_enabled = %x\n",
+		hba->provision_enabled);
+}
+
+ssize_t ufshcd_desc_configfs_store(const char *buf, size_t count)
+{
+	struct ufs_config_descr *cfg = &hba->cfgs;
+	char *strbuf;
+	char *strbuf_copy;
+	int desc_buf[count];
+	int *pt;
+	char *token;
+	int i, ret;
+	int value, commit = 0;
+	int num_luns = 0;
+	int KB_per_block = 4;
+
+	/* reserve one byte for null termination */
+	strbuf = kmalloc(count + 1, GFP_KERNEL);
+	if (!strbuf)
+		return -ENOMEM;
+
+	strbuf_copy = strbuf;
+	strlcpy(strbuf, buf, count + 1);
+	memset(desc_buf, 0, count);
+
+	/* Just return if bConfigDescrLock is already set */
+	ret = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+		QUERY_ATTR_IDN_CONF_DESC_LOCK, 0, 0, &cfg->bConfigDescrLock);
+	if (ret) {
+		dev_err(hba->dev, "%s: Failed reading bConfigDescrLock %d, cannot re-provision device!\n",
+			__func__, ret);
+		hba->provision_enabled = 0;
+		goto out;
+	}
+	if (cfg->bConfigDescrLock == 1) {
+		dev_err(hba->dev, "%s: bConfigDescrLock already set to %u, cannot re-provision device!\n",
+		__func__, cfg->bConfigDescrLock);
+		hba->provision_enabled = 0;
+		goto out;
+	}
+
+	for (i = 0; i < count; i++) {
+		token = strsep(&strbuf, " ");
+		if (!token && i) {
+			num_luns = desc_buf[i-1];
+			dev_dbg(hba->dev, "%s: token %s, num_luns %d\n",
+				__func__, token, num_luns);
+			if (num_luns > 8) {
+				dev_err(hba->dev, "%s: Invalid num_luns %d\n",
+				__func__, num_luns);
+				hba->provision_enabled = 0;
+				goto out;
+			}
+			break;
+		}
+
+		ret = kstrtoint(token, 0, &value);
+		if (ret) {
+			dev_err(hba->dev, "%s: kstrtoint failed %d %s\n",
+				__func__, ret, token);
+			break;
+		}
+		desc_buf[i] = value;
+		dev_dbg(hba->dev, " desc_buf[%d] 0x%x", i, desc_buf[i]);
+	}
+
+	/* Fill in the descriptors with parsed configuration data */
+	pt = desc_buf;
+	cfg->bNumberLU = *pt++;
+	cfg->bBootEnable = *pt++;
+	cfg->bDescrAccessEn = *pt++;
+	cfg->bInitPowerMode = *pt++;
+	cfg->bHighPriorityLUN = *pt++;
+	cfg->bSecureRemovalType = *pt++;
+	cfg->bInitActiveICCLevel = *pt++;
+	cfg->wPeriodicRTCUpdate = *pt++;
+	cfg->bConfigDescrLock = *pt++;
+	dev_dbg(hba->dev, "%s: %u %u %u %u %u %u %u %u %u\n", __func__,
+	cfg->bNumberLU, cfg->bBootEnable, cfg->bDescrAccessEn,
+	cfg->bInitPowerMode, cfg->bHighPriorityLUN, cfg->bSecureRemovalType,
+	cfg->bInitActiveICCLevel, cfg->wPeriodicRTCUpdate,
+	cfg->bConfigDescrLock);
+
+	for (i = 0; i < num_luns; i++) {
+		cfg->unit[i].LUNum = *pt++;
+		cfg->unit[i].bLUEnable = *pt++;
+		cfg->unit[i].bBootLunID = *pt++;
+		/* dNumAllocUnits = size_in_kb/KB_per_block */
+		cfg->unit[i].dNumAllocUnits = (u32)(*pt++ / KB_per_block);
+		cfg->unit[i].bDataReliability = *pt++;
+		cfg->unit[i].bLUWriteProtect = *pt++;
+		cfg->unit[i].bMemoryType = *pt++;
+		cfg->unit[i].bLogicalBlockSize = *pt++;
+		cfg->unit[i].bProvisioningType = *pt++;
+		cfg->unit[i].wContextCapabilities = *pt++;
+	}
+
+	cfg->lun_to_grow = *pt++;
+	commit = *pt++;
+	cfg->num_luns = *pt;
+	dev_dbg(hba->dev, "%s: lun_to_grow %u, commit %u num_luns %u\n",
+		__func__, cfg->lun_to_grow, commit, cfg->num_luns);
+	if (commit == 1) {
+		ret = ufshcd_do_config_device(hba);
+		if (!ret) {
+			hba->provision_enabled = 1;
+			dev_err(hba->dev,
+			"%s: UFS Provisioning completed,num_luns %u, reboot now !\n",
+			__func__, cfg->num_luns);
+		}
+	} else
+		dev_err(hba->dev, "%s: Invalid commit %u\n", __func__, commit);
+out:
+	kfree(strbuf_copy);
+	return count;
+}
+
+static ssize_t ufs_provision_store(struct config_item *item,
+		const char *buf, size_t count)
+{
+	return ufshcd_desc_configfs_store(buf, count);
+}
+
+static struct configfs_attribute ufshcd_attr_provision = {
+	.ca_name	= "ufs_provision",
+	.ca_mode	= S_IRUGO | S_IWUGO,
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
+int ufshcd_configfs_init(struct ufs_hba *hba_ufs)
+{
+	int ret;
+	struct configfs_subsystem *subsys = &ufscfg_subsys;
+
+	hba = hba_ufs;
+	config_group_init(&subsys->su_group);
+	mutex_init(&subsys->su_mutex);
+	ret = configfs_register_subsystem(subsys);
+	if (ret) {
+		pr_err("Error %d while registering subsystem %s\n",
+		       ret,
+		       subsys->su_group.cg_item.ci_namebuf);
+	}
+	return ret;
+}
+
+void ufshcd_configfs_exit(void)
+{
+	configfs_unregister_subsystem(&ufscfg_subsys);
+}
diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 1f99904..0b497fc 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -427,6 +427,7 @@ enum {
 };
 
 struct ufs_unit_desc {
+	u8	   LUNum;
 	u8     bLUEnable;              /* 1 for enabled LU */
 	u8     bBootLunID;             /* 0 for using this LU for boot */
 	u8     bLUWriteProtect;        /* 1 = power on WP, 2 = permanent WP */
@@ -451,6 +452,7 @@ struct ufs_config_descr {
 	u32    qVendorConfigCode;      /* Vendor specific configuration code */
 	struct ufs_unit_desc unit[8];
 	u8	lun_to_grow;
+	u8 num_luns;
 };
 
 /* Task management service response */
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 370a7c6..e980d5a 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7892,6 +7892,7 @@ int ufshcd_shutdown(struct ufs_hba *hba)
 void ufshcd_remove(struct ufs_hba *hba)
 {
 	ufs_sysfs_remove_nodes(hba->dev);
+	ufshcd_configfs_exit();
 	scsi_remove_host(hba->host);
 	/* disable interrupts */
 	ufshcd_disable_intr(hba, hba->intr_mask);
@@ -8145,6 +8146,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 
 	async_schedule(ufshcd_async_scan, hba);
 	ufs_sysfs_add_nodes(hba->dev);
+	ufshcd_configfs_init(hba);
 
 	return 0;
 
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 0e6bf30..7d2fa89 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -41,6 +41,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/configfs.h>
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
@@ -550,6 +551,7 @@ struct ufs_hba {
 	bool is_irq_enabled;
 	u32 dev_ref_clk_freq;
 	struct ufs_config_descr cfgs;
+	bool provision_enabled;
 
 	/* Interrupt aggregation support is broken */
 	#define UFSHCD_QUIRK_BROKEN_INTR_AGGR			0x1
@@ -869,6 +871,22 @@ int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
 int ufshcd_hold(struct ufs_hba *hba, bool async);
 void ufshcd_release(struct ufs_hba *hba);
 int ufshcd_do_config_device(struct ufs_hba *hba);
+/* Expose UFS configfs API's */
+ssize_t ufshcd_desc_configfs_store(const char *buf, size_t count);
+
+#ifdef CONFIG_CONFIGFS_FS
+int ufshcd_configfs_init(struct ufs_hba *hba_ufs);
+void ufshcd_configfs_exit(void);
+#else /* CONFIG_CONFIGFS_FS */
+int ufshcd_configfs_init(struct ufs_hba *hba_ufs)
+{
+	return 0;
+}
+
+void ufshcd_configfs_exit(void)
+{
+}
+#endif /* CONFIG_CONFIGFS_FS */
 
 int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
 	int *desc_length);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

