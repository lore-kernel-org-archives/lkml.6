Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 53rMFnmJGlujBwAAmS7hNA
	; Fri, 08 Jun 2018 13:54:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F3400607E4; Fri,  8 Jun 2018 13:54:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 72D84606FA;
	Fri,  8 Jun 2018 13:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72D84606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeFHNyF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:54:05 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:31178 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeFHNyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:54:04 -0400
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="14762806"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Jun 2018 06:54:04 -0700
Received: from [10.159.245.163] (10.10.76.4) by chn-sv-exch06.mchp-main.com
 (10.10.76.107) with Microsoft SMTP Server id 14.3.352.0; Fri, 8 Jun 2018
 06:54:03 -0700
Subject: Re: [PATCH] add support to non-uniform SFDP SPI NOR flash memories
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
        <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <Cristian.Birsan@microchip.com>
References: <20180608134818.21387-1-tudor.ambarus@microchip.com>
From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
Message-ID: <d171a525-e2bd-be61-1fd4-d6ffeecdc9b4@microchip.com>
Date: Fri, 8 Jun 2018 15:54:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608134818.21387-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

Le 08/06/2018 à 15:48, Tudor Ambarus a écrit :
> The commit message became wall-of-text, my feeling is that I heavily
> reworked the code so I changed the author. If someone thinks differently,
> please say and I'll change back to the initial authorship. What I've done:

It's obvious that you're the author of the patch so I'm totally fine with
this change :)

Best regards,

Cyrille

> 
> - minimize the amount of erase() calls by using the best sequence of erase
>   type commands depending on alignment.
> 
> - build the list of best fitted erase commands to be executed once we
>   validate that the erase can be performed.
> 
> - add improvements on how the erase map is handled. The regions are
>   consecutive in the address space, walk through the regions incrementally.
> 
> - speed up finding the best erase type command. Order erase types by
>   size, iterate them from the biggest to the smallest and stop when best
>   fitted command is found.
> 
> - determine at init if there are erase types that can erase the entire
>   memory
> 
> - fix the erase size in overlaid regions. S25FS512S states that 'if a sector
>   erase command is applied to a 256KB range that is overlaid by 4KB secors,
>   the overlaid 4kB sectors are not affected by the erase'
> 
> Backward compatibility test done on MX25L25673G.
> 
> Changes since RFC PATCH:
> - build a list of erase commands to be executed once we validate
>   that the erase can be performed
> - fix walking through the address space in overlaid regions
> - drop wall-of-text description commit message, change author
> 
> 
> Tudor Ambarus (1):
>   mtd: spi-nor: add support to non-uniform SFDP SPI NOR flash memories
> 
>  drivers/mtd/spi-nor/spi-nor.c | 357 ++++++++++++++++++++++++++++++++++++++++--
>  include/linux/mtd/spi-nor.h   | 108 +++++++++++++
>  2 files changed, 451 insertions(+), 14 deletions(-)
> 
