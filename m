Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeDYHNA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:13:00 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:62367 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750945AbeDYHM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:12:57 -0400
From: Yannick FERTRE <yannick.fertre@st.com>
To: Philippe CORNU <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        "David Airlie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH] drm/stm: ltdc: add mode_valid()
Thread-Topic: [PATCH] drm/stm: ltdc: add mode_valid()
Thread-Index: AQHT1kDms4rb0CcO1UuIGz3k5PZYoKQQ+5eA
Date: Wed, 25 Apr 2018 07:12:47 +0000
Message-ID: <c3470496-e7ff-18e6-633a-fc899ee15e17@st.com>
References: <20180417114026.8709-1-philippe.cornu@st.com>
In-Reply-To: <20180417114026.8709-1-philippe.cornu@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <38A235D74E53E2498001449F85B92BE1@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3P7D4NN006952

Hi Philippe,

Reviewed-by: Yannick Fertré <yannick.fertre@st.com>

On 04/17/2018 01:40 PM, Philippe Cornu wrote:
> Add mode_valid() function to filter modes according to available
> pll clock values and "preferred" modes. It is particularly
> useful for hdmi modes that require precise pixel clocks.
> 
> Note that "preferred" modes are always accepted:
> - this is important for panels because panel clock tolerances are
>    bigger than hdmi ones and there is no reason to not accept them
>    (the fps may vary a little but it is not a problem).
> - the hdmi preferred mode will be accepted too, but userland will
>    be able to use others hdmi "valid" modes if necessary.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>   drivers/gpu/drm/stm/ltdc.c | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 014cef8cef37..616191fe98ae 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -445,6 +445,43 @@ static void ltdc_crtc_atomic_disable(struct drm_crtc *crtc,
>   	reg_set(ldev->regs, LTDC_SRCR, SRCR_IMR);
>   }
>   
> +#define CLK_TOLERANCE_HZ 50
> +
> +static enum drm_mode_status
> +ltdc_crtc_mode_valid(struct drm_crtc *crtc,
> +		     const struct drm_display_mode *mode)
> +{
> +	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
> +	int target = mode->clock * 1000;
> +	int target_min = target - CLK_TOLERANCE_HZ;
> +	int target_max = target + CLK_TOLERANCE_HZ;
> +	int result;
> +
> +	/*
> +	 * Accept all "preferred" modes:
> +	 * - this is important for panels because panel clock tolerances are
> +	 *   bigger than hdmi ones and there is no reason to not accept them
> +	 *   (the fps may vary a little but it is not a problem).
> +	 * - the hdmi preferred mode will be accepted too, but userland will
> +	 *   be able to use others hdmi "valid" modes if necessary.
> +	 */
> +	if (mode->type & DRM_MODE_TYPE_PREFERRED)
> +		return MODE_OK;
> +
> +	result = clk_round_rate(ldev->pixel_clk, target);
> +
> +	DRM_DEBUG_DRIVER("clk rate target %d, available %d\n", target, result);
> +
> +	/*
> +	 * Filter modes according to the clock value, particularly useful for
> +	 * hdmi modes that require precise pixel clocks.
> +	 */
> +	if (result < target_min || result > target_max)
> +		return MODE_CLOCK_RANGE;
> +
> +	return MODE_OK;
> +}
> +
>   static bool ltdc_crtc_mode_fixup(struct drm_crtc *crtc,
>   				 const struct drm_display_mode *mode,
>   				 struct drm_display_mode *adjusted_mode)
> @@ -559,6 +596,7 @@ static void ltdc_crtc_atomic_flush(struct drm_crtc *crtc,
>   }
>   
>   static const struct drm_crtc_helper_funcs ltdc_crtc_helper_funcs = {
> +	.mode_valid = ltdc_crtc_mode_valid,
>   	.mode_fixup = ltdc_crtc_mode_fixup,
>   	.mode_set_nofb = ltdc_crtc_mode_set_nofb,
>   	.atomic_flush = ltdc_crtc_atomic_flush,
> 
