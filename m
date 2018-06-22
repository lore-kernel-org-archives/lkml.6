Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CA8C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C352460E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C352460E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754505AbeFVQuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:50:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33499 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbeFVQuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:50:00 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EC976207EB; Fri, 22 Jun 2018 18:49:57 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 97415203B0;
        Fri, 22 Jun 2018 18:49:47 +0200 (CEST)
Date:   Fri, 22 Jun 2018 18:49:47 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-stable #4 . 14+" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v4 1/5] mtd: rawnand: denali_dt: set clk_x_rate to 200
 MHz unconditionally
Message-ID: <20180622184947.339694b6@bbrezillon>
In-Reply-To: <1529683598-25783-2-git-send-email-yamada.masahiro@socionext.com>
References: <1529683598-25783-1-git-send-email-yamada.masahiro@socionext.com>
        <1529683598-25783-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2018 01:06:34 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Since commit 1bb88666775e ("mtd: nand: denali: handle timing parameters
> by setup_data_interface()"), denali_dt.c gets the clock rate from the
> clock driver.  The driver expects the frequency of the bus interface
> clock, whereas the clock driver of SOCFPGA provides the core clock.
> Thus, the setup_data_interface() hook calculates timing parameters
> based on a wrong frequency.
> 
> To make it work without relying on the clock driver, hard-code the clock
> frequency, 200MHz.  This is fine for existing DT of UniPhier, and also
> fixes the issue of SOCFPGA because both platforms use 200 MHz for the
> bus interface clock.
> 
> Fixes: 1bb88666775e ("mtd: nand: denali: handle timing parameters by setup_data_interface()")
> Cc: linux-stable <stable@vger.kernel.org> #4.14+
> Reported-by: Philipp Rosenberger <p.rosenberger@linutronix.de>
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Tested-by: Richard Weinberger <richard@nod.at>

Applied.

Thanks,

Boris

> ---
> 
> Changes in v4:
>   - split into a very simple patch for backport candiate
> 
>  drivers/mtd/nand/raw/denali_dt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
> index cfd33e6..5869e90 100644
> --- a/drivers/mtd/nand/raw/denali_dt.c
> +++ b/drivers/mtd/nand/raw/denali_dt.c
> @@ -123,7 +123,11 @@ static int denali_dt_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	denali->clk_x_rate = clk_get_rate(dt->clk);
> +	/*
> +	 * Hardcode the clock rate for the backward compatibility.
> +	 * This works for both SOCFPGA and UniPhier.
> +	 */
> +	denali->clk_x_rate = 200000000;
>  
>  	ret = denali_init(denali);
>  	if (ret)

