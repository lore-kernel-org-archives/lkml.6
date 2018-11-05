Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53F2C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B05A20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDYsxTqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B05A20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeKELfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 06:35:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeKELfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 06:35:55 -0500
Received: from tiger (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10B4C20685;
        Mon,  5 Nov 2018 02:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541384318;
        bh=Sh0A2noMlazwlCFayyQG4zN/9Ap9OtFiMpsBxTPRmoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IDYsxTqu4+kAes7w7haoqbNZ7LjrId9V8vT3W/vS4hCJlVEjTHSEfcQSpyeEwR4Mq
         uwegmeNEOmoLesrcaChnyXIj0i4V4/j1ZV77QYrlAzYf7GjO9F52Lwbyni66nd1WQE
         sAswYOY0hs6+XodJxHdWYIsoFxdYk0LuIGMf+/00=
Date:   Mon, 5 Nov 2018 10:18:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Andy Duan <fugang.duan@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ARM: dts: imx6sx-sdb: Fix enet phy regulator
Message-ID: <20181105021821.GA24464@tiger>
References: <c4478a98b0d2c69d58b4ba5cad3c13d73c5b387f.1539012355.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4478a98b0d2c69d58b4ba5cad3c13d73c5b387f.1539012355.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 03:28:01PM +0000, Leonard Crestez wrote:
> Bindings for "fixed-regulator" only explicitly support "gpio" property,
> not "gpios". Fix by correcting the property name.
> 
> The enet PHYs on imx6sx-sdb needs to be explicitly reset after a power
> cycle, this can be handled by the phy-reset-gpios property. Sadly this
> is not handled on suspend: the fec driver turns phy-supply off but
> doesn't assert phy-reset-gpios again on resume.
> 
> Since additional phy-level work is required to support powering off the
> phy in suspend fix the problem by just marking the regulator as
> "boot-on" "always-on" so that it's never turned off. This behavior is
> equivalent to older releases.
> 
> Keep the phy-reset-gpios property on fec anyway because it is a correct
> description of board design.
> 
> This issue was exposed by commit efdfeb079cc3 ("regulator: fixed:
> Convert to use GPIO descriptor only") which causes the "gpios" property
> to also be parsed. Before that commit the "gpios" property had no
> effect, PHY reset was only handled in the the bootloader.
> 
> This fixes linux-next boot failures previously reported here:
>  https://lore.kernel.org/patchwork/patch/982437/#1177900
>  https://lore.kernel.org/patchwork/patch/994091/#1178304
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
