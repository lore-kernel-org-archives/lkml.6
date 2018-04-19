Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbeDSRAj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:00:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60988 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753201AbeDSRAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:00:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E959F602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH] drm: clarify adjusted_mode documentation for bridges
To: Philippe CORNU <philippe.cornu@st.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>
References: <20180409152427.12449-1-philippe.cornu@st.com>
 <b09d3039-41f7-5de1-7323-2f30ccd7141b@st.com>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <a33a7a7e-fb4f-6293-2dd8-0a9afb4e9a9a@codeaurora.org>
Date: Thu, 19 Apr 2018 22:30:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b09d3039-41f7-5de1-7323-2f30ccd7141b@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 19 April 2018 09:20 PM, Philippe CORNU wrote:
> Hi Archit & Andrzej,
> 
> May I ask you please a short review of this documentation update.
> Many thanks
> Philippe :-)
> 
> On 04/09/2018 05:24 PM, Philippe Cornu wrote:
>> This patch clarifies the adjusted_mode documentation
>> for bridges.
>>

Reviewed-by: Archit Taneja <architt@codeaurora.org>

>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>> ---
>> This patch follows discussions in:
>> - "drm: clarify adjusted_mode for a bridge connected to a crtc"
>>     https://patchwork.freedesktop.org/patch/206801/
>> - "drm: bridge: Constify mode arguments to bridge .mode_set() operation"
>>     https://patchwork.freedesktop.org/patch/215449/
>>
>>    include/drm/drm_bridge.h | 16 ++++++++++++++++
>>    include/drm/drm_crtc.h   | 11 +++++++----
>>    2 files changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>> index 3270fec46979..7d632c6a9214 100644
>> --- a/include/drm/drm_bridge.h
>> +++ b/include/drm/drm_bridge.h
>> @@ -178,6 +178,22 @@ struct drm_bridge_funcs {
>>    	 * then this would be &drm_encoder_helper_funcs.mode_set. The display
>>    	 * pipe (i.e.  clocks and timing signals) is off when this function is
>>    	 * called.
>> +	 *
>> +	 * The adjusted_mode parameter corresponds to the mode output by the CRTC
>> +	 * for the first bridge in the chain. It can be different from the mode
>> +	 * parameter that contains the desired mode for the connector at the end
>> +	 * of the bridges chain, for instance when the first bridge in the chain
>> +	 * performs scaling. The adjusted mode is mostly useful for the first
>> +	 * bridge in the chain and is likely irrelevant for the other bridges.
>> +	 *
>> +	 * For atomic drivers the adjusted_mode is the mode stored in
>> +	 * &drm_crtc_state.adjusted_mode.
>> +	 *
>> +	 * NOTE:
>> +	 *
>> +	 * If a need arises to store and access modes adjusted for other locations
>> +	 * than the connection between the CRTC and the first bridge, the DRM
>> +	 * framework will have to be extended with DRM bridge states.
>>    	 */
>>    	void (*mode_set)(struct drm_bridge *bridge,
>>    			 struct drm_display_mode *mode,
>> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
>> index a2d81d2907a9..65f749a9e9d3 100644
>> --- a/include/drm/drm_crtc.h
>> +++ b/include/drm/drm_crtc.h
>> @@ -134,10 +134,13 @@ struct drm_crtc_state {
>>    	 *
>>    	 * Internal display timings which can be used by the driver to handle
>>    	 * differences between the mode requested by userspace in @mode and what
>> -	 * is actually programmed into the hardware. It is purely driver
>> -	 * implementation defined what exactly this adjusted mode means. Usually
>> -	 * it is used to store the hardware display timings used between the
>> -	 * CRTC and encoder blocks.
>> +	 * is actually programmed into the hardware.
>> +	 *
>> +	 * For drivers using drm_bridge, this stores the hardware display timings
>> +	 * used between the CRTC and the first bridge. For other drivers, the
>> +	 * meaning of the adjusted_mode field is purely driver implementation
>> +	 * defined information, and will usually be used to store the hardware
>> +	 * display timings used between the CRTC and encoder blocks.
>>    	 */
>>    	struct drm_display_mode adjusted_mode;
>>    
