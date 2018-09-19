Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E45ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCE320877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="gWt1Q5j0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCE320877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbeISMkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:40:10 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49812 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeISMkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:40:09 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D91125C18DF;
        Wed, 19 Sep 2018 09:03:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537340614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M84BgxLmlNlstm0cBVZT9aWH4abxlgWDyNqNDDUxJj4=;
        b=gWt1Q5j0AL2dT4BPxapysLilhU7j5O/1LigR+uZIKq4ZSC06bH5znCvOxblDuxOULBjE3W
        OC37Fxr13WOCqLpxiORwhL7NNCeVNrpFElhg7CuaYrVPEoMIWbznnseOg7KSw0HjxaoOVP
        QlRL6rn0QkC/Lu8XbcnCqQiMjSbNRvw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Sep 2018 00:03:34 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
In-Reply-To: <2015108.bT6A7b8iLH@avalon>
References: <20180905052113.21262-1-stefan@agner.ch>
 <CACRpkdbw0VjkHYcUpox+DorRG0oRdPARL4ShgPfV2eFaUF_w0g@mail.gmail.com>
 <b1cb586397a4cd444c33dd83d72fa544@agner.ch> <2015108.bT6A7b8iLH@avalon>
Message-ID: <02a69024caf987cf579318241862a5ba@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.09.2018 02:49, Laurent Pinchart wrote:
> Hi Stefan,
> 
> On Thursday, 6 September 2018 23:25:56 EEST Stefan Agner wrote:
>> On 06.09.2018 04:07, Linus Walleij wrote:
>> > On Wed, Sep 5, 2018 at 8:32 PM Stefan Agner <stefan@agner.ch> wrote:
>> >> On 05.09.2018 00:44, Laurent Pinchart wrote:
>> >>
>> >> Good point! I actually really don't like that we use the same flags here
>> >> but from a different perspective. Especially since the flags defines
>> >> document things differently:
>> >>
>> >> /* drive data on pos. edge */
>> >> #define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)
>> >> /* drive data on neg. edge */
>> >> #define DRM_BUS_FLAG_PIXDATA_NEGEDGE    (1<<3)
>> >
>> > Maybe a stupid comment from my side, but can't we just change the
>> > documentation to match the usecases?
>> >
>> > /* Trigger pixel data latch on positive edge */
>> > #define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)
>> >
>> >> Using the opposite perspective would also need translation in crtc
>> >> drivers... So far no driver uses sampling_edge.
>> >>
>> >> I would prefer if we always use the meaning as documented by the flags.
>> >>
>> >> I guess we would need to convert DRM_BUS_FLAG_PIXDATA_POSEDGE ->
>> >> DRM_BUS_FLAG_PIXDATA_NEGEDGE.
>> >>
>> >> Linus Walleij, you added sampling edge, any thoughts?
>> >
>> > I just thought it was generally useful to have triggering edge encoded
>> > into the bridge as it makes it clear that this edge is something
>> > that is a delayed version of the driving edge which is subject to
>> > clock skew caused by the speed of electrons in silicon and
>> > copper and slew rate caused by parasitic capacitance.
>>
>> Ok, I read a bit up on the history of bridge timing, especially:
>> https://www.spinics.net/lists/dri-devel/msg155618.html
>>
>> IMHO, this got overengineered. For displays we do not need all that
>> setup/sample delay timing information, and much longer cables are in
>> use. So why is all that needed for bridges?
>>
>> For Linus case, the THS8134(A/B) data sheet I found (revised March 2010)
>> clearly states:
>> Clock input. A rising edge on CLK latches RPr0-7, GY0-7, BPb0-7.
>>
>> So we need to drive on negative edge, hence DRM_BUS_FLAG_PIXDATA_NEGEDGE
>> should be used, which makes the pl111 driver setting TIM2_IPC:
>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0121d/index.h
>> tml
>>
>> > DRM_BUS_FLAG_PIXDATA_POSEDGE is the right value for my use cases, but it
>> > doesn't match how the ADV7123 operates. Using DRM_BUS_FLAG_PIXDATA_NEGEDGE
>> > would match the hardware, but would break display for some modes,
>> > depending on the display clock frequency as the internal 8.5ns output
>> > delay applied to a falling clock edge would fall right into the 1.7ns
>> > setup + hold time window of the ADV7123 around the rising edge. I can't
>> > test this right now as I don't have local access to boards using the
>> > ADV7123, but from a quick calculation that ignores the PCB transmission
>> > delay modes with frequencies between 57MHz and 71MHz could break if the
>> > data was output on the falling edge of the clock.
>>
>> If clocks vs. data signal are really that much off on R-Car DU, then
>> parallel displays must have the very same issue...
>>
>> Are you sure that only the clock signal has an output delay? And that
>> this output delay is a fixed value, clock independent?
>>
>> Typically, delays apply to all signals equally, and often are clock
>> frequency dependent...
>>
>> Without really looking at the signals, I would not jump to conclusions
>> here! I am pretty sure that driving on negative edge works just as well.
> 
> I've tested Linus' original patch and it broke display on R-Car, so, no, it 
> doesn't work :-)
> 

How can that be, R-Car does not use struct bridge timings or DRM_BUS_FLAG_PIXDATA_*EDGE bus_flags?

Which version exactly did you test? (in v4 you claimed that you did not have access to hardware at that point..)

> The R-Car display engine delays the clock internally (in some cases that delay 
> is even configurable, and that's not uncommon in display controllers). We 
> really need all this information, and I believe we need it for panels too, not 
> just for bridges. The fact that we managed to get away without adding it to 
> panels is likely due to the large number of panels out there, which makes it 
> less likely that the same panel gets used by different systems in mainline 
> with different clock delays. I expect that some panel drivers report the wrong 
> clock edge to make things work on the board they were tested with, and I 
> expect we'll eventually need to add the same information for panels too.

I used a bunch of parallel displays which are upstream (EDT, KEO, TPK) all of them on several different SoCs with mainline drivers, namely mxsfb, drm-mxsfb, FSL DCU, Tegra (RGB). I had several cases where data have been driven on the wrong edge, hooking up oscilloscope
and fix the driver helped in all cases...

As long as there is no case at hand I am not convinced that this is the case.

> 
> So please don't remove this useful API, otherwise you'll break my board, and I 
> won't be happy.

How does it break your board? Again, R-Car does not use struct bridge timings or DRM_BUS_FLAG_PIXDATA_*EDGE bus_flags.

>> For Linus case, the THS8134(A/B) data sheet I found (revised March 2010)
>> clearly states:
>> Clock input. A rising edge on CLK latches RPr0-7, GY0-7, BPb0-7.
>>
>> So we need to drive on negative edge, hence DRM_BUS_FLAG_PIXDATA_NEGEDGE
>> should be used, which makes the pl111 driver setting TIM2_IPC:
>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0121d/index.html

Linus confirmed me in person that simply driving on the correct edge works for him.

Btw the code which is currently in used in pl111 is just a heuristic:

		if (btimings && btimings->setup_time_ps >= 3000)
			tim2 ^= TIM2_IPC;

The code will not invert the pixel clock for THS8135 (since setup time is 2000).

But the THS8135 clearly samples on positive edge!

The above code also does not take the clock into account.

This is much more likely to work for other bridges too:

		if (btimings && btimings->input_bus_flags &
		    DRM_BUS_FLAG_PIXDATA_NEGEDGE)
			tim2 |= TIM2_IPC;


--
Stefan
