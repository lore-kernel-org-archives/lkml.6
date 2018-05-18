Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbeERJc6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:32:58 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:48519 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbeERJcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:32:54 -0400
X-IronPort-AV: E=Sophos;i="5.49,414,1520924400";
   d="scan'208";a="14337109"
From: Tudor Ambarus <tudor.ambarus@microchip.com>
To: <marek.vasut@gmail.com>, <cyrille.pitchen@microchip.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <boris.brezillon@bootlin.com>, <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <Cristian.Birsan@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [RFC PATCH] mtd: spi-nor: add support to non-uniform SPI NOR flash memories
Date: Fri, 18 May 2018 12:32:33 +0300
Message-ID: <20180518093233.24241-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cyrille Pitchen <cyrille.pitchen@microchip.com>

This patch is a first step in introducing  the support of SPI memories
with non-uniform erase sizes like Spansion s25fs512s.

It introduces the memory erase map which splits the memory array into one
or many erase regions. Each erase region supports up to 4 erase commands,
as defined by the JEDEC JESD216B (SFDP) specification.
In turn, an erase command is defined by an op code and a sector size.

To be backward compatible, the erase map of uniform SPI NOR flash memories
is initialized so it contains only one erase region and this erase region
supports only one erase command. Hence a single size is used to erase any
sector/block of the memory.

Besides, since the algorithm used to erase sectors on non-uniform SPI NOR
flash memories is quite expensive, when possible, the erase map is tuned
to come back to the uniform case.

This is a transitional patch: non-uniform erase maps will be used later
when initialized based on the SFDP data.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>

[tudor.ambarus@microchip.com:
- add improvements on how the erase map is handled. The map is an array
describing the boundaries of the erase regions. LSB bits of the region's
offset are used to describe the supported erase types, to indicate if
that specific region is the last region in the map and to mark if the
region is overlaid or not. When one sends an addr and len to erase a
chunk of memory, we identify in which region the address fits, we start
erasing with the best fitted erase commands and when the region ends,
continue to erase from the next region. The erase is optimal: identify
the start offset (once), then erase with the best erase command,
move forward and repeat.

- order erase types by size, with the biggest erase type at BIT(0). With
this, we can iterate from the biggest supported erase type to the smallest,
and when find one that meets all the required conditions, break the loop.
This saves time in determining the best erase cmd.

- minimize the amount of erase() calls by using the best sequence of erase
type commands depending on alignment.

- replace spi_nor_find_uniform_erase() with spi_nor_select_uniform_erase().
Even for the SPI NOR memories with non-uniform erase types, we can determine
at init if there are erase types that can erase the entire memory. Fill at
init the uniform_erase_type bitmask, to encode the erase type commands that
can erase the entire memory.

- clarify support for overlaid regions. Considering one of the erase maps
of the S25FS512S memory:
Bottom: 8x 4KB sectors at bottom (only 4KB erase supported),
        1x overlaid 224KB sector at bottom (only 256KB erase supported),
        255x 256KB sectors (only 256KB erase supported)
S25FS512S states that 'if a sector erase command is applied to a 256KB range
that is overlaid by 4KB secors, the overlaid 4kB sectors are not affected by
the erase'. When at init, the overlaid region size should be set to
region->size = erase_size - count; in order to not miss chunks of data
when traversing the regions.

- backward compatibility test done on MX25L25673G.

The 'erase with the best command, move forward and repeat' approach was
suggested by Cristian Birsan in a brainstorm session, so:
]
Suggested-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 281 +++++++++++++++++++++++++++++++++++++++---
 include/linux/mtd/spi-nor.h   |  89 +++++++++++++
 2 files changed, 356 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 494b7a2..bb70664 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -260,6 +260,17 @@ static void spi_nor_set_4byte_opcodes(struct spi_nor *nor,
 	nor->read_opcode = spi_nor_convert_3to4_read(nor->read_opcode);
 	nor->program_opcode = spi_nor_convert_3to4_program(nor->program_opcode);
 	nor->erase_opcode = spi_nor_convert_3to4_erase(nor->erase_opcode);
+
+	if (!spi_nor_has_uniform_erase(nor)) {
+		struct spi_nor_erase_map *map = &nor->erase_map;
+		struct spi_nor_erase_command *cmd;
+		int i;
+
+		for (i = 0; i < SNOR_CMD_ERASE_MAX; i++) {
+			cmd = &map->commands[i];
+			cmd->opcode = spi_nor_convert_3to4_erase(cmd->opcode);
+		}
+	}
 }
 
 /* Enable/disable 4-byte addressing mode. */
