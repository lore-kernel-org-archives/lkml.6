Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE16C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775E62084C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775E62084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932651AbeGII6T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:58:19 -0400
Received: from mailoutvs61.siol.net ([185.57.226.252]:59135 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932495AbeGII6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:58:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 4CA57520D3F;
        Mon,  9 Jul 2018 10:58:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id D1Ss9_zkSH7h; Mon,  9 Jul 2018 10:58:11 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id B17AD520DCC;
        Mon,  9 Jul 2018 10:58:11 +0200 (CEST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id 6BAEB520DF7;
        Mon,  9 Jul 2018 10:58:08 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jonathan Liu <net147@gmail.com>,
        Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: fix build failure with CONFIG_DRM_SUN8I_MIXER=m
Date:   Mon, 09 Jul 2018 10:58:07 +0200
Message-ID: <1768773.IAdV5VvfSI@jernej-laptop>
In-Reply-To: <20180709080724.3ekqb45fsjubvhcm@flea>
References: <20180706124628.3192421-1-arnd@arndb.de> <20180709080724.3ekqb45fsjubvhcm@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 09. julij 2018 ob 10:07:24 CEST je Maxime Ripard napisal(a):
> On Fri, Jul 06, 2018 at 02:45:53PM +0200, Arnd Bergmann wrote:
> > Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results
> > in a link error, as we try to access a symbol from the sun8i_tcon_top.ko
> > module:
> > 
> > ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko]
> > undefined! ERROR: "sun8i_tcon_top_of_table"
> > [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!
> > 
> > This solves the problem by making DRM_SUN8I_MIXER a 'bool' symbol,
> > building
> > the sun8i_tcon_top module the same way as the core sun4i-drm module
> > whenever DRM_SUN8I_MIXER is enabled, or not building it at all otherwise.
> > 
> > Alternatively, we could always build sun8i_tcon_top.ko along with
> > sun4-drm.ko and detach it from the mixer module, I could not tell which
> > way is more appropriate here.
> 
> If that's easily doable, then yeah, that would be the preferred option
> I guess. Jernej? Chen-Yu? Any opinion on this?

I guess that only means building sun8i_tcon_top.o with DRM_SUN4I instead of  
DRM_SUN8I_MIXER.

While this would be simple solution, sun8i_tcon_top would be dead weight if 
DRM_SUN8I_MIXER is disabled. But it is really small module, so I don't see any 
harm.

Additionally, with my follow up R40 HDMI series, there is even more calls from 
DRM_SUN4I enabled drivers to sun8i_tcon_top driver.

So I'm also for sun8i_tcon_top.o being build with DRM_SUN4I, because it is 
simpler, cleaner and it's symbols (including those introduced in R40 HDMI 
follow up series) are used mostly by DRM_SUN4I drivers (only exception being 
sun8i_dw_hdmi).

Best regards,
Jernej




