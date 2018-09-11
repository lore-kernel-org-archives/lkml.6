Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EB5C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027F520866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027F520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeIKUkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:40:15 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:65478 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbeIKUkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:40:14 -0400
X-IronPort-AV: E=Sophos;i="5.53,360,1531810800"; 
   d="scan'208";a="20470922"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Sep 2018 08:40:22 -0700
Received: from localhost.localdomain.com (10.10.76.4) by
 chn-sv-exch04.mchp-main.com (10.10.76.105) with Microsoft SMTP Server id
 14.3.352.0; Tue, 11 Sep 2018 08:40:21 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <cyrille.pitchen@microchip.com>,
        <nicolas.ferre@microchip.com>, <Cristian.Birsan@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 2/2] mtd: spi-nor: parse SFDP Sector Map Parameter Table
Date:   Tue, 11 Sep 2018 18:40:07 +0300
Message-ID: <20180911154007.17195-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20180911154007.17195-1-tudor.ambarus@microchip.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the SFDP (JESD216B) Sector Map Parameter Table. This
table is optional, but when available, we parse it to identify the
location and size of sectors within the main data array of the
flash memory device and to identify which Erase Types are supported by
each sector.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 316 +++++++++++++++++++++++++++++++++++++++---
 include/linux/mtd/spi-nor.h   |  12 ++
 2 files changed, 312 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 4687345..fbefcdb 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2179,6 +2179,35 @@ spi_nor_set_pp_settings(struct spi_nor_pp_command *pp,
  */
 
 /**
+ * spi_nor_read_raw() - raw read of serial flash memory. read_opcode,
+ * addr_width and read_dummy members of the struct spi_nor should be previously
+ * set.
+ * @nor:	pointer to a 'struct spi_nor'
+ * @addr:	offset in the serial flash memory
+ * @len:	number of bytes to read
+ * @buf:	buffer where the data is copied into
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_read_raw(struct spi_nor *nor, u32 addr, size_t len, u8 *buf)
+{
+	int ret;
+
+	while (len) {
+		ret = nor->read(nor, addr, len, buf);
+		if (!ret || ret > len)
+			return -EIO;
+		if (ret < 0)
+			return ret;
+
+		buf += ret;
+		addr += ret;
+		len -= ret;
+	}
+	return 0;
+}
+
+/**
  * spi_nor_read_sfdp() - read Serial Flash Discoverable Parameters.
  * @nor:	pointer to a 'struct spi_nor'
  * @addr:	offset in the SFDP area to start reading data from
@@ -2205,22 +2234,8 @@ static int spi_nor_read_sfdp(struct spi_nor *nor, u32 addr,
 	nor->addr_width = 3;
 	nor->read_dummy = 8;
 
-	while (len) {
-		ret = nor->read(nor, addr, len, (u8 *)buf);
-		if (!ret || ret > len) {
-			ret = -EIO;
-			goto read_err;
-		}
-		if (ret < 0)
-			goto read_err;
-
-		buf += ret;
-		addr += ret;
-		len -= ret;
-	}
-	ret = 0;
+	ret = spi_nor_read_raw(nor, addr, len, buf);
 
-read_err:
 	nor->read_opcode = read_opcode;
 	nor->addr_width = addr_width;
 	nor->read_dummy = read_dummy;
@@ -2777,6 +2792,275 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	return 0;
 }
 
+#define SMPT_CMD_ADDRESS_LEN_MASK		GENMASK(23, 22)
+#define SMPT_CMD_ADDRESS_LEN_0			(0x0UL << 22)
+#define SMPT_CMD_ADDRESS_LEN_3			(0x1UL << 22)
+#define SMPT_CMD_ADDRESS_LEN_4			(0x2UL << 22)
+#define SMPT_CMD_ADDRESS_LEN_USE_CURRENT	(0x3UL << 22)
+
+#define SMPT_CMD_READ_DUMMY_MASK		GENMASK(19, 16)
+#define SMPT_CMD_READ_DUMMY_SHIFT		16
+#define SMPT_CMD_READ_DUMMY(_cmd) \
+	(((_cmd) & SMPT_CMD_READ_DUMMY_MASK) >> SMPT_CMD_READ_DUMMY_SHIFT)
+#define SMPT_CMD_READ_DUMMY_IS_VARIABLE		0xfUL
+
+#define SMPT_CMD_READ_DATA_MASK			GENMASK(31, 24)
+#define SMPT_CMD_READ_DATA_SHIFT		24
+#define SMPT_CMD_READ_DATA(_cmd) \
+	(((_cmd) & SMPT_CMD_READ_DATA_MASK) >> SMPT_CMD_READ_DATA_SHIFT)
+
+#define SMPT_CMD_OPCODE_MASK			GENMASK(15, 8)
+#define SMPT_CMD_OPCODE_SHIFT			8
+#define SMPT_CMD_OPCODE(_cmd) \
+	(((_cmd) & SMPT_CMD_OPCODE_MASK) >> SMPT_CMD_OPCODE_SHIFT)
+
+#define SMPT_MAP_REGION_COUNT_MASK		GENMASK(23, 16)
+#define SMPT_MAP_REGION_COUNT_SHIFT		16
+#define SMPT_MAP_REGION_COUNT(_header) \
+	((((_header) & SMPT_MAP_REGION_COUNT_MASK) >> \
+	  SMPT_MAP_REGION_COUNT_SHIFT) + 1)
+
+#define SMPT_MAP_ID_MASK			GENMASK(15, 8)
+#define SMPT_MAP_ID_SHIFT			8
+#define SMPT_MAP_ID(_header) \
+	(((_header) & SMPT_MAP_ID_MASK) >> SMPT_MAP_ID_SHIFT)
+
+#define SMPT_MAP_REGION_SIZE_MASK		GENMASK(31, 8)
+#define SMPT_MAP_REGION_SIZE_SHIFT		8
+#define SMPT_MAP_REGION_SIZE(_region) \
+	(((((_region) & SMPT_MAP_REGION_SIZE_MASK) >> \
+	   SMPT_MAP_REGION_SIZE_SHIFT) + 1) * 256)
+
+#define SMPT_MAP_REGION_ERASE_TYPE_MASK		GENMASK(3, 0)
+#define SMPT_MAP_REGION_ERASE_TYPE(_region) \
+	((_region) & SMPT_MAP_REGION_ERASE_TYPE_MASK)
+
+#define SMPT_DESC_TYPE_MAP			BIT(1)
+#define SMPT_DESC_END				BIT(0)
+
+/*
+ * spi_nor_smpt_addr_width() - return the address width used in the
+ * configuration detection command.
+ * @nor:	pointer to a 'struct spi_nor'
+ * @settings:	configuration detection command descriptor, dword1
+ */
+static u8 spi_nor_smpt_addr_width(const struct spi_nor *nor, const u32 settings)
+{
+	switch (settings & SMPT_CMD_ADDRESS_LEN_MASK) {
+	case SMPT_CMD_ADDRESS_LEN_0:
+		return 0;
+	case SMPT_CMD_ADDRESS_LEN_3:
+		return 3;
+	case SMPT_CMD_ADDRESS_LEN_4:
+		return 4;
+	case SMPT_CMD_ADDRESS_LEN_USE_CURRENT:
+		/* fall through */
+	default:
+		return nor->addr_width;
+	}
+}
+
+/*
+ * spi_nor_smpt_read_dummy() - return the configuration detection command read
+ * latency, in clock cycles.
+ * @nor:	pointer to a 'struct spi_nor'
+ * @settings:	configuration detection command descriptor, dword1
+ */
+static u8 spi_nor_smpt_read_dummy(const struct spi_nor *nor, const u32 settings)
+{
+	u8 read_dummy = SMPT_CMD_READ_DUMMY(settings);
+
+	if (read_dummy == SMPT_CMD_READ_DUMMY_IS_VARIABLE)
+		return nor->read_dummy;
+	return read_dummy;
+}
+
+/*
+ * spi_nor_get_map_in_use() - get the configuration map in use
+ * @nor:	pointer to a 'struct spi_nor'
+ * @smpt:	pointer to the sector map parameter table
+ */
+static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
+{
+	const u32 *ret = NULL;
+	u32 i, addr;
+	int err;
+	u8 addr_width, read_opcode, read_dummy;
+	u8 read_data_mask, data_byte, map_id;
+
+	addr_width = nor->addr_width;
+	read_dummy = nor->read_dummy;
+	read_opcode = nor->read_opcode;
+
+	map_id = 0;
+	i = 0;
+	/* Determine if there are any optional Detection Command Descriptors */
+	while (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
+		read_data_mask = SMPT_CMD_READ_DATA(smpt[i]);
+		nor->addr_width = spi_nor_smpt_addr_width(nor, smpt[i]);
+		nor->read_dummy = spi_nor_smpt_read_dummy(nor, smpt[i]);
+		nor->read_opcode = SMPT_CMD_OPCODE(smpt[i]);
+		addr = smpt[i + 1];
+
+		err = spi_nor_read_raw(nor, addr, 1, &data_byte);
+		if (err)
+			goto out;
+
+		/*
+		 * Build an index value that is used to select the Sector Map
+		 * Configuration that is currently in use.
+		 */
+		map_id = map_id << 1 | !!(data_byte & read_data_mask);
+		i = i + 2;
+	}
+
+	/* Find the matching configuration map */
+	while (SMPT_MAP_ID(smpt[i]) != map_id) {
+		if (smpt[i] & SMPT_DESC_END)
+			goto out;
+		/* increment the table index to the next map */
+		i += SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
+	}
+
+	ret = smpt + i;
+	/* fall through */
+out:
+	nor->addr_width = addr_width;
+	nor->read_dummy = read_dummy;
+	nor->read_opcode = read_opcode;
+	return ret;
+}
+
+/*
+ * spi_nor_region_check_overlay() - set overlay bit when the region is overlaid
+ * @region:	pointer to a structure that describes a SPI NOR erase region
+ * @erase:	pointer to a structure that describes a SPI NOR erase type
+ * @erase_type:	erase type bitmask
+ */
+static void
+spi_nor_region_check_overlay(struct spi_nor_erase_region *region,
+			     const struct spi_nor_erase_type *erase,
+			     const u8 erase_type)
+{
+	int i;
+
+	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++) {
+		if (!(erase_type & BIT(i)))
+			continue;
+		if (region->size & erase[i].size_mask) {
+			spi_nor_region_mark_overlay(region);
+			return;
+		}
+	}
+}
+
+/*
+ * spi_nor_init_non_uniform_erase_map() - initialize the non-uniform erase map
+ * @nor:	pointer to a 'struct spi_nor'
+ * @smpt:	pointer to the sector map parameter table
+ *
+ * Returns 0 on success, -errno otherwise.
+ */
+static int spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
+					      const u32 *smpt)
+{
+	struct spi_nor_erase_map *map = &nor->erase_map;
+	const struct spi_nor_erase_type *erase = map->erase_type;
+	struct spi_nor_erase_region *region;
+	u64 offset;
+	u32 region_count;
+	int i, j;
+	u8 erase_type;
+
+	region_count = SMPT_MAP_REGION_COUNT(*smpt);
+	/*
+	 * The regions will be freed when the driver detaches from the
+	 * device.
+	 */
+	region = devm_kcalloc(nor->dev, region_count, sizeof(*region),
+			      GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+	map->regions = region;
+
+	map->uniform_erase_type = 0xff;
+	offset = 0;
+	/* Populate regions. */
+	for (i = 0; i < region_count; i++) {
+		j = i + 1; /* index for the region dword */
+		region[i].size = SMPT_MAP_REGION_SIZE(smpt[j]);
+		erase_type = SMPT_MAP_REGION_ERASE_TYPE(smpt[j]);
+		region[i].offset = offset | erase_type;
+
+		spi_nor_region_check_overlay(&region[i], erase, erase_type);
+
+		/*
+		 * Save the erase types that are supported in all regions and
+		 * can erase the entire flash memory.
+		 */
+		map->uniform_erase_type &= erase_type;
+
+		offset = (region[i].offset & ~SNOR_ERASE_FLAGS_MASK) +
+			 region[i].size;
+	}
+
+	spi_nor_region_mark_end(&region[i - 1]);
+
+	return 0;
+}
+
+/*
+ * spi_nor_parse_smpt() - parse Sector Map Parameter Table
+ * @nor:		pointer to a 'struct spi_nor'
+ * @smpt_header:	sector map parameter table header
+ *
+ * This table is optional, but when available, we parse it to identify the
+ * location and size of sectors within the main data array of the flash memory
+ * device and to identify which Erase Types are supported by each sector.
+ *
+ * Returns 0 on success, -errno otherwise.
+ */
+static int spi_nor_parse_smpt(struct spi_nor *nor,
+			      const struct sfdp_parameter_header *smpt_header)
+{
+	const u32 *sector_map;
+	u32 *smpt;
+	size_t len;
+	u32 addr;
+	int i, ret;
+
+	/* Read the Sector Map Parameter Table. */
+	len = smpt_header->length * sizeof(*smpt);
+	smpt = kzalloc(len, GFP_KERNEL);
+	if (!smpt)
+		return -ENOMEM;
+
+	addr = SFDP_PARAM_HEADER_PTP(smpt_header);
+	ret = spi_nor_read_sfdp(nor, addr, len, smpt);
+	if (ret)
+		goto out;
+
+	/* Fix endianness of the SMPT DWORDs. */
+	for (i = 0; i < smpt_header->length; i++)
+		smpt[i] = le32_to_cpu(smpt[i]);
+
+	sector_map = spi_nor_get_map_in_use(nor, smpt);
+	if (!sector_map) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = spi_nor_init_non_uniform_erase_map(nor, sector_map);
+	if (ret)
+		goto out;
+
+	spi_nor_regions_sort_erase_types(&nor->erase_map);
+	/* fall through */
+out:
+	kfree(smpt);
+	return ret;
+}
+
 /**
  * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
  * @nor:		pointer to a 'struct spi_nor'
@@ -2871,7 +3155,7 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 
 		switch (SFDP_PARAM_HEADER_ID(param_header)) {
 		case SFDP_SECTOR_MAP_ID:
-			dev_info(dev, "non-uniform erase sector maps are not supported yet.\n");
+			err = spi_nor_parse_smpt(nor, param_header);
 			break;
 
 		default:
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index a873a0b..ed8a5b7 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -420,6 +420,18 @@ spi_nor_region_end(const struct spi_nor_erase_region *region)
 	return (region->offset & ~SNOR_ERASE_FLAGS_MASK) + region->size;
 }
 
+static void __maybe_unused
+spi_nor_region_mark_end(struct spi_nor_erase_region *region)
+{
+	region->offset |= SNOR_LAST_REGION;
+}
+
+static void __maybe_unused
+spi_nor_region_mark_overlay(struct spi_nor_erase_region *region)
+{
+	region->offset |= SNOR_OVERLAID_REGION;
+}
+
 static bool __maybe_unused spi_nor_has_uniform_erase(const struct spi_nor *nor)
 {
 	return !!nor->erase_map.uniform_erase_type;
-- 
2.9.4

