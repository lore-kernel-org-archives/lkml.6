Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E61EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05AC2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05AC2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbeIRSmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:42:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41889 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbeIRSmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:42:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6CBF7208B1; Tue, 18 Sep 2018 15:09:44 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0E79A20898;
        Tue, 18 Sep 2018 15:09:34 +0200 (CEST)
Date:   Tue, 18 Sep 2018 15:09:34 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <richard@nod.at>,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com,
        cyrille.pitchen@microchip.com, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Cristian.Birsan@microchip.com
Subject: Re: [PATCH v3 0/2] add support to non-uniform SFDP SPI NOR flash
 memories
Message-ID: <20180918150934.6c55b1d4@bbrezillon>
In-Reply-To: <20180911154007.17195-1-tudor.ambarus@microchip.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018 18:40:05 +0300
Tudor Ambarus <tudor.ambarus@microchip.com> wrote:

> Backward compatibility test done on mx25l3273fm2i-08g with
> CONFIG_MTD_SPI_NOR_USE_4K_SECTORS set and unset.
> Non-uniform erase test done on sst26vf064b-104i/sn with
> CONFIG_MTD_SPI_NOR_USE_4K_SECTORS set and unset.
> 
> Note that in order to do the non-uniform test you'll have to force the
> spi_nor_has_uniform_erase() to return false, because the erase map is
> tuned to come back to the uniform case. Also, for the SST flashes, you'll
> have to unlock the global protection (see
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1763887.html).
> 
> Changes in v3:
> - drop "mtd: spi-nor: parse SFDP 4-byte Address Instruction Table":
>   let's add just a feature per patch set to make it easily digestible.
>   No worries, will resubmit it once the non-uniform erase supports gets
>   approved.
> - SNOR_ERASE_FLAGS_OFFSET was buggy and since it's used only once
>   in the uniform erase case, remove it entirely and do the init by
>   hand
> - describe all introduced functions together with arguments and
>   return value
> - various minor updates: drop a cast, rename a function - cosmetics ...
> 
> Changes in v2:
> - add JESD216B SFDP optional parsers: Sector Map Parameter Table parser and
>   4-byte Address Instruction Table parser (patch 2/3 and patch 3/3).
> 
> - save the Erase Types from bfpt to determine the Erase Type sizes. Sort all
>   the map's Erase Types in ascending order with the smallest erase size being
>   the first member in the erase_type array. Sort in the same way the Erase Type
>   mask in regions in order to have a 1-to-1 correspondence with the Erase
>   Types defined in the map. We sort the Erase Type by size, at init, in order to
>   speed up the process of finding the best erase command at run-time.
> 
> - remove setting of mtd->erasesize and nor->erase_opcode when parsing the Basic
>   Flash Parameter Table. mtd->erasesize was set to the maximum supported Erase
>   Type size, without verifying if that Erase Type can erase the entire flash.
>   mtd->erasesize is now set just in spi_nor_select_erase(), after we find which
>   Erase Types are supported in the uniform case.
> 
> - spi_nor_select_erase(): pass directly info->sector_size instead of the whole
>   flash_info structure in order to simplify the code.
> 
> - fix condition on finding erase regions:
>   while (addr < region_start || addr >= region_end) {
> - fix the list command adding: list_add_tail() instead of list_add()
> - write_enable(nor); before erasing the sectors
> - As Boris suggested, remove likely() because it doesn't make any difference
>   given the time it takes to actually erase the block.
> - bool return value for spi_nor_has_uniform_erase().
> 
> Changes in v1 or what I've done on top of Cyrille's work (https://lkml.org/lkml//
> 2017/4/15/70):
> - minimize the amount of erase() calls by using the best sequence of erase
>   type commands depending on alignment.
> - build the list of best fitted erase commands to be executed once we
>   validate that the erase can be performed.
> - add improvements on how the erase map is handled. The regions are
>   consecutive in the address space, walk through the regions incrementally.
> - speed up finding the best erase type command. Order erase types by
>   size, iterate them from the biggest to the smallest and stop when best
>   fitted command is found.
> - determine at init if there are erase types that can erase the entire
>   memory
> - fix support for overlaid regions.
> 
> 
> Tudor Ambarus (2):
>   mtd: spi-nor: add support to non-uniform SFDP SPI NOR flash memories
>   mtd: spi-nor: parse SFDP Sector Map Parameter Table

Queued to spi-nor/next after fixing the kerneldoc headers.

Thanks,

Boris
