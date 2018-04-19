Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753510AbeDSPv3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:51:29 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36341 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753059AbeDSPvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:51:25 -0400
From: Philippe CORNU <philippe.cornu@st.com>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Archit Taneja <architt@codeaurora.org>
CC: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>
Subject: Re: [PATCH] drm: clarify adjusted_mode documentation for bridges
Thread-Topic: [PATCH] drm: clarify adjusted_mode documentation for bridges
Thread-Index: AQHT0BczUn0iEJHYOUCxPfTONo+jRaQIKrOA
Date: Thu, 19 Apr 2018 15:50:58 +0000
Message-ID: <b09d3039-41f7-5de1-7323-2f30ccd7141b@st.com>
References: <20180409152427.12449-1-philippe.cornu@st.com>
In-Reply-To: <20180409152427.12449-1-philippe.cornu@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.119]
Content-Type: text/plain; charset="utf-8"
Content-ID: <60A474FA6C262948BC669A00970CF759@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3JFpWo1012265

Hi Archit & Andrzej,

May I ask you please a short review of this documentation update.
Many thanks
Philippe :-)

On 04/09/2018 05:24 PM, Philippe Cornu wrote:
> This patch clarifies the adjusted_mode documentation
> for bridges.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
> This patch follows discussions in:
> - "drm: clarify adjusted_mode for a bridge connected to a crtc"
>    https://patchwork.freedesktop.org/patch/206801/
> - "drm: bridge: Constify mode arguments to bridge .mode_set() operation"
>    https://patchwork.freedesktop.org/patch/215449/
> 
>   include/drm/drm_bridge.h | 16 ++++++++++++++++
>   include/drm/drm_crtc.h   | 11 +++++++----
>   2 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 3270fec46979..7d632c6a9214 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -178,6 +178,22 @@ struct drm_bridge_funcs {
>   	 * then this would be &drm_encoder_helper_funcs.mode_set. The display
>   	 * pipe (i.e.  clocks and timing signals) is off when this function is
>   	 * called.
> +	 *
> +	 * The adjusted_mode parameter corresponds to the mode output by the CRTC
> +	 * for the first bridge in the chain. It can be different from the mode
> +	 * parameter that contains the desired mode for the connector at the end
> +	 * of the bridges chain, for instance when the first bridge in the chain
> +	 * performs scaling. The adjusted mode is mostly useful for the first
> +	 * bridge in the chain and is likely irrelevant for the other bridges.
> +	 *
> +	 * For atomic drivers the adjusted_mode is the mode stored in
> +	 * &drm_crtc_state.adjusted_mode.
> +	 *
> +	 * NOTE:
> +	 *
> +	 * If a need arises to store and access modes adjusted for other locations
> +	 * than the connection between the CRTC and the first bridge, the DRM
> +	 * framework will have to be extended with DRM bridge states.
>   	 */
>   	void (*mode_set)(struct drm_bridge *bridge,
>   			 struct drm_display_mode *mode,
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index a2d81d2907a9..65f749a9e9d3 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -134,10 +134,13 @@ struct drm_crtc_state {
>   	 *
>   	 * Internal display timings which can be used by the driver to handle
>   	 * differences between the mode requested by userspace in @mode and what
> -	 * is actually programmed into the hardware. It is purely driver
> -	 * implementation defined what exactly this adjusted mode means. Usually
> -	 * it is used to store the hardware display timings used between the
> -	 * CRTC and encoder blocks.
> +	 * is actually programmed into the hardware.
> +	 *
> +	 * For drivers using drm_bridge, this stores the hardware display timings
> +	 * used between the CRTC and the first bridge. For other drivers, the
> +	 * meaning of the adjusted_mode field is purely driver implementation
> +	 * defined information, and will usually be used to store the hardware
> +	 * display timings used between the CRTC and encoder blocks.
>   	 */
>   	struct drm_display_mode adjusted_mode;
>   
> 
