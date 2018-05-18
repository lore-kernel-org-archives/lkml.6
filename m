Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeERPhA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:37:00 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34549 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeERPg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:36:58 -0400
X-Google-Smtp-Source: AB8JxZrBgdqyGQkW3+S2MXXQb46n1jDkkhl9kN6q9fQaHUDELFtJyFC4UvmwRIQnzon0I9rYL7CbgA==
Date: Fri, 18 May 2018 11:36:56 -0400
From: Sean Paul <seanpaul@chromium.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Brian Norris <briannorris@chromium.org>, hl <hl@rock-chips.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
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
Subject: Re: [PATCH v5 4/4] drm/rockchip: support dp training outside dp
 firmware
Message-ID: <20180518153656.GK3373@art_vandelay>
References: <1526548680-2552-1-git-send-email-hl@rock-chips.com>
 <d4c38236-7455-ccd5-a1d9-a000b7d78be9@rock-chips.com>
 <CA+ASDXN2LT6FcX_2-MM=Qu7cZOHwVK3+2rGDLGcC1SnY3BJaSw@mail.gmail.com>
 <11928313.3EhRqhFFHB@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11928313.3EhRqhFFHB@phil>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 10:52:17AM +0200, Heiko Stuebner wrote:
> Am Freitag, 18. Mai 2018, 03:45:46 CEST schrieb Brian Norris:
> > On Thu, May 17, 2018 at 6:41 PM, hl <hl@rock-chips.com> wrote:
> > > On Thursday, May 17, 2018 09:51 PM, Sean Paul wrote:
> > >> On Thu, May 17, 2018 at 05:18:00PM +0800, Lin Huang wrote:
> > >>> DP firmware uses fixed phy config values to do training, but some
> > >>> boards need to adjust these values to fit for their unique hardware
> > >>> design. So get phy config values from dts and use software link training
> > >>> instead of relying on firmware, if software training fail, keep firmware
> > >>> training as a fallback if sw training fails.
> > >>>
> > >>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> > >>> Signed-off-by: Lin Huang <hl@rock-chips.com>
> > >>> ---
> > >>> Changes in v2:
> > >>> - update patch following Enric suggest
> > >>> Changes in v3:
> > >>> - use variable fw_training instead sw_training_success
> > >>> - base on DP SPCE, if training fail use lower link rate to retry training
> > >>> Changes in v4:
> > >>> - improve cdn_dp_get_lower_link_rate() and cdn_dp_software_train_link() follow Sean suggest
> > >>> Changes in v5:
> > >>> - fix some whitespcae issue
> > >>>
> > >>>   drivers/gpu/drm/rockchip/Makefile               |   3 +-
> > >>>   drivers/gpu/drm/rockchip/cdn-dp-core.c          |  24 +-
> > >>>   drivers/gpu/drm/rockchip/cdn-dp-core.h          |   2 +
> > >>>   drivers/gpu/drm/rockchip/cdn-dp-link-training.c | 420 ++++++++++++++++++++++++
> > >>>   drivers/gpu/drm/rockchip/cdn-dp-reg.c           |  31 +-
> > >>>   drivers/gpu/drm/rockchip/cdn-dp-reg.h           |  38 ++-
> > >>>   6 files changed, 505 insertions(+), 13 deletions(-)
> > >>>   create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-link-training.c
> > >>>
> > ...
> > >>> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-link-training.c b/drivers/gpu/drm/rockchip/cdn-dp-link-training.c
> > >>> new file mode 100644
> > >>> index 0000000..73c3290
> > >>> --- /dev/null
> > >>> +++ b/drivers/gpu/drm/rockchip/cdn-dp-link-training.c
> > >>> @@ -0,0 +1,420 @@
> > >>> +// SPDX-License-Identifier: GPL-2.0
> > >>> +/*
> > >>> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> > >>> + * Author: Chris Zhong <zyw@rock-chips.com>
> > >>> + */
> > >>> +
> > >>> +#include <linux/device.h>
> > >>> +#include <linux/delay.h>
> > >>> +#include <linux/phy/phy.h>
> > >>> +#include <soc/rockchip/rockchip_phy_typec.h>
> > >>> +
> > >>> +#include "cdn-dp-core.h"
> > >>> +#include "cdn-dp-reg.h"
> > >>> +
> > >>> +static void cdn_dp_set_signal_levels(struct cdn_dp_device *dp)
> > >>> +{
> > >>> +       struct cdn_dp_port *port = dp->port[dp->active_port];
> > >>> +       struct rockchip_typec_phy *tcphy = phy_get_drvdata(port->phy);
> > >>
> > >> You ignored Brian's comment on the previous patch:
> > >>    This is still antithetical to the PHY framework; you're assuming that
> > >>    this is a particular type of PHY here.
> > >>
> > >> FWIW, the mediatek drm driver also assumes a certain PHY type. A quick grep of
> > >> drivers/ shows that the only other non-phy/ driver using this function
> > >> (pinctrl-tegra-xusb.c) also casts it.
> > >>
> > >> Sean
> > >
> > > Thanks Sean, except phy framework have new API to handle it, i have not
> > > idea how to do it in a better way.
> > 
> > Well, if Mediatek can do it for their MIPI and HDMI, then maybe we just do it...
> 
> I'd think so too. This is in Rockchip-specific code so it will always be
> possible to easily get the soc-type and thus phy-type, if that combination
> really changes down the road.
> 

So in the absence of a better solution, and with prior art,

Reviewed-by: Sean Paul <seanpaul@chromium.org>


We just need some eyes on the dt and phy changes in this set. Heiko, can you
help out with that?

Sean

> 
> Heiko
> 
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
