Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JxpPJi+JGls6EAAAmS7hNA
	; Fri, 08 Jun 2018 13:48:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7FE23608BA; Fri,  8 Jun 2018 13:48:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D55B260590;
	Fri,  8 Jun 2018 13:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D55B260590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeFHNs3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:48:29 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:24138 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752693AbeFHNs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:48:27 -0400
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="12312498"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Jun 2018 06:48:27 -0700
Received: from localhost.localdomain.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Fri, 8 Jun 2018 06:48:26 -0700
From: Tudor Ambarus <tudor.ambarus@microchip.com>
To: <marek.vasut@gmail.com>, <cyrille.pitchen@microchip.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <boris.brezillon@bootlin.com>, <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <Cristian.Birsan@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] add support to non-uniform SFDP SPI NOR flash memories
Date: Fri, 8 Jun 2018 16:48:17 +0300
Message-ID: <20180608134818.21387-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit message became wall-of-text, my feeling is that I heavily
reworked the code so I changed the author. If someone thinks differently,
please say and I'll change back to the initial authorship. What I've done:

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

- fix the erase size in overlaid regions. S25FS512S states that 'if a sector
  erase command is applied to a 256KB range that is overlaid by 4KB secors,
  the overlaid 4kB sectors are not affected by the erase'

Backward compatibility test done on MX25L25673G.

Changes since RFC PATCH:
- build a list of erase commands to be executed once we validate
  that the erase can be performed
- fix walking through the address space in overlaid regions
- drop wall-of-text description commit message, change author


Tudor Ambarus (1):
  mtd: spi-nor: add support to non-uniform SFDP SPI NOR flash memories

 drivers/mtd/spi-nor/spi-nor.c | 357 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/mtd/spi-nor.h   | 108 +++++++++++++
 2 files changed, 451 insertions(+), 14 deletions(-)

-- 
2.9.4
