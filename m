Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeENIjV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:39:21 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:26491 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752052AbeENIjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:39:19 -0400
From: Vincent ABRIOU <vincent.abriou@st.com>
To: Philippe CORNU <philippe.cornu@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Andrzej Hajda <a.hajda@samsung.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH 4/4] drm/panel: otm8009a: use new backlight api
Thread-Topic: [PATCH 4/4] drm/panel: otm8009a: use new backlight api
Thread-Index: AQHT2wzrP9mYCLnC906W5IBTbsLw96Qu5meA
Date: Mon, 14 May 2018 08:39:05 +0000
Message-ID: <2d6f2a81-4ffc-9e6e-3cb9-3115be29fa11@st.com>
References: <20180423141054.13128-1-philippe.cornu@st.com>
 <20180423141054.13128-5-philippe.cornu@st.com>
In-Reply-To: <20180423141054.13128-5-philippe.cornu@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA3399FBCABC814EAC45BD0A4C2F99E9@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4E8dOs9008877

Hi Philippe,

Reviewed-by: Vincent Abriou <vincent.abriou@st.com>

BR
Vincent

On 04/23/2018 04:10 PM, Philippe Cornu wrote:
> Use the new backlight api.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>   drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 26 ++++++++----------------
>   1 file changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> index 4c638b7b9943..c2a71bd17e08 100644
> --- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> +++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> @@ -260,11 +260,7 @@ static int otm8009a_disable(struct drm_panel *panel)
>   	if (!ctx->enabled)
>   		return 0; /* This is not an issue so we return 0 here */
>   
> -	/* Power off the backlight. Note: end-user still controls brightness */
> -	ctx->bl_dev->props.power = FB_BLANK_POWERDOWN;
> -	ret = backlight_update_status(ctx->bl_dev);
> -	if (ret)
> -		return ret;
> +	backlight_disable(ctx->bl_dev);
>   
>   	ret = mipi_dsi_dcs_set_display_off(dsi);
>   	if (ret)
> @@ -338,12 +334,7 @@ static int otm8009a_enable(struct drm_panel *panel)
>   	if (ctx->enabled)
>   		return 0;
>   
> -	/*
> -	 * Power on the backlight. Note: end-user still controls brightness
> -	 * Note: ctx->prepared must be true before updating the backlight.
> -	 */
> -	ctx->bl_dev->props.power = FB_BLANK_UNBLANK;
> -	backlight_update_status(ctx->bl_dev);
> +	backlight_enable(ctx->bl_dev);
>   
>   	ctx->enabled = true;
>   
> @@ -459,11 +450,14 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
>   	ctx->panel.dev = dev;
>   	ctx->panel.funcs = &otm8009a_drm_funcs;
>   
> -	ctx->bl_dev = backlight_device_register(dev_name(dev), dev, ctx,
> -						&otm8009a_backlight_ops, NULL);
> +	ctx->bl_dev = devm_backlight_device_register(dev, dev_name(dev),
> +						     dsi->host->dev, ctx,
> +						     &otm8009a_backlight_ops,
> +						     NULL);
>   	if (IS_ERR(ctx->bl_dev)) {
> -		dev_err(dev, "failed to register backlight device\n");
> -		return PTR_ERR(ctx->bl_dev);
> +		ret = PTR_ERR(ctx->bl_dev);
> +		dev_err(dev, "failed to register backlight %d\n", ret);
> +		return ret;
>   	}
>   
>   	ctx->bl_dev->props.max_brightness = OTM8009A_BACKLIGHT_MAX;
> @@ -491,8 +485,6 @@ static int otm8009a_remove(struct mipi_dsi_device *dsi)
>   	mipi_dsi_detach(dsi);
>   	drm_panel_remove(&ctx->panel);
>   
> -	backlight_device_unregister(ctx->bl_dev);
> -
>   	return 0;
>   }
>   
> 
