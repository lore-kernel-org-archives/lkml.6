Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9D7C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BCE20892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k4t21EEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BCE20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbeLBXYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:24:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeLBXYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yiaJgZq1AOWbaBs/Y66t+jplY6uCpT1lmW04p/9tYbU=; b=k4t21EEAnN2PaZ9TUVNMI0OYC
        bB/QLvAOcysQCDf2Sa3NjrcpQfCU/yDrKz3YO4Z/Zak5sJbLyVz1PX83I9sheHUY62p9iutjSl4B4
        2K/FlJ489pEwNLx1ddVEZ3rx+p0THcJ9IP/hQhD5WulFF3Tm7YJhqEVuzHAZ6hKTNODExKvozInQu
        5lUts4b6BVRiSTyLJLWSvonBZ/LXYFntJQi19+fZnMmLywOsbT5Inn9z9R3sT6ALSEHcPvyTVWS9j
        zD0lnu2JO7MJ0sI75uDw1B2PTtpEZQWFcPBbkSgeQORjvWg1aCvt4wBaQEXnn9X3Chq68NolYtGNi
        8G/deYlzw==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTb6C-000191-Mt; Sun, 02 Dec 2018 23:24:28 +0000
Date:   Sun, 2 Dec 2018 15:24:27 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 13/17] power: supply: olpc_battery: Use DT to get
 battery version
Message-ID: <20181202232427.GD23087@wrath>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-14-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116162403.49854-14-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 05:23:59PM +0100, Lubomir Rintel wrote:
> Avoid using the x86 OLPC platform specific call to get the board
> version. It won't work on FDT-based ARM MMP2 platform.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> Changes since v1:
> - Sort the new include a bit higher
> 
>  drivers/power/supply/olpc_battery.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
> index 5a97e42a3547..5323987d9284 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/err.h>
>  #include <linux/device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/jiffies.h>
> @@ -622,11 +623,13 @@ static int olpc_battery_probe(struct platform_device *pdev)
>  	olpc_ac = power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
>  	if (IS_ERR(olpc_ac))
>  		return PTR_ERR(olpc_ac);
> -
> -	if (olpc_board_at_least(olpc_board_pre(0xd0))) { /* XO-1.5 */
> +	if (of_property_match_string(pdev->dev.of_node, "compatible",
> +					"olpc,xo1.5-battery") >= 0) {
> +		/* XO-1.5 */
>  		olpc_bat_desc.properties = olpc_xo15_bat_props;
>  		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo15_bat_props);
> -	} else { /* XO-1 */
> +	} else {
> +		/* XO-1 */
>  		olpc_bat_desc.properties = olpc_xo1_bat_props;
>  		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo1_bat_props);
>  	}
> @@ -672,6 +675,7 @@ static int olpc_battery_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id olpc_battery_ids[] = {
>  	{ .compatible = "olpc,xo1-battery" },
> +	{ .compatible = "olpc,xo1.5-battery" },

The code previously supported xo1.5 (it seems), and the commit message doesn't
mention changing the compatible string. Was this an intentional change? If so,
it should be mentioned in the commit message.

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, olpc_battery_ids);
> -- 
> 2.19.1
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
