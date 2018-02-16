Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751100AbeBPWrU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 17:47:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46098 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeBPWqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 17:46:50 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D54B260386
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org
Cc: sboyd@codeaurora.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Subject: [PATCH v3 1/2] drivers: qcom: add command DB driver
Date: Fri, 16 Feb 2018 15:46:13 -0700
Message-Id: <20180216224614.24037-2-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180216224614.24037-1-ilina@codeaurora.org>
References: <20180216224614.24037-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mahesh Sivasubramanian <msivasub@codeaurora.org>

Command DB is a simple database in the shared memory of QCOM SoCs, that
provides information regarding shared resources. Some shared resources
in the SoC have properties that are probed dynamically at boot by the
remote processor. The information pertaining to the SoC and the platform
are made available in the shared memory. Drivers can query this
information using predefined strings.

Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/of/platform.c     |   1 +
 drivers/soc/qcom/Kconfig  |   9 ++
 drivers/soc/qcom/Makefile |   1 +
 drivers/soc/qcom/cmd-db.c | 319 ++++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/cmd-db.h |  50 ++++++++
 5 files changed, 380 insertions(+)
 create mode 100644 drivers/soc/qcom/cmd-db.c
 create mode 100644 include/soc/qcom/cmd-db.h

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index c00d81dfac0b..26fb43847f4b 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -494,6 +494,7 @@ EXPORT_SYMBOL_GPL(of_platform_default_populate);
 #ifndef CONFIG_PPC
 static const struct of_device_id reserved_mem_matches[] = {
 	{ .compatible = "qcom,rmtfs-mem" },
+	{ .compatible = "qcom,cmd-db" },
 	{ .compatible = "ramoops" },
 	{}
 };
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e050eb83341d..b12868a2b92d 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -3,6 +3,15 @@
 #
 menu "Qualcomm SoC drivers"
 
