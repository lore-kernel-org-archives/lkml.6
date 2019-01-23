Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BA0C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07B7218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="n630SCvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfAWWRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:17:39 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:51778 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfAWWRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:17:39 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 60D9423D;
        Wed, 23 Jan 2019 23:17:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1548281856;
        bh=GBiSJXMwkVdxvoTgXAhpme26VHbAsFe19uZJ27BgiDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n630SCvAimK3V9LFVdy6C6/9o4hNCPfhGUhCMi9NSKZEFfmvoFIbC3VOAaN6/kW42
         L/msBj4lTtsXzo9jum/gltvyzqjBJmKRUSaetMpJxi/+z3tQEzLv9cAe7DfeiGWb7N
         NrzocTnkcVhw+dCrFnDT5yP1OSFzONwtokvmRUlw=
Date:   Thu, 24 Jan 2019 00:17:35 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Ronald =?utf-8?B?VHNjaGFsw6Ry?= <ronald@innovation.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: sil_sii8620: depend on INPUT instead of
 selecting it.
Message-ID: <20190123221735.GE4675@pendragon.ideasonboard.com>
References: <20190122141311.10445-1-ronald@innovation.ch>
 <20190123084556.gsospl6joh53qnzs@wunner.de>
 <20190123220342.GC179701@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190123220342.GC179701@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmity,

On Wed, Jan 23, 2019 at 02:03:42PM -0800, Dmitry Torokhov wrote:
> On Wed, Jan 23, 2019 at 09:45:56AM +0100, Lukas Wunner wrote:
> > On Tue, Jan 22, 2019 at 06:13:11AM -0800, Ronald Tschalär wrote:
> >> commit d6abe6df706c66d803e6dd4fe98c1b6b7f125a56 (drm/bridge:
> >> sil_sii8620: do not have a dependency of RC_CORE) added a dependency on
> >> INPUT. However, this causes problems with other drivers, in particular
> >> an input driver that depends on MFD_INTEL_LPSS_PCI (to be added in a
> >> future commit):
> >> 
> >>   drivers/clk/Kconfig:9:error: recursive dependency detected!
> >>   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
> >>   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
> >>   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
> >>   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
> >>   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
> >>   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
> >>   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
> >>   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
> >> 
> >> According to the docs, select should only be used for non-visible
> >> symbols. Furthermore almost all other references to INPUT throughout the
> >> kernel config are depends, not selects. Hence this change.
> 
> I think this is not as cut and dry. We should be able to select needed
> subsystems (such as INPUT, USB, etc) even if they are user visible.

Semantically, maybe, but given the current state of Kconfig this results
in a recursive dependencies nightmare. It's a no-go.

> User, when enabling a piece of hardware, does not need to know ultimate
> details of all subsystems the driver might need ti function.
> 
> It looks like one of the drivers implies MFD_INTEL_LPSS_PCI, maybe
> treating imply the same as select when detecting circular dependency is
> wrong as we are allowed to deselect implied dependencies?
> 
> >> 
> >> CC: Inki Dae <inki.dae@samsung.com>
> >> CC: Andrzej Hajda <a.hajda@samsung.com>
> >> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> > 
> > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > 
> > I think this needs to be merged through the input tree as a prerequisite
> > for the applespi.c driver (keyboard + touchpad driver for 2015+ MacBook,
> > MacBook Air and MacBook Pro which uses SPI instead of USB) to avoid
> > breaking the build.  Adding Dmitry.
> 
> I have no idea what applespi.c is (it is definitely not in my tree), so
> I think it should be merged through the same tree that the original
> commit was introduced through.
> 
> >> ---
> >>  drivers/gpu/drm/bridge/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> >> index 2fee47b0d50b..eabedc83f25c 100644
> >> --- a/drivers/gpu/drm/bridge/Kconfig
> >> +++ b/drivers/gpu/drm/bridge/Kconfig
> >> @@ -83,9 +83,9 @@ config DRM_PARADE_PS8622
> >>  config DRM_SIL_SII8620
> >>  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
> >>  	depends on OF
> >> +	depends on INPUT
> >>  	select DRM_KMS_HELPER
> >>  	imply EXTCON
> >> -	select INPUT
> >>  	select RC_CORE
> 
> Keeping "select RC_CORE" is wrong though, as the driver appears to be
> working find without RC. Maybe it should be stubbed out?

It should definitely not be select'ed as it's a user-visible symbol. My
preference would be to simply revert d6abe6df706c. If we want (and can)
work without RC core then it should be stubbed out.

Commit d6abe6df706c states

    And some boards not using remote controller device don't really
    need to know that RC_CORE config should be enabled to use sil_sii8620
    driver only for HDMI.

The same reasoning applies to INPUT, if we agree that depending on
RC_CORE is confusing for users, then depending on INPUT is confusing as
well. There's not reason to apply different standards to INPUT and
RC_CORE, depending on one and selecting the other doesn't make much
sense.

-- 
Regards,

Laurent Pinchart
