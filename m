Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754893AbeDWMaQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:30:16 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57383 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754729AbeDWMaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:30:13 -0400
From: Yannick FERTRE <yannick.fertre@st.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Archit Taneja" <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
CC: Philippe CORNU <philippe.cornu@st.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "David Airlie" <airlied@linux.ie>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        Brian Norris <briannorris@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>,
        Ludovic BARRE <ludovic.barre@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mickael REULIER <mickael.reulier@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: use adjusted_mode in mode_set
Thread-Topic: [PATCH] drm/bridge/synopsys: dsi: use adjusted_mode in mode_set
Thread-Index: AQHTlfTjD0BbTyAp1Em29Mkkb8XJlaOKj2yAgAAIrICAAAZCgIAHEuMAgAjP6gCAdAgHgIAAJtiA
Date: Mon, 23 Apr 2018 12:29:34 +0000
Message-ID: <5a214d57-0a1d-8cbe-eb9e-2f6a9ad1ddb8@st.com>
References: <20180125155504.8611-1-philippe.cornu@st.com>
 <7ec671c2-a777-5dcd-dcc9-e026fff89900@st.com> <1802436.kt7XbhHcH5@avalon>
 <2334482.mQhE6fZxKp@avalon>
In-Reply-To: <2334482.mQhE6fZxKp@avalon>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <598662D32899F24582AE5FE326EFA79C@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3NCUNIh005443

Hi Philippe,
I've tried your patch on both 4.17-rc1 & drm-misc-next and it works fine.
So,

Reviewed-by: Yannick Fertré <yannick.fertre@st.com>
Tested-by: Yannick Fertré <yannick.fertre@st.com>

BR

Yannick Fertré

