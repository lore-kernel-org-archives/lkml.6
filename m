Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29DCC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D83D2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfA2KMP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:12:15 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39965 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfA2KMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:12:14 -0500
X-Originating-IP: 90.88.29.206
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 80EAE6000B;
        Tue, 29 Jan 2019 10:12:07 +0000 (UTC)
Date:   Tue, 29 Jan 2019 11:12:06 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 0/9] Rewrite clk parent handling
Message-ID: <20190129111206.36280b15@xps13>
In-Reply-To: <20190129061021.94775-1-sboyd@kernel.org>
References: <20190129061021.94775-1-sboyd@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Stephen Boyd <sboyd@kernel.org> wrote on Mon, 28 Jan 2019 22:10:12
-0800:

> There are a couple problems with clk parent handling in the common clk
> framework. This patch series combines a few different topics together as
> all this code is closely related.
> 
> First off, we don't do well at determining parents of clks at clk
> registration time because the return type of the clk_ops::get_parent()
> op is a u8 which isn't expressive enough to cover all our use-cases.
> 
> Secondly, we use strings for all parent-child linkages, and this leads
> to poorly written code that extracts clk names from struct clk pointers
> and makes clk provider drivers use clk consumer APIs. 
> 
> Thirdly, clkdev.c has a collection of DT parsing logic in it that is
> only used when the common clk framework is present but we want to use
> that same logic for describing parent-child linkages of clk providers
> via in DT. This should all be moved into the common clk framework and
> used from there as well as from clkdev.c, so this series changes the way
> clkdev interacts with the clk framework by having clkdev get clk_hw
> pointers out of DT clk specifiers and then convert those into clk
> pointers with clk_hw_create_clk(). Splitting the API this way lets us
> get clk_hw pointers for clk providers and skip the struct clk pointer
> creation phase that we don't need to do when describing parent-child
> linkages.
> 
> And finally, we have a few patches in here that lay the groundwork for
> supporting device links in the common clk framework. We do that by
> pushing the consuming device pointer through to the clk pointer creation
> in clk_hw_create_clk(). This wasn't always easy to do when we had
> __clk_create_clk() called from multiple places, some being deep in the
> clk registration path. This series simplifies that logic so that we can
> always attach a consumer device to a clk that we create in one place,
> instead of making that linkage in multiple places near where we create
> struct clk pointers.
> 
> Miquel Raynal (1):
>   clk: core: clarify the check for runtime PM
> 
> Stephen Boyd (8):
>   clk: Combine __clk_get() and __clk_create_clk()
>   clk: Introduce get_parent_hw clk op
>   clk: Introduce of_clk_get_hw_from_clkspec()
>   clk: Inform the core about consumer devices
>   clk: Move of_clk_*() APIs into clk.c from clkdev.c
>   clk: Allow parents to be specified without string names
>   clk: qcom: gcc-sdm845: Migrate to DT parent mapping
>   arm64: dts: qcom: Specify XO clk as input to GCC node
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi |   2 +
>  drivers/clk/clk.c                    | 584 ++++++++++++++++++++-------
>  drivers/clk/clk.h                    |  23 +-
>  drivers/clk/clkdev.c                 | 120 +-----
>  drivers/clk/qcom/gcc-sdm845.c        | 180 ++++-----
>  include/linux/clk-provider.h         |  26 +-
>  6 files changed, 583 insertions(+), 352 deletions(-)
> 
> 
> base-commit: 651022382c7f8da46cb4872a545ee1da6d097d2a

Thanks for working on this! I rebased my suspend to RAM work on top of
this version, including the patch adding clock device links (applies
cleanly). Everything looks fine:

[    1.859464] marvell-armada-3700-tbg-clock d0013200.tbg: Linked as a consumer to d0013800.pinctrl:xtal-clk
[    1.869415] marvell-armada-3700-tbg-clock d0013200.tbg: Dropping the link to d0013800.pinctrl:xtal-clk
[    1.879045] marvell-armada-3700-tbg-clock d0013200.tbg: Linked as a consumer to d0013800.pinctrl:xtal-clk
[    1.889466] marvell-armada-3700-periph-clock d0013000.nb-periph-clk: Linked as a consumer to d0013200.tbg
[    1.899369] marvell-armada-3700-periph-clock d0013000.nb-periph-clk: Linked as a consumer to d0013800.pinctrl:xtal-clk
[    1.910799] marvell-armada-3700-periph-clock d0018000.sb-periph-clk: Linked as a consumer to d0013200.tbg
[    1.977034] ahci-mvebu d00e0000.sata: Linked as a consumer to d0013000.nb-periph-clk
[    2.019689] armada_3700_spi d0010600.spi: Linked as a consumer to d0013000.nb-periph-clk
[    2.168316] mvneta d0030000.ethernet: Linked as a consumer to d0018000.sb-periph-clk
[    2.295016] xhci-hcd d0058000.usb: Linked as a consumer to d0018000.sb-periph-clk
[    2.431512] xenon-sdhci d00d0000.sdhci: Linked as a consumer to d0013000.nb-periph-clk
[    2.444835] xenon-sdhci d00d0000.sdhci: Dropping the link to d0013000.nb-periph-clk
[    2.526683] mvebu-uart d0012000.serial: Linked as a consumer to d0013800.pinctrl:xtal-clk
[    2.586209] advk-pcie d0070000.pcie: Linked as a consumer to d0018000.sb-periph-clk
[    4.498571] xenon-sdhci d00d0000.sdhci: Linked as a consumer to d0013000.nb-periph-clk
[    4.510078] xenon-sdhci d00d0000.sdhci: Linked as a consumer to regulator.1
[    4.559214] cpu cpu0: Linked as a consumer to d0013000.nb-periph-clk
[    4.565613] cpu cpu0: Dropping the link to d0013000.nb-periph-clk
[    4.571832] cpu cpu0: Linked as a consumer to d0013000.nb-periph-clk

Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
