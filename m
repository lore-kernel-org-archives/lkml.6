Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755810AbeDYSGx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:06:53 -0400
Received: from mailoutvs4.siol.net ([213.250.19.137]:43730 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750814AbeDYSGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:06:52 -0400
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [RFC 00/13] arm64: allwinner: Add A64 DE2 pipeline support
Date: Wed, 25 Apr 2018 20:06:35 +0200
Message-ID: <5215730.1Lvo56aXNX@jernej-laptop>
In-Reply-To: <20180425135548.ayeqo7t2dtbwq3of@flea>
References: <20180424133425.24291-1-jagan@amarulasolutions.com> <CAMty3ZCLOkdmCoh4uBhYKXgDEiAnw+b_z=d0Om2bjH7HLCa7Tg@mail.gmail.com> <20180425135548.ayeqo7t2dtbwq3of@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dne sreda, 25. april 2018 ob 15:55:48 CEST je Maxime Ripard napisal(a):
> On Wed, Apr 25, 2018 at 06:29:05PM +0530, Jagan Teki wrote:
> > On Tue, Apr 24, 2018 at 7:38 PM, Maxime Ripard
> > 
> > <maxime.ripard@bootlin.com> wrote:
> > > On Tue, Apr 24, 2018 at 07:04:12PM +0530, Jagan Teki wrote:
> > >> Allwinner A64 has display engine pipeline like other Allwinner SOC's
> > >> A83T/H3/H5.
> > >> 
> > >> A64 DE2 behaviour similar to Allwinner A83T where mixer0, connected to
> > >> tcon0 with RGB, LVDS MIPI-DSI and mixer1, connected to tcon1 with
> > >> HDMI.
> > >> This series merely concentrated on HDMI pipeline and rest will add
> > >> eventually.
> > >> 
> > >> patch 1: dt-bindings for a64 DE2 CCU
> > >> 
> > >> patch 2: a64 DE2 CCU node addition
> > >> 
> > >> patch 3: dt-bindings for a64 DE2 pipeline
> > >> 
> > >> patch 4 - 5: dt-bindings for a64 mixer0 and tcon-lcd
> > >> 
> > >> patch 6: a64 DE2 pipeline node addition
> > >> 
> > >> patch 7 - 8: dt-bindings for a64 HDMI and HDMI PHY
> > >> 
> > >> patch 9: a64 HDMI nodes addition
> > >> 
> > >> patch 10 - 11: dt-bindings for a64 mixer1 and tcon-tv
> > >> 
> > >> patch 12: a64 HDMI pipeline
> > >> 
> > >> patch 13: enable HDMI out on bananpi-m64
> > >> 
> > >> Tested HDMI on bananapi-m64 (along with DE2 SRAM C changes from [1]
> > >> thread), able to detect the HDMI but, no penguins on screen.
> > >> 
> > >> Request for any suggestions.
> > >> 
> > >> Test log on Bananpi-m64:
> > >> [    0.247631] sun4i-drm display-engine: bound 1100000.mixer (ops
> > >> sun8i_mixer_ops) [    0.256717] sun4i-drm display-engine: bound
> > >> 1200000.mixer (ops sun8i_mixer_ops) [    0.256783] sun4i-tcon
> > >> 1c0c000.lcd-controller: Missing LVDS properties, Please upgrade your
> > >> DT [    0.256792] sun4i-tcon 1c0c000.lcd-controller: LVDS output
> > >> disabled> > 
> > > That doesn't seem to work so well for LVDS.
> > > 
> > >> [    0.257081] sun4i-drm display-engine: No panel or bridge found...
> > >> RGB output disabled [    0.257099] sun4i-drm display-engine: bound
> > >> 1c0c000.lcd-controller (ops sun4i_tcon_ops) [    0.257273] sun4i-drm
> > >> display-engine: No panel or bridge found... RGB output disabled [   
> > >> 0.257288] sun4i-drm display-engine: bound 1c0d000.lcd-controller (ops
> > >> sun4i_tcon_ops) [    0.258176] sun8i-dw-hdmi 1ee0000.hdmi: Detected
> > >> HDMI TX controller v1.32a with HDCP (sun8i_dw_hdmi_p) [    0.258596]
> > >> sun8i-dw-hdmi 1ee0000.hdmi: registered DesignWare HDMI I2C bus driver
> > >> [    0.259188] sun4i-drm display-engine: bound 1ee0000.hdmi (ops
> > >> sun8i_dw_hdmi_ops) [    0.259199] [drm] Supports vblank timestamp
> > >> caching Rev 2 (21.10.2013). [    0.259205] [drm] No driver support for
> > >> vblank timestamp query. [    0.259308] [drm] Cannot find any crtc or
> > >> sizes
> > > 
> > > A good guess would be that you can't get the EDIDs for some
> > > reason. Have you tried forcing a mode to see if the display part
> > > already works?
> > 
> > Yes I've forced and used custom EDID with 1024x786 bin and observed
> > that the bin is able to load.
> > 
> > [    0.262973] [drm] No driver support for vblank timestamp query.
> > [    0.263842] [drm] Got built-in EDID base block and 0 extensions
> > from "edid/1024x768.bin" for connector
> 
> It's not really clear, is it displaying something?
> 

This smells like HDMI voltage regulator not being enabled. You have to include 
patch like this: 
https://github.com/Icenowy/linux/commit/
27d12cd2fe89f64c5f4d5224984d4cbfcb7ee137

I guess it won't apply as-is, since it's based on my old, out-of-tree hdmi 
driver.

Best regards,
Jernej
