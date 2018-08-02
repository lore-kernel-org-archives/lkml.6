Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAC7C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDC2214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDC2214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387400AbeHBNbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:31:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57311 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732191AbeHBNbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:31:01 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1flBxj-0003Iq-R2; Thu, 02 Aug 2018 13:40:11 +0200
Message-ID: <1533210010.3516.21.camel@pengutronix.de>
Subject: Re: [PATCH v2] drm/mxsfb: Fix runtime PM for unpowering lcdif block
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Stefan Agner <stefan@agner.ch>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Marek Vasut <marex@denx.de>, Anson Huang <Anson.Huang@nxp.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Robert Chiras <robert.chiras@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Date:   Thu, 02 Aug 2018 13:40:10 +0200
In-Reply-To: <053a788e297c5b54baa80d03586da53d@agner.ch>
References: <f873c5592e9907beba905ce68358d5ae2f63a4d7.1531824173.git.leonard.crestez@nxp.com>
         <053a788e297c5b54baa80d03586da53d@agner.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Wed, 2018-08-01 at 12:00 +0200, Stefan Agner wrote:
[...]
> > @@ -307,14 +335,15 @@ void mxsfb_plane_atomic_update(struct
> > mxsfb_drm_private *mxsfb,
> >  			drm_crtc_send_vblank_event(crtc, event);
> >  		}
> >  	}
> >  	spin_unlock_irq(&crtc->dev->event_lock);
> >  
> > -	if (!fb)
> > +	if (!mxsfb->enabled)
> >  		return;
> >  
> 
> I think this is the wrong thing to do.
> 
> The simple KMS helper callback ->update() is called by the
> ->atomic_update() callback of drm_plane_helper_funcs.
> 
> And the documentation of atomic_update() states:
> https://01.org/linuxgraphics/gfx-docs/drm/gpu/drm-kms-helpers.html#c.drm_plane_helper_funcs
> 
> "Note that the power state of the display pipe when this function is
> called depends upon the exact helpers and calling sequence the driver
> has picked. See drm_atomic_helper_commit_planes() for a discussion of
> the tradeoffs and variants of plane commit helpers."
> 
> The documentation of drm_atomic_helper_commit_planes() then has more
> information:
> https://01.org/linuxgraphics/gfx-docs/drm/gpu/drm-kms-helpers.html#c.drm_atomic_helper_commit_planes
> 
> Bottom line, we should be using drm_atomic_helper_commit_tail_rpm() for
> runtime pm...
> 
> So adding something like:
> 
> static const struct drm_mode_config_helper_funcs
> mxsfb_drm_mode_config_helpers = {
> 	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
> };
> 
> And add something like this in mxsfb_load:
> 
> 	drm->mode_config.funcs		= &mxsfb_mode_config_funcs;
> +	dev->mode_config.helper_private = &mxsfb_drm_mode_config_helpers;
> ...
> 
> Should make the stack not calling update while the pipe is disabled.
> 
> With that you do not have to keep state locally and can always apply the
> new state in ->enable().

Yes, thank you for the explanation. That is exactly what I would have
expected.

regards
Philipp
