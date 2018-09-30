Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416A2C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 05:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20EC208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 05:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20EC208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeI3MLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 08:11:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36488 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbeI3MLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 08:11:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 46DFE207B4; Sun, 30 Sep 2018 07:39:29 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id CB0C420717;
        Sun, 30 Sep 2018 07:39:28 +0200 (CEST)
Date:   Sun, 30 Sep 2018 07:39:27 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Lukasz Majewski <lukma@denx.de>,
        Fabio Estevam <festevam@gmail.com>, prabhakar.kushwaha@nxp.com,
        han.xu@nxp.com
Cc:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yogeshnarayan.gaur@nxp.com,
        richard@nod.at, Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <fabio.estevam@nxp.com>, broonie@kernel.org,
        david.wolfe@nxp.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, albert.aribaud@3adev.fr
Subject: Re: [RFC/RFT PATCH v1 0/9] mtd: fsl: quadspi: Fixes for
 fsl-quadspi.c driver (vybrid HW)
Message-ID: <20180930073927.001c16d2@bbrezillon>
In-Reply-To: <20180929230240.1c8d844d@jawa>
References: <20180926220739.620-1-lukma@denx.de>
        <20180929000359.34fe18ae@bbrezillon>
        <20180929230240.1c8d844d@jawa>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Sat, 29 Sep 2018 23:02:40 +0200
Lukasz Majewski <lukma@denx.de> wrote:

> > Talking about that, can you try to port your fixes on top of Frieder's
> > patchset? I'm pretty sure some bug fixes are irrelevant after the
> > migration to spi-mem (patch 1, 3, 4, 5, 6, 7 and 9 should be dropped I
> > think).  
> 
> The problem is that Frieder's patch is using IP command mode for
> transfers smaller than AHB RX fifo size.
> This according to the comment in the current driver is broken in HW for
> Vybrid (so this is a regression).

Why not fixing that in the new driver?

> 
> I'm also wondering if other users of vf610 based boards experience
> issues with QSPI?

Are you sure the 4 I/O lines are wired on your design? Anyway, if it's
a bug that only hurts vf610, you should mask quad modes in ->hwcaps (or
patch fsl_qspi_supports_op() in the new driver), not change the SPI NOR
definition.

> 
> In my case, after running the UBI/UBIFS tests (on the original and
> new driver without those "fixes") I cannot mount the volume after
> creation as the header is wrongly read.

I'm not denying this fact, I'm just saying, now that you've found where
the issue comes from, you can also port the fix to the new driver.

Regards,

Boris
