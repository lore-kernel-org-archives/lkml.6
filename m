Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbeENIiK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:38:10 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35735 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752306AbeENIiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:38:07 -0400
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
Subject: Re: [PATCH 2/4] drm/panel: otm8009a: fix glitches by moving backlight
 enable to otm8009a_enable()
Thread-Topic: [PATCH 2/4] drm/panel: otm8009a: fix glitches by moving
 backlight enable to otm8009a_enable()
Thread-Index: AQHT2wzqkLCOwWi9IUOdtAQUq28LHqQu5hAA
Date: Mon, 14 May 2018 08:37:52 +0000
Message-ID: <14a3dc6e-0a59-7c63-5195-95d6c1da7c54@st.com>
References: <20180423141054.13128-1-philippe.cornu@st.com>
 <20180423141054.13128-3-philippe.cornu@st.com>
In-Reply-To: <20180423141054.13128-3-philippe.cornu@st.com>
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
Content-ID: <65224F9E2C7AED4B877E66B47ACE102D@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4E8cEdu008857

Hi Philippe,

Reviewed-by: Vincent Abriou <vincent.abriou@st.com>

BR
Vincent

On 04/23/2018 04:10 PM, Philippe Cornu wrote:
> The backlight 1st update was in the otm8009a_prepare() function
> for a bad reason: backlight was not working in video mode and the
> otm8009a_prepare() is in command mode for the init sequence. As the
> backlight is now fixed (no lpm), it is good to put it back in the
> otm8009a_enable() function, avoiding also image glitches visible
> on some "slow" devices.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>   drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> index 0fd2e0144d2b..de4a16d5275c 100644
> --- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> +++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> @@ -330,13 +330,6 @@ static int otm8009a_prepare(struct drm_panel *panel)
>   
>   	ctx->prepared = true;
>   
> -	/*
> -	 * Power on the backlight. Note: end-user still controls brightness
> -	 * Note: ctx->prepared must be true before updating the backlight.
> -	 */
> -	ctx->bl_dev->props.power = FB_BLANK_UNBLANK;
> -	backlight_update_status(ctx->bl_dev);
> -
>   	return 0;
>   }
>   
> @@ -344,6 +337,16 @@ static int otm8009a_enable(struct drm_panel *panel)
>   {
>   	struct otm8009a *ctx = panel_to_otm8009a(panel);
>   
> +	if (ctx->enabled)
> +		return 0;
> +
> +	/*
> +	 * Power on the backlight. Note: end-user still controls brightness
> +	 * Note: ctx->prepared must be true before updating the backlight.
> +	 */
> +	ctx->bl_dev->props.power = FB_BLANK_UNBLANK;
> +	backlight_update_status(ctx->bl_dev);
> +
>   	ctx->enabled = true;
>   
>   	return 0;
> 