+config QCOM_COMMAND_DB
+	bool "Qualcomm Command DB"
+	depends on (ARCH_QCOM && OF) || COMPILE_TEST
+	help
+	  Command DB queries shared memory by key string for shared system
+	  resources. Platform drivers that require to set state of a shared
+	  resource on a RPM-hardened platform must use this database to get
+	  SoC specific identifier and information for the shared resources.
+
 config QCOM_GLINK_SSR
 	tristate "Qualcomm Glink SSR driver"
 	depends on RPMSG
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index dcebf2814e6d..bbd1230fc441 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_GLINK_SSR) +=	glink_ssr.o
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
new file mode 100644
index 000000000000..0792a2a98fc9
--- /dev/null
+++ b/drivers/soc/qcom/cmd-db.c
@@ -0,0 +1,319 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2016-2018, The Linux Foundation. All rights reserved. */
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#include <soc/qcom/cmd-db.h>
+
+#define NUM_PRIORITY		2
+#define MAX_SLV_ID		8
+#define CMD_DB_MAGIC		0x0C0330DBUL
+#define SLAVE_ID_MASK		0x7
+#define SLAVE_ID_SHIFT		16
+
+#define ENTRY_HEADER(hdr)	((void *)cmd_db_header +	\
+				sizeof(*cmd_db_header) +	\
+				hdr->header_offset)
+
+#define RSC_OFFSET(hdr, ent)	((void *)cmd_db_header +	\
+				sizeof(*cmd_db_header) +	\
+				hdr.data_offset + ent.offset)
+
+/**
+ * entry_header: header for each entry in cmddb
+ *
+ * @id: resource's identifier
+ * @priority: unused
+ * @addr: the address of the resource
+ * @len: length of the data
+ * @offset: offset at which data starts
+ */
+struct entry_header {
+	u64 id;
+	u32 priority[NUM_PRIORITY];
+	u32 addr;
+	u16 len;
+	u16 offset;
+};
+
+/**
+ * rsc_hdr: resource header information
+ *
+ * @slv_id: id for the resource
+ * @header_offset: Entry header offset from data
+ * @data_offset: Entry offset for data location
+ * @cnt: number of entries for HW type
+ * @version: MSB is major, LSB is minor
+ */
+struct rsc_hdr {
+	u16 slv_id;
+	u16 header_offset;
+	u16 data_offset;
+	u16 cnt;
+	u16 version;
+	u16 reserved[3];
+};
+
+/**
+ * cmd_db_header: The DB header information
+ *
+ * @version: The cmd db version
+ * @magic_number: constant expected in the database
+ * @header: array of resources
+ * @check_sum: check sum for the header. Unused.
+ * @reserved: reserved memory
+ * @data: driver specific data
+ */
+struct cmd_db_header {
+	u32 version;
+	u32 magic_num;
+	struct rsc_hdr header[MAX_SLV_ID];
+	u32 check_sum;
+	u32 reserved;
+	u8 data[];
+};
+
+/**
+ * DOC: Description of the Command DB database.
+ *
+ * At the start of the command DB memory is the cmd_db_header structure.
+ * The cmd_db_header holds the version, checksum, magic key as well as an
+ * array for header for each slave (depicted by the rsc_header). Each h/w
+ * based accelerator is a 'slave' (shared resource) and has slave id indicating
+ * the type of accelerator. The rsc_header is the header for such individual
+ * slaves of a given type. The entries for each of these slaves begin at the
+ * rsc_hdr.header_offset. In addition each slave could have auxiliary data
+ * that may be needed by the driver. The data for the slave starts at the
+ * entry_header.offset to the location pointed to by the rsc_hdr.data_offset.
+ *
+ * Drivers have a stringified key to a slave/resource. They can query the slave
+ * information and get the slave id and the auxiliary data and the length of the
+ * data. Using this information, they can format the request to be sent to the
+ * h/w accelerator and request a resource state.
+ */
+
+static struct cmd_db_header *cmd_db_header;
+
+/**
+ * cmd_db_ready - Indicates if command DB is available
+ *
+ * Return: 0 on success, errno otherwise
+ */
+int cmd_db_ready(void)
+{
+	if (cmd_db_header == NULL)
+		return -EPROBE_DEFER;
+	else if (cmd_db_header->magic_num != CMD_DB_MAGIC)
+		return -EINVAL;
+	else
+		return 0;
+}
+EXPORT_SYMBOL(cmd_db_ready);
+
+static u64 cmd_db_get_u64_id(const char *id)
+{
+	u64 rsc_id = 0;
+	u8 *ch = (u8 *)&rsc_id;
+	int i;
+
+	for (i = 0; i < sizeof(rsc_id) && id[i]; i++)
+		ch[i] = id[i];
+
+	return rsc_id;
+}
+
+static int cmd_db_get_header(u64 query, struct entry_header *eh,
+			    struct rsc_hdr *rh)
+{
+	struct rsc_hdr *rsc_hdr;
+	struct entry_header *ent;
+	int ret, i, j;
+
+	ret = cmd_db_ready();
+	if (ret)
+		return ret;
+
+	if (!eh || !rh)
+		return -EINVAL;
+
+	for (i = 0; i < MAX_SLV_ID; i++) {
+		rsc_hdr = &cmd_db_header->header[i];
+		if (!rsc_hdr->slv_id)
+			break;
+
+		ent = ENTRY_HEADER(rsc_hdr);
+		for (j = 0; j < rsc_hdr->cnt; j++, ent++) {
+			if (ent->id == query)
+				break;
+		}
+
+		if (j < rsc_hdr->cnt) {
+			memcpy(eh, ent, sizeof(*ent));
+			memcpy(rh, rsc_hdr, sizeof(*rh));
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+static int cmd_db_get_header_by_rsc_id(const char *id,
+				      struct entry_header *ent_hdr,
+				      struct rsc_hdr *rsc_hdr)
+{
+	u64 rsc_id = cmd_db_get_u64_id(id);
+
+	return cmd_db_get_header(rsc_id, ent_hdr, rsc_hdr);
+}
+
+/**
+ * cmd_db_read_addr() - Query command db for resource id address.
+ *
+ *  @id: resource id to query for address
+ *
+ * This is used to retrieve resource address based on resource
+ * id.
+ *  Return: resource address on success, 0 on error
+ */
+u32 cmd_db_read_addr(const char *id)
+{
+	int ret;
+	struct entry_header ent;
+	struct rsc_hdr rsc_hdr;
+
+	ret = cmd_db_get_header_by_rsc_id(id, &ent, &rsc_hdr);
+
+	return ret < 0 ? 0 : ent.addr;
+}
+EXPORT_SYMBOL(cmd_db_read_addr);
+
+/**
+ * cmd_db_read_aux_data() - Query command db for aux data.
+ *
+ *  @id : Resource to retrieve AUX Data on.
+ *  @data : Data buffer to copy returned aux data to. Returns size on NULL
+ *  @len : Caller provides size of data buffer passed in.
+ *
+ *  Return: size of data on success, errno on error
+ */
+int cmd_db_read_aux_data(const char *id, u8 *data, int len)
+{
+	int ret;
+	struct entry_header ent;
+	struct rsc_hdr rsc_hdr;
+
+	if (!data)
+		return -EINVAL;
+
+	ret = cmd_db_get_header_by_rsc_id(id, &ent, &rsc_hdr);
+	if (ret)
+		return ret;
+
+	if (len < ent.len)
+		return -EINVAL;
+
+	len = min_t(u16, ent.len, len);
+	memcpy(data, RSC_OFFSET(rsc_hdr, ent), len);
+
+	return len;
+}
+EXPORT_SYMBOL(cmd_db_read_aux_data);
+
+/**
+ * cmd_db_read_aux_data_len - Get the length of the auxllary data stored in DB.
+ *
+ * @id: Resource to retrieve AUX Data.
+ *
+ * Return: size on success, 0 on error
+ */
+size_t cmd_db_read_aux_data_len(const char *id)
+{
+	int ret;
+	struct entry_header ent;
+	struct rsc_hdr rsc_hdr;
+
+	ret = cmd_db_get_header_by_rsc_id(id, &ent, &rsc_hdr);
+
+	return ret < 0 ? 0 : ent.len;
+}
+EXPORT_SYMBOL(cmd_db_read_aux_data_len);
+
+/**
+ * cmd_db_read_slave_id - Get the slave ID for a given resource address
+ *
+ * @id: Resource id to query the DB for version
+ *
+ * Return: cmd_db_hw_type enum on success, CMD_DB_HW_INVALID on error
+ */
+enum cmd_db_hw_type cmd_db_read_slave_id(const char *id)
+{
+	int ret;
+	struct entry_header ent;
+	struct rsc_hdr rsc_hdr;
+
+	ret = cmd_db_get_header_by_rsc_id(id, &ent, &rsc_hdr);
+
+	return ret < 0 ? CMD_DB_HW_INVALID :
+		       (ent.addr >> SLAVE_ID_SHIFT) & SLAVE_ID_MASK;
+}
+EXPORT_SYMBOL(cmd_db_read_slave_id);
+
+static int cmd_db_dev_probe(struct platform_device *pdev)
+{
+	struct reserved_mem *rmem;
+	void *dict, *start_addr;
+	int ret = 0;
+
+	rmem = of_reserved_mem_lookup(pdev->dev.of_node);
+	if (!rmem) {
+		dev_err(&pdev->dev, "failed to acquire memory region\n");
+		return -EINVAL;
+	}
+
+	dict = devm_memremap(&pdev->dev, rmem->base, rmem->size, MEMREMAP_WB);
+	if (IS_ERR(dict))
+		return -ENOMEM;
+
+	start_addr = memremap(readl_relaxed(dict), readl_relaxed(dict + 0x4),
+			     MEMREMAP_WB);
+	if (IS_ERR_OR_NULL(start_addr)) {
+		ret = PTR_ERR(start_addr);
+		goto done;
+	}
+
+	cmd_db_header = start_addr;
+	if (cmd_db_header->magic_num != CMD_DB_MAGIC) {
+		ret = -EINVAL;
+		dev_err(&pdev->dev, "Invalid Command DB Magic\n");
+		goto done;
+	}
+
+done:
+	devm_memunmap(&pdev->dev, dict);
+	return ret;
+}
+
+static const struct of_device_id cmd_db_match_table[] = {
+	{ .compatible = "qcom,cmd-db" },
+	{ },
+};
+
+static struct platform_driver cmd_db_dev_driver = {
+	.probe  = cmd_db_dev_probe,
+	.driver = {
+		  .name = "cmd-db",
+		  .of_match_table = cmd_db_match_table,
+	},
+};
+
+static int __init cmd_db_device_init(void)
+{
+	return platform_driver_register(&cmd_db_dev_driver);
+}
+arch_initcall(cmd_db_device_init);
diff --git a/include/soc/qcom/cmd-db.h b/include/soc/qcom/cmd-db.h
new file mode 100644
index 000000000000..483d09ea1689
--- /dev/null
+++ b/include/soc/qcom/cmd-db.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2016-2018, The Linux Foundation. All rights reserved. */
+
+#ifndef __QCOM_COMMAND_DB_H__
+#define __QCOM_COMMAND_DB_H__
+
+
+enum cmd_db_hw_type {
+	CMD_DB_HW_INVALID = 0,
+	CMD_DB_HW_MIN = 3,
+	CMD_DB_HW_ARC = CMD_DB_HW_MIN,
+	CMD_DB_HW_VRM = 4,
+	CMD_DB_HW_BCM = 5,
+	CMD_DB_HW_MAX = CMD_DB_HW_BCM,
+	CMD_DB_HW_ALL = 0xff,
+};
+
+#if IS_ENABLED(CONFIG_QCOM_COMMAND_DB)
+u32 cmd_db_read_addr(const char *resource_id);
+int cmd_db_read_aux_data(const char *resource_id, u8 *data, int len);
+size_t cmd_db_read_aux_data_len(const char *resource_id);
+enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id);
+int cmd_db_ready(void);
+#else
+
+static inline u32 cmd_db_read_addr(const char *resource_id)
+{
+	return 0;
+}
+static inline int cmd_db_read_aux_data(const char *resource_id, u8 *data,
+				     int len)
+{
+	return -ENODEV;
+}
+static inline size_t cmd_db_read_aux_data_len(const char *resource_id)
+{
+	return -ENODEV;
+}
+
+static inline enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id)
+{
+	return -ENODEV;
+}
+static inline int cmd_db_ready(void)
+{
+	return -ENODEV;
+}
+
+#endif /* CONFIG_QCOM_COMMAND_DB */
+#endif /* __QCOM_COMMAND_DB_H__ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
