Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eIvnM3lEHVtLIAAAmS7hNA
	; Sun, 10 Jun 2018 15:32:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C218060791; Sun, 10 Jun 2018 15:32:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 491B5605A5;
	Sun, 10 Jun 2018 15:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 491B5605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753592AbeFJPcH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 11:32:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34823 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753407AbeFJPcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 11:32:05 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 059C0207A5; Sun, 10 Jun 2018 17:32:03 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7B39C20702;
        Sun, 10 Jun 2018 17:32:02 +0200 (CEST)
Date: Sun, 10 Jun 2018 17:32:02 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
Message-ID: <20180610173202.680d2ee8@bbrezillon>
In-Reply-To: <1868760.y7shk6NfjH@dimapc>
References: <20180531221637.6017-1-stefan@agner.ch>
        <22478634.OSqaXHucyu@dimapc>
        <5751ef697130ba93ce9fb7722a1ce117@agner.ch>
        <1868760.y7shk6NfjH@dimapc>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jun 2018 18:00:06 +0300
Dmitry Osipenko <digetx@gmail.com> wrote:

> > >> That seems a lot of work for a code path I do not intend to ever use :-)  
> > > 
> > > Are you sure that resetting HW resets the timing and other registers
> > > configuration? Reset implementation is HW-specific, like for example in a
> > > case of a video decoder the registers state is re-intialized on HW reset,
> > > but registers configuration is untouched in a case of resetting GPU. I'd
> > > suggest to check whether NAND controller resetting affects the HW
> > > configuration.  
> > It seems all registers are set back to their documented reset value:
> > 
> > [boot loader/ROM initialized values]
> > [    1.270253] tegra-nand 70008000.nand: Tegra NAND controller register
> > dump
> > [    1.277051] tegra-nand 70008000.nand: COMMAND: 0x66880104
> > [    1.282457] tegra-nand 70008000.nand: STATUS: 0x00000101
> > [    1.287763] tegra-nand 70008000.nand: ISR: 0x01000120
> > [    1.292818] tegra-nand 70008000.nand: IER: 0x00000000
> > [    1.297863] tegra-nand 70008000.nand: CONFIG: 0x00840000
> > [    1.303181] tegra-nand 70008000.nand: TIMING: 0x05040000
> > [    1.308486] tegra-nand 70008000.nand: TIMING2: 0x00000003
> > [    1.313897] tegra-nand 70008000.nand: CMD_REG1: 0x00000000
> > [    1.319377] tegra-nand 70008000.nand: CMD_REG2: 0x00000030
> > [    1.324868] tegra-nand 70008000.nand: ADDR_REG1: 0x03000000
> > [    1.330435] tegra-nand 70008000.nand: ADDR_REG2: 0x00000000
> > [    1.336011] tegra-nand 70008000.nand: DMA_MST_CTRL: 0x04100004
> > [    1.341838] tegra-nand 70008000.nand: DMA_CFG_A: 0x00000fff
> > [    1.347415] tegra-nand 70008000.nand: DMA_CFG_B: 0x0000001b
> > [    1.352991] tegra-nand 70008000.nand: FIFO_CTRL: 0x0000aa00
> > [reset]
> > [    1.358559] tegra-nand 70008000.nand: Tegra NAND controller register
> > dump
> > [    1.365352] tegra-nand 70008000.nand: COMMAND: 0x00800004
> > [    1.370744] tegra-nand 70008000.nand: STATUS: 0x00000101
> > [    1.376060] tegra-nand 70008000.nand: ISR: 0x00000100
> > [    1.381105] tegra-nand 70008000.nand: IER: 0x00000000
> > [    1.386161] tegra-nand 70008000.nand: CONFIG: 0x10030000
> > [    1.391466] tegra-nand 70008000.nand: TIMING: 0x00000000
> > [    1.396782] tegra-nand 70008000.nand: TIMING2: 0x00000000
> > [    1.402174] tegra-nand 70008000.nand: CMD_REG1: 0x00000000
> > [    1.407664] tegra-nand 70008000.nand: CMD_REG2: 0x00000000
> > [    1.413156] tegra-nand 70008000.nand: ADDR_REG1: 0x00000000
> > [    1.418722] tegra-nand 70008000.nand: ADDR_REG2: 0x00000000
> > [    1.424297] tegra-nand 70008000.nand: DMA_MST_CTRL: 0x24000000
> > [    1.430123] tegra-nand 70008000.nand: DMA_CFG_A: 0x00000000
> > [    1.435698] tegra-nand 70008000.nand: DMA_CFG_B: 0x00000000
> > [    1.441264] tegra-nand 70008000.nand: FIFO_CTRL: 0x0000aa00  
> 
> Alright, then indeed it's not really worth to bother with HW resetting here.  
> Probably only a kernel module reload or a reboot will help if HW is hung. 
> Maybe NAND controller / chip recovering is something that NAND core should be 
> handling in a such case by providing a nand_controller_reset() hook?
> 

I don't see what the core could do to help with that. We'd end up with
a new hook implemented by the controller that would be called by the
controller driver when it knows it's safe to reset the controller. So,
why bother exposing that in the core?
