Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6E9C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B94820645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B94820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeLJKu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:50:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55711 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbeLJKuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:50:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B9FAB20CEB; Mon, 10 Dec 2018 11:50:22 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2EE5820DC0;
        Mon, 10 Dec 2018 11:50:01 +0100 (CET)
Date:   Mon, 10 Dec 2018 11:50:01 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Message-ID: <20181210115001.6c7af1d7@bbrezillon>
In-Reply-To: <VI1PR04MB57268740CA806FFB164780EB99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1542366701-16065-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <eb8a31d8-2ba6-f27c-addf-545c77921b77@kontron.de>
        <VI1PR04MB57267D9F69719B4BEF38BF8699A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <20181210111909.35384eee@bbrezillon>
        <VI1PR04MB57268740CA806FFB164780EB99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 10:43:56 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> > > Thus, in LUT preparation we have assigned only the base address.
> > > Now if I have assigned ahb_buf_size to FSPI_FLSHXXCR0 register then for  
> > read/write data beyond limit of ahb_buf_size offset I get data corruption.
> > 
> > Why would you do that? We have the ->adjust_op_size() exactly for this reason,
> > so, if someone tries to do a spi_mem_op with data.nbytes > ahb_buf_size you
> > should return an error.
> >   
> Let me explain my implementation with example. If I have to write data of size 0x100 bytes at offset 0x1200 for CS1, I would program as below:
> In func nxp_fspi_select_mem(), would set value of controller address space size, memmap_phy_size, to FSPI_FLSHA2CR0 and rest all FSPI_FLSHXXCR0 as 0. 
> Value of memmap_phy_size is 0x10000000 i.e. 256 MB for my LX2160ARDB target.
> Then in nxp_fspi_prepare_lut(), I would prepare LUT ADDR with address length requirement 3/4 byte for NOR or 1/2/3/4 bytes for NAND flash.
> Also for LUT_NXP_WRITE would program data bytes as 0.
> 
> Then inside func nxp_fspi_do_op(), set register FSPI_IPCR0 as the address offset i.e. 0x1200 and in register FSPI_IPCR1 program the data size to write i.e. 0x100
> 
> If, as suggested if I tries to mark value of register FSPI_FLSHA2CR0 equal to ahb_buf_size (0x800), then access for address 0x1200 gives me wrong data. This is because as per the controller specification access to flash connected at CS1 can be performed under range of FSPI_ FLSHA1CR0 and FSPI_ FLSHA2CR0.

Don't you have a way to set an offset to apply to the address accessed
through the AHB? And if you don't, how will it work if your mapping
is smaller than the flash size?
