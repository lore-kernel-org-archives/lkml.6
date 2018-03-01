Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966668AbeCAJBG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:01:06 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:24142 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965361AbeCAJBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:01:04 -0500
From: Philippe CORNU <philippe.cornu@st.com>
To: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>, "Heiko Stubner" <heiko@sntech.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>
CC: Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: readl_poll_timeout return value
 clean up
Thread-Topic: [PATCH] drm/bridge/synopsys: dsi: readl_poll_timeout return
 value clean up
Thread-Index: AQHTngA8EO6d0iime02JI6Vf5496FaO7Kq8A
Date: Thu, 1 Mar 2018 09:00:22 +0000
Message-ID: <172e7f68-8f4b-7e5f-3e9f-7aaf10a51dc9@st.com>
References: <20180204213624.18288-1-philippe.cornu@st.com>
In-Reply-To: <20180204213624.18288-1-philippe.cornu@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFB7B5CB99F2654995995F876AAF03C1@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2191Dbf009313

Hi Archit, Andrzej & Laurent,

May I ask you please your feedback on this small patch?
Many thanks,

Philippe :-)

On 02/04/2018 10:36 PM, Philippe Cornu wrote:
> The readl_poll_timeout() return value is 0 in case of success
> so it is better to detect errors without taking care of the
> return value sign.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index 65aeb3f78b48..4d0e8471a15c 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -342,7 +342,7 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
>   	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>   				 val, !(val & GEN_CMD_FULL), 1000,
>   				 CMD_PKT_STATUS_TIMEOUT_US);
> -	if (ret < 0) {
> +	if (ret) {
>   		dev_err(dsi->dev, "failed to get available command FIFO\n");
>   		return ret;
>   	}
> @@ -353,7 +353,7 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
>   	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>   				 val, (val & mask) == mask,
>   				 1000, CMD_PKT_STATUS_TIMEOUT_US);
> -	if (ret < 0) {
> +	if (ret) {
>   		dev_err(dsi->dev, "failed to write command FIFO\n");
>   		return ret;
>   	}
> @@ -385,7 +385,7 @@ static int dw_mipi_dsi_write(struct dw_mipi_dsi *dsi,
>   		ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>   					 val, !(val & GEN_PLD_W_FULL), 1000,
>   					 CMD_PKT_STATUS_TIMEOUT_US);
> -		if (ret < 0) {
> +		if (ret) {
>   			dev_err(dsi->dev,
>   				"failed to get available write payload FIFO\n");
>   			return ret;
> @@ -716,13 +716,13 @@ static void dw_mipi_dsi_dphy_enable(struct dw_mipi_dsi *dsi)
>   
>   	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS, val,
>   				 val & PHY_LOCK, 1000, PHY_STATUS_TIMEOUT_US);
> -	if (ret < 0)
> +	if (ret)
>   		DRM_DEBUG_DRIVER("failed to wait phy lock state\n");
>   
>   	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
>   				 val, val & PHY_STOP_STATE_CLK_LANE, 1000,
>   				 PHY_STATUS_TIMEOUT_US);
> -	if (ret < 0)
> +	if (ret)
>   		DRM_DEBUG_DRIVER("failed to wait phy clk lane stop state\n");
>   }
>   
> 
