Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEFBC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC00620866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC00620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeIKUkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:40:07 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:65469 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbeIKUkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:40:07 -0400
X-IronPort-AV: E=Sophos;i="5.53,360,1531810800"; 
   d="scan'208";a="20470912"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Sep 2018 08:40:14 -0700
Received: from localhost.localdomain.com (10.10.76.4) by
 chn-sv-exch04.mchp-main.com (10.10.76.105) with Microsoft SMTP Server id
 14.3.352.0; Tue, 11 Sep 2018 08:40:14 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <cyrille.pitchen@microchip.com>,
        <nicolas.ferre@microchip.com>, <Cristian.Birsan@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 0/2] add support to non-uniform SFDP SPI NOR flash memories
Date:   Tue, 11 Sep 2018 18:40:05 +0300
Message-ID: <20180911154007.17195-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Backward compatibility test done on mx25l3273fm2i-08g with
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS set and unset.
Non-uniform erase test done on sst26vf064b-104i/sn with
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS set and unset.

Note that in order to do the non-uniform test you'll have to force the
spi_nor_has_uniform_erase() to return false, because the erase map is
tuned to come back to the uniform case. Also, for the SST flashes, you'll
have to unlock the global protection (see
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1763887.html).

Changes in v3:
- drop "mtd: spi-nor: parse SFDP 4-byte Address Instruction Table":
  let's add just a feature per patch set to make it easily digestible.
  No worries, will resubmit it once the non-uniform erase supports gets
  approved.
- SNOR_ERASE_FLAGS_OFFSET was buggy and since it's used only once
  in the uniform erase case, remove it entirely and do the init by
  hand
- describe all introduced functions together with arguments and
  return value
- various minor updates: drop a cast, rename a function - cosmetics ...

Changes in v2:
- add JESD216B SFDP optional parsers: Sector Map Parameter Table parser and
  4-byte Address Instruction Table parser (patch 2/3 and patch 3/3).

- save the Erase Types from bfpt to determine the Erase Type sizes. Sort all
  the map's Erase Types in ascending order with the smallest erase size being
  the first member in the erase_type array. Sort in the same way the Erase Type
  mask in regions in order to have a 1-to-1 correspondence with the Erase
  Types defined in the map. We sort the Erase Type by size, at init, in order to
  speed up the process of finding the best erase command at run-time.

- remove setting of mtd->erasesize and nor->erase_opcode when parsing the Basic
  Flash Parameter Table. mtd->erasesize was set to the maximum supported Erase
  Type size, without verifying if that Erase Type can erase the entire flash.
  mtd->erasesize is now set just in spi_nor_select_erase(), after we find which
  Erase Types are supported in the uniform case.

- spi_nor_select_erase(): pass directly info->sector_size instead of the whole
  flash_info structure in order to simplify the code.

- fix condition on finding erase regions:
  while (addr < region_start || addr >= region_end) {
- fix the list command adding: list_add_tail() instead of list_add()
- write_enable(nor); before erasing the sectors
- As Boris suggested, remove likely() because it doesn't make any difference
  given the time it takes to actually erase the block.
- bool return value for spi_nor_has_uniform_erase().

Changes in v1 or what I've done on top of Cyrille's work (https://lkml.org/lkml//
2017/4/15/70):
- minimize the amount of erase() calls by using the best sequence of erase
  type commands depending on alignment.
- build the list of best fitted erase commands to be executed once we
  validate that the erase can be performed.
- add improvements on how the erase map is handled. The regions are
  consecutive in the address space, walk through the regions incrementally.
- speed up finding the best erase type command. Order erase types by
  size, iterate them from the biggest to the smallest and stop when best
  fitted command is found.
- determine at init if there are erase types that can erase the entire
  memory
- fix support for overlaid regions.


Tudor Ambarus (2):
  mtd: spi-nor: add support to non-uniform SFDP SPI NOR flash memories
  mtd: spi-nor: parse SFDP Sector Map Parameter Table

 drivers/mtd/spi-nor/spi-nor.c | 910 +++++++++++++++++++++++++++++++++++++++---
 include/linux/mtd/spi-nor.h   | 119 ++++++
 2 files changed, 971 insertions(+), 58 deletions(-)

-- 
2.9.4

