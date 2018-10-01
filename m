Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD73C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEC32064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEC32064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeJAPqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:46:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50100 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbeJAPqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:46:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CD25E208F4; Mon,  1 Oct 2018 11:09:55 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7879C206FF;
        Mon,  1 Oct 2018 11:09:45 +0200 (CEST)
Date:   Mon, 1 Oct 2018 11:09:46 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Message-ID: <20181001110946.5330a90e@bbrezillon>
In-Reply-To: <VI1PR04MB10381FD703F054F33B9BA6BE99EF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1537525323-20730-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20180929174023.51b1e284@bbrezillon>
        <7c10ced6-91af-187a-0c34-ce9b3e897e2e@exceet.de>
        <VI1PR04MB10381FD703F054F33B9BA6BE99EF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2018 09:02:32 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> > > static void fspi_writel(struct nxp_fspi *f, u32 val, void __iomem
> > > *addr) {
> > > 	if (f->big_endian)
> > > 		iowrite32be(val, addr);
> > > 	else
> > > 		iowrite32(val, addr);
> > > }
> > >
> > >
> > > static u32 fspi_readl(struct nxp_fspi *f, void __iomem *addr) {
> > > 	if (f->big_endian)
> > > 		return ioread32be(addr);
> > > 	else
> > > 		return ioread32(addr);
> > > }  
> > 
> > I introduced the ->read/write() hooks in the QSPI driver because I
> > was told to remove the conditional in the read/write path, but I
> > can't really tell if this really makes any difference.
> >   
> Yes, I have taken these hooks by looking into the comments received
> for Frieder's QSPI patch series. For me this looks more clean and can
> be decided in the controller initialization sequence which hook would
> going to be invoked.


Well, depending on your CPU, the indirect branch (caused by the
function pointer call) might have an higher cost than the conditional
branch. Not sure we care about such micro-optimizations though.
Regarding the readability aspect, I still prefer my version, but I
guess that's a matter of taste.
