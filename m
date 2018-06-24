Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FA7C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 19:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD5F252DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 19:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD5F252DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbeFXTuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 15:50:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57690 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751728AbeFXTuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 15:50:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D78152079C; Sun, 24 Jun 2018 21:50:14 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4BC41206A0;
        Sun, 24 Jun 2018 21:50:14 +0200 (CEST)
Date:   Sun, 24 Jun 2018 21:50:14 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, benjamin.lindqvist@endian.se,
        pgaikwad@nvidia.com, dev@lynxeye.de, mirza.krak@gmail.com,
        richard@nod.at, pdeschrijver@nvidia.com,
        linux-kernel@vger.kernel.org, krzk@kernel.org,
        jonathanh@nvidia.com, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, marcel@ziswiler.com,
        miquel.raynal@bootlin.com, linux-tegra@vger.kernel.org,
        digetx@gmail.com, gaireg@gaireg.de
Subject: Re: [PATCH v7 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
Message-ID: <20180624215014.3249b382@bbrezillon>
In-Reply-To: <20180624192230.4674-5-stefan@agner.ch>
References: <20180624192230.4674-1-stefan@agner.ch>
        <20180624192230.4674-5-stefan@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2018 21:22:28 +0200
Stefan Agner <stefan@agner.ch> wrote:

> +
> +static int tegra_nand_remove(struct platform_device *pdev)
> +{
> +	struct tegra_nand_controller *ctrl = platform_get_drvdata(pdev);
> +
> +	nand_release(nand_to_mtd(ctrl->chip));

I still see nand_release() being used here. As I said in my review of
v6, it's not safe. Please use mtd_device_unregister() + nand_cleanup()
instead, and check the return code of mtd_device_unregister().

With this addressed

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> +
> +	clk_disable_unprepare(ctrl->clk);
> +
> +	return 0;
> +}
> +
