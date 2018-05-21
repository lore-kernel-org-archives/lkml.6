Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeEUNMC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:12:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40153 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeEUNMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:12:01 -0400
X-Google-Smtp-Source: AB8JxZrkXK68Ev74tCsIC0Kpn/8ln49XaCLHJJT7fdp9ZeywJCWCeFqbmQSVd7tTO6fYfSd2+6/W4A==
Subject: Re: [RFC PATCH] mtd: spi-nor: add support to non-uniform SPI NOR
 flash memories
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
        cyrille.pitchen@microchip.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        nicolas.ferre@microchip.com, Cristian.Birsan@microchip.com
References: <20180518093233.24241-1-tudor.ambarus@microchip.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <89d45190-95b0-b780-b219-e6c6adcb6147@gmail.com>
Date: Mon, 21 May 2018 13:35:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518093233.24241-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/2018 11:32 AM, Tudor Ambarus wrote:
> From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> 
> This patch is a first step in introducing  the support of SPI memories
> with non-uniform erase sizes like Spansion s25fs512s.
> 
> It introduces the memory erase map which splits the memory array into one
> or many erase regions. Each erase region supports up to 4 erase commands,
> as defined by the JEDEC JESD216B (SFDP) specification.
> In turn, an erase command is defined by an op code and a sector size.
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
> This is a transitional patch: non-uniform erase maps will be used later
> when initialized based on the SFDP data.

What about non-SFDP non-linear flashes ?

> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> 
> [tudor.ambarus@microchip.com:
> - add improvements on how the erase map is handled. The map is an array
> describing the boundaries of the erase regions. LSB bits of the region's
> offset are used to describe the supported erase types, to indicate if
> that specific region is the last region in the map and to mark if the
> region is overlaid or not. When one sends an addr and len to erase a
> chunk of memory, we identify in which region the address fits, we start
> erasing with the best fitted erase commands and when the region ends,
> continue to erase from the next region. The erase is optimal: identify
> the start offset (once), then erase with the best erase command,
> move forward and repeat.

Is that like an R-tree ?

> - order erase types by size, with the biggest erase type at BIT(0). With
> this, we can iterate from the biggest supported erase type to the smallest,
> and when find one that meets all the required conditions, break the loop.
> This saves time in determining the best erase cmd.
> 
> - minimize the amount of erase() calls by using the best sequence of erase
> type commands depending on alignment.

Nice, this was long overdue

> - replace spi_nor_find_uniform_erase() with spi_nor_select_uniform_erase().
> Even for the SPI NOR memories with non-uniform erase types, we can determine
> at init if there are erase types that can erase the entire memory. Fill at
> init the uniform_erase_type bitmask, to encode the erase type commands that
> can erase the entire memory.
> 
> - clarify support for overlaid regions. Considering one of the erase maps
> of the S25FS512S memory:
> Bottom: 8x 4KB sectors at bottom (only 4KB erase supported),
>         1x overlaid 224KB sector at bottom (only 256KB erase supported),
>         255x 256KB sectors (only 256KB erase supported)
> S25FS512S states that 'if a sector erase command is applied to a 256KB range
> that is overlaid by 4KB secors, the overlaid 4kB sectors are not affected by
> the erase'. When at init, the overlaid region size should be set to
> region->size = erase_size - count; in order to not miss chunks of data
> when traversing the regions.
> 
> - backward compatibility test done on MX25L25673G.
> 
> The 'erase with the best command, move forward and repeat' approach was
> suggested by Cristian Birsan in a brainstorm session, so:
> ]
> Suggested-by: Cristian Birsan <cristian.birsan@microchip.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 281 +++++++++++++++++++++++++++++++++++++++---
>  include/linux/mtd/spi-nor.h   |  89 +++++++++++++
>  2 files changed, 356 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 494b7a2..bb70664 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -260,6 +260,17 @@ static void spi_nor_set_4byte_opcodes(struct spi_nor *nor,
>  	nor->read_opcode = spi_nor_convert_3to4_read(nor->read_opcode);
>  	nor->program_opcode = spi_nor_convert_3to4_program(nor->program_opcode);
>  	nor->erase_opcode = spi_nor_convert_3to4_erase(nor->erase_opcode);
> +
> +	if (!spi_nor_has_uniform_erase(nor)) {
> +		struct spi_nor_erase_map *map = &nor->erase_map;
> +		struct spi_nor_erase_command *cmd;
> +		int i;
> +
> +		for (i = 0; i < SNOR_CMD_ERASE_MAX; i++) {
> +			cmd = &map->commands[i];
> +			cmd->opcode = spi_nor_convert_3to4_erase(cmd->opcode);
> +		}
> +	}
>  }
>  
>  /* Enable/disable 4-byte addressing mode. */
> @@ -497,6 +508,131 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
>  	return nor->write_reg(nor, nor->erase_opcode, buf, nor->addr_width);
>  }
>  
> +/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
> +static inline u64
> +spi_nor_div_by_erase_size(const struct spi_nor_erase_command *cmd,
> +			  u64 dividend, u32 *remainder)
> +{
> +	*remainder = (u32)dividend & cmd->size_mask;
> +	return dividend >> cmd->size_shift;
> +}
> +
> +static const struct spi_nor_erase_command *
> +spi_nor_find_best_erase_cmd(const struct spi_nor_erase_map *map,
> +			    const struct spi_nor_erase_region *region, u64 addr,
> +			    u32 len)
> +{
> +	const struct spi_nor_erase_command *cmd;
> +	u32 rem;
> +	int i;
> +	u8 cmd_mask = region->offset & SNOR_CMD_ERASE_MASK;
> +
> +	/*
> +	 * Commands are ordered by size, with the biggest erase type at
> +	 * index 0.
> +	 */
> +	for (i = 0; i < SNOR_CMD_ERASE_MAX; i++) {
> +		/* Does the erase region support the tested erase command? */
> +		if (!(cmd_mask & BIT(i)))
> +			continue;
> +
> +		cmd = &map->commands[i];
> +
> +		/* Don't erase more than what the user has asked for. */
> +		if (cmd->size > len)
> +			continue;

Are you sure checking for the full erase block length first and then
checking if you can sub-erase the block is OK ?

> +		if (!(region->offset & SNOR_OVERLAID_REGION)) {
> +			/* 'addr' must be aligned to the erase size. */
> +			spi_nor_div_by_erase_size(cmd, addr, &rem);
> +			continue;
> +		} else {
> +			 /*
> +			  * 'cmd' will erase the remaining of the overlaid
> +			  * region.
> +			  */
> +			return cmd;
> +		}
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
> +	region++;
> +	return region;
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
> +	if (!len)
> +		return ERR_PTR(-EINVAL);
> +
> +	while (addr < region_start || addr > region_end) {
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
> +static int spi_nor_erase_multi_sectors(struct spi_nor *nor, u64 addr, u32 len)
> +{
> +	const struct spi_nor_erase_map *map = &nor->erase_map;
> +	const struct spi_nor_erase_command *cmd;
> +	const struct spi_nor_erase_region *region;
> +	u64 region_end;
> +	int ret;
> +
> +	region = spi_nor_find_erase_region(map, addr, len);
> +	if (IS_ERR(region))
> +		return PTR_ERR(region);
> +
> +	region_end = spi_nor_region_end(region);
> +
> +	while (len) {
> +		cmd = spi_nor_find_best_erase_cmd(map, region, addr, len);
> +		if (!cmd)
> +			return -EINVAL;

What would happen if you realize mid-way that you cannot erase some
sector , do you end up with partial erase ?
[...]

-- 
Best regards,
Marek Vasut
