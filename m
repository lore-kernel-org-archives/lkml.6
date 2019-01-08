Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5646DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2722220827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfAHAPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 19:15:47 -0500
Received: from muru.com ([72.249.23.125]:60434 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfAHAPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 19:15:46 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 93280813A;
        Tue,  8 Jan 2019 00:15:52 +0000 (UTC)
Date:   Mon, 7 Jan 2019 16:15:43 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] mfd: syscon: Fix syscon name for device tree
Message-ID: <20190108001543.GJ5544@atomide.com>
References: <20190108000558.54914-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108000558.54914-1-tony@atomide.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [190108 00:06]:
> I'm now seeing the following error on omap5 during boot:
> 
> (NULL device *): Failed to create dummy-scm_conf@0 debugfs directory
> 
> This is because we have two separate scm_conf syscon regions in the
> dts. Let's fix the issue by setting a proper name if syscon is
> configured via device tree.
> 
> See also related fix for commit 500f9ff518cf ("mfd: syscon: Set name
> of regmap_config").
> 
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/syscon.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -241,6 +241,8 @@ static int syscon_probe(struct platform_device *pdev)
>  	syscon_config.max_register = res->end - res->start - 3;
>  	if (pdata)
>  		syscon_config.name = pdata->label;
> +	else
> +		syscon_config.name = dev_name(dev);
>  	syscon->regmap = devm_regmap_init_mmio(dev, base, &syscon_config);
>  	if (IS_ERR(syscon->regmap)) {
>  		dev_err(dev, "regmap init failed\n");

Hmm this fixes the error, but I'm still seeing only one
entry for /sys/kernel/debug/regmap/dummy-scm_conf@0.

Anybody got better ideas for setting the default name,
maybe dev->of_node->name if it exists?

Regards,

Tony
