Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeBFP3V (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 10:29:21 -0500
Received: from mail.arcx.com ([184.94.50.18]:52860 "EHLO WEBMAIL.arcx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752159AbeBFP3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 10:29:13 -0500
From: Sven Van Asbroeck <svendev@arcx.com>
To: <svendev@arcx.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <helmut.buchsbaum@gmail.com>, <Maarten.Blomme@flir.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v1 1/1] spi_ks8995: use regmap to access chip registers.
Date: Tue, 6 Feb 2018 10:13:56 -0500
Message-ID: <1517930036-17618-2-git-send-email-svendev@arcx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517930036-17618-1-git-send-email-svendev@arcx.com>
References: <1517930036-17618-1-git-send-email-svendev@arcx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.155]
X-ClientProxiedBy: webmail.arcx.com (192.168.2.64) To WEBMAIL.arcx.com
 (192.168.2.64)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register map layouts used in this driver are well suited to
being accessed through a regmap. This makes the driver simpler
and shorter, by eliminating some spi boilerplate code.

Testing:
- tested on a ksz8785.
- not tested on the other supported chips (ks8995, ksz8864)
  because I don't have access to them.
  However, I instrumented the spi layer to verify that the
  correct spi transactions are generated to read the ID
  registers on those chips.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 drivers/net/phy/spi_ks8995.c | 163 +++++++++++++------------------------------
 1 file changed, 50 insertions(+), 113 deletions(-)

diff --git a/drivers/net/phy/spi_ks8995.c b/drivers/net/phy/spi_ks8995.c
index 1e2d4f1..34223ff 100644
--- a/drivers/net/phy/spi_ks8995.c
+++ b/drivers/net/phy/spi_ks8995.c
@@ -21,6 +21,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/regmap.h>
 
 #include <linux/spi/spi.h>
 
@@ -106,11 +107,27 @@ enum ks8995_chip_variant {
 
 struct ks8995_chip_params {
 	char *name;
+	const struct regmap_config *regmap_cfg;
 	int family_id;
 	int chip_id;
 	int regs_size;
-	int addr_width;
-	int addr_shift;
+};
+
+static const struct regmap_config ksz8795_regmap_cfg = {
+	.reg_bits = 15,
+	.pad_bits = 1,
+	.val_bits = 8,
+	.write_flag_mask = KS8995_CMD_WRITE << 5,
+	.read_flag_mask = KS8995_CMD_READ << 5,
+	/* max_register filled in at runtime */
+};
+
+static const struct regmap_config ks8995_regmap_cfg = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.write_flag_mask = KS8995_CMD_WRITE,
+	.read_flag_mask = KS8995_CMD_READ,
+	/* max_register filled in at runtime */
 };
 
 static const struct ks8995_chip_params ks8995_chip[] = {
@@ -119,24 +136,21 @@ struct ks8995_chip_params {
 		.family_id = FAMILY_KS8995,
 		.chip_id = KS8995_CHIP_ID,
 		.regs_size = KS8995_REGS_SIZE,
-		.addr_width = 8,
-		.addr_shift = 0,
+		.regmap_cfg = &ks8995_regmap_cfg,
 	},
 	[ksz8864] = {
 		.name = "KSZ8864RMN",
 		.family_id = FAMILY_KS8995,
 		.chip_id = KSZ8864_CHIP_ID,
 		.regs_size = KSZ8864_REGS_SIZE,
-		.addr_width = 8,
-		.addr_shift = 0,
+		.regmap_cfg = &ks8995_regmap_cfg,
 	},
 	[ksz8795] = {
 		.name = "KSZ8795CLX",
 		.family_id = FAMILY_KSZ8795,
 		.chip_id = KSZ8795_CHIP_ID,
 		.regs_size = KSZ8795_REGS_SIZE,
-		.addr_width = 12,
-		.addr_shift = 1,
+		.regmap_cfg = &ksz8795_regmap_cfg,
 	},
 };
 
