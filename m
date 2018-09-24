Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF437ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FE221486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FE221486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbeIXSaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:30:23 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52634 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730233AbeIXSaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:30:21 -0400
Received: from wd0156.dip.tu-dresden.de ([141.76.108.156] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1g4PyC-00019j-Kg; Mon, 24 Sep 2018 14:28:08 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Damian Kos <dkos@cadence.com>, Artur Jedrysek <jartur@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Piotr Sroka <piotrs@cadence.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v4 5/5] drm: bridge: add support for Cadence MHDP DPI/DP bridge
Date:   Mon, 24 Sep 2018 14:28:07 +0200
Message-ID: <6154358.J9crsCiUTz@phil>
In-Reply-To: <CO2PR07MB2551EC0A7DEB61C54A4D6A5FCD170@CO2PR07MB2551.namprd07.prod.outlook.com>
References: <1537455288-20223-1-git-send-email-dkos@cadence.com> <1903708.pJTgKoWLiI@phil> <CO2PR07MB2551EC0A7DEB61C54A4D6A5FCD170@CO2PR07MB2551.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damian,

Am Montag, 24. September 2018, 13:40:03 CEST schrieb Damian Kos:
> > Am Donnerstag, 20. September 2018, 16:54:40 CEST schrieb Damian Kos:
> > > From: Quentin Schulz <quentin.schulz@free-electrons.com>
> > > 
> > > This adds basic support for Cadence MHDP DPI to DP bridge.
> > > 
> > > Basically, it takes a DPI stream as input and output it encoded in DP 
> > > format. It's missing proper HPD, HDCP and currently supports only SST 
> > > mode.
> > > 
> > > Changes made in the low level driver (cdn-dp-reg.*):
> > > - moved it to from drivers/gpu/drm/rockchip to
> > >   drivers/gpu/drm/bridge/cdns-mhdp-common.*
> > > - functions for sending/receiving commands are now public
> > > - added functions for reading registers and link training
> > >   adjustment
> > > 
> > > Changes made in RK's driver (cdn-dp-core.*):
> > > - Moved audio_info and audio_pdev fields from cdn_dp_device to
> > >   cdns_mhdp_device structure.
> > > 
> > > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > > Signed-off-by: Damian Kos <dkos@cadence.com>
> > 
> > [...]
> > 
> > > diff --git a/drivers/gpu/drm/rockchip/Kconfig 
> > > b/drivers/gpu/drm/rockchip/Kconfig
> > > index 0ccc76217ee4..129b0529f3e1 100644
> > > --- a/drivers/gpu/drm/rockchip/Kconfig
> > > +++ b/drivers/gpu/drm/rockchip/Kconfig
> > > @@ -27,7 +27,9 @@ config ROCKCHIP_ANALOGIX_DP
> > >  
> > >  config ROCKCHIP_CDN_DP
> > >          bool "Rockchip cdn DP"
> > > -	depends on EXTCON=y || (EXTCON=m && DRM_ROCKCHIP=m)
> > > +	depends on DRM_ROCKCHIP=m
> > 
> > Sorry, I wasn't fast enough in my reply to you mail to catch that before your v4, but I don't think this is necessary.
> > Instead I do guess, the select below should do the right thing by making EXTCON=y if DRM_ROCKCHIP=y.
> > 
> > Somewhat clumsily verified by making EXTCON=m in my defconfig and seeing get changed to y upon build, which I guess comes from a different "select" in the config.
> > 
> 
> I've changed it to:
> 
> config ROCKCHIP_CDN_DP
>         bool "Rockchip cdn DP"
>         depends on DRM_ROCKCHIP
>         select EXTCON if DRM_ROCKCHIP=y
>         select DRM_CDNS_MHDP
>         help...
> 
> and it seems that there are no issues. At least for me.
> 
> Please let me know if that's OK.

nope, just do "select EXTCON" . It works nicely and the above would
not select EXTCON at all if the the rockchip-drm driver gets built into
the kernel.

To be sure I just did a little experiment and added:

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 4ad85c046dcd..64e2b096afd8 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -154,4 +154,11 @@ source "drivers/gpu/drm/bridge/ite/Kconfig"
 
 source "drivers/gpu/drm/bridge/synopsys/Kconfig"
 
+config DRM_TMP1
+       tristate "option to select"
+
+config DRM_TMP2
+       tristate "option doing the selecting"
+       select DRM_TMP1
+

If I select DRM_TMP2=m as module I end up with
CONFIG_DRM_TMP1=m
CONFIG_DRM_TMP2=m
in the defconfig and wit DRM_TMP2=y it changes to
CONFIG_DRM_TMP1=y
CONFIG_DRM_TMP2=y

so all is well with just doing "select EXTCON" above and will
select the correct "m" or "y" stance as needed.


Heiko


