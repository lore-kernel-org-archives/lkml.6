Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F02C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEDF265BB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEDF265BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbeFZHKn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:10:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48663 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751846AbeFZHKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:10:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3705B206D8; Tue, 26 Jun 2018 09:10:40 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9B28B2087B;
        Tue, 26 Jun 2018 09:10:06 +0200 (CEST)
Date:   Tue, 26 Jun 2018 09:10:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: mxc: remove __init qualifier from
 mxcnd_probe_dt
Message-ID: <20180626091005.08d56b2a@xps13>
In-Reply-To: <1529679025-5735-1-git-send-email-martin@kaiser.cx>
References: <1529679025-5735-1-git-send-email-martin@kaiser.cx>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin, Boris,

On Fri, 22 Jun 2018 16:50:25 +0200, Martin Kaiser <martin@kaiser.cx>
wrote:

> mxcnd_probe_dt is called from mxcnd_probe, which is not marked as __init.
> 

I think this line is just a side note and should be at the end of the
commit log.

> Using the sysfs unbind, bind nodes, mxcnd_probe and mxcnd_probe_dt can
> potentially be called at any time. After the __init functions are cleaned,
> mxcnd_probe_dt is no longer available. Calling it anyway causes a crash.

The above paragraph explains the problem and the solution, you can just
add something like "mcvnd_probe is untouched because it is already not
marked as __init" instead of the first line.

> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Boris, do you think this patch is a good candidate for stable?

If yes, Martin, could you please add a couple of stable/fixes tags above
your SoB?

Thanks,
Miquèl

> ---
> I hope that my understanding is correct.
> 
> In practice, I could not get the kernel to crash, my compiler would
> inline mxcnd_probe_dt into mxcnd_probe and ignore the __init.
> 
> If I marked mxcnd_probe_dt as noinline, I could trigger a crash as
> follows
> 
> [root@host ]# echo bb000000.nand > /sys/bus/platform/drivers/mxc_nand/unbind
> [root@host ]# echo bb000000.nand > /sys/bus/platform/drivers/mxc_nand/bind
> Internal error: Oops - undefined instruction: 0 [#1] ARM
> ...
> 
>  drivers/mtd/nand/raw/mxc_nand.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
> index 26cef21..90cfb5e 100644
> --- a/drivers/mtd/nand/raw/mxc_nand.c
> +++ b/drivers/mtd/nand/raw/mxc_nand.c
> @@ -1686,7 +1686,7 @@ static const struct of_device_id mxcnd_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mxcnd_dt_ids);
>  
> -static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
> +static int mxcnd_probe_dt(struct mxc_nand_host *host)
>  {
>  	struct device_node *np = host->dev->of_node;
>  	const struct of_device_id *of_id =
> @@ -1700,7 +1700,7 @@ static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
>  	return 0;
>  }
>  #else
> -static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
> +static int mxcnd_probe_dt(struct mxc_nand_host *host)
>  {
>  	return 1;
>  }
