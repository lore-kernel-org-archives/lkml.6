Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BD4FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B7220853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ipAnRTmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B7220853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeINPLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:11:19 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33082 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeINPLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:11:19 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:44f6:3500:d929:375b:d608:66c7])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 302D0CE;
        Fri, 14 Sep 2018 11:57:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536919051;
        bh=GE9SI6+56XDaRMPGUGwASxINiCDmuL1FVpWvUwqbgJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ipAnRTmKXYLl0d407TzF8BxI/XjP5j2cGs3soWm33+cbaknNjXLvufggGXTcxWM7W
         B9d7+DN2qW2mOsLNtmuwbF3wul2XfZzwtRuiRJJWj2UvPb5Wfl8ySwKC+gn5N5xBGF
         TDpKS4tcw/TByYKLwoQWzRVNbPjwvZXaGFnSSIPc=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dave Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        sean@poorly.run, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        max.krummenacher@toradex.com,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] drm/bridge: use bus flags in bridge timings
Date:   Fri, 14 Sep 2018 12:57:45 +0300
Message-ID: <4320623.81Q3F1DtM1@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <2015108.bT6A7b8iLH@avalon>
References: <20180905052113.21262-1-stefan@agner.ch> <b1cb586397a4cd444c33dd83d72fa544@agner.ch> <2015108.bT6A7b8iLH@avalon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 14 September 2018 12:49:40 EEST Laurent Pinchart wrote:
> Hi Stefan,
> 
> On Thursday, 6 September 2018 23:25:56 EEST Stefan Agner wrote:
> > On 06.09.2018 04:07, Linus Walleij wrote:
> > > On Wed, Sep 5, 2018 at 8:32 PM Stefan Agner <stefan@agner.ch> wrote:
> > >> On 05.09.2018 00:44, Laurent Pinchart wrote:
> > >> 
> > >> Good point! I actually really don't like that we use the same flags
> > >> here
> > >> but from a different perspective. Especially since the flags defines
> > >> document things differently:
> > >> 
> > >> /* drive data on pos. edge */
> > >> #define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)
> > >> /* drive data on neg. edge */
> > >> #define DRM_BUS_FLAG_PIXDATA_NEGEDGE    (1<<3)
> > > 
> > > Maybe a stupid comment from my side, but can't we just change the
> > > documentation to match the usecases?
> > > 
> > > /* Trigger pixel data latch on positive edge */
> > > #define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)
> > > 
> > >> Using the opposite perspective would also need translation in crtc
> > >> drivers... So far no driver uses sampling_edge.
> > >> 
> > >> I would prefer if we always use the meaning as documented by the flags.
> > >> 
> > >> I guess we would need to convert DRM_BUS_FLAG_PIXDATA_POSEDGE ->
> > >> DRM_BUS_FLAG_PIXDATA_NEGEDGE.
> > >> 
> > >> Linus Walleij, you added sampling edge, any thoughts?
> > > 
> > > I just thought it was generally useful to have triggering edge encoded
> > > into the bridge as it makes it clear that this edge is something
> > > that is a delayed version of the driving edge which is subject to
> > > clock skew caused by the speed of electrons in silicon and
> > > copper and slew rate caused by parasitic capacitance.
> > 
> > Ok, I read a bit up on the history of bridge timing, especially:
> > https://www.spinics.net/lists/dri-devel/msg155618.html
> > 
> > IMHO, this got overengineered. For displays we do not need all that
> > setup/sample delay timing information, and much longer cables are in
> > use. So why is all that needed for bridges?
> > 
> > For Linus case, the THS8134(A/B) data sheet I found (revised March 2010)
> > clearly states:
> > Clock input. A rising edge on CLK latches RPr0-7, GY0-7, BPb0-7.
> > 
> > So we need to drive on negative edge, hence DRM_BUS_FLAG_PIXDATA_NEGEDGE
> > should be used, which makes the pl111 driver setting TIM2_IPC:
> > http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0121d/index
> > .h tml
> > 
> > > DRM_BUS_FLAG_PIXDATA_POSEDGE is the right value for my use cases, but it
> > > doesn't match how the ADV7123 operates. Using
> > > DRM_BUS_FLAG_PIXDATA_NEGEDGE
> > > would match the hardware, but would break display for some modes,
> > > depending on the display clock frequency as the internal 8.5ns output
> > > delay applied to a falling clock edge would fall right into the 1.7ns
> > > setup + hold time window of the ADV7123 around the rising edge. I can't
> > > test this right now as I don't have local access to boards using the
> > > ADV7123, but from a quick calculation that ignores the PCB transmission
> > > delay modes with frequencies between 57MHz and 71MHz could break if the
> > > data was output on the falling edge of the clock.
> > 
> > If clocks vs. data signal are really that much off on R-Car DU, then
> > parallel displays must have the very same issue...
> > 
> > Are you sure that only the clock signal has an output delay? And that
> > this output delay is a fixed value, clock independent?
> > 
> > Typically, delays apply to all signals equally, and often are clock
> > frequency dependent...
> > 
> > Without really looking at the signals, I would not jump to conclusions
> > here! I am pretty sure that driving on negative edge works just as well.
> 
> I've tested Linus' original patch and it broke display on R-Car, so, no, it
> doesn't work :-)
> 
> The R-Car display engine delays the clock internally (in some cases that
> delay is even configurable, and that's not uncommon in display
> controllers). We really need all this information, and I believe we need it
> for panels too, not just for bridges. The fact that we managed to get away
> without adding it to panels is likely due to the large number of panels out
> there, which makes it less likely that the same panel gets used by
> different systems in mainline with different clock delays. I expect that
> some panel drivers report the wrong clock edge to make things work on the
> board they were tested with, and I expect we'll eventually need to add the
> same information for panels too.
> 
> So please don't remove this useful API, otherwise you'll break my board, and
> I won't be happy.

Or, to be precise, the board won't break now, but as soon as I need to 
implement support for configuring the output clock edge, it will break as the 
ADV7123 driver won't give me the right information to make the right choice.

-- 
Regards,

Laurent Pinchart



