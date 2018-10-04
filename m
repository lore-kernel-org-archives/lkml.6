Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FF3C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84C62098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84C62098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJDObW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:31:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55285 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbeJDObW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:31:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E7AC220802; Thu,  4 Oct 2018 09:39:25 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 89094207B4;
        Thu,  4 Oct 2018 09:39:25 +0200 (CEST)
Date:   Thu, 4 Oct 2018 09:39:25 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Vignesh R <vigneshr@ti.com>, Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "juliensu@mxic.com.tw" <juliensu@mxic.com.tw>,
        "zhengxunli@mxic.com.tw" <zhengxunli@mxic.com.tw>,
        "masonccyang@mxic.com.tw" <masonccyang@mxic.com.tw>
Subject: Re: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for
 mt35xu512aba
Message-ID: <20181004093925.2961d881@bbrezillon>
In-Reply-To: <VI1PR04MB1038C20CA97E453FC4C9CEAE99EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
        <20181003165603.2579-2-vigneshr@ti.com>
        <VI1PR04MB1038C20CA97E453FC4C9CEAE99EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Julien, Zhengxunli and Mason from Macronix

Hi Yogesh,

On Thu, 4 Oct 2018 06:51:41 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Vignesh,
> 
> > -----Original Message-----
> > From: Vignesh R [mailto:vigneshr@ti.com]
> > Sent: Wednesday, October 3, 2018 10:26 PM
> > To: Boris Brezillon <boris.brezillon@bootlin.com>; Marek Vasut
> > <marek.vasut@gmail.com>; Rob Herring <robh+dt@kernel.org>
> > Cc: Brian Norris <computersforpeace@gmail.com>; Yogesh Narayan Gaur
> > <yogeshnarayan.gaur@nxp.com>; Linux ARM Mailing List <linux-arm-  
> > kernel@lists.infradead.org>; linux-mtd@lists.infradead.org;  
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Vignesh R
> > <vigneshr@ti.com>
> > Subject: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for mt35xu512aba
> > 
> > Micron's mt35xu512aba flash is an Octal flash that has x8 IO lines. It supports
> > read/write over 8 IO lines simulatenously. Add support for Octal read mode for
> > Micron mt35xu512aba.
> > Unfortunately, this flash is only complaint to SFDP JESD216B and does not seem
> > to support newer JESD216C standard that provides auto detection of Octal
> > mode capabilities and opcodes. Therefore, this capability is manually added
> > using new SPI_NOR_OCTAL_READ flag.
> >   
> 
> Thanks for sending the patch-set of adding octal support.
> If possible, can you share the MT35x datasheet?
> 
> I also have the patch ready in which I have added support for Read (1-1-8 and 1-8-8) protocol and Write (1-1-8 and 1-8-8).
> Also have added support of Octal in driver/spi/spi.c framework.
> 
> IMO, we would collaborate our patches.

Looks like we are of stepping on each others toes here (see this branch
[1]). I guess it's not a problem if we agree on who is working on what.

Yogesh, you already sent "spi: add flags for octal I/O data
transfer" [3] which is only adding the new OCTAL flags but is not
patching spi.c and spi-mem.c to take those new flags into account. Here
is my version of this patch [2] (it's still missing an update of
SPI_MEM_MAX_BUSWIDTH). Let me know what you want to do (rework your
version to address the problem or take mine).

Regarding other patches in [2], they're mainly here to add support for
X-X-X and DTR modes and get the m25p80 logic integrated in spi-nor.c so
that we can really check which NOR operations are supported by the SPI
controller.

Regards,

Boris

[1]https://github.com/bbrezillon/linux/commits/spi-nor/octo
[2]https://github.com/bbrezillon/linux/commit/9854a8fdd23f64e79859fd07a71d4a1c57b812f2
[3]https://patchwork.ozlabs.org/patch/894916/
