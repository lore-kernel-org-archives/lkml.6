Return-Path: <sebastian.reichel@collabora.co.uk>
X-Google-Smtp-Source: AG47ELv1p2OnzgpnDS9CPJgeF/Vz7wx+sDnUgKEwYS7aadB/4lTk1QBb75+b1Evq2gs4VArlKAaJ
ARC-Seal: i=1; a=rsa-sha256; t=1521566527; cv=none;
        d=google.com; s=arc-20160816;
        b=Qt5Qb3MPKeDceVaU4SdrSoLOXZHHiq9tNNw+wsCTv5QrV2qXS2QZBFoHVY5NOvYRkI
         gcIgdK5cXg8mXKf9HYJEvI8k0/Oh67LL7gXKP0vvZpWAHwF+wKOR/r6ynoHX+T+RySX1
         hwmtARPnAXJMGNg/PA/IKfewzlq/urPS/xHBW4kne4gDPdMmaph6OFxQO1iu9u1ijMUs
         FMNMEWoUsPBjKQu8Cr24qRV/NswbKT17mU0MIV2KntjZ51xU3ixnkoaq0t/3RK0gPx/U
         TJ18OVxb5rLnCYm9etlrOf7Io2dOtbly1RYuXlMYQNifs50dzb1B1tvQUiNjzndRTWPh
         wQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=27Jri2FNaut6dRb+Z05nzy6/O/TcYMgxdW1moGK9jSk=;
        b=Xnm4m4Zl8tlnxEJOzKAsunhtfOEyE9WTvbepPgr+4I8K0LoG2gM/vD1ZBwIR7+v6Nn
         NBx6OkOPADtkfXmkNpi/8Zd7lqpUmWFjdUJRvhcjMrg7dJWoNPHPEemvhkOvSlLo7Olv
         h76Wbht5sQnVyFaclS9L7tuSt4ptOu071+NpfNFVfYWUgX2PHjfelTYBtvGGJoaEygS0
         W0j8s6F+PfmjWgEQJajDumKOl+pUjMwo1DlHTcGjE+6CtqiqPqyw3EU6SrFzvkYmghD6
         LtBaAtLxTPb4w9PKTC4YuvBaGr/KF1ltOYv5WDkAKBklM/YZh6cALkuxDBn2ycoWtc12
         Q2sA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 46.235.227.227 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 46.235.227.227 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Nandor Han <nandor.han@ge.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 1/2] misc: ezport-firmware: new driver
Date: Tue, 20 Mar 2018 18:22:00 +0100
Message-Id: <20180320172201.2065-2-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320172201.2065-1-sebastian.reichel@collabora.co.uk>
References: <20180320172201.2065-1-sebastian.reichel@collabora.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595478143332183310?=
X-GMAIL-MSGID: =?utf-8?q?1595478143332183310?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

General Electric Healthcare's PPD has a secondary processor from
NXP's Kinetis K20 series. It's firmware can be updated from Linux
using the EzPort interface. This driver implements the firmware
updating process.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 Documentation/devicetree/bindings/misc/ge-achc.txt |  19 +-
 drivers/misc/Kconfig                               |   9 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/ezport-firmware.c                     | 487 +++++++++++++++++++++
 4 files changed, 513 insertions(+), 3 deletions(-)
 create mode 100644 drivers/misc/ezport-firmware.c

diff --git a/Documentation/devicetree/bindings/misc/ge-achc.txt b/Documentation/devicetree/bindings/misc/ge-achc.txt
index 77df94d7a32f..6c6bd6568504 100644
--- a/Documentation/devicetree/bindings/misc/ge-achc.txt
+++ b/Documentation/devicetree/bindings/misc/ge-achc.txt
@@ -7,7 +7,13 @@ Note: This device does not expose the peripherals as USB devices.
 
 Required properties:
 
-- compatible : Should be "ge,achc"
+- compatible : Should be
+  "ge,achc" (normal interface)
+  "ge,achc-ezport" (flashing interface)
+
+Required properties (flashing interface only):
+
+- reset-gpios: GPIO Specifier for the reset GPIO
 
 Required SPI properties:
 
