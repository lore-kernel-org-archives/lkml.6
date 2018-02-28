Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeB1LyY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 06:54:24 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:23259 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeB1LyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 06:54:22 -0500
X-IronPort-AV: E=Sophos;i="5.47,405,1515481200";
   d="scan'208";a="12463654"
From: Radu Pirea <radu.pirea@microchip.com>
To: <cyrille.pitchen@wedev4u.fr>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>
CC: Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH] spi-nor: Add support for Atmel Dataflash memories
Date: Wed, 28 Feb 2018 13:55:01 +0200
Message-ID: <1519818901-7116-1-git-send-email-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support in spi-nor for allmost all dataflash memories
supported by old mtd_dataflash driver.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 150 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/mtd/spi-nor.h   |  10 +++
 2 files changed, 158 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d445a4d..4cb3cf7 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -89,6 +89,7 @@ struct flash_info {
 #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip erase */
 #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
 #define USE_CLSR		BIT(14)	/* use CLSR command */
+#define SPI_DATAFLASH		BIT(15) /* Atmel Dataflash memory */
 
 	int	(*quad_enable)(struct spi_nor *nor);
 };
@@ -306,6 +307,20 @@ static int s3an_sr_ready(struct spi_nor *nor)
 	return !!(val & XSR_RDY);
 }
 
+static int dataflash_sr_ready(struct spi_nor *nor)
+{
+	int ret;
+	u8 val;
+
+	ret = nor->read_reg(nor, SPINOR_OP_DFRDSR, &val, 1);
+	if (ret < 0) {
+		dev_err(nor->dev, "error %d reading DFSR\n", ret);
+		return ret;
+	}
+
+	return !!(val & DFSR_RDY);
+}
+
 static inline int spi_nor_sr_ready(struct spi_nor *nor)
 {
 	int sr = read_sr(nor);
@@ -354,6 +369,8 @@ static int spi_nor_ready(struct spi_nor *nor)
 
 	if (nor->flags & SNOR_F_READY_XSR_RDY)
 		sr = s3an_sr_ready(nor);
+	else if (nor->flags & SPI_DATAFLASH)
+		sr = dataflash_sr_ready(nor);
 	else
 		sr = spi_nor_sr_ready(nor);
 	if (sr < 0)
@@ -457,6 +474,44 @@ static loff_t spi_nor_s3an_addr_convert(struct spi_nor *nor, unsigned int addr)
 	return page | offset;
 }
 
+static loff_t spi_nor_dataflash_addr_convert(struct spi_nor *nor,
+					     unsigned int addr)
+{
+	unsigned int offset;
+	unsigned int page;
+	unsigned int page_offset;
+
+	page = addr / nor->page_size;
+	offset = addr % nor->page_size;
+	page_offset = fls(nor->page_size);
+	if (is_power_of_2(nor->page_size))
+		page_offset--;
+
+	return (page << page_offset) | offset;
+}
+
+static int spi_nor_dataflash_erase_sector(struct spi_nor *nor, u32 addr)
+{
+	u32 block_size = 8 * nor->page_size;
+	u32 blocks = nor->mtd.erasesize / block_size;
+	u32 addr_local;
+	u8 buf[SPI_NOR_MAX_ADDR_WIDTH];
+	int i, j;
+
+	for (j = 0; j < blocks; j++) {
+		addr_local = spi_nor_dataflash_addr_convert(nor, addr);
+		for (i = nor->addr_width - 1; i >= 0; i--) {
+			buf[i] = addr_local & 0xff;
+			addr_local >>= 8;
+		}
+		nor->write_reg(nor, nor->erase_opcode, buf, nor->addr_width);
+		addr += block_size;
+		spi_nor_wait_till_ready(nor);
+	}
+
+	return 0;
+}
+
 /*
  * Initiate the erasure of a single sector
  */
