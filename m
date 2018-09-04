Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E66C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC2A20645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC2A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeIDTYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:24:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43983 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbeIDTYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:24:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0615A208B9; Tue,  4 Sep 2018 16:58:54 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9BC41206EE;
        Tue,  4 Sep 2018 16:58:43 +0200 (CEST)
Date:   Tue, 4 Sep 2018 16:58:42 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] spi: spi-mem: Add a driver for NXP FlexSPI
 controller
Message-ID: <20180904165842.774ed960@bbrezillon>
In-Reply-To: <1535711404-29528-4-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1535711404-29528-4-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

On Fri, 31 Aug 2018 16:00:00 +0530
Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> - Add a driver for NXP FlexSPI host controller
> 
> (0) What is the FlexSPI controller?
>  FlexSPI is a flexsible SPI host controller which supports two SPI
>  channels and up to 4 external devices.
>  Each channel supports Single/Dual/Quad/Octal mode data 
>  transfer (1/2/4/8 bidirectional data lines) 
>  i.e. FlexSPI acts as an interface to external devices,
>  maximum 4, each with up to 8 bidirectional data lines.
> 
>  It uses new SPI memory interface of the SPI framework to issue flash
>  memory operations to up to four connected flash chips (2 buses with
>  2 CS each).
>  Chipselect for each flash can be selected as per address assigned in
>  controller specific registers.
> 
>  FlexSPI controller is similar to the existing Freescale/NXP QuadSPI
>  controller with advanced features.

Yep, I had a quick look at the code and they really look similar. Why
not extending the existing driver instead of creating a new one from
scratch?

> 
> (1) The FlexSPI controller is driven by the LUT(Look-up Table)
>  registers.
>  The LUT registers are a look-up-table for sequences of instructions.
>  A valid sequence consists of four LUT registers.
>  Maximum 32 LUT sequences can be programmed simultaneously.
> 
> (2) The definition of the LUT register shows below:
>  ---------------------------------------------------
>  | INSTR1 | PAD1 | OPRND1 | INSTR0 | PAD0 | OPRND0 |
>  ---------------------------------------------------
> 
>  There are several types of INSTRx, such as:
>  CMD     : the SPI NOR command.
>  ADDR    : the address for the SPI NOR command.
>  DUMMY   : the dummy cycles needed by the SPI NOR command.
>  ....
> 
>  There are several types of PADx, such as:
>  PAD1    : use a singe I/O line.
>  PAD2    : use two I/O lines.
>  PAD4    : use quad I/O lines.
>  PAD8    : use octal I/O lines.
>  ....
> 
> (3) LUTs are being created at run-time based on the commands passed
>  from the spi-mem framework. Thus, using single LUT index.
> 
> (4) Software triggered Flash read/write access by IP Bus.
> 
> (5) Memory mapped read access by AHB Bus.

Do we really want to have this level of details in the commit message?
I mean, this is something you can document in the driver, but not here.

BTW, you might want to have a look at [1]. I think we can get rid of
the ->size field you're adding if this driver implements the dirmap
hooks.

> 
> (6) Tested this driver with the mtd_debug and JFFS2 filesystem utility
>  on NXP LX2160ARDB and LX2160AQDS targets.
>  LX2160ARDB is having two NOR slave device connected on single bus A
>  i.e. A0 and A1 (CS0 and CS1).
>  LX2160AQDS is having two NOR slave device connected on separate buses
>  one flash on A0 and second on B1 i.e. (CS0 and CS3).
>  Verified this driver on following SPI NOR flashes:
>     Micron, mt35xu512ab, [Read - 1 bit mode]
>     Cypress, s25fl512s, [Read - 1/2/4 bit mode]

Ok, that's good to have in the commit message.

> 
> - Add config option entry in 'spi-nor/Kconfig' for FlexSPI driver.

But this one is useless. If you add a new driver, you have no other
choice but to add a new entry in the Kconfig file.

> 
> - Add entry in the 'spi-nor/Makefile'.
>

Ditto.

Before you re-send a new version, I'd like to understand why you think
you need to create a new driver, and I want you to try to implement the
dirmap hook and check if you can get rid of the ->size field when doing
that.

I also seem one extra benefit to having a single driver for both
FlexSPI and QuadSPI IPs: you'll help Frieder debug the last remaining
problems you reported on the new QuadSPI driver :-P.

Thanks,

Boris
