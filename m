Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeBBWmI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:42:08 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7261 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751544AbeBBWmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:42:02 -0500
From: Philippe CORNU <philippe.cornu@st.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Yannick FERTRE" <yannick.fertre@st.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Ludovic BARRE <ludovic.barre@st.com>,
        Mickael REULIER <mickael.reulier@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        "Andrzej Hajda" <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: use adjusted_mode in mode_set
Thread-Topic: [PATCH] drm/bridge/synopsys: dsi: use adjusted_mode in mode_set
Thread-Index: AQHTmOYMAxAS3zEgZEeYoSDzeMGpIaOKkjWAgAAGQoCABxLhAA==
Date: Fri, 2 Feb 2018 22:41:26 +0000
Message-ID: <7ec671c2-a777-5dcd-dcc9-e026fff89900@st.com>
References: <20180125155504.8611-1-philippe.cornu@st.com>
 <2782155.lsFkNecG25@avalon> <114a9fc1-3f31-decd-6bdc-803dc88b3b3c@st.com>
 <108376394.4I4zMjzv2j@avalon>
In-Reply-To: <108376394.4I4zMjzv2j@avalon>
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
Content-ID: <DE17521205D3BE4BB12E8A8016605CA7@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w12MgDTF007746

Hi Laurent & Daniel :-)

On 01/29/2018 11:40 AM, Laurent Pinchart wrote:
> Hi Philippe,
> 
> On Monday, 29 January 2018 12:17:37 EET Philippe CORNU wrote:
>> On 01/29/2018 10:46 AM, Laurent Pinchart wrote:
>>> On Thursday, 25 January 2018 17:55:04 EET Philippe Cornu wrote:
>>>
>>>> The "adjusted_mode" clock value (ie the real pixel clock) is more
>>>> accurate than "mode" clock value (ie the panel/bridge requested
>>>> clock value). It offers a better preciseness for timing
>>>> computations and allows to reduce the extra dsi bandwidth in
>>>> burst mode (from ~20% to ~10-12%, hw platform dependant).
>>>>
>>>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>>>
>>> The adjusted mode is documented as
>>>
>>>   /**
>>>    * @adjusted_mode:
>>>    *
>>>    * Internal display timings which can be used by the driver to handle
>>>    * differences between the mode requested by userspace in @mode and what
>>>    * is actually programmed into the hardware. It is purely driver
>>>    * implementation defined what exactly this adjusted mode means. Usually
>>>    * it is used to store the hardware display timings used between the
>>>    * CRTC and encoder blocks.
>>>    */
>>>
>>> This is easy to handle when the CRTC and encoder are controlled by the
>>> same driver, as the field is "implementation defined" by a single driver
>>> . However, when using bridges, there are two drivers involved, and they
>>> must both agree to meaningfully use the adjusted mode. I can't see how to
>>> do so without standardizing the meaning of the adjusted mode field.
>>
>> This is exactly the reason why my first implementation used the dsi
>> bridge "optional pixel clock" instead of the adjusted_mode (see [1])
>>
>> But after digging more into the drm source code, I think using
>> adjusted_mode instead of the pixel clock here brings more advantages
>> because:
>> * adjusted_mode is an argument of bridge mode_set() probably for being
>> used in any manner, maybe like this :)
>> * if the bridge "user" (crtc or a master bridge drivers) does not need
>> to modify its adjusted_mode then mode & adjusted_mode mode_set()
>> arguments will have the same values so "no consequence" for the bridge.
>> * if the bridge "user" (crtc or master bridge drivers) needs to adjust
>> any value of the mode then this adjustment is available for the bridge.
> 
> Remember that there can be multiple chained bridges, and a single adjusted
> mode field.
> 
>> * rockchip crtc updates a part of the mode (the clock), stm is doing the
>> same (see [2]) but any future "user" of the dw_mipi_dsi bridge can
>> adjust something else (blankings...) and the dw_mipi_dsi bridge will be
>> then aware of...
>>
>> But maybe it is a wrong usage of the "adjusted_mode offer"...
> 
> I don't disagree that there's a need for using adjusted values, but I believe
> we need to create a clear API to do so. Using the adjust_mode field as-is when
> it's clearly documented as being implementation-defined is asking for trouble.
> 

Laurent, do you think we can use "adjusted mode" here in this small 
patch as the actual 2 "users" of this bridge (rockchip & stm) use both 
"adjusted mode" in their crtc?

>> Many thanks,
>> Philippe :-)
>> [1] https://patchwork.freedesktop.org/patch/200240/
>> [2] https://patchwork.freedesktop.org/patch/200720/
>>
>>> Daniel, what's your opinion on this ?
>>>

Daniel, any opinion on the adjusted_mode usage?

Many thanks to both of you,
Philippe :-)

>>>> ---
>>>> Note: This patch replaces "drm/bridge/synopsys: dsi: add optional pixel
>>>> clock"
>>>>
>>>>    drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 12 ++++++------
>>>>    1 file changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>>> b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c index
>>>> ed8af32f8e52..b926b62e9e33 100644
>>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>>> @@ -707,20 +707,20 @@ static void dw_mipi_dsi_bridge_mode_set(struct
>>>> drm_bridge *bridge,
>>>>
>>>>    	clk_prepare_enable(dsi->pclk);
>>>>
>>>> -	ret = phy_ops->get_lane_mbps(priv_data, mode, dsi->mode_flags,
>>>> +	ret = phy_ops->get_lane_mbps(priv_data, adjusted_mode,
>>>> dsi->mode_flags,
>>>>    				     dsi->lanes, dsi->format, &dsi->lane_mbps);
>>>>    if (ret)
>>>>    	DRM_DEBUG_DRIVER("Phy get_lane_mbps() failed\n");
>>>>
>>>>    pm_runtime_get_sync(dsi->dev);
>>>>    dw_mipi_dsi_init(dsi);
>>>>
>>>> -	dw_mipi_dsi_dpi_config(dsi, mode);
>>>> +	dw_mipi_dsi_dpi_config(dsi, adjusted_mode);
>>>>    dw_mipi_dsi_packet_handler_config(dsi);
>>>>    dw_mipi_dsi_video_mode_config(dsi);
>>>> -	dw_mipi_dsi_video_packet_config(dsi, mode);
>>>> +	dw_mipi_dsi_video_packet_config(dsi, adjusted_mode);
>>>>    dw_mipi_dsi_command_mode_config(dsi);
>>>> -	dw_mipi_dsi_line_timer_config(dsi, mode);
>>>> -	dw_mipi_dsi_vertical_timing_config(dsi, mode);
>>>> +	dw_mipi_dsi_line_timer_config(dsi, adjusted_mode);
>>>> +	dw_mipi_dsi_vertical_timing_config(dsi, adjusted_mode);
>>>>    dw_mipi_dsi_dphy_init(dsi);
>>>>    dw_mipi_dsi_dphy_timing_config(dsi);
>>>>
>>>> @@ -734,7 +734,7 @@ static void dw_mipi_dsi_bridge_mode_set(struct
>>>> drm_bridge *bridge,
>>>>
>>>>    dw_mipi_dsi_dphy_enable(dsi);
>>>>
>>>> -	dw_mipi_dsi_wait_for_two_frames(mode);
>>>> +	dw_mipi_dsi_wait_for_two_frames(adjusted_mode);
>>>>
>>>>    /* Switch to cmd mode for panel-bridge pre_enable & panel prepare */
>>>>    dw_mipi_dsi_set_mode(dsi, 0);
> 
