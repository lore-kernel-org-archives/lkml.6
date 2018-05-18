Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeERQgC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:36:02 -0400
Received: from gloria.sntech.de ([95.129.55.99]:40854 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752271AbeERQf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:35:59 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Sean Paul <seanpaul@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>, hl <hl@rock-chips.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
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
Subject: Re: [PATCH v5 4/4] drm/rockchip: support dp training outside dp firmware
Date: Fri, 18 May 2018 18:35:49 +0200
Message-ID: <5918781.MvJIhHKAbg@phil>
In-Reply-To: <20180518153656.GK3373@art_vandelay>
References: <1526548680-2552-1-git-send-email-hl@rock-chips.com> <11928313.3EhRqhFFHB@phil> <20180518153656.GK3373@art_vandelay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 18. Mai 2018, 17:36:56 CEST schrieb Sean Paul:
> On Fri, May 18, 2018 at 10:52:17AM +0200, Heiko Stuebner wrote:
> > Am Freitag, 18. Mai 2018, 03:45:46 CEST schrieb Brian Norris:
> > > On Thu, May 17, 2018 at 6:41 PM, hl <hl@rock-chips.com> wrote:
> > > > On Thursday, May 17, 2018 09:51 PM, Sean Paul wrote:
> > > >> On Thu, May 17, 2018 at 05:18:00PM +0800, Lin Huang wrote:
> > > >>> DP firmware uses fixed phy config values to do training, but some
> > > >>> boards need to adjust these values to fit for their unique hardware
> > > >>> design. So get phy config values from dts and use software link training
> > > >>> instead of relying on firmware, if software training fail, keep firmware
> > > >>> training as a fallback if sw training fails.
> > > >>>
> > > >>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> > > >>> Signed-off-by: Lin Huang <hl@rock-chips.com>
> > > >>> ---
> > > >>> Changes in v2:
> > > >>> - update patch following Enric suggest
> > > >>> Changes in v3:
> > > >>> - use variable fw_training instead sw_training_success
> > > >>> - base on DP SPCE, if training fail use lower link rate to retry training
> > > >>> Changes in v4:
> > > >>> - improve cdn_dp_get_lower_link_rate() and cdn_dp_software_train_link() follow Sean suggest
> > > >>> Changes in v5:
> > > >>> - fix some whitespcae issue
> > > >>>
> > > >>>   drivers/gpu/drm/rockchip/Makefile               |   3 +-
> > > >>>   drivers/gpu/drm/rockchip/cdn-dp-core.c          |  24 +-
> > > >>>   drivers/gpu/drm/rockchip/cdn-dp-core.h          |   2 +
> > > >>>   drivers/gpu/drm/rockchip/cdn-dp-link-training.c | 420 ++++++++++++++++++++++++
> > > >>>   drivers/gpu/drm/rockchip/cdn-dp-reg.c           |  31 +-
> > > >>>   drivers/gpu/drm/rockchip/cdn-dp-reg.h           |  38 ++-
> > > >>>   6 files changed, 505 insertions(+), 13 deletions(-)
> > > >>>   create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-link-training.c
> > > >>>
> > > ...
> > > >>> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-link-training.c b/drivers/gpu/drm/rockchip/cdn-dp-link-training.c
> > > >>> new file mode 100644
> > > >>> index 0000000..73c3290
> > > >>> --- /dev/null
> > > >>> +++ b/drivers/gpu/drm/rockchip/cdn-dp-link-training.c
> > > >>> @@ -0,0 +1,420 @@
> > > >>> +// SPDX-License-Identifier: GPL-2.0
> > > >>> +/*
> > > >>> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> > > >>> + * Author: Chris Zhong <zyw@rock-chips.com>
> > > >>> + */
> > > >>> +
> > > >>> +#include <linux/device.h>
> > > >>> +#include <linux/delay.h>
> > > >>> +#include <linux/phy/phy.h>
> > > >>> +#include <soc/rockchip/rockchip_phy_typec.h>
> > > >>> +
> > > >>> +#include "cdn-dp-core.h"
> > > >>> +#include "cdn-dp-reg.h"
> > > >>> +
> > > >>> +static void cdn_dp_set_signal_levels(struct cdn_dp_device *dp)
> > > >>> +{
> > > >>> +       struct cdn_dp_port *port = dp->port[dp->active_port];
> > > >>> +       struct rockchip_typec_phy *tcphy = phy_get_drvdata(port->phy);
> > > >>
> > > >> You ignored Brian's comment on the previous patch:
> > > >>    This is still antithetical to the PHY framework; you're assuming that
> > > >>    this is a particular type of PHY here.
> > > >>
> > > >> FWIW, the mediatek drm driver also assumes a certain PHY type. A quick grep of
> > > >> drivers/ shows that the only other non-phy/ driver using this function
> > > >> (pinctrl-tegra-xusb.c) also casts it.
> > > >>
> > > >> Sean
> > > >
> > > > Thanks Sean, except phy framework have new API to handle it, i have not
> > > > idea how to do it in a better way.
> > > 
> > > Well, if Mediatek can do it for their MIPI and HDMI, then maybe we just do it...
> > 
> > I'd think so too. This is in Rockchip-specific code so it will always be
> > possible to easily get the soc-type and thus phy-type, if that combination
> > really changes down the road.
> > 
> 
> So in the absence of a better solution, and with prior art,
> 
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> 
> 
> We just need some eyes on the dt and phy changes in this set. Heiko, can you
> help out with that?

done, but both the binding + phy changes should also get Acks from
Rob (dt) and Kishon (phy). Especially as the binding change is a bit more
than a new simple property.


Heiko
