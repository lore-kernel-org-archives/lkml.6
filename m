Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF1AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310FE20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310FE20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeJWR3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:29:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40821 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbeJWR3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:29:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BE2B6208C7; Tue, 23 Oct 2018 11:06:44 +0200 (CEST)
Received: from bbrezillon (aaubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5E57020794;
        Tue, 23 Oct 2018 11:06:34 +0200 (CEST)
Date:   Tue, 23 Oct 2018 11:06:34 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
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
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v4 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Message-ID: <20181023110634.26ff2629@bbrezillon>
In-Reply-To: <1540284888-32307-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1540284888-32307-2-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018 08:56:46 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> +struct nxp_fspi {
> +	void __iomem *iobase;
> +	void __iomem *ahb_addr;
> +	u32 memmap_phy;
> +	u32 memmap_phy_size;
> +	struct clk *clk, *clk_en;
> +	struct device *dev;
> +	struct completion c;
> +	const struct nxp_fspi_devtype_data *devtype_data;
> +	struct mutex lock;
> +	struct pm_qos_request pm_qos_req;
> +	int selected;
> +	void (*write)(u32 val, void __iomem *addr);
> +	u32 (*read)(void __iomem *addr);

I think I already commented on this aspect, and I keep thinking having a
function pointer is overkill here.
Just declare 2 functions and do the f->devtype_data->little_endian
check in there:

static u32 fspi_readl(struct nxp_fspi *f, void __iomem *addr)
{
	if (f->devtype_data->little_endian)
		return ioread32(addr);

	return ioread32be(addr);
}

static void fspi_writel(struct nxp_fspi *f, u32 val, void __iomem *addr)
{
	if (f->devtype_data->little_endian)
		iowrite32(val, addr);

	iowrite32be(val, addr);
}
