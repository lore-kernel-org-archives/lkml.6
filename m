Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeBEPAS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:00:18 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:59630 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752767AbeBEPAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:00:12 -0500
From: Philippe CORNU <philippe.cornu@st.com>
To: Andrzej Hajda <a.hajda@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        "Brian Norris" <briannorris@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>, Heiko Stubner <heiko@sntech.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>
CC: Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Ludovic BARRE <ludovic.barre@st.com>,
        Mickael REULIER <mickael.reulier@st.com>
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: Add 1.31 version support
Thread-Topic: [PATCH] drm/bridge/synopsys: dsi: Add 1.31 version support
Thread-Index: AQHTk5LdWuAUn8YTGUy5g1hoX/UE5qOVy4sAgAAgZAA=
Date: Mon, 5 Feb 2018 14:59:30 +0000
Message-ID: <4c69e41e-4f80-41ec-94f9-556baadfe8a8@st.com>
References: <CGME20180122150916epcas5p14fc276bc3320d82685b3c19dd62f5273@epcas5p1.samsung.com>
 <20180122150819.22066-1-philippe.cornu@st.com>
 <61f522e7-bdb7-7eba-ffb2-7dbb77ffa09e@samsung.com>
In-Reply-To: <61f522e7-bdb7-7eba-ffb2-7dbb77ffa09e@samsung.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8E6F5444EB9E04087F8794B85F3F361@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-05_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w15F0L26010466

Hi Andrzej,

And many thanks for your good comments

