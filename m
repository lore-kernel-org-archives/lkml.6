Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754266AbeDPJOu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:14:50 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:30617 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751099AbeDPJOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:14:49 -0400
From: Vincent ABRIOU <vincent.abriou@st.com>
To: Philippe CORNU <philippe.cornu@st.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Fabien DESSENNE <fabien.dessenne@st.com>,
        Mickael REULIER <mickael.reulier@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH] drm/stm: ltdc: add user update info in plane print state
Thread-Topic: [PATCH] drm/stm: ltdc: add user update info in plane print state
Thread-Index: AQHTzrhWwCZmriDzrESJEFIN65KdyqQDB7SA
Date: Mon, 16 Apr 2018 09:14:36 +0000
Message-ID: <8843fede-9859-7332-1e34-515efe58024c@st.com>
References: <20180407213503.30932-1-philippe.cornu@st.com>
In-Reply-To: <20180407213503.30932-1-philippe.cornu@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.117]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB7D2F16F1BD284CB8C992A26862BA6D@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3G9Et1A019029

Hi Philippe,

Reviewed-by: Vincent Abriou <vincent.abriou@st.com>

On 04/07/2018 11:35 PM, Philippe Cornu wrote:
> This patch adds the user update information in
> frames-per-second into the drm debugfs plane state.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>   drivers/gpu/drm/stm/ltdc.c | 22 ++++++++++++++++++++++
>   drivers/gpu/drm/stm/ltdc.h |  8 ++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 2b745cfc9000..061d2b6e5157 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -729,6 +729,8 @@ static void ltdc_plane_atomic_update(struct drm_plane *plane,
>   	reg_update_bits(ldev->regs, LTDC_L1CR + lofs,
>   			LXCR_LEN | LXCR_CLUTEN, val);
>   
> +	ldev->plane_fpsi[plane->index].counter++;
> +
>   	mutex_lock(&ldev->err_lock);
>   	if (ldev->error_status & ISR_FUIF) {
>   		DRM_DEBUG_DRIVER("Fifo underrun\n");
> @@ -754,6 +756,25 @@ static void ltdc_plane_atomic_disable(struct drm_plane *plane,
>   			 oldstate->crtc->base.id, plane->base.id);
>   }
>   
> +static void ltdc_plane_atomic_print_state(struct drm_printer *p,
> +					  const struct drm_plane_state *state)
> +{
> +	struct drm_plane *plane = state->plane;
> +	struct ltdc_device *ldev = plane_to_ltdc(plane);
> +	struct fps_info *fpsi = &ldev->plane_fpsi[plane->index];
> +	int ms_since_last;
> +	ktime_t now;
> +
> +	now = ktime_get();
> +	ms_since_last = ktime_to_ms(ktime_sub(now, fpsi->last_timestamp));
> +
> +	drm_printf(p, "\tuser_updates=%dfps\n",
> +		   DIV_ROUND_CLOSEST(fpsi->counter * 1000, ms_since_last));
> +
> +	fpsi->last_timestamp = now;
> +	fpsi->counter = 0;
> +}
> +
>   static const struct drm_plane_funcs ltdc_plane_funcs = {
>   	.update_plane = drm_atomic_helper_update_plane,
>   	.disable_plane = drm_atomic_helper_disable_plane,
> @@ -761,6 +782,7 @@ static const struct drm_plane_funcs ltdc_plane_funcs = {
>   	.reset = drm_atomic_helper_plane_reset,
>   	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>   	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
> +	.atomic_print_state = ltdc_plane_atomic_print_state,
>   };
>   
>   static const struct drm_plane_helper_funcs ltdc_plane_helper_funcs = {
> diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
> index 61a80d00bc3b..1e16d6afb0d2 100644
> --- a/drivers/gpu/drm/stm/ltdc.h
> +++ b/drivers/gpu/drm/stm/ltdc.h
> @@ -20,6 +20,13 @@ struct ltdc_caps {
>   	bool non_alpha_only_l1; /* non-native no-alpha formats on layer 1 */
>   };
>   
> +#define LTDC_MAX_LAYER	4
> +
> +struct fps_info {
> +	unsigned int counter;
> +	ktime_t last_timestamp;
> +};
> +
>   struct ltdc_device {
>   	void __iomem *regs;
>   	struct clk *pixel_clk;	/* lcd pixel clock */
> @@ -27,6 +34,7 @@ struct ltdc_device {
>   	struct ltdc_caps caps;
>   	u32 error_status;
>   	u32 irq_status;
> +	struct fps_info plane_fpsi[LTDC_MAX_LAYER];
>   };
>   
>   int ltdc_load(struct drm_device *ddev);
> 
