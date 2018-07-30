Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2121FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC0620892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC0620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbeG3I7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 04:59:22 -0400
Received: from mout01.posteo.de ([185.67.36.141]:40744 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbeG3I7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 04:59:22 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 2A16F2102E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 09:25:43 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41fB1d4mnJz6tm6;
        Mon, 30 Jul 2018 09:25:41 +0200 (CEST)
Date:   Mon, 30 Jul 2018 09:25:15 +0200 (CEST)
From:   Marc Dietrich <marvin24@gmx.de>
X-X-Sender: lucile@macbook-pro.fritz.box
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] ASoC: tegra_alc5632: fix device_node refcounting
In-Reply-To: <1532725619-8775-1-git-send-email-khoroshilov@ispras.ru>
Message-ID: <alpine.OSX.2.21.1807300901100.4127@macbook-pro.fritz.box>
References: <1532725619-8775-1-git-send-email-khoroshilov@ispras.ru>
User-Agent: Alpine 2.21 (OSX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexey,

AFAICT, this looks right. It seems that *most* of the machine 
drivers (not only tegra) forget to decrease the refcount. I'm wondering 
why you didn't sent a series patch to fix them all at once?

Reviewed-by: Marc Dietrich <marvin24@gmx.de>

Marc

On Sat, 28 Jul 2018, Alexey Khoroshilov wrote:

> tegra_alc5632_probe() increments reference count of device nodes
> with of_parse_phandle(), but there is no code decrementing them
> in the driver.
>
> The patch adds of_node_put() to tegra_alc5632_remove() and
> to error handling paths in the probe.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
> sound/soc/tegra/tegra_alc5632.c | 17 +++++++++++++++--
> 1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
> index 5197d6b18cb6..98d87801d57a 100644
> --- a/sound/soc/tegra/tegra_alc5632.c
> +++ b/sound/soc/tegra/tegra_alc5632.c
> @@ -190,14 +190,14 @@ static int tegra_alc5632_probe(struct platform_device *pdev)
> 		dev_err(&pdev->dev,
> 			"Property 'nvidia,i2s-controller' missing or invalid\n");
> 		ret = -EINVAL;
> -		goto err;
> +		goto err_put_codec_of_node;
> 	}
>
> 	tegra_alc5632_dai.platform_of_node = tegra_alc5632_dai.cpu_of_node;
>
> 	ret = tegra_asoc_utils_init(&alc5632->util_data, &pdev->dev);
> 	if (ret)
> -		goto err;
> +		goto err_put_cpu_of_node;
>
> 	ret = snd_soc_register_card(card);
> 	if (ret) {
> @@ -210,6 +210,13 @@ static int tegra_alc5632_probe(struct platform_device *pdev)
>
> err_fini_utils:
> 	tegra_asoc_utils_fini(&alc5632->util_data);
> +err_put_cpu_of_node:
> +	of_node_put(tegra_alc5632_dai.cpu_of_node);
> +	tegra_alc5632_dai.cpu_of_node = NULL;
> +	tegra_alc5632_dai.platform_of_node = NULL;
> +err_put_codec_of_node:
> +	of_node_put(tegra_alc5632_dai.codec_of_node);
> +	tegra_alc5632_dai.codec_of_node = NULL;
> err:
> 	return ret;
> }
> @@ -223,6 +230,12 @@ static int tegra_alc5632_remove(struct platform_device *pdev)
>
> 	tegra_asoc_utils_fini(&machine->util_data);
>
> +	of_node_put(tegra_alc5632_dai.cpu_of_node);
> +	tegra_alc5632_dai.cpu_of_node = NULL;
> +	tegra_alc5632_dai.platform_of_node = NULL;
> +	of_node_put(tegra_alc5632_dai.codec_of_node);
> +	tegra_alc5632_dai.codec_of_node = NULL;
> +
> 	return 0;
> }
>
> -- 
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
