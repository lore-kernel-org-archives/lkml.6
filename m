Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06212C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B252082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbfBDP4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:56:09 -0500
Received: from muru.com ([72.249.23.125]:37442 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728275AbfBDP4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:56:08 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B9D1E808C;
        Mon,  4 Feb 2019 15:56:16 +0000 (UTC)
Date:   Mon, 4 Feb 2019 07:56:04 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux@armlinux.org.uk, khilman@kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH] omap3: give off mode enable a more prominent place
Message-ID: <20190204155604.GH5720@atomide.com>
References: <20190202055827.12956-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190202055827.12956-1-andreas@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190202 06:01]:
> Enabling off mode was only reachable deeply hidden
> in the debugfs. As powersaving is an important feature,
> move the option out of its shady place.

How about let's enable always if we have the twl4030
configured to allow it? You can just check if the dts has
"ti,twl4030-power-idle" or "ti,twl4030-power-idle-osc-off"
properties set.

In order to enable deeper idle states, the user space still
needs to idle the UARTs and possibly other hardware blocking
idle. So we should be safe there.

> The debugfs file can still be used to override the default.

Yes let's keep the debugfs switch around. But it should
be optional for CONFIG_DEBUGFS like I think it now is.

> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -416,7 +416,12 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
>  	if (!pwrst)
>  		return -ENOMEM;
>  	pwrst->pwrdm = pwrdm;
> -	pwrst->next_state = PWRDM_POWER_RET;
> +
> +	if (IS_ENABLED(CONFIG_OMAP3_PM_OFFMODE))
> +		pwrst->next_state = PWRDM_POWER_OFF;
> +	else
> +		pwrst->next_state = PWRDM_POWER_RET;
> +
>  	list_add(&pwrst->node, &pwrst_list);
>  
>  	if (pwrdm_has_hdwr_sar(pwrdm))

You can check for the PMIC properties by adding a function
for omap3_pm_check_pmic() or similar and call it
from omap3_pm_init(). And then you can set the needed flags
in omap3_pm_check_pmic() such as omap3_has_twl and off mode.
You might want to make it somewhat PMIC independent as in
theory somebody may still want to add support for other
PMICs such as cpacp for omap3 although that's unlikely.

Regards,

Tony