@@ -542,7 +597,11 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		while (len) {
 			write_enable(nor);
 
-			ret = spi_nor_erase_sector(nor, addr);
+			if (nor->flags & SPI_DATAFLASH)
+				ret = spi_nor_dataflash_erase_sector(nor, addr);
+			else
+				ret = spi_nor_erase_sector(nor, addr);
+
 			if (ret)
 				goto erase_err;
 
@@ -914,6 +973,20 @@ static int macronix_quad_enable(struct spi_nor *nor);
 		.page_size = 256,					\
 		.flags = (_flags),
 
+#define INFOP(_jedec_id, _ext_id, _sector_size, _n_sectors, _page_size, _flags)	\
+		.id = {							\
+			((_jedec_id) >> 16) & 0xff,			\
+			((_jedec_id) >> 8) & 0xff,			\
+			(_jedec_id) & 0xff,				\
+			((_ext_id) >> 8) & 0xff,			\
+			(_ext_id) & 0xff,				\
+			},						\
+		.id_len = (!(_jedec_id) ? 0 : (3 + ((_ext_id) ? 2 : 0))),	\
+		.sector_size = (_sector_size),				\
+		.n_sectors = (_n_sectors),				\
+		.page_size = _page_size,				\
+		.flags = (_flags),
+
 #define INFO6(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags)	\
 		.id = {							\
 			((_jedec_id) >> 16) & 0xff,			\
@@ -975,7 +1048,14 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32, SECT_4K) },
 	{ "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64, SECT_4K) },
 
-	{ "at45db081d", INFO(0x1f2500, 0, 64 * 1024, 16, SECT_4K) },
+	{ "at45db021d", INFOP(0x1f2300, 0, 512 * 264,  2, 264, SPI_DATAFLASH | NO_CHIP_ERASE) },
+	{ "at45db041d", INFOP(0x1f2400, 0, 256 * 264,  8, 264, SPI_DATAFLASH | NO_CHIP_ERASE) },
+	{ "at45db081d", INFOP(0x1f2500, 0, 256 * 264, 16, 264, SPI_DATAFLASH | NO_CHIP_ERASE) },
+	{ "at45db161d", INFOP(0x1f2600, 0, 256 * 528, 16, 528, SPI_DATAFLASH | NO_CHIP_ERASE) },
+	{ "at45db321d", INFOP(0x1f2700, 0, 128 * 528, 64, 528, SPI_DATAFLASH | NO_CHIP_ERASE) },
+	{ "at45db321d", INFOP(0x1f2701, 0, 128 * 528, 64, 528, SPI_DATAFLASH | NO_CHIP_ERASE) },
+	{ "at45db642d", INFOP(0x1f2800, 0, 256 * 1056, 32, 1056, SPI_DATAFLASH | NO_CHIP_ERASE) },
+	{ "at45db641e", INFOP(0x1f2800, 0x0100, 1024 * 264, 32, 264, SPI_DATAFLASH | NO_CHIP_ERASE) },
 
 	/* EON -- en25xxx */
 	{ "en25f32",    INFO(0x1c3116, 0, 64 * 1024,   64, SECT_4K) },
@@ -1278,6 +1358,9 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 		if (nor->flags & SNOR_F_S3AN_ADDR_DEFAULT)
 			addr = spi_nor_s3an_addr_convert(nor, addr);
 
+		if (nor->flags & SPI_DATAFLASH)
+			addr = spi_nor_dataflash_addr_convert(nor, addr);
+
 		ret = nor->read(nor, addr, len, buf);
 		if (ret == 0) {
 			/* We shouldn't see 0-length reads */
@@ -1379,6 +1462,21 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 	return ret;
 }
 
+static int dataflash_memtobuf(struct spi_nor *nor, u32 addr)
+{
+	u8 buf[SPI_NOR_MAX_ADDR_WIDTH];
+	int i;
+
+	addr = spi_nor_dataflash_addr_convert(nor, addr);
+
+	for (i = nor->addr_width - 1; i >= 0; i--) {
+		buf[i] = addr & 0xff;
+		addr >>= 8;
+	}
+
+	return nor->write_reg(nor, SPINOR_OP_DFMTB, buf, nor->addr_width);
+}
+
 /*
  * Write an address range to the nor chip.  Data must be written in
  * FLASH_PAGESIZE chunks.  The address range may be any size provided
@@ -1420,9 +1518,17 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 		page_remain = min_t(size_t,
 				    nor->page_size - page_offset, len - i);
 
+		if (nor->flags & SPI_DATAFLASH) {
+			dataflash_memtobuf(nor, addr);
+			spi_nor_wait_till_ready(nor);
+		}
+
 		if (nor->flags & SNOR_F_S3AN_ADDR_DEFAULT)
 			addr = spi_nor_s3an_addr_convert(nor, addr);
 
+		if (nor->flags & SPI_DATAFLASH)
+			addr = spi_nor_dataflash_addr_convert(nor, addr);
+
 		write_enable(nor);
 		ret = nor->write(nor, addr, page_remain, buf + i);
 		if (ret < 0)
@@ -1742,6 +1848,37 @@ static int s3an_nor_scan(const struct flash_info *info, struct spi_nor *nor)
 	return 0;
 }
 
+static int dataflash_nor_scan(const struct flash_info *info,
+			      struct spi_nor *nor)
+{
+	int ret;
+	u8 val;
+
+	ret = nor->read_reg(nor, SPINOR_OP_DFRDSR, &val, 1);
+	if (ret < 0) {
+		dev_err(nor->dev, "error reading status register\n");
+		return ret;
+	}
+
+	nor->erase_opcode = SPINOR_OP_DFBE_8k;
+	nor->program_opcode = SPINOR_OP_DFBTOM;
+	nor->read_opcode = SPINOR_OP_DFRD;
+	nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
+
+	if (val & DFSR_PAGESIZE) {
+		/* Flash in Power of 2 mode */
+		nor->mtd.erasesize = nor->mtd.erasesize / nor->page_size *
+		(1 << (fls(nor->page_size) - 1));
+		nor->mtd.size = nor->mtd.erasesize * info->n_sectors;
+		nor->page_size = 1 << (fls(nor->page_size) - 1);
+		nor->mtd.writebufsize = nor->page_size;
+	}
+
+	nor->read_dummy = 32;
+
+	return 0;
+}
+
 struct spi_nor_read_command {
 	u8			num_mode_clocks;
 	u8			num_wait_states;
@@ -2818,6 +2955,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (info->flags & SPI_S3AN)
 		nor->flags |=  SNOR_F_READY_XSR_RDY;
 
+	if (info->flags & SPI_DATAFLASH)
+		nor->flags |= SPI_DATAFLASH;
+
 	/* Parse the Serial Flash Discoverable Parameters table. */
 	ret = spi_nor_init_params(nor, info, &params);
 	if (ret)
@@ -2922,6 +3062,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 			return ret;
 	}
 
+	if (info->flags & SPI_DATAFLASH) {
+		ret = dataflash_nor_scan(info, nor);
+		if (ret)
+			return ret;
+	}
+
 	/* Send all the required SPI flash commands to initialize device */
 	nor->info = info;
 	ret = spi_nor_init(nor);
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index de36969..843edf9 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -91,6 +91,16 @@
 #define SPINOR_OP_WRDI		0x04	/* Write disable */
 #define SPINOR_OP_AAI_WP	0xad	/* Auto address increment word program */
 
+/* Used for Atmel Dataflashes only. */
+#define SPINOR_OP_DFRDSR	0xd7
+#define SPINOR_OP_DFBE_8k	0x50
+#define SPINOR_OP_DFMTB		0x53
+#define SPINOR_OP_DFBTOM	0x82
+#define SPINOR_OP_DFRD		0xe8
+
+#define DFSR_PAGESIZE		BIT(0)	/* Page size in Po2 or Linear */
+#define DFSR_RDY		BIT(7)	/* Ready */
+
 /* Used for S3AN flashes only */
 #define SPINOR_OP_XSE		0x50	/* Sector erase */
 #define SPINOR_OP_XPP		0x82	/* Page program */
-- 
2.7.4
