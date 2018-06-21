Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23D1C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38D222463
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38D222463
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933797AbeFUWBm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:01:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36126 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933490AbeFUWBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:01:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2B683206D8; Fri, 22 Jun 2018 00:01:39 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 935F4203B0;
        Fri, 22 Jun 2018 00:01:28 +0200 (CEST)
Date:   Fri, 22 Jun 2018 00:01:28 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, dev@lynxeye.de,
        miquel.raynal@bootlin.com, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, digetx@gmail.com, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, gaireg@gaireg.de,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
Message-ID: <20180622000128.3ea45ef7@bbrezillon>
In-Reply-To: <20180621203145.7628-5-stefan@agner.ch>
References: <20180621203145.7628-1-stefan@agner.ch>
        <20180621203145.7628-5-stefan@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Thu, 21 Jun 2018 22:31:43 +0200
Stefan Agner <stefan@agner.ch> wrote:

> Add support for the NAND flash controller found on NVIDIA
> Tegra 2 SoCs. This implementation does not make use of the
> command queue feature. Regular operations using ->exec_op()
> use PIO mode for data transfers. Raw, ECC and OOB read/writes
> make use of the DMA mode for data transfer.
> 
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  MAINTAINERS                       |    7 +
>  drivers/mtd/nand/raw/Kconfig      |    6 +
>  drivers/mtd/nand/raw/Makefile     |    1 +
>  drivers/mtd/nand/raw/tegra_nand.c | 1225 +++++++++++++++++++++++++++++
>  4 files changed, 1239 insertions(+)
>  create mode 100644 drivers/mtd/nand/raw/tegra_nand.c

I think we're almost good. No big issues spotted in this version.
Can you fix the CHECKs/WARNINGs reported by checkpatch --strict (most
of them are valid)?

> +
> +static int tegra_nand_remove(struct platform_device *pdev)
> +{
> +	struct tegra_nand_controller *ctrl = platform_get_drvdata(pdev);
> +
> +	nand_release(nand_to_mtd(ctrl->chip));

Use mtd_device_unregister() + nand_cleanup() instead of nand_release().
nand_release() is broken in that it does not check the return code of
mtd_device_unregister() before calling nand_cleanup(), and does not
propagate mtd_device_unregister() ret code to its caller. 

> +
> +	clk_disable_unprepare(ctrl->clk);
> +
> +	return 0;
> +}

Thanks for the great work you've done! Yay, another driver implementing
->exec_op()!

Boris
