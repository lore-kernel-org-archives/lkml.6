Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7C1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739842081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="pyxZ3Oeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739842081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbeKWAsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:48:08 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:37900 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbeKWAsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:48:08 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 1735025BDFD;
        Fri, 23 Nov 2018 01:08:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1542895715; bh=saPfczYdxwFdiYA7nifJ+WLbmpTcdXhH54nNaj87G/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pyxZ3Oeo7sqyDDWnsrW5ORuZNP7DiJmJBrepgeIUj62h/7/AzgYbXRZMiKSl9NiTT
         y9lH+jR6OV1KRr+fKB1ZbqcBK2ipFqRMo7xA+cIyojuw0Z6ncwlp0ie6ngM52a2tEc
         M24ET2bSFRp9n3WCYcfALst+XqNZSIfJI0MCIHcY=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 26099940370; Thu, 22 Nov 2018 15:08:33 +0100 (CET)
Date:   Thu, 22 Nov 2018 15:08:33 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] pinctrl: rzn1: Fix check for used MDIO bus
Message-ID: <20181122140832.qcrhmmybdzbvfv6s@verge.net.au>
References: <20181119161838.10610-1-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119161838.10610-1-phil.edworthy@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 04:18:38PM +0000, Phil Edworthy wrote:
> This fixes the check for unused mdio bus setting and the following static
> checker warning:
>  drivers/pinctrl/pinctrl-rzn1.c:198 rzn1_pinctrl_mdio_select()
>  warn: always true condition '(ipctl->mdio_func[mdio] >= 0) => (0-u32max >= 0)'
> 
> It also fixes the return var when calling of_get_child_count()
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v2:
>  - Don't rely on rely on the implicit typecast from -1 to uint
> ---
>  drivers/pinctrl/pinctrl-rzn1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-rzn1.c b/drivers/pinctrl/pinctrl-rzn1.c
> index 57886dcff53d..cc0e5aa9128a 100644
> --- a/drivers/pinctrl/pinctrl-rzn1.c
> +++ b/drivers/pinctrl/pinctrl-rzn1.c
> @@ -112,7 +112,7 @@ struct rzn1_pinctrl {
>  	struct rzn1_pinctrl_regs __iomem *lev2;
>  	u32 lev1_protect_phys;
>  	u32 lev2_protect_phys;
> -	u32 mdio_func[2];
> +	int mdio_func[2];

Hi Phil,

rzn1_pinctrl_mdio_select() assigns values of type u32 to elements
of mdio_func. Perhaps that warrants cleaning up too?

>  
>  	struct rzn1_pin_group *groups;
>  	unsigned int ngroups;
> @@ -810,8 +810,8 @@ static int rzn1_pinctrl_probe_dt(struct platform_device *pdev,
>  	struct device_node *np = pdev->dev.of_node;
>  	struct device_node *child;
>  	unsigned int maxgroups = 0;
> -	unsigned int nfuncs = 0;
>  	unsigned int i = 0;
> +	int nfuncs = 0;
>  	int ret;
>  
>  	nfuncs = of_get_child_count(np);
> -- 
> 2.17.1
> 
