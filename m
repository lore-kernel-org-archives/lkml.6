Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeERBpz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:45:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33610 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbeERBpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:45:51 -0400
X-Google-Smtp-Source: AB8JxZpxkCIe9IlQjLTP6JZIYmFRqtBari9xYTKc0fSeHdyhBDfyOmHH+Lwckh7Cf06YYAb+2Y7hBg==
MIME-Version: 1.0
In-Reply-To: <d4c38236-7455-ccd5-a1d9-a000b7d78be9@rock-chips.com>
References: <1526548680-2552-1-git-send-email-hl@rock-chips.com>
 <1526548680-2552-4-git-send-email-hl@rock-chips.com> <20180517135136.GD3373@art_vandelay>
 <d4c38236-7455-ccd5-a1d9-a000b7d78be9@rock-chips.com>
From: Brian Norris <briannorris@chromium.org>
Date: Thu, 17 May 2018 18:45:46 -0700
X-Gmail-Original-Message-ID: <CA+ASDXN2LT6FcX_2-MM=Qu7cZOHwVK3+2rGDLGcC1SnY3BJaSw@mail.gmail.com>
Message-ID: <CA+ASDXN2LT6FcX_2-MM=Qu7cZOHwVK3+2rGDLGcC1SnY3BJaSw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] drm/rockchip: support dp training outside dp firmware
To: hl <hl@rock-chips.com>
Cc: Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>, David Airlie <airlied@linux.ie>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>, dri-devel@lists.freedesktop.org,
        Chris Zhong <zyw@rock-chips.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 6:41 PM, hl <hl@rock-chips.com> wrote:
> On Thursday, May 17, 2018 09:51 PM, Sean Paul wrote:
>> On Thu, May 17, 2018 at 05:18:00PM +0800, Lin Huang wrote:
>>> DP firmware uses fixed phy config values to do training, but some
>>> boards need to adjust these values to fit for their unique hardware
>>> design. So get phy config values from dts and use software link training
>>> instead of relying on firmware, if software training fail, keep firmware
>>> training as a fallback if sw training fails.
>>>
>>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>>> Signed-off-by: Lin Huang <hl@rock-chips.com>
>>> ---
>>> Changes in v2:
>>> - update patch following Enric suggest
>>> Changes in v3:
>>> - use variable fw_training instead sw_training_success
>>> - base on DP SPCE, if training fail use lower link rate to retry training
>>> Changes in v4:
>>> - improve cdn_dp_get_lower_link_rate() and cdn_dp_software_train_link() follow Sean suggest
>>> Changes in v5:
>>> - fix some whitespcae issue
>>>
>>>   drivers/gpu/drm/rockchip/Makefile               |   3 +-
>>>   drivers/gpu/drm/rockchip/cdn-dp-core.c          |  24 +-
>>>   drivers/gpu/drm/rockchip/cdn-dp-core.h          |   2 +
>>>   drivers/gpu/drm/rockchip/cdn-dp-link-training.c | 420 ++++++++++++++++++++++++
>>>   drivers/gpu/drm/rockchip/cdn-dp-reg.c           |  31 +-
>>>   drivers/gpu/drm/rockchip/cdn-dp-reg.h           |  38 ++-
>>>   6 files changed, 505 insertions(+), 13 deletions(-)
>>>   create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-link-training.c
>>>
...
>>> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-link-training.c b/drivers/gpu/drm/rockchip/cdn-dp-link-training.c
>>> new file mode 100644
>>> index 0000000..73c3290
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/rockchip/cdn-dp-link-training.c
>>> @@ -0,0 +1,420 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
>>> + * Author: Chris Zhong <zyw@rock-chips.com>
>>> + */
>>> +
>>> +#include <linux/device.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/phy/phy.h>
>>> +#include <soc/rockchip/rockchip_phy_typec.h>
>>> +
>>> +#include "cdn-dp-core.h"
>>> +#include "cdn-dp-reg.h"
>>> +
>>> +static void cdn_dp_set_signal_levels(struct cdn_dp_device *dp)
>>> +{
>>> +       struct cdn_dp_port *port = dp->port[dp->active_port];
>>> +       struct rockchip_typec_phy *tcphy = phy_get_drvdata(port->phy);
>>
>> You ignored Brian's comment on the previous patch:
>>    This is still antithetical to the PHY framework; you're assuming that
>>    this is a particular type of PHY here.
>>
>> FWIW, the mediatek drm driver also assumes a certain PHY type. A quick grep of
>> drivers/ shows that the only other non-phy/ driver using this function
>> (pinctrl-tegra-xusb.c) also casts it.
>>
>> Sean
>
> Thanks Sean, except phy framework have new API to handle it, i have not
> idea how to do it in a better way.

Well, if Mediatek can do it for their MIPI and HDMI, then maybe we just do it...

Brian
