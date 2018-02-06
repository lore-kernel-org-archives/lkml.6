Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeBFJNg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:13:36 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41624 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752388AbeBFJNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:13:24 -0500
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
Subject: Re: [PATCH v1 2/2] drm/stm: ltdc: remove non-alpha color formats on
 layer 2 for older hw
Thread-Topic: [PATCH v1 2/2] drm/stm: ltdc: remove non-alpha color formats on
 layer 2 for older hw
Thread-Index: AQHTm0lufK1wfomA2keGcznqXQ6pwaOXDheA
Date: Tue, 6 Feb 2018 09:13:14 +0000
Message-ID: <e36e7e5f-e5c8-8214-0a01-f4f2ee06cf69@st.com>
References: <20180201104243.20726-1-philippe.cornu@st.com>
 <20180201104243.20726-3-philippe.cornu@st.com>
In-Reply-To: <20180201104243.20726-3-philippe.cornu@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EB2F9A51ADACE4DAD5838F6091E44DC@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-06_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w169Deu1017790

Reviewed-by: Yannick Fertré <yannick.fertre@st.com>


On 02/01/2018 11:42 AM, Philippe Cornu wrote:
> Hw older versions support non-alpha color formats derived
> from native alpha color formats only on the primary layer.
> For instance, RG16 native format without alpha works fine
> on 2nd layer but XR24 (derived color format from AR24)
> does not work on 2nd layer.
>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>   drivers/gpu/drm/stm/ltdc.c | 20 ++++++++++++++++++++
>   drivers/gpu/drm/stm/ltdc.h |  1 +
>   2 files changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index f6f26fc0ae9e..1a3277e483d5 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -703,6 +703,11 @@ static void ltdc_plane_atomic_update(struct drm_plane *plane,
>   	if (!fb->format->has_alpha)
>   		val = BF1_CA | BF2_1CA;
>   
> +	/* Manage hw-specific capabilities */
> +	if (ldev->caps.non_alpha_only_l1 &&
> +	    plane->type != DRM_PLANE_TYPE_PRIMARY)
> +		val = BF1_PAXCA | BF2_1PAXCA;
> +
>   	reg_update_bits(ldev->regs, LTDC_L1BFCR + lofs,
>   			LXBFCR_BF2 | LXBFCR_BF1, val);
>   
> @@ -785,6 +790,12 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
>   		drm_fmt_no_alpha = get_pixelformat_without_alpha(drm_fmt);
>   		if (!drm_fmt_no_alpha)
>   			continue;
> +
> +		/* Manage hw-specific capabilities */
> +		if (ldev->caps.non_alpha_only_l1 &&
> +		    type != DRM_PLANE_TYPE_PRIMARY)
> +			continue;
> +
>   		formats[nb_fmt++] = drm_fmt_no_alpha;
>   	}
>   
> @@ -913,10 +924,19 @@ static int ltdc_get_caps(struct drm_device *ddev)
>   	case HWVER_10300:
>   		ldev->caps.reg_ofs = REG_OFS_NONE;
>   		ldev->caps.pix_fmt_hw = ltdc_pix_fmt_a0;
> +		/*
> +		 * Hw older versions support non-alpha color formats derived
> +		 * from native alpha color formats only on the primary layer.
> +		 * For instance, RG16 native format without alpha works fine
> +		 * on 2nd layer but XR24 (derived color format from AR24)
> +		 * does not work on 2nd layer.
> +		 */
> +		ldev->caps.non_alpha_only_l1 = true;
>   		break;
>   	case HWVER_20101:
>   		ldev->caps.reg_ofs = REG_OFS_4;
>   		ldev->caps.pix_fmt_hw = ltdc_pix_fmt_a1;
> +		ldev->caps.non_alpha_only_l1 = false;
>   		break;
>   	default:
>   		return -ENODEV;
> diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
> index edd1c0a446d1..edb268129c54 100644
> --- a/drivers/gpu/drm/stm/ltdc.h
> +++ b/drivers/gpu/drm/stm/ltdc.h
> @@ -17,6 +17,7 @@ struct ltdc_caps {
>   	u32 reg_ofs;		/* register offset for applicable regs */
>   	u32 bus_width;		/* bus width (32 or 64 bits) */
>   	const u32 *pix_fmt_hw;	/* supported pixel formats */
> +	bool non_alpha_only_l1; /* non-native no-alpha formats on layer 1 */
>   };
>   
>   struct ltdc_device {
