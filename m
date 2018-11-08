Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D32C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1471B20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1471B20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeKHS3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:29:47 -0500
Received: from gloria.sntech.de ([185.11.138.130]:50174 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbeKHS3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:29:46 -0500
Received: from ip5f5a905a.dynamic.kabel-deutschland.de ([95.90.144.90] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gKg5s-00025l-4Q; Thu, 08 Nov 2018 09:55:16 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.co.uk>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] input: cros_ec_keyb: fix button/switch capability reports
Date:   Thu, 08 Nov 2018 09:55:14 +0100
Message-ID: <3546338.6jxQVHVFiU@phil>
In-Reply-To: <20181107223813.178462-1-briannorris@chromium.org>
References: <20181107223813.178462-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 7. November 2018, 23:38:13 CET schrieb Brian Norris:
> The cros_ec_keyb_bs array lists buttons and switches together, expecting
> that its users will match the appropriate type and bit fields. But
> cros_ec_keyb_register_bs() only checks the 'bit' field, which causes
> misreported input capabilities in some cases. For example, tablets
> (e.g., Scarlet -- a.k.a. Acer Chromebook Tab 10) were reporting a SW_LID
> capability, because EC_MKBP_POWER_BUTTON and EC_MKBP_LID_OPEN happen to
> share the same bit.
> 
> (This has comedic effect on a tablet, in which a power-management daemon
> then thinks this "lid" is closed, and so puts the system to sleep as
> soon as it boots!)
> 
> To fix this, check both the 'ev_type' and 'bit' fields before reporting
> the capability.
> 
> Tested with a lid (Kevin / Samsung Chromebook Plus) and without a lid
> (Scarlet / Acer Chromebook Tab 10).
> 
> This error got introduced when porting the feature from the downstream
> Chromium OS kernel to be upstreamed.
> 
> Fixes: cdd7950e7aa4 ("input: cros_ec_keyb: Add non-matrix buttons and switches")
> Cc: <stable@vger.kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


> ---
>  drivers/input/keyboard/cros_ec_keyb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 81be6f781f0b..d56001181598 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -493,7 +493,8 @@ static int cros_ec_keyb_register_bs(struct cros_ec_keyb *ckdev)
>  	for (i = 0; i < ARRAY_SIZE(cros_ec_keyb_bs); i++) {
>  		const struct cros_ec_bs_map *map = &cros_ec_keyb_bs[i];
>  
> -		if (buttons & BIT(map->bit))
> +		if ((map->ev_type == EV_KEY && (buttons & BIT(map->bit))) ||
> +		    (map->ev_type == EV_SW && (switches & BIT(map->bit))))
>  			input_set_capability(idev, map->ev_type, map->code);
>  	}
>  
> 




