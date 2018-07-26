Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3213DC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82662088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="rSUXA3HY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82662088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbeGZJuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:50:20 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54124 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeGZJuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:50:20 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9AEEA5C1E35;
        Thu, 26 Jul 2018 10:34:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1532594071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZAo9i8049J9TM9+O8n7CFUEuL14WtY6ku7wmwDIsaBs=;
        b=rSUXA3HYeJQSK5PzO6JfgDwKzp89lgQeG/STyQvZS2f129gYlw/PArWYUSBulpC/Cnr43h
        tep4eBZhGcrR/LYiKQqXmBzHU5+CMcvZPZWn6TR0HVZkYR9h5NWYHnd/QGwROx8M9OsRlc
        Xq2QnRkGnU2ezKanCPCy3lbAeoboX4Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Jul 2018 10:34:30 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-tegra-owner@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: tegra: probe deferral error reporting
In-Reply-To: <20180720080424.31505-2-marcel@ziswiler.com>
References: <20180720080424.31505-1-marcel@ziswiler.com>
 <20180720080424.31505-2-marcel@ziswiler.com>
Message-ID: <2203d95715a9c73daa07c30ae37b095f@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[12];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.2018 10:04, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Actually report the error codes from of_get_named_gpio() resp.
> devm_gpio_request_one() upon trying to get the codec reset resp. sync
> GPIOs which may as well just be a probe deferrals.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  sound/soc/tegra/tegra20_ac97.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra20_ac97.c b/sound/soc/tegra/tegra20_ac97.c
> index 682ef33afb5f..4875512f0732 100644
> --- a/sound/soc/tegra/tegra20_ac97.c
> +++ b/sound/soc/tegra/tegra20_ac97.c
> @@ -351,18 +351,21 @@ static int tegra20_ac97_platform_probe(struct
> platform_device *pdev)
>  		ret = devm_gpio_request_one(&pdev->dev, ac97->reset_gpio,
>  					    GPIOF_OUT_INIT_HIGH, "codec-reset");
>  		if (ret) {
> -			dev_err(&pdev->dev, "could not get codec-reset GPIO\n");
> +			dev_err(&pdev->dev, "could not get codec-reset GPIO: "
> +					    "%d\n", ret);
>  			goto err_clk_put;
>  		}
>  	} else {
> -		dev_err(&pdev->dev, "no codec-reset GPIO supplied\n");
> +		ret = ac97->reset_gpio;
> +		dev_err(&pdev->dev, "no codec-reset GPIO supplied: %d\n", ret);
>  		goto err_clk_put;
>  	}
>  
>  	ac97->sync_gpio = of_get_named_gpio(pdev->dev.of_node,
>  					    "nvidia,codec-sync-gpio", 0);
>  	if (!gpio_is_valid(ac97->sync_gpio)) {
> -		dev_err(&pdev->dev, "no codec-sync GPIO supplied\n");
> +		ret = ac97->sync_gpio;
> +		dev_err(&pdev->dev, "no codec-sync GPIO supplied: %d\n", ret);
>  		goto err_clk_put;

This will still print an error on defer, which is not really nice. I
suggest to suppress defer errors completely, e.g. by:

		if (ret != -EPROBE_DEFER)
			dev_err(&pdev->dev, "no codec-sync GPIO supplied: %d\n", ret);

The driver framework provides debug level prints if debugging of
deferred probing is required.

--
Stefan


>  	}
