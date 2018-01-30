Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeA3Kws (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:52:48 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36119 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeA3Kwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:52:46 -0500
X-Google-Smtp-Source: AH8x225NXNSoW5CLCxpYsPzqIErDNvvQpWPxl1NpOk91YS0Xt0li4q893hrNdy77E23xVydr5QM7W9wiJE/Ihy6aox4=
MIME-Version: 1.0
In-Reply-To: <20180122164628.24728-1-philippe.cornu@st.com>
References: <20180122164628.24728-1-philippe.cornu@st.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 30 Jan 2018 11:52:45 +0100
Message-ID: <CA+M3ks4UvJWOpNsqzL6RVUCJY15EC5vuCSkfw=mkbiSO2xRgEw@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: dsi: Add 1.31 version support
To: Philippe Cornu <philippe.cornu@st.com>
Cc: Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Mickael Reulier <mickael.reulier@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-01-22 17:46 GMT+01:00 Philippe Cornu <philippe.cornu@st.com>:
> Add support for the stm dsi phy/wrapper version 1.31.
> Only lane capabilities need to be modified.
>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>

Applied on drm-misc-next.

Regards,
Benjamin

> ---
>  drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 39 +++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> index 0ba8635d738a..a514b593f37c 100644
> --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> @@ -14,7 +14,14 @@
>  #include <drm/bridge/dw_mipi_dsi.h>
>  #include <video/mipi_display.h>
>
> -/* DSI wrapper register & bit definitions */
> +#define HWVER_130                      0x31333000      /* IP version 1.30 */
> +#define HWVER_131                      0x31333100      /* IP version 1.31 */
> +
> +/* DSI digital registers & bit definitions */
> +#define DSI_VERSION                    0x00
> +#define VERSION                                GENMASK(31, 8)
> +
> +/* DSI wrapper registers & bit definitions */
>  /* Note: registers are named as in the Reference Manual */
>  #define DSI_WCFGR      0x0400          /* Wrapper ConFiGuration Reg */
>  #define WCFGR_DSIM     BIT(0)          /* DSI Mode */
> @@ -66,6 +73,9 @@ struct dw_mipi_dsi_stm {
>         void __iomem *base;
>         struct clk *pllref_clk;
>         struct dw_mipi_dsi *dsi;
> +       u32 hw_version;
> +       int lane_min_kbps;
> +       int lane_max_kbps;
>  };
>
>  static inline void dsi_write(struct dw_mipi_dsi_stm *dsi, u32 reg, u32 val)
> @@ -122,7 +132,8 @@ static int dsi_pll_get_clkout_khz(int clkin_khz, int idf, int ndiv, int odf)
>         return DIV_ROUND_CLOSEST(clkin_khz * ndiv, divisor);
>  }
>
> -static int dsi_pll_get_params(int clkin_khz, int clkout_khz,
> +static int dsi_pll_get_params(struct dw_mipi_dsi_stm *dsi,
> +                             int clkin_khz, int clkout_khz,
>                               int *idf, int *ndiv, int *odf)
>  {
>         int i, o, n, n_min, n_max;
> @@ -132,8 +143,8 @@ static int dsi_pll_get_params(int clkin_khz, int clkout_khz,
>         if (clkin_khz <= 0 || clkout_khz <= 0)
>                 return -EINVAL;
>
> -       fvco_min = LANE_MIN_KBPS * 2 * ODF_MAX;
> -       fvco_max = LANE_MAX_KBPS * 2 * ODF_MIN;
> +       fvco_min = dsi->lane_min_kbps * 2 * ODF_MAX;
> +       fvco_max = dsi->lane_max_kbps * 2 * ODF_MIN;
>
>         best_delta = 1000000; /* big started value (1000000khz) */
>
> @@ -213,6 +224,15 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, struct drm_display_mode *mode,
>         int ret, bpp;
>         u32 val;
>
> +       /* Update lane capabilities according to hw version */
> +       dsi->hw_version = dsi_read(dsi, DSI_VERSION) & VERSION;
> +       dsi->lane_min_kbps = LANE_MIN_KBPS;
> +       dsi->lane_max_kbps = LANE_MAX_KBPS;
> +       if (dsi->hw_version == HWVER_131) {
> +               dsi->lane_min_kbps *= 2;
> +               dsi->lane_max_kbps *= 2;
> +       }
> +
>         pll_in_khz = (unsigned int)(clk_get_rate(dsi->pllref_clk) / 1000);
>
>         /* Compute requested pll out */
> @@ -220,12 +240,12 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, struct drm_display_mode *mode,
>         pll_out_khz = mode->clock * bpp / lanes;
>         /* Add 20% to pll out to be higher than pixel bw (burst mode only) */
>         pll_out_khz = (pll_out_khz * 12) / 10;
> -       if (pll_out_khz > LANE_MAX_KBPS) {
> -               pll_out_khz = LANE_MAX_KBPS;
> +       if (pll_out_khz > dsi->lane_max_kbps) {
> +               pll_out_khz = dsi->lane_max_kbps;
>                 DRM_WARN("Warning max phy mbps is used\n");
>         }
> -       if (pll_out_khz < LANE_MIN_KBPS) {
> -               pll_out_khz = LANE_MIN_KBPS;
> +       if (pll_out_khz < dsi->lane_min_kbps) {
> +               pll_out_khz = dsi->lane_min_kbps;
>                 DRM_WARN("Warning min phy mbps is used\n");
>         }
>
> @@ -233,7 +253,8 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, struct drm_display_mode *mode,
>         idf = 0;
>         ndiv = 0;
>         odf = 0;
> -       ret = dsi_pll_get_params(pll_in_khz, pll_out_khz, &idf, &ndiv, &odf);
> +       ret = dsi_pll_get_params(dsi, pll_in_khz, pll_out_khz,
> +                                &idf, &ndiv, &odf);
>         if (ret)
>                 DRM_WARN("Warning dsi_pll_get_params(): bad params\n");
>
> --
> 2.15.1
>
