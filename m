Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9FCC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19012073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY1DpFJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfBDUeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:34:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40318 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfBDUd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:33:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so1322836wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 12:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xcHkR/1SeufR2DxFKCVXE9LfKi3ntgQ6E0yP8fiafTw=;
        b=TY1DpFJ7KqZQt/EOybcOjXNUwbD+Bx9LlMc9V8pMsBHBhhHDxTIWbCmyZnVMh70hNs
         sF3LLhMkhdVzxrsGXGhTTeJvNSMu+CDSZh7/UloayszUgDdxwhFEGeKzcatu14zyAXtW
         gUK2ytc8Y/l0YasfkAfunv3X+8a6Y/taPs78eLdwmer2eAxT3/cwnlyuq0LiR6yL0ujj
         tp6oGiYOrx9aXkZp8B67zeCSXRYS5W8mXkadAE/7LZEJMeMN2Xz7FRJKFPC4VaNWUVrR
         eACxVK+Rm0CLH/vsdQq3moZCjcm4M/u2YqZ511ZayQSFO87qUEbGD99l7II04XDtHBWC
         1ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xcHkR/1SeufR2DxFKCVXE9LfKi3ntgQ6E0yP8fiafTw=;
        b=SA76r78T+/9NJyT3+zFAUL0PVyIHe6zsNrEzD9skBHbJaXG3pw9w9Ihhbma1+QJmMC
         zNY3XI/qG6NuxB8/F7SQc0KaYwF0Od72M9glVGaqm42PBRsCoLY5vDQFlRXzlo/+Ch39
         NEDLjVuWbVX93sJlWGzzyA1txOeHdFpClQzT6HY7PfRPRWGX4AJbrFdGSODuup3LBC8a
         iue18oXvlL6fHXZsbk97MfCOUampAzoxH+YRybLZEX3Vel0VWkgUGwHNsoSJtDZ/982A
         LfT1KzMPosW8z+isGU+bqCFW88lIfl3NHqCaSl0VnkyCyaXDOM0XpZPJerAVpNhkxDwf
         DvhA==
X-Gm-Message-State: AHQUAuYCA7iQs/VA15IrNumKZ1a5L/BQnuBDdqlF7/AW17Mo+FVPJTq+
        6BxGj9oo1uQDi+99INJBZac=
X-Google-Smtp-Source: AHgI3IalwW717Lbx6KT8TotflrSAsNMtWMy42bztRxzJ01lxI9NE5eFGT9eQ0ZLxZNIPaFK5luUqiA==
X-Received: by 2002:adf:f009:: with SMTP id j9mr883291wro.170.1549312406581;
        Mon, 04 Feb 2019 12:33:26 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j24sm19990792wrd.86.2019.02.04.12.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 12:33:25 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, rppt@linux.ibm.com
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v3 13/15] habanalabs: implement INFO IOCTL
Date:   Mon,  4 Feb 2019 22:32:52 +0200
Message-Id: <20190204203254.4026-14-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204203254.4026-1-oded.gabbay@gmail.com>
References: <20190204203254.4026-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the INFO IOCTL. That IOCTL is used by the user to
query information that is relevant/needed by the user in order to submit
deep learning jobs to Goya.

The information is divided into several categories, such as H/W IP, Events
that happened, DDR usage and more.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v3:
  - Remove use of three exclamation marks
 
 drivers/misc/habanalabs/goya/goya.c        |   6 +
 drivers/misc/habanalabs/habanalabs.h       |   2 +
 drivers/misc/habanalabs/habanalabs_ioctl.c | 126 +++++++++++++++++++++
 include/uapi/misc/habanalabs.h             |  75 +++++++++++-
 4 files changed, 208 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index e87fe053605d..3e858f499013 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5117,6 +5117,11 @@ static void goya_hw_queues_unlock(struct hl_device *hdev)
 	spin_unlock(&goya->hw_queues_lock);
 }
 
