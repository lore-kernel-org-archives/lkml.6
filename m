Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3228BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D05C2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfAROoe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:44:34 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46588 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbfAROoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:44:30 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 71667207A3; Fri, 18 Jan 2019 15:44:28 +0100 (CET)
Received: from localhost (alyon-652-1-26-46.w109-213.abo.wanadoo.fr [109.213.9.46])
        by mail.bootlin.com (Postfix) with ESMTPSA id EDBD2206A7;
        Fri, 18 Jan 2019 15:44:27 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 3/3] phy: make phy-armada375-usb2 explicitly non-modular
References: <1544402090-30970-1-git-send-email-paul.gortmaker@windriver.com>
        <1544402090-30970-4-git-send-email-paul.gortmaker@windriver.com>
Date:   Fri, 18 Jan 2019 15:44:27 +0100
In-Reply-To: <1544402090-30970-4-git-send-email-paul.gortmaker@windriver.com>
        (Paul Gortmaker's message of "Sun, 9 Dec 2018 19:34:50 -0500")
Message-ID: <87h8e6m3ec.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,
 
 On dim., déc. 09 2018, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> The Kconfig currently controlling compilation of this code is:
>
> drivers/phy/marvell/Kconfig:config ARMADA375_USBCLUSTER_PHY
> drivers/phy/marvell/Kconfig:    def_bool y
>
> ...meaning that it currently is not being built as a module by anyone.
>
> Lets remove the couple of traces of modular infrastructure, so that
> when reading the driver there is no doubt it is builtin-only.
>
> Since module_platform_driver() uses the same init level priority as
> builtin_platform_driver() the init ordering remains unchanged with
> this commit.
>
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
>
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory

> ---
>  drivers/phy/marvell/phy-armada375-usb2.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/phy/marvell/phy-armada375-usb2.c b/drivers/phy/marvell/phy-armada375-usb2.c
> index 1a3db288c0a9..4f0295992500 100644
> --- a/drivers/phy/marvell/phy-armada375-usb2.c
> +++ b/drivers/phy/marvell/phy-armada375-usb2.c
> @@ -18,7 +18,6 @@
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> @@ -142,7 +141,6 @@ static const struct of_device_id of_usb_cluster_table[] = {
>  	{ .compatible = "marvell,armada-375-usb-cluster", },
>  	{ /* end of list */ },
>  };
> -MODULE_DEVICE_TABLE(of, of_usb_cluster_table);
>  
>  static struct platform_driver armada375_usb_phy_driver = {
>  	.probe	= armada375_usb_phy_probe,
> @@ -151,8 +149,4 @@ static struct platform_driver armada375_usb_phy_driver = {
>  		.name  = "armada-375-usb-cluster",
>  	}
>  };
> -module_platform_driver(armada375_usb_phy_driver);
> -
> -MODULE_DESCRIPTION("Armada 375 USB cluster driver");
> -MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
> -MODULE_LICENSE("GPL");
> +builtin_platform_driver(armada375_usb_phy_driver);
> -- 
> 2.7.4
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
