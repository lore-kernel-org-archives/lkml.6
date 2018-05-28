Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424918AbeE1LsY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:48:24 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46151 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423874AbeE1LK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:10:29 -0400
X-Google-Smtp-Source: ADUXVKKta/DhRR/5fIYGTzZW7hbEB7u7Ye6MSWyZdIyJwJp1ohWiCVK4Yp0WZyxj1EU9Zjd8M27e6P2l1BR2R0ggQVI=
MIME-Version: 1.0
In-Reply-To: <CAKMK7uHi6Pi3oX2hfoWFzh-LUC9QqFS5AY6b=BojvE9Yqc5Oug@mail.gmail.com>
References: <20180525155030.3667352-1-arnd@arndb.de> <20180525155030.3667352-7-arnd@arndb.de>
 <2050411.pJQe2GrhOB@avalon> <CAKMK7uHi6Pi3oX2hfoWFzh-LUC9QqFS5AY6b=BojvE9Yqc5Oug@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 28 May 2018 13:10:27 +0200
X-Google-Sender-Auth: zmv9P9ha215w2nLQFmUq-1miatw
Message-ID: <CAK8P3a0zWenhp683cqiK=dfBuSbUxUKCUHrD_795Fuk=deM7MQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/bridge: fix dependency for lvds-encoder
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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

On Mon, May 28, 2018 at 10:06 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Mon, May 28, 2018 at 10:02 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>> Hi Arnd,
>>
>> Thank you for the patch.
>>
>> On Friday, 25 May 2018 18:50:14 EEST Arnd Bergmann wrote:
>>> The DRM panel bridge code is built into the kms helpers module, so we
>>> get a link error when trying to use it from a built-in driver while the
>>> kms helper is a loadable module:
>>>
>>> drivers/gpu/drm/bridge/lvds-encoder.o: In function `lvds_encoder_probe':
>>> lvds-encoder.c:(.text+0x124): undefined reference to
>>> `devm_drm_panel_bridge_add'
>>>
>>> This adds a the same dependency in the lvds-encoder that we use for all
>>> the other users of the panel bridge. I did not bisect the problem, but
>>> from inspection it seems to date back to the patch that separated out
>>> the panel bridge from lvds encoder.
>>>
>>> Fixes: 13dfc0540a57 ("drm/bridge: Refactor out the panel wrapper from the
>>> lvds-encoder bridge.") Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  drivers/gpu/drm/bridge/Kconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>>> index 6caa47834194..cf47bfa7a050 100644
>>> --- a/drivers/gpu/drm/bridge/Kconfig
>>> +++ b/drivers/gpu/drm/bridge/Kconfig
>>> @@ -46,6 +46,7 @@ config DRM_DUMB_VGA_DAC
>>>  config DRM_LVDS_ENCODER
>>>       tristate "Transparent parallel to LVDS encoder support"
>>>       depends on OF
>>> +     select DRM_KMS_HELPER
>>>       select DRM_PANEL_BRIDGE
>>>       help
>>>         Support for transparent parallel to LVDS encoders that don't require
>>
>> Wouldn't it be better to apply the following ?
>>
>> config DRM_PANEL_BRIDGE
>>         def_bool y
>>         depends on DRM_BRIDGE
>> -       depends on DRM_KMS_HELPER
>> +       select DRM_KMS_HELPER
>>         select DRM_PANEL
>>         help
>>            DRM bridge wrapper of DRM panels
>>
>> Otherwise you'll potentially have to patch every user of DRM_PANEL_BRIDGE as
>> done in this patch.
>
> Select isn't recursive, so this won't work unfortunately :-/

The problem is a bit different: select *is* recursive, which is part of the
reason we normally try to avoid it (it gets hard to disable certain
symbols or turn them into modules when there are lots of things selecting
them).

However, DRM_PANEL_BRIDGE is a silent 'bool' symbol that is
always enabled when DRM_BRIDGE is enabled. Making it 'select
DRM_KMS_HELPER' would lead to DRM_KMS_HELPER always
being built-in even if all other DRM drivers are configured as
loadable modules! Note these Makefile line in drivers/gpu/drm:

drm_kms_helper-$(CONFIG_DRM_PANEL_BRIDGE) += bridge/panel.o
obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o

The intention is definitely that drm_kms_helper can be a loadable module,
(it cannot be built-in when CONFIG_DRM=m) and the panel bridge
is simply a component that gets linked into it, as of commit 123387d5efa6
("drm/bridge: Build the panel wrapper in drm_kms_helper").

       Arnd
