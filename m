Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7297C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 05:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581CD2173D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 05:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581CD2173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbeHNIOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 04:14:06 -0400
Received: from hermes.aosc.io ([199.195.250.187]:47400 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728521AbeHNIOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 04:14:06 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 2BB0A5DAF9;
        Tue, 14 Aug 2018 05:28:28 +0000 (UTC)
Message-ID: <ddd86a558977fc9942f5f1fa8cefc813ad80f614.camel@aosc.io>
Subject: Re: [PATCH] drm/bridge/synopsys: dw-hdmi: re-run dw_hdmi_setup when
 setting mode
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Aug 2018 13:28:18 +0800
In-Reply-To: <20180813114945eucas1p1e9d900848b4256341fe93278f4fa6f67~Kb0nDRoKq0841508415eucas1p1p@eucas1p1.samsung.com>
References: <CGME20180725035712epcas1p25df72b8af38438b7bb66a2729fdff445@epcas1p2.samsung.com>
         <20180725035627.58223-1-icenowy@aosc.io>
         <20180813114945eucas1p1e9d900848b4256341fe93278f4fa6f67~Kb0nDRoKq0841508415eucas1p1p@eucas1p1.samsung.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-08-13一的 13:49 +0200，Andrzej Hajda写道：
> On 25.07.2018 05:56, Icenowy Zheng wrote:
> > Currently dw_hdmi_setup is only run when the dw-hdmi bridge is
> > enabled,
> > with the mode set last time.
> > 
> > When the bridge is enabled before any mode is set (this may happen
> > when
> > booting), the mode won't be set at all, some setup steps will be
> > skipped or fail, and the HDMI output may not work.
> 
> I guess, it should not happen. Could you show the stack-trace.

Mysteriously dw_hdmi_setup isn't called at all currently when booting
in thie situation. I added dump_stack() at the head of the function,
and it's only triggered when I re-plug the monitor.

In this case I got:
```
[   46.891513] CPU: 0 PID: 73 Comm: irq/34-1ee0000. Not tainted 4.18.0+
#152
[   46.898290] Hardware name: Allwinner sun8i Family
[   46.903008] [<c010efac>] (unwind_backtrace) from [<c010bfd0>]
(show_stack+0x10/0x14)
[   46.910746] [<c010bfd0>] (show_stack) from [<c06f59c4>]
(dump_stack+0x88/0x9c)
[   46.917966] [<c06f59c4>] (dump_stack) from [<c04444d8>]
(dw_hdmi_update_power+0xb8/0x12cc)
[   46.926225] [<c04444d8>] (dw_hdmi_update_power) from [<c044593c>]
(dw_hdmi_bridge_enable+0x2c/0x70)
[   46.935262] [<c044593c>] (dw_hdmi_bridge_enable) from [<c04261f0>]
(drm_bridge_enable+0x24/0x34)
[   46.944040] [<c04261f0>] (drm_bridge_enable) from [<c0404fd0>]
(drm_atomic_helper_commit_modeset_enables+0x9c/0x180)
[   46.954552] [<c0404fd0>] (drm_atomic_helper_commit_modeset_enables)
from [<c040879c>] (drm_atomic_helper_commit_tail_rpm+0x24/0x64)
[   46.966361] [<c040879c>] (drm_atomic_helper_commit_tail_rpm) from
[<c040861c>] (commit_tail+0x40/0x6c)
[   46.975657] [<c040861c>] (commit_tail) from [<c040870c>]
(drm_atomic_helper_commit+0xbc/0x128)
[   46.984259] [<c040870c>] (drm_atomic_helper_commit) from
[<c040ac70>] (restore_fbdev_mode_atomic+0x1cc/0x220)
[   46.994164] [<c040ac70>] (restore_fbdev_mode_atomic) from
[<c040df90>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x54/0xa0)
[   47.005369] [<c040df90>] (drm_fb_helper_restore_fbdev_mode_unlocked)
from [<c040e00c>] (drm_fb_helper_set_par+0x30/0x54)
[   47.016226] [<c040e00c>] (drm_fb_helper_set_par) from [<c040df08>]
(drm_fb_helper_hotplug_event.part.11+0xa0/0xa8)
[   47.026563] [<c040df08>] (drm_fb_helper_hotplug_event.part.11) from
[<c03fee0c>] (drm_helper_hpd_irq_event+0x110/0x118)
[   47.037334] [<c03fee0c>] (drm_helper_hpd_irq_event) from
[<c0445888>] (dw_hdmi_irq+0x10c/0x194)
[   47.046025] [<c0445888>] (dw_hdmi_irq) from [<c01626a8>]
(irq_thread_fn+0x1c/0x54)
[   47.053589] [<c01626a8>] (irq_thread_fn) from [<c01629c4>]
(irq_thread+0x158/0x21c)
[   47.061241] [<c01629c4>] (irq_thread) from [<c013a324>]
(kthread+0x148/0x150)
[   47.068373] [<c013a324>] (kthread) from [<c01010e8>]
(ret_from_fork+0x14/0x2c)
[   47.075584] Exception stack(0xee8bbfb0 to 0xee8bbff8)
[   47.080630] bfa0:                                     00000000
00000000 00000000 00000000
[   47.088797] bfc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   47.096964] bfe0: 00000000 00000000 00000000 00000000 00000013
00000000
```

> 
> > 
> > Re-run dw_hdmi_setup when setting mode, in order to prevent such
> > situation.
> 
> mode_set is run with hardware disabled, thus usually it should not
> touch
> hardware.

However I think there's many instances now where some hardware setup is
performed in mode_set.

> 
> 
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > index 5971976284bf..e2f832182afe 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -2007,6 +2007,7 @@ static void dw_hdmi_bridge_mode_set(struct
> > drm_bridge *bridge,
> >  
> >  	/* Store the display mode for plugin/DKMS poweron events */
> >  	memcpy(&hdmi->previous_mode, mode, sizeof(hdmi-
> > >previous_mode));
> > +	dw_hdmi_setup(hdmi, mode);
> 
> This hdmi->previous_mode also looks strange, it is current mode and
> moreover it is always available from crtc state, there is no point in
> copying it to private field.

Sorry I don't know about this. Maybe you should ask the original author
of dw-hdmi?

> 
> Regards
> Andrzej
> >  
> >  	mutex_unlock(&hdmi->mutex);
> >  }
> 
> 

