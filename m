Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97A6C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B102B20863
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfBLKrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:47:43 -0500
Received: from gloria.sntech.de ([185.11.138.130]:35280 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbfBLKrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:47:41 -0500
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gtVbA-00013l-F1; Tue, 12 Feb 2019 11:47:32 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] phy: Variable "caldone" in function rockchip_emmc_phy_power() could be uninitialized
Date:   Tue, 12 Feb 2019 11:47:31 +0100
Message-ID: <1884796.YtlDmFZGdE@diego>
In-Reply-To: <20190206014733.21094-1-yzhai003@ucr.edu>
References: <20190206014733.21094-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 6. Februar 2019, 02:47:33 CET schrieb Yizhuo:
> In function rockchip_emmc_phy_power(), local variable "caldone"
> could be uninitialized if function regmap_read() returns -EINVAL.
> However, it will be used directly in the later context, which
> is potentially unsafe.
> 
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/phy/rockchip/phy-rockchip-emmc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c
> b/drivers/phy/rockchip/phy-rockchip-emmc.c index f1b24f18e9b2..ca921ae08309
> 100644
> --- a/drivers/phy/rockchip/phy-rockchip-emmc.c
> +++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
> @@ -85,11 +85,12 @@ struct rockchip_emmc_phy {
>  static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
>  {
>  	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
> -	unsigned int caldone;
> +	unsigned int caldone = 0;

hmm, this may hide actual uninitialized uses in the future?
With the added error handling below, there shouldn't be a case
where caldone might be used uninitialized still?


Heiko

>  	unsigned int dllrdy;
>  	unsigned int freqsel = PHYCTRL_FREQSEL_200M;
>  	unsigned long rate;
>  	unsigned long timeout;
> +	int err;
> 
>  	/*
>  	 * Keep phyctrl_pdb and phyctrl_endll low to allow
> @@ -164,9 +165,14 @@ static int rockchip_emmc_phy_power(struct phy *phy,
> bool on_off) * wait 5us for calpad busy trimming
>  	 */
>  	udelay(5);
> -	regmap_read(rk_phy->reg_base,
> +	err = regmap_read(rk_phy->reg_base,
>  		    rk_phy->reg_offset + GRF_EMMCPHY_STATUS,
>  		    &caldone);
> +	if (err) {
> +		pr_err("Failed to read status.\n");
> +		return err;
> +	}
> +
>  	caldone = (caldone >> PHYCTRL_CALDONE_SHIFT) & PHYCTRL_CALDONE_MASK;
>  	if (caldone != PHYCTRL_CALDONE_DONE) {
>  		pr_err("rockchip_emmc_phy_power: caldone timeout.\n");