@@ -152,6 +166,7 @@ struct ks8995_switch {
 	struct bin_attribute	regs_attr;
 	const struct ks8995_chip_params	*chip;
 	int			revision_id;
+	struct regmap *regmap;
 };
 
 static const struct spi_device_id ks8995_id[] = {
@@ -162,118 +177,24 @@ struct ks8995_switch {
 };
 MODULE_DEVICE_TABLE(spi, ks8995_id);
 
-static inline u8 get_chip_id(u8 val)
+static inline u8 get_chip_id(u32 val)
 {
 	return (val >> ID1_CHIPID_S) & ID1_CHIPID_M;
 }
 
-static inline u8 get_chip_rev(u8 val)
+static inline u8 get_chip_rev(u32 val)
 {
 	return (val >> ID1_REVISION_S) & ID1_REVISION_M;
 }
 
-/* create_spi_cmd - create a chip specific SPI command header
- * @ks: pointer to switch instance
- * @cmd: SPI command for switch
- * @address: register address for command
- *
- * Different chip families use different bit pattern to address the switches
- * registers:
- *
- * KS8995: 8bit command + 8bit address
- * KSZ8795: 3bit command + 12bit address + 1bit TR (?)
- */
-static inline __be16 create_spi_cmd(struct ks8995_switch *ks, int cmd,
-				    unsigned address)
-{
-	u16 result = cmd;
-
-	/* make room for address (incl. address shift) */
-	result <<= ks->chip->addr_width + ks->chip->addr_shift;
-	/* add address */
-	result |= address << ks->chip->addr_shift;
-	/* SPI protocol needs big endian */
-	return cpu_to_be16(result);
-}
-/* ------------------------------------------------------------------------ */
-static int ks8995_read(struct ks8995_switch *ks, char *buf,
-		 unsigned offset, size_t count)
-{
-	__be16 cmd;
-	struct spi_transfer t[2];
-	struct spi_message m;
-	int err;
-
-	cmd = create_spi_cmd(ks, KS8995_CMD_READ, offset);
-	spi_message_init(&m);
-
-	memset(&t, 0, sizeof(t));
-
-	t[0].tx_buf = &cmd;
-	t[0].len = sizeof(cmd);
-	spi_message_add_tail(&t[0], &m);
-
-	t[1].rx_buf = buf;
-	t[1].len = count;
-	spi_message_add_tail(&t[1], &m);
-
-	mutex_lock(&ks->lock);
-	err = spi_sync(ks->spi, &m);
-	mutex_unlock(&ks->lock);
-
-	return err ? err : count;
-}
-
-static int ks8995_write(struct ks8995_switch *ks, char *buf,
-		 unsigned offset, size_t count)
-{
-	__be16 cmd;
-	struct spi_transfer t[2];
-	struct spi_message m;
-	int err;
-
-	cmd = create_spi_cmd(ks, KS8995_CMD_WRITE, offset);
-	spi_message_init(&m);
-
-	memset(&t, 0, sizeof(t));
-
-	t[0].tx_buf = &cmd;
-	t[0].len = sizeof(cmd);
-	spi_message_add_tail(&t[0], &m);
-
-	t[1].tx_buf = buf;
-	t[1].len = count;
-	spi_message_add_tail(&t[1], &m);
-
-	mutex_lock(&ks->lock);
-	err = spi_sync(ks->spi, &m);
-	mutex_unlock(&ks->lock);
-
-	return err ? err : count;
-}
-
-static inline int ks8995_read_reg(struct ks8995_switch *ks, u8 addr, u8 *buf)
-{
-	return ks8995_read(ks, buf, addr, 1) != 1;
-}
-
-static inline int ks8995_write_reg(struct ks8995_switch *ks, u8 addr, u8 val)
-{
-	char buf = val;
-
-	return ks8995_write(ks, &buf, addr, 1) != 1;
-}
-
-/* ------------------------------------------------------------------------ */
-
 static int ks8995_stop(struct ks8995_switch *ks)
 {
-	return ks8995_write_reg(ks, KS8995_REG_ID1, 0);
+	return regmap_write(ks->regmap, KS8995_REG_ID1, 0);
 }
 
 static int ks8995_start(struct ks8995_switch *ks)
 {
-	return ks8995_write_reg(ks, KS8995_REG_ID1, 1);
+	return regmap_write(ks->regmap, KS8995_REG_ID1, 1);
 }
 
 static int ks8995_reset(struct ks8995_switch *ks)
@@ -294,11 +215,13 @@ static ssize_t ks8995_registers_read(struct file *filp, struct kobject *kobj,
 {
 	struct device *dev;
 	struct ks8995_switch *ks8995;
+	int err;
 
 	dev = container_of(kobj, struct device, kobj);
 	ks8995 = dev_get_drvdata(dev);
 
-	return ks8995_read(ks8995, buf, off, count);
+	err = regmap_bulk_read(ks8995->regmap, off, buf, count);
+	return err ? : count;
 }
 
 static ssize_t ks8995_registers_write(struct file *filp, struct kobject *kobj,
@@ -306,11 +229,13 @@ static ssize_t ks8995_registers_write(struct file *filp, struct kobject *kobj,
 {
 	struct device *dev;
 	struct ks8995_switch *ks8995;
+	int err;
 
 	dev = container_of(kobj, struct device, kobj);
 	ks8995 = dev_get_drvdata(dev);
 
-	return ks8995_write(ks8995, buf, off, count);
+	err = regmap_bulk_write(ks8995->regmap, off, buf, count);
+	return err ? : count;
 }
 
 /* ks8995_get_revision - get chip revision
@@ -321,10 +246,10 @@ static ssize_t ks8995_registers_write(struct file *filp, struct kobject *kobj,
 static int ks8995_get_revision(struct ks8995_switch *ks)
 {
 	int err;
-	u8 id0, id1, ksz8864_id;
+	u32 id0, id1, ksz8864_id;
 
 	/* read family id */
-	err = ks8995_read_reg(ks, KS8995_REG_ID0, &id0);
+	err = regmap_read(ks->regmap, KS8995_REG_ID0, &id0);
 	if (err) {
 		err = -EIO;
 		goto err_out;
@@ -341,7 +266,7 @@ static int ks8995_get_revision(struct ks8995_switch *ks)
 	switch (ks->chip->family_id) {
 	case FAMILY_KS8995:
 		/* try reading chip id at CHIP ID1 */
-		err = ks8995_read_reg(ks, KS8995_REG_ID1, &id1);
+		err = regmap_read(ks->regmap, KS8995_REG_ID1, &id1);
 		if (err) {
 			err = -EIO;
 			goto err_out;
@@ -354,7 +279,8 @@ static int ks8995_get_revision(struct ks8995_switch *ks)
 			ks->revision_id = get_chip_rev(id1);
 		} else if (get_chip_id(id1) != CHIPID_M) {
 			/* KSZ8864RMN */
-			err = ks8995_read_reg(ks, KS8995_REG_ID1, &ksz8864_id);
+			err = regmap_read(ks->regmap, KS8995_REG_ID1,
+					  &ksz8864_id);
 			if (err) {
 				err = -EIO;
 				goto err_out;
@@ -373,7 +299,7 @@ static int ks8995_get_revision(struct ks8995_switch *ks)
 		break;
 	case FAMILY_KSZ8795:
 		/* try reading chip id at CHIP ID1 */
-		err = ks8995_read_reg(ks, KS8995_REG_ID1, &id1);
+		err = regmap_read(ks->regmap, KS8995_REG_ID1, &id1);
 		if (err) {
 			err = -EIO;
 			goto err_out;
@@ -429,6 +355,7 @@ static int ks8995_probe(struct spi_device *spi)
 {
 	struct ks8995_switch *ks;
 	int err;
+	struct regmap_config regmap_cfg;
 	int variant = spi_get_device_id(spi)->driver_data;
 
 	if (variant >= max_variant) {
@@ -487,6 +414,16 @@ static int ks8995_probe(struct spi_device *spi)
 		return err;
 	}
 
+	memcpy(&regmap_cfg, ks->chip->regmap_cfg, sizeof(regmap_cfg));
+	regmap_cfg.max_register = ks->chip->regs_size - 1;
+	ks->regmap = devm_regmap_init_spi(spi, &regmap_cfg);
+	if (IS_ERR(ks->regmap)) {
+		err = PTR_ERR(ks->regmap);
+		dev_err(&spi->dev, "Failed to allocate register map: %d\n",
+			err);
+		return err;
+	}
+
 	err = ks8995_get_revision(ks);
 	if (err)
 		return err;
-- 
1.9.1
