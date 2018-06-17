Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765DEC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 08:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3F520874
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 08:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3F520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932996AbeFQIEI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 04:04:08 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:60930 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S932451AbeFQIEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 04:04:06 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id BCCB65C098D; Sun, 17 Jun 2018 08:02:42 +0000 (UTC)
Date:   Sun, 17 Jun 2018 08:02:42 +0000
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, ldv-project@linuxtesting.org,
        alsa-devel@alsa-project.org, sil2review@lists.osadl.org,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
        linux-tegra@vger.kernel.org
Subject: Re: [SIL2review] [PATCH] ASoC: tegra: fix device_node refcounting
Message-ID: <20180617080242.GB24046@osadl.at>
References: <1529101378-5543-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529101378-5543-1-git-send-email-khoroshilov@ispras.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 01:22:58AM +0300, Alexey Khoroshilov wrote:
> tegra_rt5677_probe() gets a couple of device nodes with of_parse_phandle(),
> but there is no release of them.
> 
> The patch adds the release to tegra_rt5677_remove() and
> to error handling paths in the probe.
> 
> Found by Linux Driver Verification project (linuxtesting.org).

static int tegra_rt5677_probe(struct platform_device *pdev)
{
        struct device_node *np = pdev->dev.of_node;

 calls of_get_named_gpio() three times and then checks for 
 -EPROBE_DEFER and bails out in that error cases. but of_get_named_gpio()
 may have incremented  np  at that point. The call try i think is:

 of_get_named_gpio(np,....) 
  -> of_get_named_gpio_flags()
    -> of_get_named_gpiod_flags()
      -> of_parse_phandle_with_args_map()
        -> of_for_each_phandle()
          -> of_phandle_iterator_next()
            -> of_find_node_by_phandle()
              -> of_node_get(np)

 so that got refcounted as well and not decremented/released in the
 non -EPROBE_DEFER case. I think those should be added while cleaning
 up the other missing of_node_put() you detected below.

 I think thos of_node_put() are also missing.

> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Reviewed-by: Nicholas Mc Guire <der.herr@hofr.at>

> ---
>  sound/soc/tegra/tegra_rt5677.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra_rt5677.c b/sound/soc/tegra/tegra_rt5677.c
> index 0e4805c7b4ca..7081f15302cc 100644
> --- a/sound/soc/tegra/tegra_rt5677.c
> +++ b/sound/soc/tegra/tegra_rt5677.c
> @@ -264,13 +264,13 @@ static int tegra_rt5677_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev,
>  			"Property 'nvidia,i2s-controller' missing or invalid\n");
>  		ret = -EINVAL;
> -		goto err;
> +		goto err_put_codec_of_node;
>  	}
>  	tegra_rt5677_dai.platform_of_node = tegra_rt5677_dai.cpu_of_node;
>  
>  	ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
>  	if (ret)
> -		goto err;
> +		goto err_put_cpu_of_node;
>  
>  	ret = snd_soc_register_card(card);
>  	if (ret) {
> @@ -283,6 +283,13 @@ static int tegra_rt5677_probe(struct platform_device *pdev)
>  
>  err_fini_utils:
>  	tegra_asoc_utils_fini(&machine->util_data);
> +err_put_cpu_of_node:
> +	of_node_put(tegra_rt5677_dai.cpu_of_node);
> +	tegra_rt5677_dai.cpu_of_node = NULL;
> +	tegra_rt5677_dai.platform_of_node = NULL;
> +err_put_codec_of_node:
> +	of_node_put(tegra_rt5677_dai.codec_of_node);
> +	tegra_rt5677_dai.codec_of_node = NULL;
>  err:
>  	return ret;
>  }
> @@ -296,6 +303,12 @@ static int tegra_rt5677_remove(struct platform_device *pdev)
>  
>  	tegra_asoc_utils_fini(&machine->util_data);
>  
> +	tegra_rt5677_dai.platform_of_node = NULL;
> +	of_node_put(tegra_rt5677_dai.codec_of_node);
> +	tegra_rt5677_dai.codec_of_node = NULL;
> +	of_node_put(tegra_rt5677_dai.cpu_of_node);
> +	tegra_rt5677_dai.cpu_of_node = NULL;
> +
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 
> _______________________________________________
> SIL2review mailing list
> SIL2review@lists.osadl.org
> https://lists.osadl.org/mailman/listinfo/sil2review
