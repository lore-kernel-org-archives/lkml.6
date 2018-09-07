Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A23C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D31204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D31204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeIGNun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:50:43 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:34366 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbeIGNun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:50:43 -0400
X-IronPort-AV: E=Sophos;i="5.53,341,1531810800"; 
   d="scan'208";a="19129754"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 07 Sep 2018 02:10:33 -0700
Received: from localhost.localdomain (10.10.76.4) by
 CHN-SV-EXCH01.mchp-main.com (10.10.76.37) with Microsoft SMTP Server id
 14.3.352.0; Fri, 7 Sep 2018 02:10:32 -0700
Subject: Re: [RESEND PATCH v2 2/3] mtd: spi-nor: parse SFDP Sector Map
 Parameter Table
To:     Marek Vasut <marek.vasut@gmail.com>,
        <cyrille.pitchen@microchip.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>
References: <20180827102644.7323-1-tudor.ambarus@microchip.com>
 <20180827102644.7323-3-tudor.ambarus@microchip.com>
 <1bfbb5f7-39ee-08cb-8f7b-5c3f441f66a2@gmail.com>
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <78a6ebd0-f0e4-cee4-ab66-b393366b2fe5@microchip.com>
Date:   Fri, 7 Sep 2018 12:10:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1bfbb5f7-39ee-08cb-8f7b-5c3f441f66a2@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/2018 08:40 PM, Marek Vasut wrote:
> On 08/27/2018 12:26 PM, Tudor Ambarus wrote:
> [...]
>> +static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
>> +{
>> +	const u32 *ret = NULL;
>> +	u32 i, addr;
>> +	int err;
>> +	u8 addr_width, read_opcode, read_dummy;
>> +	u8 read_data_mask, data_byte, map_id;
>> +
>> +	addr_width = nor->addr_width;
>> +	read_dummy = nor->read_dummy;
>> +	read_opcode = nor->read_opcode;
>> +
>> +	map_id = 0;
>> +	i = 0;
>> +	/* Determine if there are any optional Detection Command Descriptors */
>> +	while (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
>> +		read_data_mask = SMPT_CMD_READ_DATA(smpt[i]);
>> +		nor->addr_width = spi_nor_smpt_addr_width(nor, smpt[i]);
>> +		nor->read_dummy = spi_nor_smpt_read_dummy(nor, smpt[i]);
>> +		nor->read_opcode = SMPT_CMD_OPCODE(smpt[i]);
>> +		addr = smpt[i + 1];
>> +
>> +		err = spi_nor_read_raw(nor, addr, 1, &data_byte);
>> +		if (err)
>> +			goto out;
>> +
>> +		/*
>> +		 * Build an index value that is used to select the Sector Map
>> +		 * Configuration that is currently in use.
>> +		 */
>> +		map_id = map_id << 1 | (!(data_byte & read_data_mask) ? 0 : 1);
> 
> You can drop the ternary operator part completely ^

I'll use !! instead.

> 
>> +		i = i + 2;
>> +	}
>> +
>> +	/* Find the matching configuration map */
>> +	while (SMPT_MAP_ID(smpt[i]) != map_id) {
>> +		if (smpt[i] & SMPT_DESC_END)
>> +			goto out;
>> +		/* increment the table index to the next map */
>> +		i += SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
>> +	}
>> +
>> +	ret = smpt + i;
>> +	/* fall through */
>> +out:
>> +	nor->addr_width = addr_width;
>> +	nor->read_dummy = read_dummy;
>> +	nor->read_opcode = read_opcode;
>> +	return ret;
>> +}
>> +
>> +static void
>> +spi_nor_region_check_overlay(struct spi_nor_erase_region *region,
>> +			     const struct spi_nor_erase_type *erase,
>> +			     const u8 erase_type)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++) {
>> +		if (!(erase_type & BIT(i)))
>> +			continue;
>> +		if (region->size & erase[i].size_mask) {
>> +			spi_nor_region_mark_overlay(region);
>> +			return;
>> +		}
>> +	}
>> +}
>> +
>> +static int spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
>> +					      const u32 *smpt)
>> +{
>> +	struct spi_nor_erase_map *map = &nor->erase_map;
>> +	const struct spi_nor_erase_type *erase = map->erase_type;
>> +	struct spi_nor_erase_region *region;
>> +	u64 offset;
>> +	u32 region_count;
>> +	int i, j;
>> +	u8 erase_type;
>> +
>> +	region_count = SMPT_MAP_REGION_COUNT(*smpt);
>> +	region = devm_kcalloc(nor->dev, region_count, sizeof(*region),
>> +			      GFP_KERNEL);
> 
> Is this memory always correctly free'd ?

Yes. It will be free'd when the driver detaches from the device.

Thanks,
ta
