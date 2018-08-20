Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07DEC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED7E21581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED7E21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeHTQRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:17:24 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:39971 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeHTQRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:17:24 -0400
X-IronPort-AV: E=Sophos;i="5.53,265,1531810800"; 
   d="scan'208";a="16242335"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Aug 2018 06:01:50 -0700
Received: from localhost.localdomain (10.10.76.4) by
 chn-sv-exch07.mchp-main.com (10.10.76.108) with Microsoft SMTP Server id
 14.3.352.0; Mon, 20 Aug 2018 06:01:48 -0700
Subject: Re: [PATCH v2 0/3] add support to non-uniform SFDP SPI NOR flash
 memories
To:     <marek.vasut@gmail.com>
CC:     <cyrille.pitchen@microchip.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>
References: <20180712173235.7901-1-tudor.ambarus@microchip.com>
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <bb6647a7-8d3b-5487-8876-228adfc5ad53@microchip.com>
Date:   Mon, 20 Aug 2018 16:01:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180712173235.7901-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marek,

Did you have the chance to look over these patches? Please advise how can I move
forward with the non-uniform erase support.

Thanks,
ta

On 07/12/2018 08:32 PM, Tudor Ambarus wrote:
> Backward compatibility test done on mx25l3273fm2i-08g.
> Non-uniform erase test done on sst26vf064b-104i/sn.
> 
> Note that in order to do the non-uniform test on the aforementioned memory
> you'll have to force the spi_nor_has_uniform_erase() to return false, because
> the erase map is tuned to come back to the uniform case. Also, you'll have to
> unlock the global protection on the flash. There was an attempt to unlock this
> protection, but for whatever reason the patch was not taken:
> https://patchwork.ozlabs.org/patch/544270/. I'm taking care of the
> global protection lock on sst26vf064b-104i/sn, I will submit a patch soon.
> 
> Changes in v2:
> - add JESD216B SFDP optional parser: Sector Map Parameter Table parser
>   and 4-byte Address Instruction Table parser (patch 2/3 and patch 3/3).
> - fix condition on finding erase regions
> - fix the list command adding
> - write_enable(nor); before erasing the sectors
> - As Boris suggested, remove likely() because it doesn't make any difference
>   given the time it takes to actually erase the block.
> - save the Erase Types from bfpt, to determine the Erase Type sizes. Sort all
>   the map's Erase Types in ascending order with the smallest erase size being
>   the first member in the erase_type array. Sort Erase Type mask in regions.
>   We sort the Erase Type by size, at init, in order to speed up the
>   process of finding the best erase command at run-time.
> - spi_nor_select_erase(): pass directly info->sector_size instead of the whole
>   flash_info structure in order to simplify the code.
> - keep the same convention as most flashes, and order erase types by size with
>   the smallest Erase Type size starting at index 0/ BIT(0).
> - return unused function: spi_nor_region_mark_end().
> - fix return value of spi_nor_has_uniform_erase().
> - remove setting of mtd->erasesize and nor->erase_opcode when parsing the Basic
>   Flash Parameter Table. mtd->erasesize was set to the maximum supported Erase
>   Type size, without verifying if that Erase Type can erase the entire flash.
>   mtd->erasesize is now set just in spi_nor_select_erase(), after we find which
>   Erase Types are supported in the uniform case.
> 
> Changes in v1 or what I've done on top of Cyrille's work (https://lkml.org/lkml/2017/4/15/70):
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
> Cyrille Pitchen (1):
>   mtd: spi-nor: parse SFDP 4-byte Address Instruction Table
> 
> Tudor Ambarus (2):
>   mtd: spi-nor: add support to non-uniform SFDP SPI NOR flash memories
>   mtd: spi-nor: parse SFDP Sector Map Parameter Table
> 
>  drivers/mtd/spi-nor/spi-nor.c | 892 +++++++++++++++++++++++++++++++++++++++---
>  include/linux/mtd/spi-nor.h   | 120 ++++++
>  2 files changed, 954 insertions(+), 58 deletions(-)
> 
