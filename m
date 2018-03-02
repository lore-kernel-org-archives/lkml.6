Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427987AbeCBNQy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:16:54 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7338 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1424439AbeCBNQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:16:41 -0500
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
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: readl_poll_timeout return value
 clean up
Thread-Topic: [PATCH] drm/bridge/synopsys: dsi: readl_poll_timeout return
 value clean up
Thread-Index: AQHTngA8EO6d0iime02JI6Vf5496FaO7Kq8AgAGo+oCAADC8gA==
Date: Fri, 2 Mar 2018 13:15:49 +0000
Message-ID: <587f8a32-b9b3-0e81-d91d-69ea256bdc29@st.com>
References: <20180204213624.18288-1-philippe.cornu@st.com>
 <CGME20180301090106epcas2p3c47f4436b0c8a31ce71cfd3909dc77ae@epcas2p3.samsung.com>
 <172e7f68-8f4b-7e5f-3e9f-7aaf10a51dc9@st.com>
 <290c749a-70bf-2b74-1fb9-2de26708d001@samsung.com>
In-Reply-To: <290c749a-70bf-2b74-1fb9-2de26708d001@samsung.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4FA7D0F1751414AA5C5DA7792EDD915@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w22DH1N8025759

Hi Andrzej,


On 03/02/2018 11:21 AM, Andrzej Hajda wrote:
> On 01.03.2018 10:00, Philippe CORNU wrote:
>> Hi Archit, Andrzej & Laurent,
>>
>> May I ask you please your feedback on this small patch?
>> Many thanks,
>>
>> Philippe :-)
>>
>> On 02/04/2018 10:36 PM, Philippe Cornu wrote:
>>> The readl_poll_timeout() return value is 0 in case of success
>>> so it is better to detect errors without taking care of the
>>> return value sign.
>>>
>>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> 
> The patch is of course correct. However I am not sure if necessary. For
> sure functionally it does not change anything.
> AFAIK kernel CodingStyle says nothing about it, so I suppose it is
> matter of personal taste.

I sent this tiny patch in order to homogenize the dw mipi driver because 
there were both cases "if (ret)" & "if (ret < 0)" in the source code.

I did not really find a preferred way in the kernel source code so I 
selected what sounds the best to me ie "if (ret)" but it is not a 
problem to make another patch for "if (ret < 0)" everywhere :-)

In any case, the most important from my pov is to have a homogeneous 
source code :-)

Does anyone have a preferred choice between "if (ret)" & "if (ret < 0)" 
after a "ret = readl_poll_timeout()"?

> Anyway I can give it:
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Many thanks,
Philippe :)

> 
>   --
> Regards
> Andrzej
> 
>>> ---
>>>    drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 10 +++++-----
>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>> index 65aeb3f78b48..4d0e8471a15c 100644
>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>> @@ -342,7 +342,7 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
>>>    	ret = qq(dsi->base + DSI_CMD_PKT_STATUS,
>>>    				 val, !(val & GEN_CMD_FULL), 1000,
>>>    				 CMD_PKT_STATUS_TIMEOUT_US);
>>> -	if (ret < 0) {
>>> +	if (ret) {
>>>    		dev_err(dsi->dev, "failed to get available command FIFO\n");
>>>    		return ret;
>>>    	}
>>> @@ -353,7 +353,7 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
>>>    	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>>>    				 val, (val & mask) == mask,
>>>    				 1000, CMD_PKT_STATUS_TIMEOUT_US);
>>> -	if (ret < 0) {
>>> +	if (ret) {
>>>    		dev_err(dsi->dev, "failed to write command FIFO\n");
>>>    		return ret;
>>>    	}
>>> @@ -385,7 +385,7 @@ static int dw_mipi_dsi_write(struct dw_mipi_dsi *dsi,
>>>    		ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>>>    					 val, !(val & GEN_PLD_W_FULL), 1000,
>>>    					 CMD_PKT_STATUS_TIMEOUT_US);
>>> -		if (ret < 0) {
>>> +		if (ret) {
>>>    			dev_err(dsi->dev,
>>>    				"failed to get available write payload FIFO\n");
>>>    			return ret;
>>> @@ -716,13 +716,13 @@ static void dw_mipi_dsi_dphy_enable(struct dw_mipi_dsi *dsi)
>>>    
>>>    	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS, val,
>>>    				 val & PHY_LOCK, 1000, PHY_STATUS_TIMEOUT_US);
>>> -	if (ret < 0)
>>> +	if (ret)
>>>    		DRM_DEBUG_DRIVER("failed to wait phy lock state\n");
>>>    
>>>    	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
>>>    				 val, val & PHY_STOP_STATE_CLK_LANE, 1000,
>>>    				 PHY_STATUS_TIMEOUT_US);
>>> -	if (ret < 0)
>>> +	if (ret)
>>>    		DRM_DEBUG_DRIVER("failed to wait phy clk lane stop state\n");
>>>    }
>>>    
> 
> 
