Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeBFJNN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:13:13 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29990 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752388AbeBFJND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:13:03 -0500
From: Yannick FERTRE <yannick.fertre@st.com>
To: Philippe CORNU <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        "David Airlie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Fabien DESSENNE <fabien.dessenne@st.com>,
        Mickael REULIER <mickael.reulier@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH v1 1/2] drm/stm: ltdc: add non-alpha color formats
Thread-Topic: [PATCH v1 1/2] drm/stm: ltdc: add non-alpha color formats
Thread-Index: AQHTm0ludE1mHZlaoEK4NKxNvd+3J6OXDfiA
Date: Tue, 6 Feb 2018 09:12:52 +0000
Message-ID: <2c9f9935-a1ce-84de-e90b-c9462c9bf785@st.com>
References: <20180201104243.20726-1-philippe.cornu@st.com>
 <20180201104243.20726-2-philippe.cornu@st.com>
In-Reply-To: <20180201104243.20726-2-philippe.cornu@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F1AB470707F4B4BA44ABBECC6102CB8@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-06_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w169DKp1017754

Reviewed-by: Yannick Fertré <yannick.fertre@st.com>


On 02/01/2018 11:42 AM, Philippe Cornu wrote:
> ltdc supports natively some color formats with alpha (like
> ARGB8888, ARGB1555, ARGB4444...). Related non-alpha formats are
> supported too (ARGB8888->XRGB8888, ARGB4444->XRGB4444...) by
> adjusting ltdc blending factors.
>
> Note: Wayland/Weston requests by default the non-alpha XRGB8888
> color format.
>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>   drivers/gpu/drm/stm/ltdc.c | 33 +++++++++++++++++++++++++++++++--
>   1 file changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 90b3de516c91..f6f26fc0ae9e 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -328,6 +328,26 @@ static inline u32 to_drm_pixelformat(enum ltdc_pix_fmt pf)
>   	}
>   }
>   
> +static inline u32 get_pixelformat_without_alpha(u32 drm)
> +{
> +	switch (drm) {
> +	case DRM_FORMAT_ARGB4444:
> +		return DRM_FORMAT_XRGB4444;
> +	case DRM_FORMAT_RGBA4444:
> +		return DRM_FORMAT_RGBX4444;
> +	case DRM_FORMAT_ARGB1555:
> +		return DRM_FORMAT_XRGB1555;
> +	case DRM_FORMAT_RGBA5551:
> +		return DRM_FORMAT_RGBX5551;
> +	case DRM_FORMAT_ARGB8888:
> +		return DRM_FORMAT_XRGB8888;
> +	case DRM_FORMAT_RGBA8888:
> +		return DRM_FORMAT_RGBX8888;
> +	default:
> +		return 0;
> +	}
> +}
> +
>   static irqreturn_t ltdc_irq_thread(int irq, void *arg)
>   {
>   	struct drm_device *ddev = arg;
> @@ -680,6 +700,9 @@ static void ltdc_plane_atomic_update(struct drm_plane *plane,
>   
>   	/* Specifies the blending factors */
>   	val = BF1_PAXCA | BF2_1PAXCA;
> +	if (!fb->format->has_alpha)
> +		val = BF1_CA | BF2_1CA;
> +
>   	reg_update_bits(ldev->regs, LTDC_L1BFCR + lofs,
>   			LXBFCR_BF2 | LXBFCR_BF1, val);
>   
> @@ -747,8 +770,8 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
>   	struct device *dev = ddev->dev;
>   	struct drm_plane *plane;
>   	unsigned int i, nb_fmt = 0;
> -	u32 formats[NB_PF];
> -	u32 drm_fmt;
> +	u32 formats[NB_PF * 2];
> +	u32 drm_fmt, drm_fmt_no_alpha;
>   	int ret;
>   
>   	/* Get supported pixel formats */
> @@ -757,6 +780,12 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
>   		if (!drm_fmt)
>   			continue;
>   		formats[nb_fmt++] = drm_fmt;
> +
> +		/* Add the no-alpha related format if any & supported */
> +		drm_fmt_no_alpha = get_pixelformat_without_alpha(drm_fmt);
> +		if (!drm_fmt_no_alpha)
> +			continue;
> +		formats[nb_fmt++] = drm_fmt_no_alpha;
>   	}
>   
>   	plane = devm_kzalloc(dev, sizeof(*plane), GFP_KERNEL);
