Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03D0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939D5214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfBLKtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:49:55 -0500
Received: from gloria.sntech.de ([185.11.138.130]:35322 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfBLKtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:49:55 -0500
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gtVdP-00014V-Tf; Tue, 12 Feb 2019 11:49:51 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] phy: rockchip-typec: Variable "val" of function rockchip_usb3_phy_power_on() could be uninitialized
Date:   Tue, 12 Feb 2019 11:49:51 +0100
Message-ID: <3410531.oxWKaip9ZE@diego>
In-Reply-To: <20190206021810.21596-1-yzhai003@ucr.edu>
References: <20190206021810.21596-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 6. Februar 2019, 03:18:10 CET schrieb Yizhuo:
> In function rockchip_usb3_phy_power_on(), local variable
> "val" could be uninitialized if function regmap_read()
> returns -EINVAL. However, this value is directly used in
> later context. This is potentially unsafe.

While highly unlikely case (GRF-registers are mmio-based),
it's still nicer to go the clean way, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/phy/rockchip/phy-rockchip-typec.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c
> b/drivers/phy/rockchip/phy-rockchip-typec.c index
> a958c9bced01..b1e24418cb2d 100644
> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c
> @@ -716,7 +716,10 @@ static int rockchip_usb3_phy_power_on(struct phy *phy)
> 
>  	/* wait TCPHY for pipe ready */
>  	for (timeout = 0; timeout < 100; timeout++) {
> -		regmap_read(tcphy->grf_regs, reg->offset, &val);
> +		ret = regmap_read(tcphy->grf_regs, reg->offset, &val);
> +		if (ret)
> +			goto unlock_ret;
> +
>  		if (!(val & BIT(reg->enable_bit))) {
>  			tcphy->mode |= new_mode & (MODE_DFP_USB | MODE_UFP_USB);
>  			goto unlock_ret;




