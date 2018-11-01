Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1653BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9E72081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9E72081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeKARyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:54:37 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:61809 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeKARyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 13:54:37 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-04.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gI8iG-00039B-FF from Vladimir_Zapolskiy@mentor.com ; Thu, 01 Nov 2018 01:52:24 -0700
Received: from [137.202.108.125] (137.202.0.90) by
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 1 Nov 2018 08:52:20 +0000
Subject: Re: [PATCH] pinctrl: lpc18xx: Use define directive for
 PIN_CONFIG_GPIO_PIN_INT
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20181101005257.8778-1-natechancellor@gmail.com>
CC:     Vladimir Zapolskiy <vz@mleia.com>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
From:   Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <0af2686f-3d9a-3ca6-e5c2-2955ffbd8bd5@mentor.com>
Date:   Thu, 1 Nov 2018 10:52:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181101005257.8778-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

thank you for your patch.

On 11/01/2018 02:52 AM, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another:
> 
> drivers/pinctrl/pinctrl-lpc18xx.c:643:29: warning: implicit conversion
> from enumeration type 'enum lpc18xx_pin_config_param' to different
> enumeration type 'enum pin_config_param' [-Wenum-conversion]
>         {"nxp,gpio-pin-interrupt", PIN_CONFIG_GPIO_PIN_INT, 0},
>         ~                          ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/pinctrl/pinctrl-lpc18xx.c:648:12: warning: implicit conversion
> from enumeration type 'enum lpc18xx_pin_config_param' to different
> enumeration type 'enum pin_config_param' [-Wenum-conversion]
>         PCONFDUMP(PIN_CONFIG_GPIO_PIN_INT, "gpio pin int", NULL, true),
>         ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> macro 'PCONFDUMP'
>         .param = a, .display = b, .format = c, .has_arg = d     \
>                  ^
> 2 warnings generated.
> 
> It is expected that pinctrl drivers can extend pin_config_param because
> of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> isn't an issue. Most drivers that take advantage of this define the
> PIN_CONFIG variables as constants, rather than enumerated values. Do the
> same thing here so that Clang no longer warns.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/140
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/pinctrl/pinctrl-lpc18xx.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-lpc18xx.c b/drivers/pinctrl/pinctrl-lpc18xx.c
> index a14bc5e5fc24..4bee606088e1 100644
> --- a/drivers/pinctrl/pinctrl-lpc18xx.c
> +++ b/drivers/pinctrl/pinctrl-lpc18xx.c
> @@ -631,13 +631,10 @@ static const struct pinctrl_pin_desc lpc18xx_pins[] = {
>  };
>  
>  /**
> - * enum lpc18xx_pin_config_param - possible pin configuration parameters
>   * @PIN_CONFIG_GPIO_PIN_INT: route gpio to the gpio pin interrupt
>   * 	controller.
>   */
> -enum lpc18xx_pin_config_param {
> -	PIN_CONFIG_GPIO_PIN_INT = PIN_CONFIG_END + 1,
> -};
> +#define PIN_CONFIG_GPIO_PIN_INT		(PIN_CONFIG_END + 1)
>  
>  static const struct pinconf_generic_params lpc18xx_params[] = {
>  	{"nxp,gpio-pin-interrupt", PIN_CONFIG_GPIO_PIN_INT, 0},
> 

The change, if it is applied, starts to produce a W=1 warning:

	drivers/pinctrl/pinctrl-lpc18xx.c:634: warning: Cannot understand  * @PIN_CONFIG_GPIO_PIN_INT: route gpio to the gpio pin interrupt on line 634 - I thought it was a doc line

Could you please take a look how to satisfy process_name() check from scripts/kernel-doc?

My proposals are:
1) change the first line of the comment block from '/**' to '/*',
2) remove '@' prefix symbol and place pinconf description on one line.

--
Best wishes,
Vladimir