@@ -19,8 +25,15 @@ Required SPI properties:
 
 Example:
 
-spidev0: spi@0 {
-	compatible = "ge,achc";
+spidev1: spi@0 {
+	compatible = "ge,achc-ezport";
 	reg = <0>;
+	spi-max-frequency = <300000>;
+	reset-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+};
+
+spidev0: spi@1 {
+	compatible = "ge,achc";
+	reg = <1>;
 	spi-max-frequency = <1000000>;
 };
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 03605f8fc0dc..841249111204 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -92,6 +92,15 @@ config DUMMY_IRQ
 	  The sole purpose of this module is to help with debugging of systems on
 	  which spurious IRQs would happen on disabled IRQ vector.
 
+config EZPORT_FW
+	tristate "Kinetis K20 EzPort firmware update support
+	depends on SPI && SYSFS && OF
+	select FW_LOADER
+	---help---
+	  EzPort is the flash interface from NXP Kinetis K20, that can be used to
+	  access the microcontroller's flash memory. This driver supports flashing
+	  a new image using the kernel's firmware API.
+
 config IBM_ASM
 	tristate "Device driver for IBM RSA service processor"
 	depends on X86 && PCI && INPUT
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c3c8624f4d95..61eb228d2a7b 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_INTEL_MID_PTI)	+= pti.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
 obj-$(CONFIG_ATMEL_TCLIB)	+= atmel_tclib.o
 obj-$(CONFIG_DUMMY_IRQ)		+= dummy-irq.o
+obj-$(CONFIG_EZPORT_FW)		+= ezport-firmware.o
 obj-$(CONFIG_ICS932S401)	+= ics932s401.o
 obj-$(CONFIG_LKDTM)		+= lkdtm.o
 obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