@@ -497,6 +508,131 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 	return nor->write_reg(nor, nor->erase_opcode, buf, nor->addr_width);
 }
 
+/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
+static inline u64
+spi_nor_div_by_erase_size(const struct spi_nor_erase_command *cmd,
+			  u64 dividend, u32 *remainder)
+{
+	*remainder = (u32)dividend & cmd->size_mask;
+	return dividend >> cmd->size_shift;
+}
+
+static const struct spi_nor_erase_command *
+spi_nor_find_best_erase_cmd(const struct spi_nor_erase_map *map,
+			    const struct spi_nor_erase_region *region, u64 addr,
+			    u32 len)
+{
+	const struct spi_nor_erase_command *cmd;
+	u32 rem;
+	int i;
+	u8 cmd_mask = region->offset & SNOR_CMD_ERASE_MASK;
+
+	/*
+	 * Commands are ordered by size, with the biggest erase type at
+	 * index 0.
+	 */
+	for (i = 0; i < SNOR_CMD_ERASE_MAX; i++) {
+		/* Does the erase region support the tested erase command? */
+		if (!(cmd_mask & BIT(i)))
+			continue;
+
+		cmd = &map->commands[i];
+
+		/* Don't erase more than what the user has asked for. */
+		if (cmd->size > len)
+			continue;
+
+		if (!(region->offset & SNOR_OVERLAID_REGION)) {
+			/* 'addr' must be aligned to the erase size. */
+			spi_nor_div_by_erase_size(cmd, addr, &rem);
+			continue;
+		} else {
+			 /*
+			  * 'cmd' will erase the remaining of the overlaid
+			  * region.
+			  */
+			return cmd;
+		}
+	}
+
+	return NULL;
+}
+
+static const struct spi_nor_erase_region *
+spi_nor_region_next(const struct spi_nor_erase_region *region)
+{
+	if (spi_nor_region_is_last(region))
+		return NULL;
+	region++;
+	return region;
+}
+
+static const struct spi_nor_erase_region *
+spi_nor_find_erase_region(const struct spi_nor_erase_map *map, u64 addr,
+			  u32 len)
+{
+	const struct spi_nor_erase_region *region = map->regions;
+	u64 region_start = region->offset & ~SNOR_ERASE_FLAGS_MASK;
+	u64 region_end = region_start + region->size;
+
+	if (!len)
+		return ERR_PTR(-EINVAL);
+
+	while (addr < region_start || addr > region_end) {
+		region = spi_nor_region_next(region);
+		if (!region)
+			return ERR_PTR(-EINVAL);
+
+		region_start = region->offset & ~SNOR_ERASE_FLAGS_MASK;
+		region_end = region_start + region->size;
+	}
+
+	return region;
+}
+
+static int spi_nor_erase_multi_sectors(struct spi_nor *nor, u64 addr, u32 len)
+{
+	const struct spi_nor_erase_map *map = &nor->erase_map;
+	const struct spi_nor_erase_command *cmd;
+	const struct spi_nor_erase_region *region;
+	u64 region_end;
+	int ret;
+
+	region = spi_nor_find_erase_region(map, addr, len);
+	if (IS_ERR(region))
+		return PTR_ERR(region);
+
+	region_end = spi_nor_region_end(region);
+
+	while (len) {
+		cmd = spi_nor_find_best_erase_cmd(map, region, addr, len);
+		if (!cmd)
+			return -EINVAL;
+
+		nor->erase_opcode = cmd->opcode;
+
+		ret = spi_nor_erase_sector(nor, addr);
+		if (ret)
+			return ret;
+
+		addr += cmd->size;
+		len -= cmd->size;
+
+		if (len && addr >= region_end) {
+			region = spi_nor_region_next(region);
+			if (!region)
+				return -EINVAL;
+			region_end = spi_nor_region_end(region);
+		}
+
+		ret = spi_nor_wait_till_ready(nor);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /*
  * Erase an address range on the nor chip.  The address range may extend
  * one or more erase sectors.  Return an error is there is a problem erasing.
@@ -511,9 +647,11 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 	dev_dbg(nor->dev, "at 0x%llx, len %lld\n", (long long)instr->addr,
 			(long long)instr->len);
 
-	div_u64_rem(instr->len, mtd->erasesize, &rem);
-	if (rem)
-		return -EINVAL;
+	if (likely(spi_nor_has_uniform_erase(nor))) {
+		div_u64_rem(instr->len, mtd->erasesize, &rem);
+		if (rem)
+			return -EINVAL;
+	}
 
 	addr = instr->addr;
 	len = instr->len;
@@ -552,7 +690,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 	 */
 
 	/* "sector"-at-a-time erase */
-	} else {
+	} else if (likely(spi_nor_has_uniform_erase(nor))) {
 		while (len) {
 			write_enable(nor);
 
@@ -567,6 +705,12 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 			if (ret)
 				goto erase_err;
 		}
+
+	/* erase multiple sectors */
+	} else {
+		ret = spi_nor_erase_multi_sectors(nor, addr, len);
+		if (ret)
+			goto erase_err;
 	}
 
 	write_disable(nor);
@@ -2329,6 +2473,27 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	return 0;
 }
 
