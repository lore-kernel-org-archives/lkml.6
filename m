Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935361AbeCCAU1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 19:20:27 -0500
Received: from regular1.263xmail.com ([211.150.99.141]:56717 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932890AbeCCAUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 19:20:25 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: laurent.pinchart@ideasonboard.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <ae582945c0639de38d7bc1ddbe299896>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A99EA37.6070006@rock-chips.com>
Date: Sat, 03 Mar 2018 08:20:07 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
CC: Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-rockchip@lists.infradead.org,
        Archit Taneja <architt@codeaurora.org>, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        kernel@collabora.com, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH v9 5/5] drm/bridge/synopsys: dw-hdmi: Add missing bridge
 detach
References: <20180302175757.28192-1-enric.balletbo@collabora.com> <20180302175757.28192-6-enric.balletbo@collabora.com> <2714218.VptbnhJPkd@avalon>
In-Reply-To: <2714218.VptbnhJPkd@avalon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 03/03/2018 05:49 AM, Laurent Pinchart wrote:
> Hi Enric,
>
> Thank you for the patch.
>
> On Friday, 2 March 2018 19:57:57 EET Enric Balletbo i Serra wrote:
>> From: Jeffy Chen <jeffy.chen@rock-chips.com>
>>
>> We inited connector in attach(), so need a detach() to cleanup.
>
> Do we ? The dw-hdmi driver already sets drm_connector_cleanup() as the
> connector .destroy() handler, and the .destroy() operation is called by the
> DRM core. None of the other bridge drivers call drm_connector_cleanup()
> directly.

hmmm, checking the code, there are also lots of drivers do the 
cleanup(drm_connector_cleanup or funcs->destroy):
drm# grep -r "connector.*funcs->destroy" .
./rockchip/inno_hdmi.c: hdmi->connector.funcs->destroy(&hdmi->connector);
./rockchip/cdn-dp-core.c:       connector->funcs->destroy(connector);
./bridge/analogix/analogix_dp_core.c: 
dp->connector.funcs->destroy(&dp->connector);
./msm/hdmi/hdmi.c: 
hdmi->connector->funcs->destroy(hdmi->connector);
./msm/dsi/dsi.c: 
msm_dsi->connector->funcs->destroy(msm_dsi->connector);
./msm/edp/edp.c: 
edp->connector->funcs->destroy(edp->connector);
./zte/zx_hdmi.c:        hdmi->connector.funcs->destroy(&hdmi->connector);
./drm_connector.c:      connector->funcs->destroy(connector);
./drm_connector.c:              connector->funcs->destroy(connector);
./nouveau/dispnv04/disp.c: 
connector->funcs->destroy(connector);
./nouveau/nv50_display.c: 
mstc->connector.funcs->destroy(&mstc->connector);
./nouveau/nv50_display.c: 
connector->funcs->destroy(connector);



when i debug analogix_dp bind/unbind, i found that we need to cleanup 
the connector(reported by kmemleak). so i added it to 
./bridge/analogix/analogix_dp_core.c...after that i saw dw-hdmi missing 
that too(by checking the code), so make this patch.

but i didn't really tested it on devices using dw-hdmi, so i'm not very 
sure the dw-hdmi(maybe also other bridges) is the same with analogix_dp.

i can try to find a chromebook veyron to check it next week :)

but even there's a leak, i'm still not very sure about:
should the caller of drm_connector_init cleanup it
or the caller of drm_bridge_attach should do it(for example 
analogix_dp_bind/analogix_dp_unbind)
or should the DRM core take care of that?

>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v9: None
>>
>>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
>> f9802399cc0d..5626922f95f9 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -1985,6 +1985,13 @@ static int dw_hdmi_bridge_attach(struct drm_bridge
>> *bridge) return 0;
>>   }
>>
>> +static void dw_hdmi_bridge_detach(struct drm_bridge *bridge)
>> +{
>> +	struct dw_hdmi *hdmi = bridge->driver_private;
>> +
>> +	drm_connector_cleanup(&hdmi->connector);
>> +}
>> +
>>   static enum drm_mode_status
>>   dw_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
>>   			  const struct drm_display_mode *mode)
>> @@ -2041,6 +2048,7 @@ static void dw_hdmi_bridge_enable(struct drm_bridge
>> *bridge)
>>
>>   static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
>>   	.attach = dw_hdmi_bridge_attach,
>> +	.detach = dw_hdmi_bridge_detach,
>>   	.enable = dw_hdmi_bridge_enable,
>>   	.disable = dw_hdmi_bridge_disable,
>>   	.mode_set = dw_hdmi_bridge_mode_set,
>