diff --git a/drivers/misc/ezport-firmware.c b/drivers/misc/ezport-firmware.c
new file mode 100644
index 000000000000..069981b13e69
--- /dev/null
+++ b/drivers/misc/ezport-firmware.c
@@ -0,0 +1,487 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NXP Kinetis EzPort is a flash interface found on NXP microcontrollers
+ * from the Kinetis K20 series. It can be used to update the firmware.
+ * The interface is enabled by enabling the chip-select while resetting
+ * the processor.
+ *
+ * Copyright (C) 2018 Collabora
+ * Copyright (C) 2018 GE Healthcare
+ */
+
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/gpio/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/of_device.h>
+
+#define EZPORT_SPI_RESET_DELAY_MS 50
+#define EZPORT_SPI_POST_RESET_DELAY_MS 500
+#define EZPORT_TRANSFER_SIZE 2048
+
+#define EZPORT_CMD_SP		0x02 /* flash section program*/
+#define EZPORT_CMD_RDSR		0x05 /* read status register */
+#define EZPORT_CMD_WREN		0x06 /* write enable */
+#define EZPORT_CMD_FAST_READ	0x0b /* flash read data at high speed */
+#define EZPORT_CMD_RESET	0xb9 /* reset chip */
+#define EZPORT_CMD_BE		0xc7 /* bulk erase */
+#define EZPORT_CMD_SE		0xd8 /* sector erase */
+
+#define EZPORT_DUMMY		0x00
+
+#define EZPORT_FAST_READ_SIZE	5
+#define EZPORT_SP_SIZE		4
+
+#define EZPORT_SECTOR_SIZE	4096
+#define EZPORT_SECTOR_MASK	(EZPORT_SECTOR_SIZE - 1)
+#define EZPORT_WRITE_WAIT_MS	50
+
+#define EZPORT_STATUS_WIP	BIT(0) /* write in progress */
+#define EZPORT_STATUS_WEN	BIT(1) /* write enable */
+#define EZPORT_STATUS_WEF	BIT(6) /* write error flag */
+#define EZPORT_STATUS_FS	BIT(7) /* flash security */
+
+struct ezport_device_info {
+	const char *fwname;
+	u32 flash_size;
+};
+
+/* https://www.nxp.com/part/MK20FN1M0VMD12 */
+static const struct ezport_device_info data_ge_achc = {
+	.fwname = "gehc-achc.fw",
+	.flash_size = 1024*1024,
+};
+
+static int ezport_acquire(struct spi_device *spi,
+			  struct gpio_desc *reset)
+{
+	struct spi_message msg;
+	struct spi_transfer assert_cs = {
+		.cs_change   = 1,
+	};
+	struct spi_transfer release_cs = { };
+	int ret;
+
+	spi_bus_lock(spi->master);
+
+	/* assert chip select */
+	spi_message_init(&msg);
+	spi_message_add_tail(&assert_cs, &msg);
+	ret = spi_sync_locked(spi, &msg);
+	if (ret)
+		goto fail;
+
+	/* reset to return into normal mode */
+	gpiod_set_value(reset, 1);
+	msleep(EZPORT_SPI_RESET_DELAY_MS);
+	gpiod_set_value(reset, 0);
+
+	msleep(EZPORT_SPI_POST_RESET_DELAY_MS);
+
+	/* release chip select */
+	spi_message_init(&msg);
+	spi_message_add_tail(&release_cs, &msg);
+	ret = spi_sync_locked(spi, &msg);
+
+fail:
+	spi_bus_unlock(spi->master);
+	return ret;
+}
+
+static void ezport_release(struct gpio_desc *reset)
+{
+	/* reset without chip select to return into normal mode */
+	gpiod_set_value(reset, 1);
+	msleep(EZPORT_SPI_RESET_DELAY_MS);
+	gpiod_set_value(reset, 0);
+
+	msleep(EZPORT_SPI_POST_RESET_DELAY_MS);
+}
+
+static inline int ezport_get_status_register(struct spi_device *spi)
+{
+	return spi_w8r8(spi, EZPORT_CMD_RDSR);
+}
+
+static bool ezport_ready(int statusreg, bool write)
+{
+	if (statusreg < 0)
+		return false;
+	if (statusreg & EZPORT_STATUS_WIP)
+		return false;
+	if (statusreg & EZPORT_STATUS_WEF)
+		return false;
+	if (statusreg & EZPORT_STATUS_FS)
+		return false;
+	if (write && !(statusreg & EZPORT_STATUS_WEN))
+		return false;
+
+	return true;
+}
+
+static int ezport_wait_write(struct spi_device *spi)
+{
+	int ret;
+	u32 i;
+
+	/*
+	 * poll status for write in progress bit. It usually needs 100ms
+	 * to get cleared, but we wait 250ms to be sure.
+	 */
+	for (i = 0; i < 5; i++) {
+		ret = ezport_get_status_register(spi);
+		if (ret < 0)
+			return ret;
+		if (!(ret & EZPORT_STATUS_WIP))
+			break;
+		msleep(EZPORT_WRITE_WAIT_MS);
+	}
+
+	return ret;
+}
+
+static int ezport_write_enable(struct spi_device *spi)
+{
+	static const u8 cmd = EZPORT_CMD_WREN;
+	int ret;
+
+	ret = spi_write(spi, &cmd, 1);
+	if (ret < 0)
+		return ret;
+
+	return ezport_get_status_register(spi);
+}
+
+static int ezport_bulk_erase(struct spi_device *spi)
+{
+	int ret;
+	static const u8 cmd = EZPORT_CMD_BE;
+
+	ret = ezport_write_enable(spi);
+	if (ret < 0)
+		return ret;
+
+	if (!(ret & EZPORT_STATUS_WEN))
+		return -EIO;
+
+	ret = spi_write(spi, &cmd, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = ezport_wait_write(spi);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int ezport_section_erase(struct spi_device *spi, u32 address)
+{
+	u8 query[] = {EZPORT_CMD_SE, address >> 16, address >> 8, address};
+	int ret;
+
+	if (address & EZPORT_SECTOR_MASK)
+		return -EINVAL;
+
+	ret = ezport_write_enable(spi);
+	if (ret < 0)
+		return ret;
+
+	ret = spi_write(spi, query, ARRAY_SIZE(query));
+	if (ret < 0)
+		return ret;
+
+	return ezport_wait_write(spi);
+}
+
+static int ezport_flash_transfer(struct spi_device *spi, u32 address,
+				 const u8 *payload, size_t size)
+{
+	struct spi_transfer xfers[2] = {};
+	u8 *query;
+	int ret;
+
+	query = kmalloc(EZPORT_SP_SIZE, GFP_KERNEL);
+	if (!query)
+		return -ENOMEM;
+
+	query[0] = EZPORT_CMD_SP;
+	query[1] = address >> 16;
+	query[2] = address >> 8;
+	query[3] = address >> 0;
+
+	xfers[0].len = EZPORT_SP_SIZE;
+	xfers[0].tx_buf = query;
+
+	xfers[1].len = size;
+	xfers[1].tx_buf = payload;
+
+	ret = spi_sync_transfer(spi, xfers, 2);
+
+	kfree(query);
+
+	if (ret < 0)
+		return ret;
+
+	return ezport_wait_write(spi);
+}
+
+static int ezport_read_data(struct spi_device *spi, u32 address,
+			    u8 *buffer, size_t size)
+{
+	struct spi_transfer xfers[2] = {};
+	u8 *query = kmalloc(EZPORT_FAST_READ_SIZE, GFP_KERNEL);
+	int ret;
+
+	if (!query)
+		return -ENOMEM;
+
+	query[0] = EZPORT_CMD_FAST_READ;
+	query[1] = address >> 16;
+	query[2] = address >> 8;
+	query[3] = address >> 0;
+	query[4] = EZPORT_DUMMY;
+
+	xfers[0].len = EZPORT_FAST_READ_SIZE;
+	xfers[0].tx_buf = query;
+
+	xfers[1].len = size;
+	xfers[1].rx_buf = buffer;
+
+	ret = spi_sync_transfer(spi, xfers, 2);
+
+	kfree(query);
+
+	return ret;
+}
+
+static int ezport_firmware_flash_data(struct spi_device *spi,
+				      const u8 *data, size_t size)
+{
+	int ret;
+	u32 address = 0;
+	u32 transfer_size;
+
+	ret = ezport_get_status_register(spi);
+	if (ret < 0)
+		return ret;
+
+	if (ret & EZPORT_STATUS_FS) {
+		dev_dbg(&spi->dev, "bulk erase");
+		ret = ezport_bulk_erase(spi);
+		if (!ezport_ready(ret, false))
+			return ret;
+	}
+
+	ret = ezport_get_status_register(spi);
+	if (!ezport_ready(ret, false)) {
+		dev_err(&spi->dev, "flash memory is not ready!");
+		return ret;
+	}
+
+	while (address < size) {
+		if (!(address & EZPORT_SECTOR_MASK)) {
+			dev_dbg(&spi->dev, "section erase: %x", address);
+			ret = ezport_section_erase(spi, address);
+			if (!ezport_ready(ret, false))
+				return ret;
+		}
+
+		ret = ezport_write_enable(spi);
+		if (!ezport_ready(ret, true))
+			return ret;
+
+		transfer_size = min((u32) EZPORT_TRANSFER_SIZE, size - address);
+
+		dev_dbg(&spi->dev, "transfer: %x", address);
+		ret = ezport_flash_transfer(spi, address,
+					    data+address, transfer_size);
+		if (!ezport_ready(ret, false))
+			return ret;
+
+		address += transfer_size;
+	}
+
+	return 0;
+}
+
+static int ezport_firmware_verify_data(struct spi_device *spi,
+				       const u8 *data, size_t size)
+{
+	u32 transfer_size;
+	u32 address = 0;
+	u8 *buffer;
+	int ret;
+
+	ret = ezport_get_status_register(spi);
+	if (!ezport_ready(ret, false)) {
+		dev_err(&spi->dev, "flash not ready: %d\n", ret);
+		return -EBUSY;
+	}
+
+	buffer = kmalloc(EZPORT_TRANSFER_SIZE, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	while (address < size) {
+		transfer_size = min((u32) EZPORT_TRANSFER_SIZE, size - address);
+
+		ret = ezport_read_data(spi, address, buffer, transfer_size);
+		if (ret < 0)
+			goto exit_free_buffer;
+
+		ret = memcmp(data + address, buffer, transfer_size);
+		if (ret) {
+			ret = -EBADMSG;
+			goto exit_free_buffer;
+		}
+
+		address += transfer_size;
+	}
+
+exit_free_buffer:
+	kfree(buffer);
+	return ret;
+}
+
+static int ezport_flash(struct spi_device *spi, bool verify)
+{
+	struct ezport_device_info *data = spi_get_drvdata(spi);
+	const struct firmware *fw;
+	struct gpio_desc *reset;
+	int ret;
+
+	ret = request_firmware(&fw, data->fwname, &spi->dev);
+	if (ret) {
+		dev_err(&spi->dev, "Could not get firmware: %d\n", ret);
+		return ret;
+	}
+
+	if (fw->size > data->flash_size) {
+		dev_err(&spi->dev, "FW image does not fit into flash memory!\n");
+		ret = -EFBIG;
+		goto exit_release_fw;
+	}
+
+	reset = gpiod_get(&spi->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset)) {
+		ret = PTR_ERR(reset);
+		dev_err(&spi->dev, "Could not get reset gpio: %d\n", ret);
+		goto exit_release_fw;
+	}
+
+	ret = ezport_acquire(spi, reset);
+	if (ret)
+		goto exit_release_gpio;
+
+	if (verify)
+		ret = ezport_firmware_verify_data(spi, fw->data, fw->size);
+	else
+		ret = ezport_firmware_flash_data(spi, fw->data, fw->size);
+
+	if (ret > 0) {
+		dev_err(&spi->dev, "Failure, Status Register: 0x%02x\n", ret);
+		ret = -EIO;
+	}
+
+	ezport_release(reset);
+
+exit_release_gpio:
+	gpiod_put(reset);
+exit_release_fw:
+	release_firmware(fw);
+	return ret;
+}
+
+static ssize_t verify_fw_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	static const char *success = "Firmware matches!\n";
+	static const char *failure = "Firmware does not match!\n";
+	struct spi_device *spi = to_spi_device(dev);
+	int ret = ezport_flash(spi, true);
+
+	if (ret == 0) {
+		strcpy(buf, success);
+		return strlen(success);
+	} else if (ret == -EBADMSG) {
+		strcpy(buf, failure);
+		return strlen(failure);
+	} else {
+		return ret;
+	}
+}
+
+static ssize_t update_fw_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	int ret;
+
+	dev_dbg(dev, "Firmware update started!");
+	ret = ezport_flash(spi, false);
+	if (!ret)
+		dev_dbg(dev, "Firmware update finished!");
+
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR_WO(update_fw);
+static DEVICE_ATTR_RO(verify_fw);
+
+static struct attribute *ezport_attrs[] = {
+	&dev_attr_update_fw.attr,
+	&dev_attr_verify_fw.attr,
+	NULL
+};
+
+static const struct attribute_group ezport_attr_group = {
+	.attrs = ezport_attrs,
+};
+
+static int ezport_probe(struct spi_device *spi)
+{
+	const struct ezport_device_info *data;
+	struct ezport_device_info *copy;
+	int ret;
+
+	data = of_device_get_match_data(&spi->dev);
+	if (!data)
+		return -ENODEV;
+
+	copy = devm_kmemdup(&spi->dev, data, sizeof(*data), GFP_KERNEL);
+	if (!copy)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, copy);
+
+	ret = devm_device_add_group(&spi->dev, &ezport_attr_group);
+	if (ret) {
+		dev_err(&spi->dev, "create sysfs failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id ezport_of_match[] = {
+	{ .compatible = "ge,achc-ezport", .data = &data_ge_achc, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ezport_of_match);
+
+static struct spi_driver ezport_fw_spi_driver = {
+	.driver = {
+		.name	= "ezport-fw",
+		.of_match_table = ezport_of_match,
+	},
+	.probe		= ezport_probe,
+};
+module_spi_driver(ezport_fw_spi_driver);
+
+MODULE_DESCRIPTION("Kinetis EzPort firmware driver");
+MODULE_AUTHOR("Sebastian Reichel <sebastian.reichel@collabora.co.uk>");
+MODULE_LICENSE("GPL");
-- 
2.16.2
