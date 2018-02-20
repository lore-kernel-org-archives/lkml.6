Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeBTJFA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 04:05:00 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40613 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbeBTJE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 04:04:57 -0500
X-Google-Smtp-Source: AH8x227lZWZaatg6CgYiqUA0klja6FMnmnYd07mKt9KGn9hBqYKk8xpqhsS80OEQU4AmaT1i/nrISw==
Subject: Re: [PATCH] drm/meson: fix vsync buffer update
To: airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Michal Lazo <michal.lazo@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1518689976-23292-1-git-send-email-narmstrong@baylibre.com>
 <20180219151900.GP22199@phenom.ffwll.local>
From: Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <261b72e2-554c-6fcc-34ea-1e4f8201d21e@baylibre.com>
Date: Tue, 20 Feb 2018 10:04:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219151900.GP22199@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2018 16:19, Daniel Vetter wrote:
> On Thu, Feb 15, 2018 at 11:19:36AM +0100, Neil Armstrong wrote:
>> The plane buffer address/stride/height was incorrectly updated in the
>> plane_atomic_update operation instead of the vsync irq.
>> This patch delays this operation in the vsync irq along with the
>> other plane delayed setup.
>>
>> This issue was masked using legacy framebuffer and X11 modesetting, but
>> is clearly visible using gbm rendering when buffer is submitted late after
>> vblank, like using software decoding and OpenGL rendering in Kodi.
>> With this patch, tearing and other artifacts disappears completely.
> 
> You mean the frontbuffer rendering nature of X11 with all it's tearing
> made the issue not noticeable? I'm also not clear what you mean with
> legacy framebuffer ...

Yeah I don't have to correct technical terms, sorry.

> 
> Either way looks reasonable:
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks,

Pushed to drm-misc-fixes.

Neil

> 
>> Cc: Michal Lazo <michal.lazo@gmail.com>
>> Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpu/drm/meson/meson_crtc.c  | 6 ++++++
>>  drivers/gpu/drm/meson/meson_drv.h   | 3 +++
>>  drivers/gpu/drm/meson/meson_plane.c | 7 +++----
>>  3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
>> index 5155f01..0552020 100644
>> --- a/drivers/gpu/drm/meson/meson_crtc.c
>> +++ b/drivers/gpu/drm/meson/meson_crtc.c
>> @@ -36,6 +36,7 @@
>>  #include "meson_venc.h"
>>  #include "meson_vpp.h"
>>  #include "meson_viu.h"
>> +#include "meson_canvas.h"
>>  #include "meson_registers.h"
>>  
>>  /* CRTC definition */
>> @@ -192,6 +193,11 @@ void meson_crtc_irq(struct meson_drm *priv)
>>  		} else
>>  			meson_vpp_disable_interlace_vscaler_osd1(priv);
>>  
>> +		meson_canvas_setup(priv, MESON_CANVAS_ID_OSD1,
>> +			   priv->viu.osd1_addr, priv->viu.osd1_stride,
>> +			   priv->viu.osd1_height, MESON_CANVAS_WRAP_NONE,
>> +			   MESON_CANVAS_BLKMODE_LINEAR);
>> +
>>  		/* Enable OSD1 */
>>  		writel_bits_relaxed(VPP_OSD1_POSTBLEND, VPP_OSD1_POSTBLEND,
>>  				    priv->io_base + _REG(VPP_MISC));
>> diff --git a/drivers/gpu/drm/meson/meson_drv.h b/drivers/gpu/drm/meson/meson_drv.h
>> index 5e8b392..8450d6ac 100644
>> --- a/drivers/gpu/drm/meson/meson_drv.h
>> +++ b/drivers/gpu/drm/meson/meson_drv.h
>> @@ -43,6 +43,9 @@ struct meson_drm {
>>  		bool osd1_commit;
>>  		uint32_t osd1_ctrl_stat;
>>  		uint32_t osd1_blk0_cfg[5];
>> +		uint32_t osd1_addr;
>> +		uint32_t osd1_stride;
>> +		uint32_t osd1_height;
>>  	} viu;
>>  
>>  	struct {
>> diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
>> index d0a6ac8..27bd350 100644
>> --- a/drivers/gpu/drm/meson/meson_plane.c
>> +++ b/drivers/gpu/drm/meson/meson_plane.c
>> @@ -164,10 +164,9 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
>>  	/* Update Canvas with buffer address */
>>  	gem = drm_fb_cma_get_gem_obj(fb, 0);
>>  
>> -	meson_canvas_setup(priv, MESON_CANVAS_ID_OSD1,
>> -			   gem->paddr, fb->pitches[0],
>> -			   fb->height, MESON_CANVAS_WRAP_NONE,
>> -			   MESON_CANVAS_BLKMODE_LINEAR);
>> +	priv->viu.osd1_addr = gem->paddr;
>> +	priv->viu.osd1_stride = fb->pitches[0];
>> +	priv->viu.osd1_height = fb->height;
>>  
>>  	spin_unlock_irqrestore(&priv->drm->event_lock, flags);
>>  }
>> -- 
>> 2.7.4
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