+static u32 goya_get_pci_id(struct hl_device *hdev)
+{
+	return hdev->pdev->device;
+}
+
 int goya_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 {
 	struct goya_device *goya = hdev->asic_specific;
@@ -5214,6 +5219,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.soft_reset_late_init = goya_soft_reset_late_init,
 	.hw_queues_lock = goya_hw_queues_lock,
 	.hw_queues_unlock = goya_hw_queues_unlock,
+	.get_pci_id = goya_get_pci_id,
 	.get_eeprom_data = goya_get_eeprom_data,
 	.send_cpu_message = goya_send_cpu_message
 };
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index c798caae2c09..fc33026974c9 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -460,6 +460,7 @@ enum hl_pll_frequency {
  * @soft_reset_late_init: perform certain actions needed after soft reset.
  * @hw_queues_lock: acquire H/W queues lock.
  * @hw_queues_unlock: release H/W queues lock.
+ * @get_pci_id: retrieve PCI ID.
  * @get_eeprom_data: retrieve EEPROM data from F/W.
  * @send_cpu_message: send buffer to ArmCP.
  */
@@ -528,6 +529,7 @@ struct hl_asic_funcs {
 	int (*soft_reset_late_init)(struct hl_device *hdev);
 	void (*hw_queues_lock)(struct hl_device *hdev);
 	void (*hw_queues_unlock)(struct hl_device *hdev);
+	u32 (*get_pci_id)(struct hl_device *hdev);
 	int (*get_eeprom_data)(struct hl_device *hdev, void *data,
 				size_t max_size);
 	int (*send_cpu_message)(struct hl_device *hdev, u32 *msg,
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index cd6904e639e9..0db0809c2ac6 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -12,10 +12,136 @@
 #include <linux/uaccess.h>
 #include <linux/cred.h>
 
+static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
+{
+	struct hl_info_hw_ip_info hw_ip = {0};
+	u32 size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 sram_kmd_size, dram_kmd_size;
+
+	if ((!size) || (!out))
+		return -EINVAL;
+
+	sram_kmd_size = (prop->sram_user_base_address -
+				prop->sram_base_address);
+	dram_kmd_size = (prop->dram_user_base_address -
+				prop->dram_base_address);
+
+	hw_ip.device_id = hdev->asic_funcs->get_pci_id(hdev);
+	hw_ip.sram_base_address = prop->sram_user_base_address;
+	hw_ip.dram_base_address = prop->dram_user_base_address;
+	hw_ip.tpc_enabled_mask = prop->tpc_enabled_mask;
+	hw_ip.sram_size = prop->sram_size - sram_kmd_size;
+	hw_ip.dram_size = prop->dram_size - dram_kmd_size;
+	if (hw_ip.dram_size > 0)
+		hw_ip.dram_enabled = 1;
+	hw_ip.num_of_events = prop->num_of_events;
+	memcpy(hw_ip.armcp_version,
+		prop->armcp_info.armcp_version, VERSION_MAX_LEN);
+	hw_ip.armcp_cpld_version = prop->armcp_info.cpld_version;
+	hw_ip.psoc_pci_pll_nr = prop->psoc_pci_pll_nr;
+	hw_ip.psoc_pci_pll_nf = prop->psoc_pci_pll_nf;
+	hw_ip.psoc_pci_pll_od = prop->psoc_pci_pll_od;
+	hw_ip.psoc_pci_pll_div_factor = prop->psoc_pci_pll_div_factor;
+
+	return copy_to_user(out, &hw_ip,
+		min((size_t)size, sizeof(hw_ip))) ? -EFAULT : 0;
+}
+
+static int hw_events_info(struct hl_device *hdev, struct hl_info_args *args)
+{
+	u32 size, max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	void *arr;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	arr = hdev->asic_funcs->get_events_stat(hdev, &size);
+
+	return copy_to_user(out, arr, min(max_size, size)) ? -EFAULT : 0;
+}
+
+static int dram_usage_info(struct hl_device *hdev, struct hl_info_args *args)
+{
+	struct hl_info_dram_usage dram_usage = {0};
+	u32 max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 dram_kmd_size;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	dram_kmd_size = (prop->dram_user_base_address -
+				prop->dram_base_address);
+	dram_usage.dram_free_mem = (prop->dram_size - dram_kmd_size) -
+					atomic64_read(&hdev->dram_used_mem);
+	dram_usage.ctx_dram_mem = atomic64_read(&hdev->user_ctx->dram_phys_mem);
+
+	return copy_to_user(out, &dram_usage,
+		min((size_t) max_size, sizeof(dram_usage))) ? -EFAULT : 0;
+}
+
+static int hw_idle(struct hl_device *hdev, struct hl_info_args *args)
+{
+	struct hl_info_hw_idle hw_idle = {0};
+	u32 max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	hw_idle.is_idle = hdev->asic_funcs->is_device_idle(hdev);
+
+	return copy_to_user(out, &hw_idle,
+		min((size_t) max_size, sizeof(hw_idle))) ? -EFAULT : 0;
+}
+
+static int hl_info_ioctl(struct hl_fpriv *hpriv, void *data)
+{
+	struct hl_info_args *args = data;
+	struct hl_device *hdev = hpriv->hdev;
+	int rc;
+
+	if (hl_device_disabled_or_in_reset(hdev)) {
+		dev_err(hdev->dev,
+			"Device is disabled or in reset. Can't execute INFO IOCTL\n");
+		return -EBUSY;
+	}
+
+	switch (args->op) {
+	case HL_INFO_HW_IP_INFO:
+		rc = hw_ip_info(hdev, args);
+		break;
+
+	case HL_INFO_HW_EVENTS:
+		rc = hw_events_info(hdev, args);
+		break;
+
+	case HL_INFO_DRAM_USAGE:
+		rc = dram_usage_info(hdev, args);
+		break;
+
+	case HL_INFO_HW_IDLE:
+		rc = hw_idle(hdev, args);
+		break;
+
+	default:
+		dev_err(hdev->dev, "Invalid request %d\n", args->op);
+		rc = -EINVAL;
+		break;
+	}
+
+	return rc;
+}
+
 #define HL_IOCTL_DEF(ioctl, _func) \
 	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func}
 
 static const struct hl_ioctl_desc hl_ioctls[] = {
+	HL_IOCTL_DEF(HL_IOCTL_INFO, hl_info_ioctl),
 	HL_IOCTL_DEF(HL_IOCTL_CB, hl_cb_ioctl),
 	HL_IOCTL_DEF(HL_IOCTL_CS, hl_cs_ioctl),
 	HL_IOCTL_DEF(HL_IOCTL_WAIT_CS, hl_cs_wait_ioctl),
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 9015043887d1..4afc1891ece8 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -45,6 +45,62 @@ enum goya_queue_id {
 	GOYA_QUEUE_ID_SIZE
 };
 
+/* Opcode for management ioctl */
+#define HL_INFO_HW_IP_INFO	0
+#define HL_INFO_HW_EVENTS	1
+#define HL_INFO_DRAM_USAGE	2
+#define HL_INFO_HW_IDLE		3
+
+#define HL_INFO_VERSION_MAX_LEN	128
+
+struct hl_info_hw_ip_info {
+	__u64 sram_base_address;
+	__u64 dram_base_address;
+	__u64 dram_size;
+	__u32 sram_size;
+	__u32 num_of_events;
+	__u32 device_id; /* PCI Device ID */
+	__u32 reserved[3];
+	__u32 armcp_cpld_version;
+	__u32 psoc_pci_pll_nr;
+	__u32 psoc_pci_pll_nf;
+	__u32 psoc_pci_pll_od;
+	__u32 psoc_pci_pll_div_factor;
+	__u8 tpc_enabled_mask;
+	__u8 dram_enabled;
+	__u8 pad[2];
+	__u8 armcp_version[HL_INFO_VERSION_MAX_LEN];
+};
+
+struct hl_info_dram_usage {
+	__u64 dram_free_mem;
+	__u64 ctx_dram_mem;
+};
+
+struct hl_info_hw_idle {
+	__u32 is_idle;
+	__u32 pad;
+};
+
+struct hl_info_args {
+	/* Location of relevant struct in userspace */
+	__u64 return_pointer;
+	/*
+	 * The size of the return value. Just like "size" in "snprintf",
+	 * it limits how many bytes the kernel can write
+	 *
+	 * For hw_events array, the size should be
+	 * hl_info_hw_ip_info.num_of_events * sizeof(__u32)
+	 */
+	__u32 return_size;
+
+	/* HL_INFO_* */
+	__u32 op;
+
+	/* Context ID - Currently not in use */
+	__u32 ctx_id;
+	__u32 pad;
+};
 
 /* Opcode to create a new command buffer */
 #define HL_CB_OP_CREATE		0
@@ -264,6 +320,23 @@ union hl_mem_args {
 	struct hl_mem_out out;
 };
 
+/*
+ * Various information operations such as:
+ * - H/W IP information
+ * - Current dram usage
+ *
+ * The user calls this IOCTL with an opcode that describes the required
+ * information. The user should supply a pointer to a user-allocated memory
+ * chunk, which will be filled by the driver with the requested information.
+ *
+ * The user supplies the maximum amount of size to copy into the user's memory,
+ * in order to prevent data corruption in case of differences between the
+ * definitions of structures in kernel and userspace, e.g. in case of old
+ * userspace and new kernel driver
+ */
+#define HL_IOCTL_INFO	\
+		_IOWR('H', 0x01, struct hl_info_args)
+
 /*
  * Command Buffer
  * - Request a Command Buffer
@@ -365,7 +438,7 @@ union hl_mem_args {
 #define HL_IOCTL_MEMORY		\
 		_IOWR('H', 0x05, union hl_mem_args)
 
-#define HL_COMMAND_START	0x02
+#define HL_COMMAND_START	0x01
 #define HL_COMMAND_END		0x06
 
 #endif /* HABANALABS_H_ */
-- 
2.17.1