+/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
+static inline void
+spi_nor_set_erase_command(struct spi_nor_erase_command *cmd,
+			  u32 size, u8 opcode)
+{
+	cmd->size = size;
+	cmd->opcode = opcode;
+	cmd->size_shift = ffs(cmd->size) - 1;
+	cmd->size_mask = (1 << cmd->size_shift) - 1;
+}
+
+static inline void
+spi_nor_init_uniform_erase_map(struct spi_nor_erase_map *map,
+			       u8 cmd_mask, u64 flash_size)
+{
+	map->uniform_region.offset = SNOR_ERASE_FLAGS_OFFSET(cmd_mask, 1, 0, 0);
+	map->uniform_region.size = flash_size;
+	map->regions = &map->uniform_region;
+	map->uniform_erase_type = cmd_mask;
+}
+
 /**
  * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
  * @nor:		pointer to a 'struct spi_nor'
@@ -2443,6 +2608,9 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			       const struct flash_info *info,
 			       struct spi_nor_flash_parameter *params)
 {
+	struct spi_nor_erase_map *map = &nor->erase_map;
+	u8 erase_mask = 0;
+
 	/* Set legacy flash parameters as default. */
 	memset(params, 0, sizeof(*params));
 
@@ -2482,6 +2650,24 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
 				SPINOR_OP_PP, SNOR_PROTO_1_1_1);
 
