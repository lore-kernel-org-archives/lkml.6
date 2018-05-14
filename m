Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbeENIhE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:37:04 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10386 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751992AbeENIhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:37:03 -0400
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
Subject: Re: [PATCH 1/4] drm/panel: otm8009a: fix backlight updates
Thread-Topic: [PATCH 1/4] drm/panel: otm8009a: fix backlight updates
Thread-Index: AQHT2wzpPb+fCe+VckaRZma5305BD6Qu5b6A
Date: Mon, 14 May 2018 08:36:43 +0000
Message-ID: <a33cea9b-d998-be36-dc8c-f13e58db4fde@st.com>
References: <20180423141054.13128-1-philippe.cornu@st.com>
 <20180423141054.13128-2-philippe.cornu@st.com>
In-Reply-To: <20180423141054.13128-2-philippe.cornu@st.com>
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
Content-ID: <0F430959B1D2884AAF761788DC6B3E6F@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4E8c4wX008853

Hi Philippe,

Reviewed-by: Vincent Abriou <vincent.abriou@st.com>

BR
Vincent

On 04/23/2018 04:10 PM, Philippe Cornu wrote:
> Backlight updates was not working anymore since the good
> implementation of the dsi lpm mode in the dsi host driver.
> After a longer analysis, the backlight updates in dsi video
> mode require the dsi hs mode.
> Note: it is important to keep the dsi lpm mode for the rest
> of the driver as init sequence, sleep in/out... dsi commands
> work in lp mode.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>   drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> index 90f1ae4af93c..0fd2e0144d2b 100644
> --- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> +++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> @@ -98,6 +98,20 @@ static void otm8009a_dcs_write_buf(struct otm8009a *ctx, const void *data,
>   		DRM_WARN("mipi dsi dcs write buffer failed\n");
>   }
>   
> +static void otm8009a_dcs_write_buf_hs(struct otm8009a *ctx, const void *data,
> +				      size_t len)
> +{
> +	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> +
> +	/* data will be sent in dsi hs mode (ie. no lpm) */
> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	otm8009a_dcs_write_buf(ctx, data, len);
> +
> +	/* restore back the dsi lpm mode */
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +}
> +
>   #define dcs_write_seq(ctx, seq...)			\
>   ({							\
>   	static const u8 d[] = { seq };			\
> @@ -387,7 +401,7 @@ static int otm8009a_backlight_update_status(struct backlight_device *bd)
>   		 */
>   		data[0] = MIPI_DCS_SET_DISPLAY_BRIGHTNESS;
>   		data[1] = bd->props.brightness;
> -		otm8009a_dcs_write_buf(ctx, data, ARRAY_SIZE(data));
> +		otm8009a_dcs_write_buf_hs(ctx, data, ARRAY_SIZE(data));
>   
>   		/* set Brightness Control & Backlight on */
>   		data[1] = 0x24;
> @@ -399,7 +413,7 @@ static int otm8009a_backlight_update_status(struct backlight_device *bd)
>   
>   	/* Update Brightness Control & Backlight */
>   	data[0] = MIPI_DCS_WRITE_CONTROL_DISPLAY;
> -	otm8009a_dcs_write_buf(ctx, data, ARRAY_SIZE(data));
> +	otm8009a_dcs_write_buf_hs(ctx, data, ARRAY_SIZE(data));
>   
>   	return 0;
>   }
> 
