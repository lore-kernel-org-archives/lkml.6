Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BECC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82CC206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82CC206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeIGNb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:31:57 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:49230 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeIGNb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:31:57 -0400
X-IronPort-AV: E=Sophos;i="5.53,341,1531810800"; 
   d="scan'208";a="17368090"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 01:52:00 -0700
Received: from localhost.localdomain (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Fri, 7 Sep 2018 01:51:59 -0700
Subject: Re: [RESEND PATCH v2 1/3] mtd: spi-nor: add support to non-uniform
 SFDP SPI NOR flash memories
To:     Marek Vasut <marek.vasut@gmail.com>,
        <cyrille.pitchen@microchip.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>
References: <20180827102644.7323-1-tudor.ambarus@microchip.com>
 <20180827102644.7323-2-tudor.ambarus@microchip.com>
 <8f25975d-e0d8-dd11-76ce-857e99df9c2c@gmail.com>
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <7b7f9f85-075a-eb3c-1c27-24c67dbc027f@microchip.com>
Date:   Fri, 7 Sep 2018 11:51:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <8f25975d-e0d8-dd11-76ce-857e99df9c2c@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Marek,

On 09/03/2018 08:37 PM, Marek Vasut wrote:
> On 08/27/2018 12:26 PM, Tudor Ambarus wrote:
> [...]
> 
>> +/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
>> +static inline u64
>> +spi_nor_div_by_erase_size(const struct spi_nor_erase_type *erase,
>> +			  u64 dividend, u32 *remainder)
>> +{
>> +	*remainder = (u32)dividend & erase->size_mask;
> 
> Is the cast really needed ? btw I think there might be a macro doing
> just this, div_by_ or something in include/ .

The cast is not needed, the AND sets to zero all but the low-order 32bits of
divided and then we have the implicit cast.

Are you referring to do_div()? I expect the bitwise operations to be faster.
Bitwise operations are preferred in include/linux/mtd/mtd.h too:

static inline uint32_t mtd_div_by_eb(uint64_t sz, struct mtd_info *mtd)
{
        if (mtd->erasesize_shift)
                return sz >> mtd->erasesize_shift;
        do_div(sz, mtd->erasesize);
        return sz;
}

> 
>> +	return dividend >> erase->size_shift;
>> +}
>> +
>> +static const struct spi_nor_erase_type *
>> +spi_nor_find_best_erase_type(const struct spi_nor_erase_map *map,
>> +			     const struct spi_nor_erase_region *region,
>> +			     u64 addr, u32 len)
>> +{
>> +	const struct spi_nor_erase_type *erase;
>> +	u32 rem;
>> +	int i;
>> +	u8 erase_mask = region->offset & SNOR_ERASE_TYPE_MASK;
>> +
>> +	/*
>> +	 * Erase types are ordered by size, with the biggest erase type at
>> +	 * index 0.
>> +	 */
>> +	for (i = SNOR_ERASE_TYPE_MAX - 1; i >= 0; i--) {
>> +		/* Does the erase region support the tested erase type? */
>> +		if (!(erase_mask & BIT(i)))
>> +			continue;
>> +
>> +		erase = &map->erase_type[i];
>> +
>> +		/* Don't erase more than what the user has asked for. */
>> +		if (erase->size > len)
>> +			continue;
>> +
>> +		/* Alignment is not mandatory for overlaid regions */
>> +		if (region->offset & SNOR_OVERLAID_REGION)
>> +			return erase;
>> +
>> +		spi_nor_div_by_erase_size(erase, addr, &rem);
>> +		if (rem)
>> +			continue;
>> +		else
>> +			return erase;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static struct spi_nor_erase_region *
>> +spi_nor_region_next(struct spi_nor_erase_region *region)
>> +{
>> +	if (spi_nor_region_is_last(region))
>> +		return NULL;
>> +	return ++region;
> 
> region++ ...

It's an array of regions, consecutive in address space, in which walking is done
incrementally. If the received region is not the last, I want to return the next
region, so ++region is correct.

> 
> [...]
> 
>> +static int spi_nor_cmp_erase_type(const void *a, const void *b)
>> +{
>> +	const struct spi_nor_erase_type *erase1 = a;
>> +	const struct spi_nor_erase_type *erase2 = b;
>> +
>> +	return erase1->size - erase2->size;
> 
> What does this function do again ?

It's a compare function, I compare by size the map's Erase Types. I pass a
pointer to this function in the sort() call. I sort in ascending order, by size,
all the map's Erase Types when parsing bfpt. I'm doing the sort at init to speed
up the finding of the best erase command at run-time.

A better name for this function is spi_nor_map_cmp_erase_type(), we compare the
map's Erase Types by size.

> 
>> +}
>> +
>> +static void spi_nor_regions_sort_erase_types(struct spi_nor_erase_map *map)
>> +{
>> +	struct spi_nor_erase_region *region = map->regions;
>> +	struct spi_nor_erase_type *erase_type = map->erase_type;
>> +	int i;
>> +	u8 region_erase_mask, ordered_erase_mask;
>> +
>> +	/*
>> +	 * Sort each region's Erase Types in ascending order with the smallest
>> +	 * Erase Type size starting at BIT(0).
>> +	 */
>> +	while (region) {
>> +		region_erase_mask = region->offset & SNOR_ERASE_TYPE_MASK;
>> +
>> +		/*
>> +		 * The region's erase mask indicates which erase types are
>> +		 * supported from the erase types defined in the map.
>> +		 */
>> +		ordered_erase_mask = 0;
>> +		for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++)
>> +			if (erase_type[i].size &&
>> +			    region_erase_mask & BIT(erase_type[i].idx))
>> +				ordered_erase_mask |= BIT(i);
>> +
>> +		/* Overwrite erase mask. */
>> +		region->offset = (region->offset & ~SNOR_ERASE_TYPE_MASK) |
>> +				 ordered_erase_mask;
>> +
>> +		region = spi_nor_region_next(region);
>> +	}
>> +}
>> +
>> +static inline void
> 
> Drop the inline

Ok.

> 
>> +spi_nor_init_uniform_erase_map(struct spi_nor_erase_map *map,
>> +			       u8 erase_mask, u64 flash_size)
>> +{
>> +	map->uniform_region.offset = SNOR_ERASE_FLAGS_OFFSET(erase_mask, 1, 0,
>> +							     0);
>> +	map->uniform_region.size = flash_size;
>> +	map->regions = &map->uniform_region;
>> +	map->uniform_erase_type = erase_mask;
>> +}
>> +
> 
> [...]
> 
>> +#define spi_nor_region_is_last(region)  (region->offset & SNOR_LAST_REGION)
>> +
>> +static inline u64 spi_nor_region_end(const struct spi_nor_erase_region *region)
> 
> Get rid of the inlines, really.

Agreed.

> 
>> +{
>> +	return (region->offset & ~SNOR_ERASE_FLAGS_MASK) + region->size;
>> +}
>> +
>> +static inline bool spi_nor_has_uniform_erase(const struct spi_nor *nor)
>> +{
>> +	return !!nor->erase_map.uniform_erase_type;
>> +}
>> +
>>  static inline void spi_nor_set_flash_node(struct spi_nor *nor,
>>  					  struct device_node *np)
>>  {
>>
> 
> General question, what happens if the multi-block erase fails mid-way ,
> is that handled or reported somehow to the user ?

I already implemented your suggestion. I build a list of erase commands to be
executed once I validate that the erase can be performed.

Will send a v3 soon. Cheers,
ta
