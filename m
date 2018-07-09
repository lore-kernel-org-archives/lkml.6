Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9DAC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5BD20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5BD20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932992AbeGIOs3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:48:29 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:46288 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932508AbeGIOs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:48:27 -0400
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="15788637"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Jul 2018 07:48:27 -0700
Received: from localhost.localdomain (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Mon, 9 Jul 2018 07:48:26 -0700
Subject: Re: [PATCH] mtd: spi-nor: add support to non-uniform SFDP SPI NOR
 flash memories
To:     <marek.vasut@gmail.com>, <cyrille.pitchen@microchip.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <boris.brezillon@bootlin.com>, <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <Cristian.Birsan@microchip.com>
References: <20180608134818.21387-1-tudor.ambarus@microchip.com>
 <20180608134818.21387-2-tudor.ambarus@microchip.com>
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <0ee3dd9d-cce7-37d6-9843-580e47b2343e@microchip.com>
Date:   Mon, 9 Jul 2018 17:48:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180608134818.21387-2-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I will send a v2 in few days, together with the parsers for the optional SFDP
tables: Sector Map Parameter table and 4-byte Address Instruction table.

Below I detail what I'll change in v2 for this patch.

On 06/08/2018 04:48 PM, Tudor Ambarus wrote:
> Based on Cyrille Pitchen's patch https://lkml.org/lkml/2017/3/22/935.
> 
> This patch is a transitional patch in introducing  the support of
> SFDP SPI memories with non-uniform erase sizes like Spansion s25fs512s.
> Non-uniform erase maps will be used later when initialized based on the
> SFDP data.
> 
> Introduce the memory erase map which splits the memory array into one
> or many erase regions. Each erase region supports up to 4 erase types,
> as defined by the JEDEC JESD216B (SFDP) specification.
> 
> To be backward compatible, the erase map of uniform SPI NOR flash memories
> is initialized so it contains only one erase region and this erase region
> supports only one erase command. Hence a single size is used to erase any
> sector/block of the memory.
> 
> Besides, since the algorithm used to erase sectors on non-uniform SPI NOR
> flash memories is quite expensive, when possible, the erase map is tuned
> to come back to the uniform case.
> 
> The 'erase with the best command, move forward and repeat' approach was
> suggested by Cristian Birsan in a brainstorm session, so:
> 
> Suggested-by: Cristian Birsan <cristian.birsan@microchip.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 357 ++++++++++++++++++++++++++++++++++++++++--
>  include/linux/mtd/spi-nor.h   | 108 +++++++++++++
>  2 files changed, 451 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 494b7a2..3e04082 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -260,6 +260,18 @@ static void spi_nor_set_4byte_opcodes(struct spi_nor *nor,
>  	nor->read_opcode = spi_nor_convert_3to4_read(nor->read_opcode);
>  	nor->program_opcode = spi_nor_convert_3to4_program(nor->program_opcode);
>  	nor->erase_opcode = spi_nor_convert_3to4_erase(nor->erase_opcode);
> +
> +	if (!spi_nor_has_uniform_erase(nor)) {
> +		struct spi_nor_erase_map *map = &nor->erase_map;
> +		struct spi_nor_erase_type *erase;
> +		int i;
> +
> +		for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++) {
> +			erase = &map->erase_type[i];
> +			erase->opcode =
> +				spi_nor_convert_3to4_erase(erase->opcode);
> +		}
> +	}
>  }
>  
>  /* Enable/disable 4-byte addressing mode. */
> @@ -497,6 +509,204 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
>  	return nor->write_reg(nor, nor->erase_opcode, buf, nor->addr_width);
>  }
>  
> +/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
> +static inline u64
> +spi_nor_div_by_erase_size(const struct spi_nor_erase_type *erase,
> +			  u64 dividend, u32 *remainder)
> +{
> +	*remainder = (u32)dividend & erase->size_mask;
> +	return dividend >> erase->size_shift;
> +}
> +
> +static const struct spi_nor_erase_type *
> +spi_nor_find_best_erase_type(const struct spi_nor_erase_map *map,
> +			     const struct spi_nor_erase_region *region,
> +			     u64 addr, u32 len)
> +{
> +	const struct spi_nor_erase_type *erase;
> +	u32 rem;
> +	int i;
> +	u8 erase_mask = region->offset & SNOR_ERASE_TYPE_MASK;
> +
> +	/*
> +	 * Erase types are ordered by size, with the biggest erase type at
> +	 * index 0.
> +	 */
> +	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++) {
> +		/* Does the erase region support the tested erase type? */
> +		if (!(erase_mask & BIT(i)))
> +			continue;
> +
> +		erase = &map->erase_type[i];
> +
> +		/* Don't erase more than what the user has asked for. */
> +		if (erase->size > len)
> +			continue;
> +
> +		/* Alignment is not mandatory for overlaid regions */
> +		if (region->offset & SNOR_OVERLAID_REGION)
> +			return erase;
> +
> +		spi_nor_div_by_erase_size(erase, addr, &rem);
> +		if (rem)
> +			continue;
> +		else
> +			return erase;
> +	}
> +
> +	return NULL;
> +}
> +
> +static const struct spi_nor_erase_region *
> +spi_nor_region_next(const struct spi_nor_erase_region *region)
> +{
> +	if (spi_nor_region_is_last(region))
> +		return NULL;
> +	return ++region;
> +}
> +
> +static const struct spi_nor_erase_region *
> +spi_nor_find_erase_region(const struct spi_nor_erase_map *map, u64 addr,
> +			  u32 len)
> +{
> +	const struct spi_nor_erase_region *region = map->regions;
> +	u64 region_start = region->offset & ~SNOR_ERASE_FLAGS_MASK;
> +	u64 region_end = region_start + region->size;
> +
> +	while (addr < region_start || addr > region_end) {

this should have been:
while (addr < region_start || addr >= region_end) {


> +		region = spi_nor_region_next(region);
> +		if (!region)
> +			return ERR_PTR(-EINVAL);
> +
> +		region_start = region->offset & ~SNOR_ERASE_FLAGS_MASK;
> +		region_end = region_start + region->size;
> +	}
> +
> +	return region;
> +}
> +
> +static struct spi_nor_erase_command *
> +spi_nor_init_erase_cmd(const struct spi_nor_erase_region *region,
> +		       const struct spi_nor_erase_type *erase, u64 addr)
> +{
> +	struct spi_nor_erase_command *cmd;
> +
> +	cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
> +	if (!cmd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_LIST_HEAD(&cmd->list);
> +	cmd->opcode = erase->opcode;
> +	cmd->count = 1;
> +
> +	if (region->offset & SNOR_OVERLAID_REGION)
> +		cmd->size = region->size;
> +	else
> +		cmd->size = erase->size;
> +
> +	return cmd;
> +}
> +
> +static void spi_nor_destroy_erase_cmd_list(struct list_head *erase_list)
> +{
> +	struct spi_nor_erase_command *cmd, *next;
> +
> +	list_for_each_entry_safe(cmd, next, erase_list, list) {
> +		list_del(&cmd->list);
> +		kfree(cmd);
> +	}
> +}
> +
> +static int spi_nor_init_erase_cmd_list(struct spi_nor *nor,
> +				       struct list_head *erase_list,
> +				       u64 addr, u32 len)
> +{
> +	const struct spi_nor_erase_map *map = &nor->erase_map;
> +	const struct spi_nor_erase_region *region;
> +	const struct spi_nor_erase_type *erase, *prev_erase = NULL;
> +	struct spi_nor_erase_command *cmd = NULL;
> +	u64 region_end;
> +	int ret = -EINVAL;
> +
> +	region = spi_nor_find_erase_region(map, addr, len);
> +	if (IS_ERR(region))
> +		return PTR_ERR(region);
> +
> +	region_end = spi_nor_region_end(region);
> +
> +	while (len) {
> +		erase = spi_nor_find_best_erase_type(map, region, addr, len);
> +		if (!erase)
> +			goto destroy_erase_cmd_list;
> +
> +		if (prev_erase != erase ||
> +		    region->offset & SNOR_OVERLAID_REGION) {
> +			cmd = spi_nor_init_erase_cmd(region, erase, addr);
> +			if (IS_ERR(cmd)) {
> +				ret = PTR_ERR(cmd);
> +				goto destroy_erase_cmd_list;
> +			}
> +
> +			list_add(&cmd->list, erase_list);

this should have been:
list_add_tail(&cmd->list, erase_list);

> +		} else {
> +			cmd->count++;
> +		}
> +
> +		addr += cmd->size;
> +		len -= cmd->size;
> +
> +		if (len && addr >= region_end) {
> +			region = spi_nor_region_next(region);
> +			if (!region)
> +				goto destroy_erase_cmd_list;
> +			region_end = spi_nor_region_end(region);
> +		}
> +
> +		prev_erase = erase;
> +	}
> +
> +	return 0;
> +
> +destroy_erase_cmd_list:
> +	spi_nor_destroy_erase_cmd_list(erase_list);
> +	return ret;
> +}
> +
> +static int spi_nor_erase_multi_sectors(struct spi_nor *nor, u64 addr, u32 len)
> +{
> +	LIST_HEAD(erase_list);
> +	struct spi_nor_erase_command *cmd, *next;
> +	int ret;
> +
> +	ret = spi_nor_init_erase_cmd_list(nor, &erase_list, addr, len);
> +	if (ret)
> +		return ret;
> +
> +	list_for_each_entry_safe(cmd, next, &erase_list, list) {
> +		nor->erase_opcode = cmd->opcode;
> +		while (cmd->count) {

write_enable(nor);

> +			ret = spi_nor_erase_sector(nor, addr);
> +			if (ret)
> +				goto destroy_erase_cmd_list;
> +
> +			addr += cmd->size;
> +			cmd->count--;
> +
> +			ret = spi_nor_wait_till_ready(nor);
> +			if (ret)
> +				goto destroy_erase_cmd_list;
> +		}
> +		list_del(&cmd->list);
> +		kfree(cmd);
> +	}
> +
> +	return 0;
> +
> +destroy_erase_cmd_list:
> +	spi_nor_destroy_erase_cmd_list(&erase_list);
> +	return ret;
> +}
> +
>  /*
>   * Erase an address range on the nor chip.  The address range may extend
>   * one or more erase sectors.  Return an error is there is a problem erasing.
> @@ -511,9 +721,11 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>  	dev_dbg(nor->dev, "at 0x%llx, len %lld\n", (long long)instr->addr,
>  			(long long)instr->len);
>  
> -	div_u64_rem(instr->len, mtd->erasesize, &rem);
> -	if (rem)
> -		return -EINVAL;
> +	if (likely(spi_nor_has_uniform_erase(nor))) {

As Boris suggested, likely() doesn't make any difference here, given the time it
takes to actually erase the block.

> +		div_u64_rem(instr->len, mtd->erasesize, &rem);
> +		if (rem)
> +			return -EINVAL;
> +	}
>  
>  	addr = instr->addr;
>  	len = instr->len;
> @@ -552,7 +764,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>  	 */
>  
>  	/* "sector"-at-a-time erase */
> -	} else {
> +	} else if (likely(spi_nor_has_uniform_erase(nor))) {
>  		while (len) {
>  			write_enable(nor);
>  
> @@ -567,6 +779,12 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>  			if (ret)
>  				goto erase_err;
>  		}
> +
> +	/* erase multiple sectors */
> +	} else {
> +		ret = spi_nor_erase_multi_sectors(nor, addr, len);
> +		if (ret)
> +			goto erase_err;
>  	}
>  
>  	write_disable(nor);
> @@ -2329,6 +2547,27 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,

I'll have to save the erase types from bfpt, to determine the erase type sizes.

>  	return 0;
>  }
>  
> +/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
> +static inline void
> +spi_nor_set_erase_type(struct spi_nor_erase_type *erase,  u32 size, u8 opcode)
> +{
> +	erase->size = size;
> +	erase->opcode = opcode;
> +	erase->size_shift = ffs(erase->size) - 1;
> +	erase->size_mask = (1 << erase->size_shift) - 1;
> +}
> +
> +static inline void
> +spi_nor_init_uniform_erase_map(struct spi_nor_erase_map *map,
> +			       u8 erase_mask, u64 flash_size)
> +{
> +	map->uniform_region.offset = SNOR_ERASE_FLAGS_OFFSET(erase_mask, 1, 0,
> +							     0);
> +	map->uniform_region.size = flash_size;
> +	map->regions = &map->uniform_region;
> +	map->uniform_erase_type = erase_mask;
> +}
> +
>  /**
>   * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
>   * @nor:		pointer to a 'struct spi_nor'
> @@ -2443,6 +2682,9 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  			       const struct flash_info *info,
>  			       struct spi_nor_flash_parameter *params)
>  {
> +	struct spi_nor_erase_map *map = &nor->erase_map;
> +	u8 erase_mask = 0;
> +
>  	/* Set legacy flash parameters as default. */
>  	memset(params, 0, sizeof(*params));
>  
> @@ -2482,6 +2724,24 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
>  				SPINOR_OP_PP, SNOR_PROTO_1_1_1);
>  
> +	/*
> +	 * Sector Erase settings. Order erase types by size, with the biggest
> +	 * erase size at BIT(0)
> +	 */
> +	erase_mask |= BIT(0);
> +	spi_nor_set_erase_type(&map->erase_type[0], info->sector_size,
> +			       SPINOR_OP_SE);
> +	if (info->flags & SECT_4K_PMC) {
> +		erase_mask |= BIT(1);
> +		spi_nor_set_erase_type(&map->erase_type[1], 4096u,
> +				       SPINOR_OP_BE_4K_PMC);
> +	} else if (info->flags & SECT_4K) {
> +		erase_mask |= BIT(1);
> +		spi_nor_set_erase_type(&map->erase_type[1], 4096u,
> +				       SPINOR_OP_BE_4K);
> +	}
> +	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
> +
>  	/* Select the procedure to set the Quad Enable bit. */
>  	if (params->hwcaps.mask & (SNOR_HWCAPS_READ_QUAD |
>  				   SNOR_HWCAPS_PP_QUAD)) {
> @@ -2631,29 +2891,98 @@ static int spi_nor_select_pp(struct spi_nor *nor,
>  	return 0;
>  }
>  
> +static const struct spi_nor_erase_type *
> +spi_nor_select_uniform_erase(struct spi_nor_erase_map *map,
> +			     const struct flash_info *info, u32 wanted_size)
> +{
> +	const struct spi_nor_erase_type *tested_erase, *erase = NULL;
> +	int i;
> +	u8 uniform_erase_type = map->uniform_erase_type;
> +
> +	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++) {
> +		if (!(uniform_erase_type & BIT(i)))
> +			continue;
> +
> +		tested_erase = &map->erase_type[i];
> +
> +		/*
> +		 * If the current erase size is the one, stop here:
> +		 * we have found the right uniform Sector Erase command.
> +		 */
> +		if (tested_erase->size == wanted_size) {
> +			erase = tested_erase;
> +			break;
> +		}
> +
> +		/*
> +		 * Otherwise, the current erase size is still a valid canditate
> +		 * we select the biggest valid candidate unless we find the
> +		 * Sector Erase command for an erase size of
> +		 * 'info->sector_size'.
> +		 */
> +		if (!erase || tested_erase->size == info->sector_size)
> +			erase = tested_erase;
> +	}
> +
> +	if (!erase || !erase->size)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* Disable all other Sector Erase commands. */
> +	map->uniform_erase_type &= ~SNOR_ERASE_TYPE_MASK;
> +	map->uniform_erase_type |= BIT(erase - map->erase_type);
> +	return erase;
> +}
> +
>  static int spi_nor_select_erase(struct spi_nor *nor,
>  				const struct flash_info *info)

