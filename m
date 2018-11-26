Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18876C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DB620850
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="is5XHjh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DB620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeKZUcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:32:53 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:60764 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeKZUcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:32:52 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 7118125BE34;
        Mon, 26 Nov 2018 20:39:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1543225158; bh=7FvFJi8hu1lzAKM+QqarQNO+Bf44Vc9orBOZZcH6Thk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=is5XHjh8W329FO1ZsJeKYusdtUbA0FKzFChr8EX5zMO7xEogGgWR7Hcu1Ij+Syzcp
         +A0h1gcBLflDzisz9ZSzct7VhIyaK3QbeilXZ09yI7jtenl7TTwysjF4luvG3Qus6P
         qUJdo1jDT0wm6AKao78g4cSbAD7nPz+mCdFRKn6Q=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id A8ED0940461; Mon, 26 Nov 2018 10:39:16 +0100 (CET)
Date:   Mon, 26 Nov 2018 10:39:16 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "kishon@ti.com" <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] phy: renesas: rcar-gen3-usb2: follow the hardware manual
 procedure
Message-ID: <20181126093911.npr3ktohqciuq5my@verge.net.au>
References: <1542787663-32142-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542787663-32142-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 08:10:06AM +0000, Yoshihiro Shimoda wrote:
> This patch modifies rcar_gen3_init_otg() procedure to follow Figure
> 73.4 of "R-Car Series, 3rd Generation User's Manual: Hardware Rev.1.00".
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  This patch is based on the latest linux-phy / next branch
> (commit id = 0eb86fa77f0f0c81631a030f10679a45c05df33a).
> 
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> index d0f412c..a9e53e8 100644
> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -307,16 +307,21 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
>  	void __iomem *usb2_base = ch->base;
>  	u32 val;
>  
> +	rcar_gen3_set_linectrl(ch, 0, 1);
> +	val = readl(usb2_base + USB2_LINECTRL1);
> +	writel(val | USB2_LINECTRL1_DPRPD_EN | USB2_LINECTRL1_DMRPD_EN,
> +	       usb2_base + USB2_LINECTRL1);

I am wondering if as well as the above
USB2_LINECTRL1_DPRPD_EN should be set and
USB2_LINECTRL1_DP_RPD should be cleared.

> +
>  	val = readl(usb2_base + USB2_VBCTRL);
>  	writel(val | USB2_VBCTRL_DRVVBUSSEL, usb2_base + USB2_VBCTRL);
> -	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
> -	rcar_gen3_control_otg_irq(ch, 1);
>  	val = readl(usb2_base + USB2_ADPCTRL);
>  	writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
> -	val = readl(usb2_base + USB2_LINECTRL1);
> -	rcar_gen3_set_linectrl(ch, 0, 0);
> -	writel(val | USB2_LINECTRL1_DPRPD_EN | USB2_LINECTRL1_DMRPD_EN,
> -	       usb2_base + USB2_LINECTRL1);
> +
> +	msleep(20);
> +
> +	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);

I wonder if it is appropriate to write 0xffffffff to USB2_OBINTSTA 
and then USB2_OBINT_BITS to USB2_OBINTEN here.

> +
> +	rcar_gen3_control_otg_irq(ch, 1);
>  
>  	rcar_gen3_device_recognition(ch);
>  }
> -- 
> 1.9.1
> 
