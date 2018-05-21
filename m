Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbeEUQmS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:42:18 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:45239 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752882AbeEUQmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:42:17 -0400
X-IronPort-AV: E=Sophos;i="5.49,426,1520924400";
   d="scan'208";a="14497850"
Subject: Re: [RFC PATCH] mtd: spi-nor: add support to non-uniform SPI NOR
 flash memories
To: Marek Vasut <marek.vasut@gmail.com>, <cyrille.pitchen@microchip.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <boris.brezillon@bootlin.com>, <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <Cristian.Birsan@microchip.com>
References: <20180518093233.24241-1-tudor.ambarus@microchip.com>
 <89d45190-95b0-b780-b219-e6c6adcb6147@gmail.com>
From: Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <4cd7d47a-fd56-6b54-3b38-262adf46a97f@microchip.com>
Date: Mon, 21 May 2018 19:42:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <89d45190-95b0-b780-b219-e6c6adcb6147@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marek,

On 05/21/2018 02:35 PM, Marek Vasut wrote:
> On 05/18/2018 11:32 AM, Tudor Ambarus wrote:
>> From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
>>
>> This patch is a first step in introducing  the support of SPI memories
>> with non-uniform erase sizes like Spansion s25fs512s.
>>
>> It introduces the memory erase map which splits the memory array into one
>> or many erase regions. Each erase region supports up to 4 erase commands,
>> as defined by the JEDEC JESD216B (SFDP) specification.
>> In turn, an erase command is defined by an op code and a sector size.
>>
>> To be backward compatible, the erase map of uniform SPI NOR flash memories
>> is initialized so it contains only one erase region and this erase region
>> supports only one erase command. Hence a single size is used to erase any
>> sector/block of the memory.
>>
>> Besides, since the algorithm used to erase sectors on non-uniform SPI NOR
>> flash memories is quite expensive, when possible, the erase map is tuned
>> to come back to the uniform case.
>>
>> This is a transitional patch: non-uniform erase maps will be used later
>> when initialized based on the SFDP data.
> 
> What about non-SFDP non-linear flashes ?

Non-SFDP non-uniform flashes support is not addressed with this
proposal, I should have told this in the commit message, thanks. But we
are backward compatible, if non-SFDP, the flashes are considered
uniform.

