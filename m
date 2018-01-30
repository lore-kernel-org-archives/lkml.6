Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751725AbeA3K6R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:58:17 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:48503 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751378AbeA3K6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:58:16 -0500
From: Philippe CORNU <philippe.cornu@st.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        Mickael REULIER <mickael.reulier@st.com>,
        "Ludovic BARRE" <ludovic.barre@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH] drm/stm: dsi: Add 1.31 version support
Thread-Topic: [PATCH] drm/stm: dsi: Add 1.31 version support
Thread-Index: AQHTmbh4u/+luY3SjUC18BvZ9Db/YKOMLiiA
Date: Tue, 30 Jan 2018 10:57:56 +0000
Message-ID: <aa0bb416-a9ed-7e88-adf6-54a65e0f0eff@st.com>
References: <20180122164628.24728-1-philippe.cornu@st.com>
 <CA+M3ks4UvJWOpNsqzL6RVUCJY15EC5vuCSkfw=mkbiSO2xRgEw@mail.gmail.com>
In-Reply-To: <CA+M3ks4UvJWOpNsqzL6RVUCJY15EC5vuCSkfw=mkbiSO2xRgEw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EB9E62015479F4CB086B24B053DAF36@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0UAwLh4010452

Hi Benjamin,

and many thanks
Philippe :-)

On 01/30/2018 11:52 AM, Benjamin Gaignard wrote:
> 2018-01-22 17:46 GMT+01:00 Philippe Cornu <philippe.cornu@st.com>:
>> Add support for the stm dsi phy/wrapper version 1.31.
>> Only lane capabilities need to be modified.
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> 
> Applied on drm-misc-next.
> 
> Regards,
> Benjamin
> 
>> ---
>>   drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 39 +++++++++++++++++++++++++++--------
>>   1 file changed, 30 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
>> index 0ba8635d738a..a514b593f37c 100644
>> --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
>> +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
>> @@ -14,7 +14,14 @@
>>   #include <drm/bridge/dw_mipi_dsi.h>
>>   #include <video/mipi_display.h>
>>
>> -/* DSI wrapper register & bit definitions */
>> +#define HWVER_130                      0x31333000      /* IP version 1.30 */
>> +#define HWVER_131                      0x31333100      /* IP version 1.31 */
>> +
>> +/* DSI digital registers & bit definitions */
>> +#define DSI_VERSION                    0x00
>> +#define VERSION                                GENMASK(31, 8)
>> +
>> +/* DSI wrapper registers & bit definitions */
>>   /* Note: registers are named as in the Reference Manual */
>>   #define DSI_WCFGR      0x0400          /* Wrapper ConFiGuration Reg */
>>   #define WCFGR_DSIM     BIT(0)          /* DSI Mode */
>> @@ -66,6 +73,9 @@ struct dw_mipi_dsi_stm {
>>          void __iomem *base;
>>          struct clk *pllref_clk;
>>          struct dw_mipi_dsi *dsi;
>> +       u32 hw_version;
>> +       int lane_min_kbps;
>> +       int lane_max_kbps;
>>   };
>>
>>   static inline void dsi_write(struct dw_mipi_dsi_stm *dsi, u32 reg, u32 val)
>> @@ -122,7 +132,8 @@ static int dsi_pll_get_clkout_khz(int clkin_khz, int idf, int ndiv, int odf)
>>          return DIV_ROUND_CLOSEST(clkin_khz * ndiv, divisor);
>>   }
>>
>> -static int dsi_pll_get_params(int clkin_khz, int clkout_khz,
>> +static int dsi_pll_get_params(struct dw_mipi_dsi_stm *dsi,
>> +                             int clkin_khz, int clkout_khz,
>>                                int *idf, int *ndiv, int *odf)
>>   {
>>          int i, o, n, n_min, n_max;
>> @@ -132,8 +143,8 @@ static int dsi_pll_get_params(int clkin_khz, int clkout_khz,
>>          if (clkin_khz <= 0 || clkout_khz <= 0)
>>                  return -EINVAL;
>>
>> -       fvco_min = LANE_MIN_KBPS * 2 * ODF_MAX;
>> -       fvco_max = LANE_MAX_KBPS * 2 * ODF_MIN;
>> +       fvco_min = dsi->lane_min_kbps * 2 * ODF_MAX;
>> +       fvco_max = dsi->lane_max_kbps * 2 * ODF_MIN;
>>
>>          best_delta = 1000000; /* big started value (1000000khz) */
>>
>> @@ -213,6 +224,15 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, struct drm_display_mode *mode,
>>          int ret, bpp;
>>          u32 val;
>>
>> +       /* Update lane capabilities according to hw version */
>> +       dsi->hw_version = dsi_read(dsi, DSI_VERSION) & VERSION;
>> +       dsi->lane_min_kbps = LANE_MIN_KBPS;
>> +       dsi->lane_max_kbps = LANE_MAX_KBPS;
>> +       if (dsi->hw_version == HWVER_131) {
>> +               dsi->lane_min_kbps *= 2;
>> +               dsi->lane_max_kbps *= 2;
>> +       }
>> +
>>          pll_in_khz = (unsigned int)(clk_get_rate(dsi->pllref_clk) / 1000);
>>
>>          /* Compute requested pll out */
>> @@ -220,12 +240,12 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, struct drm_display_mode *mode,
>>          pll_out_khz = mode->clock * bpp / lanes;
>>          /* Add 20% to pll out to be higher than pixel bw (burst mode only) */
>>          pll_out_khz = (pll_out_khz * 12) / 10;
>> -       if (pll_out_khz > LANE_MAX_KBPS) {
>> -               pll_out_khz = LANE_MAX_KBPS;
>> +       if (pll_out_khz > dsi->lane_max_kbps) {
>> +               pll_out_khz = dsi->lane_max_kbps;
>>                  DRM_WARN("Warning max phy mbps is used\n");
>>          }
>> -       if (pll_out_khz < LANE_MIN_KBPS) {
>> -               pll_out_khz = LANE_MIN_KBPS;
>> +       if (pll_out_khz < dsi->lane_min_kbps) {
>> +               pll_out_khz = dsi->lane_min_kbps;
>>                  DRM_WARN("Warning min phy mbps is used\n");
>>          }
>>
>> @@ -233,7 +253,8 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, struct drm_display_mode *mode,
>>          idf = 0;
>>          ndiv = 0;
>>          odf = 0;
>> -       ret = dsi_pll_get_params(pll_in_khz, pll_out_khz, &idf, &ndiv, &odf);
>> +       ret = dsi_pll_get_params(dsi, pll_in_khz, pll_out_khz,
>> +                                &idf, &ndiv, &odf);
>>          if (ret)
>>                  DRM_WARN("Warning dsi_pll_get_params(): bad params\n");
>>
>> --
>> 2.15.1
>>
