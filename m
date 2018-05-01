Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753576AbeEAFac (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 01:30:32 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34926 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEAFaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 01:30:15 -0400
X-Google-Smtp-Source: AB8JxZpK+sBEkIUvCelEXtnFOEMNg1ic9T6BHvjY3YjcpCJTbLiAU5JbjbKd4vB+gwNpQedvjnmuZg==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>
Subject: [PATCH v3 2/2] nvmem: Add RAVE SP EEPROM driver
Date: Mon, 30 Apr 2018 22:29:52 -0700
Message-Id: <20180501052952.26765-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180501052952.26765-1-andrew.smirnov@gmail.com>
References: <20180501052952.26765-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver providing access to EEPROMs connected to RAVE SP devices

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Aleksander Morgado <aleksander@aleksander.es>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/nvmem/Kconfig          |   6 +
 drivers/nvmem/Makefile         |   3 +
 drivers/nvmem/rave-sp-eeprom.c | 357 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 366 insertions(+)
 create mode 100644 drivers/nvmem/rave-sp-eeprom.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 1090924efdb1..54a3c298247b 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -175,4 +175,10 @@ config NVMEM_SNVS_LPGPR
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-snvs-lpgpr.
 
+config RAVE_SP_EEPROM
+	tristate "Rave SP EEPROM Support"
+	depends on RAVE_SP_CORE
+	help
+	  Say y here to enable Rave SP EEPROM support.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index e54dcfa6565a..27e96a8efd1c 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -37,3 +37,6 @@ obj-$(CONFIG_MESON_MX_EFUSE)	+= nvmem_meson_mx_efuse.o
 nvmem_meson_mx_efuse-y		:= meson-mx-efuse.o
 obj-$(CONFIG_NVMEM_SNVS_LPGPR)	+= nvmem_snvs_lpgpr.o
 nvmem_snvs_lpgpr-y		:= snvs_lpgpr.o
+obj-$(CONFIG_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
+nvmem-rave-sp-eeprom-y		:= rave-sp-eeprom.o
+
diff --git a/drivers/nvmem/rave-sp-eeprom.c b/drivers/nvmem/rave-sp-eeprom.c
new file mode 100644
index 000000000000..50aeea6ec6cc
--- /dev/null
+++ b/drivers/nvmem/rave-sp-eeprom.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * EEPROM driver for RAVE SP
+ *
+ * Copyright (C) 2018 Zodiac Inflight Innovations
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/mfd/rave-sp.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/sizes.h>
+
+/**
+ * enum rave_sp_eeprom_access_type - Supported types of EEPROM access
+ *
+ * @RAVE_SP_EEPROM_WRITE:	EEPROM write
+ * @RAVE_SP_EEPROM_READ:	EEPROM read
+ */
+enum rave_sp_eeprom_access_type {
+	RAVE_SP_EEPROM_WRITE = 0,
+	RAVE_SP_EEPROM_READ  = 1,
+};
+
+/**
+ * enum rave_sp_eeprom_header_size - EEPROM command header sizes
+ *
+ * @RAVE_SP_EEPROM_HEADER_SMALL: EEPROM header size for "small" devices (< 8K)
+ * @RAVE_SP_EEPROM_HEADER_BIG:	 EEPROM header size for "big" devices (> 8K)
+ */
+enum rave_sp_eeprom_header_size {
+	RAVE_SP_EEPROM_HEADER_SMALL = 4U,
+	RAVE_SP_EEPROM_HEADER_BIG   = 5U,
+};
+
+#define	RAVE_SP_EEPROM_PAGE_SIZE	32U
+
+/**
+ * struct rave_sp_eeprom_page - RAVE SP EEPROM page
+ *
+ * @type:	Access type (see enum rave_sp_eeprom_access_type)
+ * @success:	Success flag (Success = 1, Failure = 0)
+ * @data:	Read data
+
+ * Note this structure corresponds to RSP_*_EEPROM payload from RAVE
+ * SP ICD
+ */
+struct rave_sp_eeprom_page {
+	u8  type;
+	u8  success;
+	u8  data[RAVE_SP_EEPROM_PAGE_SIZE];
+} __packed;
+
+/**
+ * struct rave_sp_eeprom - RAVE SP EEPROM device
+ *
+ * @sp:			Pointer to parent RAVE SP device
+ * @mutex:		Lock protecting access to EEPROM
+ * @address:		EEPROM device address
+ * @header_size:	Size of EEPROM command header for this device
+ * @dev:		Pointer to corresponding struct device used for logging
+ */
+struct rave_sp_eeprom {
+	struct rave_sp *sp;
+	struct mutex mutex;
+	u8 address;
+	unsigned int header_size;
+	struct device *dev;
+};
+
+/**
+ * rave_sp_eeprom_io - Low-level part of EEPROM page access
+ *
+ * @eeprom:	EEPROM device to write to
+ * @type:	EEPROM access type (read or write)
+ * @idx:	number of the EEPROM page
+ * @page:	Data to write or buffer to store result (via page->data)
+ *
+ * This function does all of the low-level work required to perform a
+ * EEPROM access. This includes formatting correct command payload,
+ * sending it and checking received results.
+ *
+ * Returns zero in case of success or negative error code in
+ * case of failure.
+ */
+static int rave_sp_eeprom_io(struct rave_sp_eeprom *eeprom,
+			     enum rave_sp_eeprom_access_type type,
+			     u16 idx,
+			     struct rave_sp_eeprom_page *page)
+{
+	const bool is_write = type == RAVE_SP_EEPROM_WRITE;
+	const unsigned int data_size = is_write ? sizeof(page->data) : 0;
+	const unsigned int cmd_size = eeprom->header_size + data_size;
+	const unsigned int rsp_size =
+		is_write ? sizeof(*page) - sizeof(page->data) : sizeof(*page);
+	unsigned int offset = 0;
+	u8 cmd[cmd_size];
+	int ret;
+
+	cmd[offset++] = eeprom->address;
+	cmd[offset++] = 0;
+	cmd[offset++] = type;
+	cmd[offset++] = idx;
+
+	/*
+	 * If there's still room in this command's header it means we
+	 * are talkin to EEPROM that uses 16-bit page numbers and we
+	 * have to specify index's MSB in payload as well.
+	 */
+	if (offset < eeprom->header_size)
+		cmd[offset++] = idx >> 8;
+	/*
+	 * Copy our data to write to command buffer first. In case of
+	 * a read data_size should be zero and memcpy would become a
+	 * no-op
+	 */
+	memcpy(&cmd[offset], page->data, data_size);
+
+	ret = rave_sp_exec(eeprom->sp, cmd, cmd_size, page, rsp_size);
+	if (ret)
+		return ret;
+
+	if (page->type != type)
+		return -EPROTO;
+
+	if (!page->success)
+		return -EIO;
+
+	return 0;
+}
+
+/**
+ * rave_sp_eeprom_page_access - Access single EEPROM page
+ *
+ * @eeprom:	EEPROM device to access
+ * @type:	Access type to perform (read or write)
+ * @offset:	Offset within EEPROM to access
+ * @data:	Data buffer
+ * @data_len:	Size of the data buffer
+ *
+ * This function performs a generic access to a single page or a
+ * portion thereof. Requested access MUST NOT cross the EEPROM page
+ * boundary.
+ *
+ * Returns zero in case of success or negative error code in
+ * case of failure.
+ */
+static int
+rave_sp_eeprom_page_access(struct rave_sp_eeprom *eeprom,
+			   enum rave_sp_eeprom_access_type type,
+			   unsigned int offset, u8 *data,
+			   size_t data_len)
+{
+	const unsigned int page_offset = offset % RAVE_SP_EEPROM_PAGE_SIZE;
+	const unsigned int page_nr     = offset / RAVE_SP_EEPROM_PAGE_SIZE;
+	struct rave_sp_eeprom_page page;
+	int ret;
+
+	/*
+	 * This function will not work if data access we've been asked
+	 * to do is crossing EEPROM page boundary. Normally this
+	 * should never happen and getting here would indicate a bug
+	 * in the code.
+	 */
+	if (WARN_ON(data_len > sizeof(page.data) - page_offset))
+		return -EINVAL;
+
+	if (type == RAVE_SP_EEPROM_WRITE) {
+		/*
+		 * If doing a partial write we need to do a read first
+		 * to fill the rest of the page with correct data.
+		 */
+		if (data_len < RAVE_SP_EEPROM_PAGE_SIZE) {
+			ret = rave_sp_eeprom_io(eeprom, RAVE_SP_EEPROM_READ,
+						page_nr, &page);
+			if (ret)
+				return ret;
+		}
+
+		memcpy(&page.data[page_offset], data, data_len);
+	}
+
+	ret = rave_sp_eeprom_io(eeprom, type, page_nr, &page);
+	if (ret)
+		return ret;
+
+	/*
+	 * Since we receive the result of the read via 'page.data'
+	 * buffer we need to copy that to 'data'
+	 */
+	if (type == RAVE_SP_EEPROM_READ)
+		memcpy(data, &page.data[page_offset], data_len);
+
+	return 0;
+}
+
+/**
+ * rave_sp_eeprom_access - Access EEPROM data
+ *
+ * @eeprom:	EEPROM device to access
+ * @type:	Access type to perform (read or write)
+ * @offset:	Offset within EEPROM to access
+ * @data:	Data buffer
+ * @data_len:	Size of the data buffer
+ *
+ * This function performs a generic access (either read or write) at
+ * arbitrary offset (not necessary page aligned) of arbitrary length
+ * (is not constrained by EEPROM page size).
+ *
+ * Returns zero in case of success or negative error code in case of
+ * failure.
+ */
+static int rave_sp_eeprom_access(struct rave_sp_eeprom *eeprom,
+				 enum rave_sp_eeprom_access_type type,
+				 unsigned int offset, u8 *data,
+				 unsigned int data_len)
+{
+	unsigned int residue;
+	unsigned int chunk;
+	unsigned int head;
+	int ret;
+
+	mutex_lock(&eeprom->mutex);
+
+	head    = offset % RAVE_SP_EEPROM_PAGE_SIZE;
+	residue = data_len;
+
+	do {
+		/*
+		 * First iteration, if we are doing an access that is
+		 * not 32-byte aligned, we need to access only data up
+		 * to a page boundary to avoid corssing it in
+		 * rave_sp_eeprom_page_access()
+		 */
+		if (unlikely(head)) {
+			chunk = RAVE_SP_EEPROM_PAGE_SIZE - head;
+			/*
+			 * This can only happen once per
+			 * rave_sp_eeprom_access() call, so we set
+			 * head to zero to process all the other
+			 * iterations normally.
+			 */
+			head  = 0;
+		} else {
+			chunk = RAVE_SP_EEPROM_PAGE_SIZE;
+		}
+
+		/*
+		 * We should never read more that 'residue' bytes
+		 */
+		chunk = min(chunk, residue);
+		ret = rave_sp_eeprom_page_access(eeprom, type, offset,
+						 data, chunk);
+		if (ret)
+			goto out;
+
+		residue -= chunk;
+		offset  += chunk;
+		data    += chunk;
+	} while (residue);
+out:
+	mutex_unlock(&eeprom->mutex);
+	return ret;
+}
+
+static int rave_sp_eeprom_reg_read(void *eeprom, unsigned int offset,
+				   void *val, size_t bytes)
+{
+	return rave_sp_eeprom_access(eeprom, RAVE_SP_EEPROM_READ,
+				     offset, val, bytes);
+}
+
+static int rave_sp_eeprom_reg_write(void *eeprom, unsigned int offset,
+				    void *val, size_t bytes)
+{
+	return rave_sp_eeprom_access(eeprom, RAVE_SP_EEPROM_WRITE,
+				     offset, val, bytes);
+}
+
+static int rave_sp_eeprom_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rave_sp *sp = dev_get_drvdata(dev->parent);
+	struct device_node *np = dev->of_node;
+	struct nvmem_config config = { 0 };
+	struct rave_sp_eeprom *eeprom;
+	struct nvmem_device *nvmem;
+	u32 reg[2], size;
+
+	if (of_property_read_u32_array(np, "reg", reg, ARRAY_SIZE(reg))) {
+		dev_err(dev, "Failed to parse \"reg\" property\n");
+		return -EINVAL;
+	}
+
+	size = reg[1];
+	/*
+	 * Per ICD, we have no more than 2 bytes to specify EEPROM
+	 * page.
+	 */
+	if (size > U16_MAX * RAVE_SP_EEPROM_PAGE_SIZE) {
+		dev_err(dev, "Specified size is too big\n");
+		return -EINVAL;
+	}
+
+	eeprom = devm_kzalloc(dev, sizeof(*eeprom), GFP_KERNEL);
+	if (!eeprom)
+		return -ENOMEM;
+
+	eeprom->address = reg[0];
+	eeprom->sp      = sp;
+	eeprom->dev     = dev;
+
+	if (size > SZ_8K)
+		eeprom->header_size = RAVE_SP_EEPROM_HEADER_BIG;
+	else
+		eeprom->header_size = RAVE_SP_EEPROM_HEADER_SMALL;
+
+	mutex_init(&eeprom->mutex);
+
+	config.id		= -1;
+	of_property_read_string(np, "zii,eeprom-name", &config.name);
+	config.priv		= eeprom;
+	config.dev		= dev;
+	config.size		= size;
+	config.reg_read		= rave_sp_eeprom_reg_read;
+	config.reg_write	= rave_sp_eeprom_reg_write;
+	config.word_size	= 1;
+	config.stride		= 1;
+
+	nvmem = devm_nvmem_register(dev, &config);
+
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static const struct of_device_id rave_sp_eeprom_of_match[] = {
+	{ .compatible = "zii,rave-sp-eeprom" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rave_sp_eeprom_of_match);
+
+static struct platform_driver rave_sp_eeprom_driver = {
+	.probe = rave_sp_eeprom_probe,
+	.driver	= {
+		.name = KBUILD_MODNAME,
+		.of_match_table = rave_sp_eeprom_of_match,
+	},
+};
+module_platform_driver(rave_sp_eeprom_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>");
+MODULE_AUTHOR("Nikita Yushchenko <nikita.yoush@cogentembedded.com>");
+MODULE_AUTHOR("Andrey Smirnov <andrew.smirnov@gmail.com>");
+MODULE_DESCRIPTION("RAVE SP EEPROM driver");
-- 
2.14.3
