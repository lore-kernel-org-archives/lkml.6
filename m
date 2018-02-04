Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeBDPOE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 10:14:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeBDPN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 10:13:57 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87F536029D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: Add 1.31 version support
To: Philippe CORNU <philippe.cornu@st.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>, Heiko Stubner <heiko@sntech.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ludovic BARRE <ludovic.barre@st.com>,
        Mickael REULIER <mickael.reulier@st.com>
References: <20180122150819.22066-1-philippe.cornu@st.com>
 <37f38992-0ad3-317f-5337-fbe018bf5f45@st.com>
From: Archit <architt@codeaurora.org>
Message-ID: <917ebadc-d5f0-ef98-eb50-5e9bf25d722b@codeaurora.org>
Date: Sun, 4 Feb 2018 20:43:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <37f38992-0ad3-317f-5337-fbe018bf5f45@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillipe,

On Saturday 03 February 2018 03:49 AM, Philippe CORNU wrote:
> Hi Archit, Andrzej, Laurent & Brian,
> 
> What is your opinion regarding this patch? Do you have any advice for
> handling hw versions?
> 
> Do not hesitate to comment.

The patch looks mostly good to me. One query below.

> 
> Many thanks,
> Philippe :-)
> 
> 
> On 01/22/2018 04:08 PM, Philippe Cornu wrote:
>> From: Philippe CORNU <philippe.cornu@st.com>
>>
>> Add support for the Synopsys DesignWare MIPI DSI version 1.31
>> Two registers need to be updated/added for supporting 1.31:
>> * PHY_TMR_CFG 0x9c (updated)
>>     1.30 [31:24] phy_hs2lp_time
>>          [23:16] phy_lp2hs_time
>>          [14: 0] max_rd_time
>>
>>     1.31 [25:16] phy_hs2lp_time
>>          [ 9: 0] phy_lp2hs_time
>>
>> * PHY_TMR_RD_CFG 0xf4 (new)
>>     1.31 [14: 0] max_rd_time
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> ---
>>    drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 52 +++++++++++++++++++++++----
>>    1 file changed, 46 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> index 735f38429c06..20a2ca14a7ad 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> @@ -25,7 +25,13 @@
>>    #include <drm/bridge/dw_mipi_dsi.h>
>>    #include <video/mipi_display.h>
>>    
>> +#define HWVER_130			0x31333000	/* IP version 1.30 */
>> +#define HWVER_131			0x31333100	/* IP version 1.31 */
>> +#define HWVER_OLDEST			HWVER_130
>> +#define HWVER_NEWEST			HWVER_131
>> +
>>    #define DSI_VERSION			0x00
>> +#define VERSION				GENMASK(31, 8)
>>    
>>    #define DSI_PWR_UP			0x04
>>    #define RESET				0
>> @@ -161,11 +167,12 @@
>>    #define PHY_CLKHS2LP_TIME(lbcc)		(((lbcc) & 0x3ff) << 16)
>>    #define PHY_CLKLP2HS_TIME(lbcc)		((lbcc) & 0x3ff)
>>    
>> -/* TODO Next register is slightly different between 1.30 & 1.31 IP version */
>>    #define DSI_PHY_TMR_CFG			0x9c
>> -#define PHY_HS2LP_TIME(lbcc)		(((lbcc) & 0xff) << 24)
>> -#define PHY_LP2HS_TIME(lbcc)		(((lbcc) & 0xff) << 16)
>> -#define MAX_RD_TIME(lbcc)		((lbcc) & 0x7fff)
>> +#define PHY_HS2LP_TIME_V130(lbcc)	(((lbcc) & 0xff) << 24)
>> +#define PHY_LP2HS_TIME_V130(lbcc)	(((lbcc) & 0xff) << 16)
>> +#define MAX_RD_TIME_V130(lbcc)		((lbcc) & 0x7fff)
>> +#define PHY_HS2LP_TIME_V131(lbcc)	(((lbcc) & 0x3ff) << 16)
>> +#define PHY_LP2HS_TIME_V131(lbcc)	((lbcc) & 0x3ff)
>>    
>>    #define DSI_PHY_RSTZ			0xa0
>>    #define PHY_DISFORCEPLL			0
>> @@ -204,7 +211,9 @@
>>    #define DSI_INT_ST1			0xc0
>>    #define DSI_INT_MSK0			0xc4
>>    #define DSI_INT_MSK1			0xc8
>> +
>>    #define DSI_PHY_TMR_RD_CFG		0xf4
>> +#define MAX_RD_TIME_V131(lbcc)		((lbcc) & 0x7fff)
>>    
>>    #define PHY_STATUS_TIMEOUT_US		10000
>>    #define CMD_PKT_STATUS_TIMEOUT_US	20000
>> @@ -215,6 +224,7 @@ struct dw_mipi_dsi {
>>    	struct drm_bridge *panel_bridge;
>>    	struct device *dev;
>>    	void __iomem *base;
>> +	u32 hw_version;
>>    
>>    	struct clk *pclk;
>>    	struct clk *px_clk;
>> @@ -616,8 +626,14 @@ static void dw_mipi_dsi_dphy_timing_config(struct dw_mipi_dsi *dsi)
>>    	 * note: DSI_PHY_TMR_CFG.MAX_RD_TIME should be in line with
>>    	 * DSI_CMD_MODE_CFG.MAX_RD_PKT_SIZE_LP (see CMD_MODE_ALL_LP)
>>    	 */
>> -	dsi_write(dsi, DSI_PHY_TMR_CFG, PHY_HS2LP_TIME(0x40)
>> -		  | PHY_LP2HS_TIME(0x40) | MAX_RD_TIME(10000));
>> +	if (dsi->hw_version == HWVER_131) {
>> +		dsi_write(dsi, DSI_PHY_TMR_CFG, PHY_HS2LP_TIME_V131(0x40) |
>> +			  PHY_LP2HS_TIME_V131(0x40));
>> +		dsi_write(dsi, DSI_PHY_TMR_RD_CFG, MAX_RD_TIME_V131(10000));
>> +	} else {
>> +		dsi_write(dsi, DSI_PHY_TMR_CFG, PHY_HS2LP_TIME_V130(0x40) |
>> +			  PHY_LP2HS_TIME_V130(0x40) | MAX_RD_TIME_V130(10000));
>> +	}
>>    
>>    	dsi_write(dsi, DSI_PHY_TMR_LPCLK_CFG, PHY_CLKHS2LP_TIME(0x40)
>>    		  | PHY_CLKLP2HS_TIME(0x40));
>> @@ -791,6 +807,28 @@ static const struct drm_bridge_funcs dw_mipi_dsi_bridge_funcs = {
>>    	.attach	      = dw_mipi_dsi_bridge_attach,
>>    };
>>    
>> +static void dsi_get_version(struct dw_mipi_dsi *dsi)
>> +{
>> +	u32 hw_version;
>> +
>> +	clk_prepare_enable(dsi->pclk);
>> +	hw_version = dsi_read(dsi, DSI_VERSION) & VERSION;
>> +	clk_disable_unprepare(dsi->pclk);
>> +
>> +	if (hw_version > HWVER_NEWEST) {
>> +		DRM_DEBUG("hw version: use 0x%08x for this recent 0x%08x\n",
>> +			  HWVER_NEWEST, hw_version);
>> +		hw_version = HWVER_NEWEST;
>> +
>> +	} else if (hw_version < HWVER_OLDEST) {
>> +		DRM_DEBUG("hw version: use 0x%08x for this old 0x%08x\n",
>> +			  HWVER_OLDEST, hw_version);
>> +		hw_version = HWVER_OLDEST;

I didn't understand the point of HWVER_NEWEST and HWVWER_OLDEST. We're
not going to have a huge number of hw versions that we need to check if
our version lies within a range. We should rather have a switch case
which explicitly sets the hw_version vale based on what we read from
the DSI_VERSION register.

The patch looks fine otherwise.

Thanks,
Archit

>> +	}
>> +
>> +	dsi->hw_version = hw_version;
>> +}
>> +
>>    static struct dw_mipi_dsi *
>>    __dw_mipi_dsi_probe(struct platform_device *pdev,
>>    		    const struct dw_mipi_dsi_plat_data *plat_data)
>> @@ -870,6 +908,8 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
>>    		clk_disable_unprepare(dsi->pclk);
>>    	}
>>    
>> +	dsi_get_version(dsi);
>> +
>>    	pm_runtime_enable(dev);
>>    
>>    	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
