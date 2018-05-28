Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeE1IGh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:06:37 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54978 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753718AbeE1IGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:06:32 -0400
X-Google-Smtp-Source: ADUXVKIPsA6HV9BL++1qaPatNojOtnrG5lljXdVyaD9bc63j8Z3DmssnMmmnHC6TFfL+gTRggUDxvzTjb2ISIWARbQo=
MIME-Version: 1.0
X-Originating-IP: [2a02:168:5628:0:d0c7:bcda:eea:9e5d]
In-Reply-To: <2050411.pJQe2GrhOB@avalon>
References: <20180525155030.3667352-1-arnd@arndb.de> <20180525155030.3667352-7-arnd@arndb.de>
 <2050411.pJQe2GrhOB@avalon>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 28 May 2018 10:06:31 +0200
X-Google-Sender-Auth: ku4aV4bmYXFPbLTfFn_ekxZH7o4
Message-ID: <CAKMK7uHi6Pi3oX2hfoWFzh-LUC9QqFS5AY6b=BojvE9Yqc5Oug@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/bridge: fix dependency for lvds-encoder
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maciej Purski <m.purski@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 10:02 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Arnd,
>
> Thank you for the patch.
>
> On Friday, 25 May 2018 18:50:14 EEST Arnd Bergmann wrote:
>> The DRM panel bridge code is built into the kms helpers module, so we
>> get a link error when trying to use it from a built-in driver while the
>> kms helper is a loadable module:
>>
>> drivers/gpu/drm/bridge/lvds-encoder.o: In function `lvds_encoder_probe':
>> lvds-encoder.c:(.text+0x124): undefined reference to
>> `devm_drm_panel_bridge_add'
>>
>> This adds a the same dependency in the lvds-encoder that we use for all
>> the other users of the panel bridge. I did not bisect the problem, but
>> from inspection it seems to date back to the patch that separated out
>> the panel bridge from lvds encoder.
>>
>> Fixes: 13dfc0540a57 ("drm/bridge: Refactor out the panel wrapper from the
>> lvds-encoder bridge.") Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/gpu/drm/bridge/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>> index 6caa47834194..cf47bfa7a050 100644
>> --- a/drivers/gpu/drm/bridge/Kconfig
>> +++ b/drivers/gpu/drm/bridge/Kconfig
>> @@ -46,6 +46,7 @@ config DRM_DUMB_VGA_DAC
>>  config DRM_LVDS_ENCODER
>>       tristate "Transparent parallel to LVDS encoder support"
>>       depends on OF
>> +     select DRM_KMS_HELPER
>>       select DRM_PANEL_BRIDGE
>>       help
>>         Support for transparent parallel to LVDS encoders that don't require
>
> Wouldn't it be better to apply the following ?
>
> config DRM_PANEL_BRIDGE
>         def_bool y
>         depends on DRM_BRIDGE
> -       depends on DRM_KMS_HELPER
> +       select DRM_KMS_HELPER
>         select DRM_PANEL
>         help
>            DRM bridge wrapper of DRM panels
>
> Otherwise you'll potentially have to patch every user of DRM_PANEL_BRIDGE as
> done in this patch.

Select isn't recursive, so this won't work unfortunately :-/
-Daniel


> --
> Regards,
>
> Laurent Pinchart
>
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