+	/*
+	 * Sector Erase settings. Order erase commands by size, with the biggest
+	 * erase size at BIT(0)
+	 */
+	erase_mask |= BIT(0);
+	spi_nor_set_erase_command(&map->commands[0],
+				  info->sector_size, SPINOR_OP_SE);
+	if (info->flags & SECT_4K_PMC) {
+		erase_mask |= BIT(1);
+		spi_nor_set_erase_command(&map->commands[1],
+					  4096u, SPINOR_OP_BE_4K_PMC);
+	} else if (info->flags & SECT_4K) {
+		erase_mask |= BIT(1);
+		spi_nor_set_erase_command(&map->commands[1],
+					  4096u, SPINOR_OP_BE_4K);
+	}
+	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
+
 	/* Select the procedure to set the Quad Enable bit. */
 	if (params->hwcaps.mask & (SNOR_HWCAPS_READ_QUAD |
 				   SNOR_HWCAPS_PP_QUAD)) {
@@ -2631,29 +2817,96 @@ static int spi_nor_select_pp(struct spi_nor *nor,
 	return 0;
 }
 
+static const struct spi_nor_erase_command *
+spi_nor_select_uniform_erase(struct spi_nor_erase_map *map,
+			     const struct flash_info *info, u32 wanted_size)
+{
+	const struct spi_nor_erase_command *tested_cmd, *cmd = NULL;
+	int i;
+	u8 erase_type = map->uniform_erase_type;
+
+	for (i = 0; i < SNOR_CMD_ERASE_MAX; i++) {
+		if (!(erase_type & BIT(i)))
+			continue;
+
+		tested_cmd = &map->commands[i];
+
+		/*
+		 * If the current erase size is the one, stop here:
+		 * we have found the right uniform Sector Erase command.
+		 */
+		if (tested_cmd->size == wanted_size) {
+			cmd = tested_cmd;
+			break;
+		}
+
+		/*
+		 * Otherwise, the current erase size is still a valid canditate
+		 * we select the biggest valid candidate unless we find the
+		 * Sector Erase command for an erase size of
+		 * 'info->sector_size'.
+		 */
+		if (!cmd || tested_cmd->size == info->sector_size)
+			cmd = tested_cmd;
+	}
+
+	if (!cmd || !cmd->size)
+		return ERR_PTR(-EINVAL);
+
+	/* Disable all other Sector Erase commands. */
+	map->uniform_erase_type &= ~SNOR_CMD_ERASE_MASK;
+	map->uniform_erase_type |= BIT(cmd - map->commands);
+	return cmd;
+}
+
 static int spi_nor_select_erase(struct spi_nor *nor,
 				const struct flash_info *info)
 {
+	struct spi_nor_erase_map *map = &nor->erase_map;
+	const struct spi_nor_erase_command *cmd = NULL;
 	struct mtd_info *mtd = &nor->mtd;
+	u32 wanted_size = info->sector_size;
+	int i;
 
 	/* Do nothing if already configured from SFDP. */
 	if (mtd->erasesize)
 		return 0;
 
+	/*
+	 * The previous implementation handling Sector Erase commands assumed
+	 * that the SPI flash memory has an uniform layout then used only one
+	 * of the supported erase sizes for all Sector Erase commands.
+	 * So to be backward compatible, the new implementation also tries to
+	 * manage the SPI flash memory as uniform with a single erase sector
+	 * size, when possible.
+	 */
 #ifdef CONFIG_MTD_SPI_NOR_USE_4K_SECTORS
 	/* prefer "small sector" erase if possible */
-	if (info->flags & SECT_4K) {
-		nor->erase_opcode = SPINOR_OP_BE_4K;
-		mtd->erasesize = 4096;
-	} else if (info->flags & SECT_4K_PMC) {
-		nor->erase_opcode = SPINOR_OP_BE_4K_PMC;
-		mtd->erasesize = 4096;
-	} else
+	wanted_size = 4096u;
 #endif
-	{
-		nor->erase_opcode = SPINOR_OP_SE;
-		mtd->erasesize = info->sector_size;
+
+	if (map->uniform_erase_type) {
+		cmd = spi_nor_select_uniform_erase(map, info, wanted_size);
+		if (IS_ERR(cmd))
+			return PTR_ERR(cmd);
+		nor->erase_opcode = cmd->opcode;
+		mtd->erasesize = cmd->size;
+		return 0;
 	}
+
+	/*
+	 * For non-uniform SPI flash memory, set mtd->erasesize to the
+	 * maximum erase sector size. No need to set nor->erase_opcode.
+	 */
+	for (i = 0; i < SNOR_CMD_ERASE_MAX; i++)
+		if (!map->commands[i].size) {
+			cmd = &map->commands[i];
+			break;
+		}
+	if (!cmd)
+		return -EINVAL;
+
+	mtd->erasesize = cmd->size;
 	return 0;
 }
 
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index e60da0d..fcf14b7 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -238,6 +238,76 @@ enum spi_nor_option_flags {
 };
 
 /**
+ * struct spi_nor_erase_command - Structure to describe a SPI NOR erase command
+ * @size:		the size of the sector/block erased by the command.
+ *			JEDEC JESD216B imposes erase sizes to be a power of 2.
+ * @size_shift:		@size is a power of 2, the shift is stored in
+ *			@size_shift.
+ * @size_mask:		the size mask based on @size_shift.
+ * @opcode:		the SPI command op code to erase the sector/block.
+ */
+struct spi_nor_erase_command {
+	u32	size;
+	u32	size_shift;
+	u32	size_mask;
+	u8	opcode;
+};
+
+/**
+ * struct spi_nor_erase_region - Structure to describe a SPI NOR erase region
+ * @offset:		the offset in the data array of erase region start.
+ *			LSB bits are used as a bitmask encoding flags to
+ *			determine if this region is overlaid, if this region is
+ *			the last in the SPI NOR flash memory and to indicate
+ *			all the supported erase commands inside this region.
+ *			The erase types are ordered by size with the biggest
+ *			erase type at BIT(0).
+ * @size:		the size of the region in bytes.
+ */
+struct spi_nor_erase_region {
+	u64		offset;
+	u64		size;
+};
+
+#define SNOR_CMD_ERASE_MAX	4
+#define SNOR_CMD_ERASE_MASK	GENMASK_ULL(SNOR_CMD_ERASE_MAX - 1, 0)
+
+#define SNOR_LAST_REGION	BIT(4)
+#define SNOR_OVERLAID_REGION	BIT(5)
+
+#define SNOR_ERASE_FLAGS_MAX	6
+#define SNOR_ERASE_FLAGS_MASK	GENMASK_ULL(SNOR_ERASE_FLAGS_MAX - 1, 0)
+
+#define SNOR_ERASE_FLAGS_OFFSET(_cmd_mask, _last_region, _overlaid_region, \
+				_offset)				\
+	((((u64)(_offset)) & ~SNOR_ERASE_FLAGS_MASK)	|		\
+	 (((u64)(_cmd_mask)) & SNOR_CMD_ERASE_MASK)	|		\
+	 (((u64)(_last_region)) & SNOR_LAST_REGION)	|		\
+	 (((u64)(_overlaid_region)) & SNOR_OVERLAID_REGION))
+
+/**
+ * struct spi_nor_erase_map - Structure to describe the SPI NOR erase map
+ * @regions:		point to an array describing the boundaries of the erase
+ *			regions.
+ * @uniform_region:	a pre-allocated erase region for SPI NOR with a uniform
+ *			sector size (legacy implementation).
+ * @commands:		an array of erase commands shared by all the regions.
+ *			The erase commands are oredered by size, with the
+ *			biggest erase type command starting at index 0.
+ * @uniform_erase_type:	bitmask encoding erase commands that can erase the
+ *			entire memory. This member is also completed by
+ *			non-uniform erase type SPI NOR flash memories if they
+ *			support at least one erase type command that can erase
+ *			the entire memory.
+ */
+struct spi_nor_erase_map {
+	struct spi_nor_erase_region	*regions;
+	struct spi_nor_erase_region	uniform_region;
+	struct spi_nor_erase_command	commands[SNOR_CMD_ERASE_MAX];
+	u8				uniform_erase_type;
+};
+
+/**
  * struct flash_info - Forward declaration of a structure used internally by
  *		       spi_nor_scan()
  */
@@ -261,6 +331,7 @@ struct flash_info;
  * @write_proto:	the SPI protocol for write operations
  * @reg_proto		the SPI protocol for read_reg/write_reg/erase operations
  * @cmd_buf:		used by the write_reg
+ * @erase_map:		the erase map of the SPI NOR
  * @prepare:		[OPTIONAL] do some preparations for the
  *			read/write/erase/lock/unlock operations
  * @unprepare:		[OPTIONAL] do some post work after the
@@ -296,6 +367,7 @@ struct spi_nor {
 	bool			sst_write_second;
 	u32			flags;
 	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
+	struct spi_nor_erase_map	erase_map;
 
 	int (*prepare)(struct spi_nor *nor, enum spi_nor_ops ops);
 	void (*unprepare)(struct spi_nor *nor, enum spi_nor_ops ops);
@@ -316,6 +388,23 @@ struct spi_nor {
 	void *priv;
 };
 
+#define spi_nor_region_is_last(region)  (region->offset & SNOR_LAST_REGION)
+
+static inline u64 spi_nor_region_end(const struct spi_nor_erase_region *region)
+{
+	return (region->offset & ~SNOR_ERASE_FLAGS_MASK) + region->size;
+}
+
+static inline void spi_nor_region_mark_end(struct spi_nor_erase_region *region)
+{
+	region->offset |= SNOR_LAST_REGION;
+}
+
+static inline bool spi_nor_has_uniform_erase(const struct spi_nor *nor)
+{
+	return (nor->erase_map.regions == &nor->erase_map.uniform_region);
+}
+
 static inline void spi_nor_set_flash_node(struct spi_nor *nor,
 					  struct device_node *np)
 {
-- 
2.9.4
