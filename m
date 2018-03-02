Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936248AbeCBLoC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 06:44:02 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:49074 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935632AbeCBLoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 06:44:00 -0500
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH] drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1519834492-30559-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180301093909.ph6nuvxuqtwyfssd@flea>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <0666b792-1f01-8138-7a6f-f98f9de95348@micronovasrl.com>
Date: Fri, 2 Mar 2018 12:43:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301093909.ph6nuvxuqtwyfssd@flea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Il 01/03/2018 10:39, Maxime Ripard ha scritto:
> On Wed, Feb 28, 2018 at 05:14:52PM +0100, Giulio Benetti wrote:
>> Handle both positive and negative dclk polarity,
>> according to bus_flags.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> ---
>>   drivers/gpu/drm/sun4i/sun4i_tcon.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> index aaf911a..534e5ee 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> @@ -17,6 +17,7 @@
>>   #include <drm/drm_encoder.h>
>>   #include <drm/drm_modes.h>
>>   #include <drm/drm_of.h>
>> +#include <drm/drm_panel.h>
>>   
>>   #include <uapi/drm/drm_mode.h>
>>   
>> @@ -340,6 +341,9 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
>>   static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>>   				     const struct drm_display_mode *mode)
>>   {
>> +	struct drm_panel *panel = tcon->panel;
>> +	struct drm_connector *connector = panel->connector;
>> +	struct drm_display_info display_info = connector->display_info;
>>   	unsigned int bp, hsync, vsync;
>>   	u8 clk_delay;
>>   	u32 val = 0;
>> @@ -395,8 +399,15 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>>   	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>>   		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
>>   
>> +	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
>> +		clk_set_phase(tcon->dclk, 240);
>> +
>> +	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
>> +		clk_set_phase(tcon->dclk, 0);
>> +
> 
> This needs to have a whole bunch of comments here. We want to have
> basically the whole discussion we had by mail previously about this in
> there.
> 
> And the same goes for your commit log.

Ok, I follow asap with V2 patch describing everything we told on 
previous thread.

> 
>>   	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
>> -			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
>> +			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE |
>> +			   SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
>>   			   val);
> 
> This has nothing to do with your patch.

Yes, sorry, I've seen it now, I remove it on V2 patch

> 
> Maxime
> 
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 


-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
