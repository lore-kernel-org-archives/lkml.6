Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD7EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49732083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="VruonReK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49732083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbeIFWEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:04:09 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:47138 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbeIFWEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:04:09 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 8B4075C08AC;
        Thu,  6 Sep 2018 19:27:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536254857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zH15cs26qYQnTN72QlZnTgeN2SRn7AVR2FOdxCYzQgY=;
        b=VruonReK2ofsG31sFlqqOInLafO05tIX4KSblzTPbI/JBWpzUqsbvaEj9vz079wIoHuw8B
        c7Wrk/DsfzlpoKaAVryXf+5M1vHmrv3g63C9icjXPyJeYQ2Hsx5QG/UZk/TGvmYaTKKG3A
        TFYwl1ky8NV1PhVyNJnN9hsE+oUDHgw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Sep 2018 10:27:36 -0700
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
In-Reply-To: <1611934.U20VZ57ca3@avalon>
References: <20180905052113.21262-1-stefan@agner.ch>
 <10044412.4MiZRujKJI@avalon> <d07214d3005fb7229f17dd62d1b5b8ee@agner.ch>
 <1611934.U20VZ57ca3@avalon>
Message-ID: <c1507b33c4b2d8e657cd6cdf54e14136@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.2018 09:54, Laurent Pinchart wrote:
> Hi Stefan,
> 
> On Thursday, 6 September 2018 19:48:51 EEST Stefan Agner wrote:
>> On 06.09.2018 05:25, Laurent Pinchart wrote:
>> > On Thursday, 6 September 2018 14:07:41 EEST Linus Walleij wrote:
>> >> On Wed, Sep 5, 2018 at 8:32 PM Stefan Agner <stefan@agner.ch> wrote:
>> >> > On 05.09.2018 00:44, Laurent Pinchart wrote:
>> >> >
>> >> > Good point! I actually really don't like that we use the same flags
>> >> > here
>> >> > but from a different perspective. Especially since the flags defines
>> >> > document things differently:
>> >> >
>> >> > /* drive data on pos. edge */
>> >> > #define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)
>> >> > /* drive data on neg. edge */
>> >> > #define DRM_BUS_FLAG_PIXDATA_NEGEDGE    (1<<3)
>> >>
>> >> Maybe a stupid comment from my side, but can't we just change the
>> >> documentation to match the usecases?
>> >>
>> >> /* Trigger pixel data latch on positive edge */
>> >> #define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)
>> >
>> > The flags are used for the drm_connector bus_flags field, and really mean
>> > driving on the positive/negative edges. We this can't change their meaning
>> > like this.
>> >
>> >> > Using the opposite perspective would also need translation in crtc
>> >> > drivers... So far no driver uses sampling_edge.
>> >> >
>> >> > I would prefer if we always use the meaning as documented by the flags.
>> >> >
>> >> > I guess we would need to convert DRM_BUS_FLAG_PIXDATA_POSEDGE ->
>> >> > DRM_BUS_FLAG_PIXDATA_NEGEDGE.
>> >> >
>> >> > Linus Walleij, you added sampling edge, any thoughts?
>> >>
>> >> I just thought it was generally useful to have triggering edge encoded
>> >> into the bridge as it makes it clear that this edge is something
>> >> that is a delayed version of the driving edge which is subject to
>> >> clock skew caused by the speed of electrons in silicon and
>> >> copper and slew rate caused by parasitic capacitance.
>> >
>> > I agree that we need both the driving and sampling edge. In many case they
>> > will be opposite, and providing some kind of appropriate defaults in APIs
>> > is fine by me, but we need a way to specify both when needed.
>>
>> We do have pixel clock flags for displays, but also they are actually
>> controller oriented:
>>
>> https://elixir.bootlin.com/linux/latest/source/include/video/display_timing.
>> h#L15
>>
>> I guess having different flags to denote driving and sampling edge
>> independently would be ideal. But then, is there really a use case where
>> it wouldn't be the exact opposite?
> 
> Yes, for instance when the transmission delay for clock and data signals is 
> different, you may want to sample on the same edge used by the transmitter to 
> latch the output. Linus had that case, which prompted him to add the sampling 
> edge field.
> 

Bu in that case the controller does not know what it actually should do
with the sampling information alone either...

Where is that code handling that today? sample_edge has been added, but
I only see setup_time_ps being used in pl111_display.c.

I'm not a hardware guy, but according to my rough calculation a pixel
clock signal at 100MHz would need to be 1.5m off compared to the data
signals to skew by a half period! Length matching is usually only
necessary at really high speed signals. Is that really what is going on
here?

Why not just work around by specifying "the wrong" edge...?

--
Stefan

>> The other bus flags are actually fine as is. I suggest to just stick
>> with the bus flags as we have them now, at least for now.
>>
>> Alternatively, we could provide "consumer/bridge" oriented flags which
>> use the same bit and just are the opposite of the controller oriented
>> flags, e.g.:
>>
>> /* drive data on pos. edge */
>> #define DRM_BUS_FLAG_PIXDATA_POSEDGE	(1<<2)
>> /* drive data on neg. edge */
>> #define DRM_BUS_FLAG_PIXDATA_NEGEDGE	(1<<3)
>> /* sample data on neg. edge */
>> #define DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE	(1<<2)
>> /* sample data on pos. edge */
>> #define DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE	(1<<3)
