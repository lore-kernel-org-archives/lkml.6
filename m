Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F02C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DF020989
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DF020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503248AbeKWVB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:01:59 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55124 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388074AbeKWVB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:01:59 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DE26420D92; Fri, 23 Nov 2018 11:18:18 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7737820EB0;
        Fri, 23 Nov 2018 11:17:34 +0100 (CET)
Date:   Fri, 23 Nov 2018 11:17:29 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Cc:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: fix erase_type array to indicate current
 map conf
Message-ID: <20181123111729.1d5b6e57@bbrezillon>
In-Reply-To: <3d8a2b83-282d-7cb2-3c8b-addae3c2af7f@nokia.com>
References: <20181122123552.15756-1-tudor.ambarus@microchip.com>
        <3d8a2b83-282d-7cb2-3c8b-addae3c2af7f@nokia.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 09:42:55 +0000
"Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
wrote:

> Hello Tudor,
> 
> On 22/11/2018 13:36, Tudor.Ambarus@microchip.com wrote:
> > From: Tudor Ambarus <tudor.ambarus@microchip.com>
> > 
> > Bug reported for the out-of-tree S25FS128S flash memory.
> > 
> > BFPT table advertises all the erase types supported by all the
> > possible map configurations. Update the erase_type array to indicate
> > which erase types are applicable to the current map configuration.
> > 
> > Backward compatibility test done on sst26vf064b.
> > 
> > Fixes: b038e8e3be72 ("mtd: spi-nor: parse SFDP Sector Map Parameter Table")
> > Reported-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>  
> 
> I've tested this patch and it fixes the erasesize for S25FS128S and
> our 128k partitions are writeable again with this patch.
> 
> Nevertheless, I think this is coincidence. I don't think that it
> makes sense to OR all the erase types from all regions in one
> bitmask and derive any uniform erasesize out of it.
> This makes little sense for me in case of non-uniform maps.
> 
> I believe, the culprit here is one level higher, in the MTD partitioning
> code (mtdpart.c) which has to be taught about non-uniform maps
> but there is no infrastructure for this currently.

Keep in mind that mtdpart is only one part of the issue. As I said
previously, some MTD users (UBI) expect a single eraseblock size, so
it's not only mtdpart that you'd need to fix, but basically all MTD
users that don't check ->eraseregions.

> 
> What is possible to fix still is to choose smallest, not biggest
> erasesize for uniform case.

Yep, I agree. But we also have to be careful here, if some NORs were
already supported and were picking the biggest erasesize, we have to
preserve this behavior, otherwise we'll break things.

> I have such a patch, but I need hands
> on on a S25FS128S configured in uniform mode.
> 
> Non uniform case requires MTD layer rework.

There's already the concept of ->eraseregions. Maybe I'm wrong but I
thought it would fit the non-uniform erase scheme we have in SPI NOR. 

> We just cannot handle
> this hardware with just one erasesize in mind.

We can, if we decide to always use the biggest non-uniform erasesize.
Of course that only works if the biggest erase size is always a
multiple of smaller ones, but I'm pretty sure this is always true.

> 
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c | 29 ++++++++++++++++++++++++++++-
> >  1 file changed, 28 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> > index 93c9bc8931fc..a71adcd6ddfa 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -3000,7 +3000,8 @@ static int spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
> >  	u64 offset;
> >  	u32 region_count;
> >  	int i, j;
> > -	u8 erase_type, uniform_erase_type;
> > +	u8 uniform_erase_type, save_uniform_erase_type;
> > +	u8 erase_type, regions_erase_type;
> >  
> >  	region_count = SMPT_MAP_REGION_COUNT(*smpt);
> >  	/*
> > @@ -3014,6 +3015,7 @@ static int spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
> >  	map->regions = region;
> >  
> >  	uniform_erase_type = 0xff;
> > +	regions_erase_type = 0;
> >  	offset = 0;
> >  	/* Populate regions. */
> >  	for (i = 0; i < region_count; i++) {
> > @@ -3030,13 +3032,38 @@ static int spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
> >  		 */
> >  		uniform_erase_type &= erase_type;
> >  
> > +		/*
> > +		 * regions_erase_type mask will indicate all the erase types
> > +		 * supported in this configuration map.
> > +		 */
> > +		regions_erase_type |= erase_type;
> > +
> >  		offset = (region[i].offset & ~SNOR_ERASE_FLAGS_MASK) +
> >  			 region[i].size;
> >  	}
> >  
> > +	save_uniform_erase_type = map->uniform_erase_type;
> >  	map->uniform_erase_type = spi_nor_sort_erase_mask(map,
> >  							  uniform_erase_type);
> >  
> > +	if (!regions_erase_type) {
> > +		/*
> > +		 * Roll back to the previous uniform_erase_type mask, SMPT is
> > +		 * broken.
> > +		 */
> > +		map->uniform_erase_type = save_uniform_erase_type;
> > +		return -EINVAL;
> > +	}
> > +
> > +	/*
> > +	 * BFPT table advertises all the erase types supported by all the
> > +	 * possible map configurations. Update the erase_type array to indicate
> > +	 * which erase types are applicable to the current map configuration.
> > +	 */
> > +	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++)
> > +		if (!(regions_erase_type & BIT(erase[i].idx)))
> > +			spi_nor_set_erase_type(&erase[i], 0, 0xFF);
> > +
> >  	spi_nor_region_mark_end(&region[i - 1]);
> >  
> >  	return 0;  
> 