On 04/23/2018 12:10 PM, Laurent Pinchart wrote:
> Hi Philippe,
> 
> On Thursday, 8 February 2018 15:15:40 EEST Laurent Pinchart wrote:
>> On Saturday, 3 February 2018 00:41:26 EET Philippe CORNU wrote:
>>> On 01/29/2018 11:40 AM, Laurent Pinchart wrote:
>>>> On Monday, 29 January 2018 12:17:37 EET Philippe CORNU wrote:
>>>>> On 01/29/2018 10:46 AM, Laurent Pinchart wrote:
>>>>>> On Thursday, 25 January 2018 17:55:04 EET Philippe Cornu wrote:
>>>>>>> The "adjusted_mode" clock value (ie the real pixel clock) is more
>>>>>>> accurate than "mode" clock value (ie the panel/bridge requested
>>>>>>> clock value). It offers a better preciseness for timing
>>>>>>> computations and allows to reduce the extra dsi bandwidth in
>>>>>>> burst mode (from ~20% to ~10-12%, hw platform dependant).
>>>>>>>
>>>>>>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>>>>>>
>>>>>> The adjusted mode is documented as
>>>>>>
>>>>>>    /**
>>>>>>    
>>>>>>     * @adjusted_mode:
>>>>>>     *
>>>>>>     * Internal display timings which can be used by the driver to
>>>>>>     handle
>>>>>>     * differences between the mode requested by userspace in @mode and
>>>>>>     what
>>>>>>     * is actually programmed into the hardware. It is purely driver
>>>>>>     * implementation defined what exactly this adjusted mode means.
>>>>>>     Usually
>>>>>>     * it is used to store the hardware display timings used between the
>>>>>>     * CRTC and encoder blocks.
>>>>>>     */
>>>>>>
>>>>>> This is easy to handle when the CRTC and encoder are controlled by the
>>>>>> same driver, as the field is "implementation defined" by a single
>>>>>> driver. However, when using bridges, there are two drivers involved,
>>>>>> and
>>>>>> they must both agree to meaningfully use the adjusted mode. I can't
>>>>>> see
>>>>>> how to do so without standardizing the meaning of the adjusted mode
>>>>>> field.
>>>>>
>>>>> This is exactly the reason why my first implementation used the dsi
>>>>> bridge "optional pixel clock" instead of the adjusted_mode (see [1])
>>>>>
>>>>> But after digging more into the drm source code, I think using
>>>>> adjusted_mode instead of the pixel clock here brings more advantages
>>>>> because:
>>>>> * adjusted_mode is an argument of bridge mode_set() probably for being
>>>>> used in any manner, maybe like this :)
>>>>> * if the bridge "user" (crtc or a master bridge drivers) does not need
>>>>> to modify its adjusted_mode then mode & adjusted_mode mode_set()
>>>>> arguments will have the same values so "no consequence" for the bridge.
>>>>> * if the bridge "user" (crtc or master bridge drivers) needs to adjust
>>>>> any value of the mode then this adjustment is available for the bridge.
>>>>
>>>> Remember that there can be multiple chained bridges, and a single
>>>> adjusted mode field.
>>>>
>>>>> * rockchip crtc updates a part of the mode (the clock), stm is doing
>>>>> the
>>>>> same (see [2]) but any future "user" of the dw_mipi_dsi bridge can
>>>>> adjust something else (blankings...) and the dw_mipi_dsi bridge will be
>>>>> then aware of...
>>>>>
>>>>> But maybe it is a wrong usage of the "adjusted_mode offer"...
>>>>
>>>> I don't disagree that there's a need for using adjusted values, but I
>>>> believe we need to create a clear API to do so. Using the adjust_mode
>>>> field as-is when it's clearly documented as being implementation-defined
>>>> is asking for trouble.
>>>
>>> Laurent, do you think we can use "adjusted mode" here in this small
>>> patch as the actual 2 "users" of this bridge (rockchip & stm) use both
>>> "adjusted mode" in their crtc?
>>
>> The Synopsys DSI driver might only be used by two display controller drivers
>> today, it is nonetheless a standard bridge driver that should not make any
>> assumption of a particular use of the adjusted_mode in particular display
>> controller drivers. To use the adjusted_mode value in bridge drivers we
>> need to standardize its usage, otherwise we'll end up with
>> incompatibilities between bridge drivers and display controller drivers.
> 
> Now that the documentation has been clarified I have no objection against this
> patch anymore.
> 
>>>>> [1] https://patchwork.freedesktop.org/patch/200240/
>>>>> [2] https://patchwork.freedesktop.org/patch/200720/
>>>>>
>>>>>> Daniel, what's your opinion on this ?
>>>
>>> Daniel, any opinion on the adjusted_mode usage?
>>>
>>>>>>> ---
>>>>>>> Note: This patch replaces "drm/bridge/synopsys: dsi: add optional
>>>>>>> pixel clock"
>>>>>>>
>>>>>>> drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 12 ++++++------
>>>>>>> 1 file changed, 6 insertions(+), 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>>>>>> b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c index
>>>>>>> ed8af32f8e52..b926b62e9e33 100644
>>>>>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>>>>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>>>>>> @@ -707,20 +707,20 @@ static void dw_mipi_dsi_bridge_mode_set(struct
>>>>>>> drm_bridge *bridge,
>>>>>>>
>>>>>>>     	clk_prepare_enable(dsi->pclk);
>>>>>>>
>>>>>>> -	ret = phy_ops->get_lane_mbps(priv_data, mode, dsi->mode_flags,
>>>>>>> +	ret = phy_ops->get_lane_mbps(priv_data, adjusted_mode,
>>>>>>> dsi->mode_flags,
>>>>>>>
>>>>>>>     				     dsi->lanes, dsi->format, &dsi->lane_mbps);
>>>>>>>     
>>>>>>>     if (ret)
>>>>>>>     
>>>>>>>     	DRM_DEBUG_DRIVER("Phy get_lane_mbps() failed\n");
>>>>>>>     
>>>>>>>     pm_runtime_get_sync(dsi->dev);
>>>>>>>     dw_mipi_dsi_init(dsi);
>>>>>>>
>>>>>>> -	dw_mipi_dsi_dpi_config(dsi, mode);
>>>>>>> +	dw_mipi_dsi_dpi_config(dsi, adjusted_mode);
>>>>>>>
>>>>>>>     dw_mipi_dsi_packet_handler_config(dsi);
>>>>>>>     dw_mipi_dsi_video_mode_config(dsi);
>>>>>>>
>>>>>>> -	dw_mipi_dsi_video_packet_config(dsi, mode);
>>>>>>> +	dw_mipi_dsi_video_packet_config(dsi, adjusted_mode);
>>>>>>>
>>>>>>>     dw_mipi_dsi_command_mode_config(dsi);
>>>>>>>
>>>>>>> -	dw_mipi_dsi_line_timer_config(dsi, mode);
>>>>>>> -	dw_mipi_dsi_vertical_timing_config(dsi, mode);
>>>>>>> +	dw_mipi_dsi_line_timer_config(dsi, adjusted_mode);
>>>>>>> +	dw_mipi_dsi_vertical_timing_config(dsi, adjusted_mode);
>>>>>>>
>>>>>>>     dw_mipi_dsi_dphy_init(dsi);
>>>>>>>     dw_mipi_dsi_dphy_timing_config(dsi);
>>>>>>>
>>>>>>> @@ -734,7 +734,7 @@ static void dw_mipi_dsi_bridge_mode_set(struct
>>>>>>> drm_bridge *bridge,
>>>>>>>
>>>>>>>     dw_mipi_dsi_dphy_enable(dsi);
>>>>>>>
>>>>>>> -	dw_mipi_dsi_wait_for_two_frames(mode);
>>>>>>> +	dw_mipi_dsi_wait_for_two_frames(adjusted_mode);
>>>>>>>
>>>>>>>     /* Switch to cmd mode for panel-bridge pre_enable & panel prepare
>>>>>>>     */
>>>>>>>     dw_mipi_dsi_set_mode(dsi, 0);
> 