I can simplify the code by passing directly info->sector_size instead of the
whole flash_info structure.

>  {
> +	struct spi_nor_erase_map *map = &nor->erase_map;
> +	const struct spi_nor_erase_type *erase = NULL;
>  	struct mtd_info *mtd = &nor->mtd;
> +	u32 wanted_size = info->sector_size;
> +	int i;
>  
>  	/* Do nothing if already configured from SFDP. */
>  	if (mtd->erasesize)
>  		return 0;
>  
> +	/*
> +	 * The previous implementation handling Sector Erase commands assumed
> +	 * that the SPI flash memory has an uniform layout then used only one
> +	 * of the supported erase sizes for all Sector Erase commands.
> +	 * So to be backward compatible, the new implementation also tries to
> +	 * manage the SPI flash memory as uniform with a single erase sector
> +	 * size, when possible.
> +	 */
>  #ifdef CONFIG_MTD_SPI_NOR_USE_4K_SECTORS
>  	/* prefer "small sector" erase if possible */
> -	if (info->flags & SECT_4K) {
> -		nor->erase_opcode = SPINOR_OP_BE_4K;
> -		mtd->erasesize = 4096;
> -	} else if (info->flags & SECT_4K_PMC) {
> -		nor->erase_opcode = SPINOR_OP_BE_4K_PMC;
> -		mtd->erasesize = 4096;
> -	} else
> +	wanted_size = 4096u;
>  #endif
> -	{
> -		nor->erase_opcode = SPINOR_OP_SE;
> -		mtd->erasesize = info->sector_size;
> +
> +	if (map->uniform_erase_type) {
> +		erase = spi_nor_select_uniform_erase(map, info, wanted_size);
> +		if (IS_ERR(erase))
> +			return PTR_ERR(erase);
> +		nor->erase_opcode = erase->opcode;
> +		mtd->erasesize = erase->size;
> +		return 0;
>  	}
> +
> +	/*
> +	 * For non-uniform SPI flash memory, set mtd->erasesize to the
> +	 * maximum erase sector size. No need to set nor->erase_opcode.
> +	 */
> +	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++) {
> +		if (!map->erase_type[i].size) {
> +			erase = &map->erase_type[i];
> +			break;
> +		}
> +	}
> +
> +	if (!erase)
> +		return -EINVAL;
> +
> +	mtd->erasesize = erase->size;
>  	return 0;
>  }
>  
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index e60da0d..072ff5f 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -238,6 +238,95 @@ enum spi_nor_option_flags {
>  };
>  
>  /**
> + * struct spi_nor_erase_type - Structure to describe a SPI NOR erase type
> + * @size:		the size of the sector/block erased by the erase type.
> + *			JEDEC JESD216B imposes erase sizes to be a power of 2.
> + * @size_shift:		@size is a power of 2, the shift is stored in
> + *			@size_shift.
> + * @size_mask:		the size mask based on @size_shift.
> + * @opcode:		the SPI command op code to erase the sector/block.
> + */
> +struct spi_nor_erase_type {
> +	u32	size;
> +	u32	size_shift;
> +	u32	size_mask;
> +	u8	opcode;
> +};
> +
> +/**
> + * struct spi_nor_erase_command - Used for non-uniform erases
> + * The structure is used to describe a list of erase commands to be executed
> + * once we validate that the erase can be performed. The elements in the list
> + * are run-length encoded.
> + * @list:		for inclusion into the list of erase commands.
> + * @count:		how many times the same erase command should be
> + *			consecutively used.
> + * @size:		the size of the sector/block erased by the command.
> + * @opcode:		the SPI command op code to erase the sector/block.
> + */
> +struct spi_nor_erase_command {
> +	struct list_head	list;
> +	u32			count;
> +	u32			size;
> +	u8			opcode;
> +};
> +
> +/**
> + * struct spi_nor_erase_region - Structure to describe a SPI NOR erase region
> + * @offset:		the offset in the data array of erase region start.
> + *			LSB bits are used as a bitmask encoding flags to
> + *			determine if this region is overlaid, if this region is
> + *			the last in the SPI NOR flash memory and to indicate
> + *			all the supported erase commands inside this region.
> + *			The erase types are ordered by size with the biggest
> + *			erase type at BIT(0).

JESD216B does not impose a restriction on how flashes should order the erase
types. Nevertheless, serial flashes tend to order the erase types by size, with
the smallest being Erase Type 1, and the biggest, Erase Type 4. I will keep the
same convention as most flashes, and I'll order erase types by size with the
biggest at BIT(3) and the smallest at BIT(0), so that I'll avoid unnecessary
reordering at init.

> + * @size:		the size of the region in bytes.
> + */
> +struct spi_nor_erase_region {
> +	u64		offset;
> +	u64		size;
> +};
> +
> +#define SNOR_ERASE_TYPE_MAX	4
> +#define SNOR_ERASE_TYPE_MASK	GENMASK_ULL(SNOR_ERASE_TYPE_MAX - 1, 0)
> +
> +#define SNOR_LAST_REGION	BIT(4)
> +#define SNOR_OVERLAID_REGION	BIT(5)
> +
> +#define SNOR_ERASE_FLAGS_MAX	6
> +#define SNOR_ERASE_FLAGS_MASK	GENMASK_ULL(SNOR_ERASE_FLAGS_MAX - 1, 0)
> +
> +#define SNOR_ERASE_FLAGS_OFFSET(_cmd_mask, _last_region, _overlaid_region, \
> +				_offset)				\
> +	((((u64)(_offset)) & ~SNOR_ERASE_FLAGS_MASK)	|		\
> +	 (((u64)(_cmd_mask)) & SNOR_ERASE_TYPE_MASK)	|		\
> +	 (((u64)(_last_region)) & SNOR_LAST_REGION)	|		\
> +	 (((u64)(_overlaid_region)) & SNOR_OVERLAID_REGION))
> +
> +/**
> + * struct spi_nor_erase_map - Structure to describe the SPI NOR erase map
> + * @regions:		array of erase regions. The regions are consecutive in
> + *			address space. Walking through the regions is done
> + *			incrementally.
> + * @uniform_region:	a pre-allocated erase region for SPI NOR with a uniform
> + *			sector size (legacy implementation).
> + * @erase_type:		an array of erase types shared by all the regions.
> + *			The erase types are ordered by size, with the
> + *			biggest erase type size starting at index 0.
> + * @uniform_erase_type:	bitmask encoding erase types that can erase the
> + *			entire memory. This member is completed at init by
> + *			uniform and non-uniform SPI NOR flash memories if they
> + *			support at least one erase type that can erase the
> + *			entire memory.
> + */
> +struct spi_nor_erase_map {
> +	struct spi_nor_erase_region	*regions;
> +	struct spi_nor_erase_region	uniform_region;
> +	struct spi_nor_erase_type	erase_type[SNOR_ERASE_TYPE_MAX];
> +	u8				uniform_erase_type;
> +};
> +
> +/**
>   * struct flash_info - Forward declaration of a structure used internally by
>   *		       spi_nor_scan()
>   */
> @@ -261,6 +350,7 @@ struct flash_info;
>   * @write_proto:	the SPI protocol for write operations
>   * @reg_proto		the SPI protocol for read_reg/write_reg/erase operations
>   * @cmd_buf:		used by the write_reg
> + * @erase_map:		the erase map of the SPI NOR
>   * @prepare:		[OPTIONAL] do some preparations for the
>   *			read/write/erase/lock/unlock operations
>   * @unprepare:		[OPTIONAL] do some post work after the
> @@ -296,6 +386,7 @@ struct spi_nor {
>  	bool			sst_write_second;
>  	u32			flags;
>  	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
> +	struct spi_nor_erase_map	erase_map;
>  
>  	int (*prepare)(struct spi_nor *nor, enum spi_nor_ops ops);
>  	void (*unprepare)(struct spi_nor *nor, enum spi_nor_ops ops);
> @@ -316,6 +407,23 @@ struct spi_nor {
>  	void *priv;
>  };
>  
> +#define spi_nor_region_is_last(region)  (region->offset & SNOR_LAST_REGION)
> +
> +static inline u64 spi_nor_region_end(const struct spi_nor_erase_region *region)
> +{
> +	return (region->offset & ~SNOR_ERASE_FLAGS_MASK) + region->size;
> +}
> +
> +static inline void spi_nor_region_mark_end(struct spi_nor_erase_region *region)

remove this function because it is not used in this patch. I will introduce it
when parsing the sector map table.

> +{
> +	region->offset |= SNOR_LAST_REGION;
> +}
> +
> +static inline bool spi_nor_has_uniform_erase(const struct spi_nor *nor)
> +{
> +	return (nor->erase_map.regions == &nor->erase_map.uniform_region);

better return !!nor->erase_map.uniform_erase_type;
because when multiple regions, all regions can have a common supported erase
type. uniform_erase_type member is completed at init by uniform and non-uniform
SPI NOR flash memories if they support at least one erase type that can erase
the entire memory. We will manage the flash memory as uniform, with a single
erase sector size when possible, to be backward compatible.

Best,
ta

> +}
> +
>  static inline void spi_nor_set_flash_node(struct spi_nor *nor,
>  					  struct device_node *np)
>  {
> 
