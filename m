Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1078EC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F082073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F082073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeI2E3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:29:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45797 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbeI2E3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:29:49 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 005CF20737; Sat, 29 Sep 2018 00:04:01 +0200 (CEST)
Received: from bbrezillon (unknown [109.190.253.16])
        by mail.bootlin.com (Postfix) with ESMTPSA id 991DC206A7;
        Sat, 29 Sep 2018 00:04:00 +0200 (CEST)
Date:   Sat, 29 Sep 2018 00:03:59 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yogeshnarayan.gaur@nxp.com,
        richard@nod.at, Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        prabhakar.kushwaha@nxp.com, han.xu@nxp.com, broonie@kernel.org,
        david.wolfe@nxp.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, albert.aribaud@3adev.fr
Subject: Re: [RFC/RFT PATCH v1 0/9] mtd: fsl: quadspi: Fixes for
 fsl-quadspi.c driver (vybrid HW)
Message-ID: <20180929000359.34fe18ae@bbrezillon>
In-Reply-To: <20180926220739.620-1-lukma@denx.de>
References: <20180926220739.620-1-lukma@denx.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Thu, 27 Sep 2018 00:07:30 +0200
Lukasz Majewski <lukma@denx.de> wrote:

> Please find following set of patches, which provide improved behaviour
> of the fsl-quadspi.c driver on Vybrid vf610 HW.
> 
> Below code is based on previous work done by Albert ARIBAUD:
> https://patchwork.ozlabs.org/patch/675401/
> 
> I've cleaned up the code a bit, make separate patches, exclude not
> needed parts and port it to v4.19-rc3.
> 
> After applying those patches, the quadspi controller on vf610 works
> with UBI/UBIFS.
> The problem is with some corner case writes to raw MTD device
> (like writing 1023B with single byte writes). Those fail sometimes.
> 
> Regression tests can be found in the following repository:
> https://github.com/lmajewski/tests-spi/tree/master/tests
> 
> (Please read README.txt).
> 
> The NXP's community thread regarding HW issues in this block on
> the vf610:
> https://community.nxp.com/thread/485139
> 
> Maybe those patches will be helpful with the new, work in progress
> driver for spi-fsl-qspi.c

Talking about that, can you try to port your fixes on top of Frieder's
patchset? I'm pretty sure some bug fixes are irrelevant after the
migration to spi-mem (patch 1, 3, 4, 5, 6, 7 and 9 should be dropped I
think).

> 
> Lukasz Majewski (9):
>   Revert "mtd: fsl-quadspi: Rename SEQID_QUAD_READ to SEQID_READ"
>   mtd: qspi: Provide quirk to read only half of RX buffer (NXP's vybrid)
>   mtd: spi: Do not setup the default seqid as we got it set for DUAL and
>     QUAD
>   mtd: spi: Modify the HW capability mask according to supported RX
>     lanes
>   mtd: spi: Provide LUT entry to perform DUAL read
>   mtd: spi: Enhance the fsl_qspi_read() method to support DUAL and QUAD
>   mtd: spi: Add SPI_NOR_DUAL_READ property for the 'n25q128a13' Micron
>     memory
>   mtd: spi: Allocate memory corresponding to maximal fsl-quadspi.c
>     controller area
>   mtd: spi: Skip reading the Serial Flash Discoverable Parameters