On 02/05/2018 02:03 PM, Andrzej Hajda wrote:
> On 22.01.2018 16:08, Philippe Cornu wrote:
>> From: Philippe CORNU <philippe.cornu@st.com>
>>
>> Add support for the Synopsys DesignWare MIPI DSI version 1.31
>> Two registers need to be updated/added for supporting 1.31:
>> * PHY_TMR_CFG 0x9c (updated)
>>    1.30 [31:24] phy_hs2lp_time
>>         [23:16] phy_lp2hs_time
>>         [14: 0] max_rd_time
>>
>>    1.31 [25:16] phy_hs2lp_time
>>         [ 9: 0] phy_lp2hs_time
>>
>> * PHY_TMR_RD_CFG 0xf4 (new)
>>    1.31 [14: 0] max_rd_time
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 52 +++++++++++++++++++++++----
>>   1 file changed, 46 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> index 735f38429c06..20a2ca14a7ad 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> @@ -25,7 +25,13 @@
>>   #include <drm/bridge/dw_mipi_dsi.h>
>>   #include <video/mipi_display.h>
>>   
>> +#define HWVER_130			0x31333000	/* IP version 1.30 */
>> +#define HWVER_131			0x31333100	/* IP version 1.31 */
>> +#define HWVER_OLDEST			HWVER_130
>> +#define HWVER_NEWEST			HWVER_131
>> +
>>   #define DSI_VERSION			0x00
>> +#define VERSION				GENMASK(31, 8)
>>   
>>   #define DSI_PWR_UP			0x04
>>   #define RESET				0
>> @@ -161,11 +167,12 @@
>>   #define PHY_CLKHS2LP_TIME(lbcc)		(((lbcc) & 0x3ff) << 16)
>>   #define PHY_CLKLP2HS_TIME(lbcc)		((lbcc) & 0x3ff)
>>   
>> -/* TODO Next register is slightly different between 1.30 & 1.31 IP version */
>>   #define DSI_PHY_TMR_CFG			0x9c
>> -#define PHY_HS2LP_TIME(lbcc)		(((lbcc) & 0xff) << 24)
>> -#define PHY_LP2HS_TIME(lbcc)		(((lbcc) & 0xff) << 16)
>> -#define MAX_RD_TIME(lbcc)		((lbcc) & 0x7fff)
>> +#define PHY_HS2LP_TIME_V130(lbcc)	(((lbcc) & 0xff) << 24)
>> +#define PHY_LP2HS_TIME_V130(lbcc)	(((lbcc) & 0xff) << 16)
>> +#define MAX_RD_TIME_V130(lbcc)		((lbcc) & 0x7fff)
>> +#define PHY_HS2LP_TIME_V131(lbcc)	(((lbcc) & 0x3ff) << 16)
>> +#define PHY_LP2HS_TIME_V131(lbcc)	((lbcc) & 0x3ff)
>>   
>>   #define DSI_PHY_RSTZ			0xa0
>>   #define PHY_DISFORCEPLL			0
>> @@ -204,7 +211,9 @@
>>   #define DSI_INT_ST1			0xc0
>>   #define DSI_INT_MSK0			0xc4
>>   #define DSI_INT_MSK1			0xc8
>> +
>>   #define DSI_PHY_TMR_RD_CFG		0xf4
>> +#define MAX_RD_TIME_V131(lbcc)		((lbcc) & 0x7fff)
>>   
>>   #define PHY_STATUS_TIMEOUT_US		10000
>>   #define CMD_PKT_STATUS_TIMEOUT_US	20000
>> @@ -215,6 +224,7 @@ struct dw_mipi_dsi {
>>   	struct drm_bridge *panel_bridge;
>>   	struct device *dev;
>>   	void __iomem *base;
>> +	u32 hw_version;
>>   
>>   	struct clk *pclk;
>>   	struct clk *px_clk;
>> @@ -616,8 +626,14 @@ static void dw_mipi_dsi_dphy_timing_config(struct dw_mipi_dsi *dsi)
>>   	 * note: DSI_PHY_TMR_CFG.MAX_RD_TIME should be in line with
>>   	 * DSI_CMD_MODE_CFG.MAX_RD_PKT_SIZE_LP (see CMD_MODE_ALL_LP)
>>   	 */
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
>>   	dsi_write(dsi, DSI_PHY_TMR_LPCLK_CFG, PHY_CLKHS2LP_TIME(0x40)
>>   		  | PHY_CLKLP2HS_TIME(0x40));
>> @@ -791,6 +807,28 @@ static const struct drm_bridge_funcs dw_mipi_dsi_bridge_funcs = {
>>   	.attach	      = dw_mipi_dsi_bridge_attach,
>>   };
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
>> +	}
>> +
>> +	dsi->hw_version = hw_version;
>> +}
>> +
>>   static struct dw_mipi_dsi *
>>   __dw_mipi_dsi_probe(struct platform_device *pdev,
>>   		    const struct dw_mipi_dsi_plat_data *plat_data)
>> @@ -870,6 +908,8 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
>>   		clk_disable_unprepare(dsi->pclk);
>>   	}
>>   
>> +	dsi_get_version(dsi);
>> +
>>   	pm_runtime_enable(dev);
> 
> Two questions:
> 1. You have generally two variants:
> - older than 131,
> - not older than 131.
> Wouldn't be better to just assume that since 131 registers slightly differ?
> So you just stores:
>      dsi->hw_version = dsi_read(dsi, DSI_VERSION) & VERSION;
> And if neccessary performs comparison:
>      if (dsi->hw_version >= HWVER_131)
>          ...
>      else
>          ...
> 
> This way you can remove these HWVER_(NEWEST|OLDEST).
> 

Archit & you are right, my code is too complex for at the end only 2 
different reg writes for the 1.31 version :)

I will follow all your good tips to simplify the code.

> 2. You are using pm_runtime, but not in dsi_get_version. I guess it is
> SoC dependant  but I suppose performing registry read should be safer
> after runtime_get.
> 
> Regards
> Andrzej
> 

dsi_get_version() is called only once and just before pm_runtime_enable().
Anyway, I think this function is not required anymore as there is only 
one place where we need to take care of the 1.31 version.

Many thanks,
Philippe :-)

>>   
>>   	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
> 
> 