> 
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
>>
>> [tudor.ambarus@microchip.com:
>> - add improvements on how the erase map is handled. The map is an array
>> describing the boundaries of the erase regions. LSB bits of the region's
>> offset are used to describe the supported erase types, to indicate if
>> that specific region is the last region in the map and to mark if the
>> region is overlaid or not. When one sends an addr and len to erase a
>> chunk of memory, we identify in which region the address fits, we start
>> erasing with the best fitted erase commands and when the region ends,
>> continue to erase from the next region. The erase is optimal: identify
>> the start offset (once), then erase with the best erase command,
>> move forward and repeat.
> 
> Is that like an R-tree ?

Not really. I find this RFC proposal faster and neat, but I'm open for
suggestions and guidance.

One wants to erase a contiguous chunk of memory and sends us the
starting address and the total length. The algorithm of finding the best
sequence of erase commands can be summarized in four steps:

1. Find in which region the address fits.
This step is done only once, at the beginning. For the non-uniform
SFDP-defined flashes, usually there are two or three regions defined.
Nevertheless, in the worst case, the maximum number of regions that can
be defined is on eight bits, so 255. Linear search for just 255 elements
in the worst case looks good for me, especially that we do this search
once.

2. Find the *best* erase command that is defined in that region.
Each region can define maximum 4 erase commands. *Best* is defined as
the largest/biggest supported erase command with which the provided
address is aligned and which does not erase more that what the user has
asked for. In case of overlaid regions, alignment does not matter. The
largest command will erase the remaining of the overlaid region without
touching the region with which it overlaps (see S25FS512S). The
supported erase commands are ordered by size with the biggest queried
first. It is desirable to erase with large erase commands so that we
erase as much as we can in one shoot, minimizing the erase() calls.

3. Erase sector with the *best* erase command and move forward in a
linear fashion.
addr += cmd->size;
len -= cmd->size;
If the new address exceeds the end of this region, move to the next.

4. While (len) goto step2.

That's all. Linearity is an advantage. We find the starting region and
then we traverse each region in order without other queries.

> 
>> - order erase types by size, with the biggest erase type at BIT(0). With
>> this, we can iterate from the biggest supported erase type to the smallest,
>> and when find one that meets all the required conditions, break the loop.
>> This saves time in determining the best erase cmd.
>>
>> - minimize the amount of erase() calls by using the best sequence of erase
>> type commands depending on alignment.
> 
> Nice, this was long overdue
> 
>> - replace spi_nor_find_uniform_erase() with spi_nor_select_uniform_erase().
>> Even for the SPI NOR memories with non-uniform erase types, we can determine
>> at init if there are erase types that can erase the entire memory. Fill at
>> init the uniform_erase_type bitmask, to encode the erase type commands that
>> can erase the entire memory.
>>
>> - clarify support for overlaid regions. Considering one of the erase maps
>> of the S25FS512S memory:
>> Bottom: 8x 4KB sectors at bottom (only 4KB erase supported),
>>          1x overlaid 224KB sector at bottom (only 256KB erase supported),
>>          255x 256KB sectors (only 256KB erase supported)
>> S25FS512S states that 'if a sector erase command is applied to a 256KB range
>> that is overlaid by 4KB secors, the overlaid 4kB sectors are not affected by
>> the erase'. When at init, the overlaid region size should be set to
>> region->size = erase_size - count; in order to not miss chunks of data
>> when traversing the regions.
>>
>> - backward compatibility test done on MX25L25673G.
>>
>> The 'erase with the best command, move forward and repeat' approach was
>> suggested by Cristian Birsan in a brainstorm session, so:
>> ]
>> Suggested-by: Cristian Birsan <cristian.birsan@microchip.com>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>>   drivers/mtd/spi-nor/spi-nor.c | 281 +++++++++++++++++++++++++++++++++++++++---
>>   include/linux/mtd/spi-nor.h   |  89 +++++++++++++
>>   2 files changed, 356 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index 494b7a2..bb70664 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -260,6 +260,17 @@ static void spi_nor_set_4byte_opcodes(struct spi_nor *nor,
>>   	nor->read_opcode = spi_nor_convert_3to4_read(nor->read_opcode);
>>   	nor->program_opcode = spi_nor_convert_3to4_program(nor->program_opcode);
>>   	nor->erase_opcode = spi_nor_convert_3to4_erase(nor->erase_opcode);
>> +
>> +	if (!spi_nor_has_uniform_erase(nor)) {
>> +		struct spi_nor_erase_map *map = &nor->erase_map;
>> +		struct spi_nor_erase_command *cmd;
>> +		int i;
>> +
>> +		for (i = 0; i < SNOR_CMD_ERASE_MAX; i++) {
>> +			cmd = &map->commands[i];
>> +			cmd->opcode = spi_nor_convert_3to4_erase(cmd->opcode);
>> +		}
>> +	}
>>   }
>>   
>>   /* Enable/disable 4-byte addressing mode. */
>> @@ -497,6 +508,131 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
>>   	return nor->write_reg(nor, nor->erase_opcode, buf, nor->addr_width);
>>   }
>>   
>> +/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
>> +static inline u64
>> +spi_nor_div_by_erase_size(const struct spi_nor_erase_command *cmd,
>> +			  u64 dividend, u32 *remainder)
>> +{
>> +	*remainder = (u32)dividend & cmd->size_mask;
>> +	return dividend >> cmd->size_shift;
>> +}
>> +
>> +static const struct spi_nor_erase_command *
>> +spi_nor_find_best_erase_cmd(const struct spi_nor_erase_map *map,
>> +			    const struct spi_nor_erase_region *region, u64 addr,
>> +			    u32 len)
>> +{
>> +	const struct spi_nor_erase_command *cmd;
>> +	u32 rem;
>> +	int i;
>> +	u8 cmd_mask = region->offset & SNOR_CMD_ERASE_MASK;
>> +
>> +	/*
>> +	 * Commands are ordered by size, with the biggest erase type at
>> +	 * index 0.
>> +	 */
>> +	for (i = 0; i < SNOR_CMD_ERASE_MAX; i++) {
>> +		/* Does the erase region support the tested erase command? */
>> +		if (!(cmd_mask & BIT(i)))
>> +			continue;
>> +
>> +		cmd = &map->commands[i];
>> +
>> +		/* Don't erase more than what the user has asked for. */
>> +		if (cmd->size > len)
>> +			continue;
> 
> Are you sure checking for the full erase block length first and then
> checking if you can sub-erase the block is OK ?

will respond in the next comment.

> 
>> +		if (!(region->offset & SNOR_OVERLAID_REGION)) {
>> +			/* 'addr' must be aligned to the erase size. */
>> +			spi_nor_div_by_erase_size(cmd, addr, &rem);

oh, I missed the if here, this should have been confusing.
if (rem)
	continue;
else
	return cmd;
The else case can be merged with the one from below.

Returning to your previous question. I iterate from the biggest erase
command to the smallest, because bigger is preferred, it will minimize
the amount of erase() calls. The biggest erase command that doesn't
erase more that what the user has asked for, will do. If the region is
not-overlaid the address must also be aligned with the erase size.


>> +			continue;
>> +		} else {
>> +			 /*
>> +			  * 'cmd' will erase the remaining of the overlaid
>> +			  * region.
>> +			  */
>> +			return cmd;
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static const struct spi_nor_erase_region *
>> +spi_nor_region_next(const struct spi_nor_erase_region *region)
>> +{
>> +	if (spi_nor_region_is_last(region))
>> +		return NULL;
>> +	region++;
>> +	return region;
>> +}
>> +
>> +static const struct spi_nor_erase_region *
>> +spi_nor_find_erase_region(const struct spi_nor_erase_map *map, u64 addr,
>> +			  u32 len)
>> +{
>> +	const struct spi_nor_erase_region *region = map->regions;
>> +	u64 region_start = region->offset & ~SNOR_ERASE_FLAGS_MASK;
>> +	u64 region_end = region_start + region->size;
>> +
>> +	if (!len)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	while (addr < region_start || addr > region_end) {
>> +		region = spi_nor_region_next(region);
>> +		if (!region)
>> +			return ERR_PTR(-EINVAL);
>> +
>> +		region_start = region->offset & ~SNOR_ERASE_FLAGS_MASK;
>> +		region_end = region_start + region->size;
>> +	}
>> +
>> +	return region;
>> +}
>> +
>> +static int spi_nor_erase_multi_sectors(struct spi_nor *nor, u64 addr, u32 len)
>> +{
>> +	const struct spi_nor_erase_map *map = &nor->erase_map;
>> +	const struct spi_nor_erase_command *cmd;
>> +	const struct spi_nor_erase_region *region;
>> +	u64 region_end;
>> +	int ret;
>> +
>> +	region = spi_nor_find_erase_region(map, addr, len);
>> +	if (IS_ERR(region))
>> +		return PTR_ERR(region);
>> +
>> +	region_end = spi_nor_region_end(region);
>> +
>> +	while (len) {
>> +		cmd = spi_nor_find_best_erase_cmd(map, region, addr, len);
>> +		if (!cmd)
>> +			return -EINVAL;
> 
> What would happen if you realize mid-way that you cannot erase some
> sector , do you end up with partial erase ?

Is this possible? In non-overlaid regions, the address is aligned with
at least one of the erase commands, else -EINVAL. For overlaid regions
alignment doesn't matter. But yes, if this is possible, in this case,
this proposal will do a partial erase.

Best,
ta
