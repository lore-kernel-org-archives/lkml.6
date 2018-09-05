Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DC1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8D8206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="lGq6bH20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8D8206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeIEXDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:03:44 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:35786 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeIEXDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:03:44 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 81CC65C00FA;
        Wed,  5 Sep 2018 20:32:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536172338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uPwjubr9ytHNj/+1LZwCAhDGtbsJve5ZzNSW7jgrXGc=;
        b=lGq6bH20bcXdyt4GAGJg6iNEcsPnoXk1SY2l1rUgZhlMf3+1oimwXFDbHitGgx4ThCgDAw
        pAOT+Me/P55/4ju1/YrN75kS5xNLhM6IyhF3+hqq9j+y2sekGVsvO4zM/P4Ty6nHNsj20Y
        5D734VmfIiVtQm5VEUj95ESTb62w7bk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Sep 2018 11:32:18 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linus.walleij@linaro.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        p.zabel@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, architt@codeaurora.org,
        a.hajda@samsung.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] drm/bridge: use bus flags in bridge timings
In-Reply-To: <1569297.pdEFdpi3HS@avalon>
References: <20180905052113.21262-1-stefan@agner.ch>
 <4035252.QuWadVx7pr@avalon> <1569297.pdEFdpi3HS@avalon>
Message-ID: <a00c1650b69ba85bed7ae39b81a0c40f@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.2018 00:44, Laurent Pinchart wrote:
> Hi Stefan,
> 
> On Wednesday, 5 September 2018 10:06:28 EEST Laurent Pinchart wrote:
>> On Wednesday, 5 September 2018 08:21:08 EEST Stefan Agner wrote:
>> > The DRM bus flags convey additional information on pixel data on
>> > the bus. All current available bus flags might be of interest for
>> > a bridge. Remove the sampling_edge field and use bus_flags.
>> >
>> > In the case at hand a dumb VGA bridge needs a specific data enable
>> > polarity (DRM_BUS_FLAG_DE_LOW).
>> >
>> > Signed-off-by: Stefan Agner <stefan@agner.ch>
>> > ---
>> >
>> >  drivers/gpu/drm/bridge/dumb-vga-dac.c |  6 +++---
>> >  include/drm/drm_bridge.h              | 11 +++++------
>> >  2 files changed, 8 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c
>> > b/drivers/gpu/drm/bridge/dumb-vga-dac.c index 9b706789a341..7a5c24967115
>> > 100644
>> > --- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
>> > +++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
>> > @@ -234,7 +234,7 @@ static int dumb_vga_remove(struct platform_device
>> > *pdev) */
>> >
>> >  static const struct drm_bridge_timings default_dac_timings = {
>> >
>> >  	/* Timing specifications, datasheet page 7 */
>> >
>> > -	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
>> > +	.bus_flags = DRM_BUS_FLAG_PIXDATA_POSEDGE,
>> >
>> >  	.setup_time_ps = 500,
>> >  	.hold_time_ps = 1500,
>> >
>> >  };
>> >
>> > @@ -245,7 +245,7 @@ static const struct drm_bridge_timings
>> > default_dac_timings = { */
>> >
>> >  static const struct drm_bridge_timings ti_ths8134_dac_timings = {
>> >
>> >  	/* From timing diagram, datasheet page 9 */
>> >
>> > -	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
>> > +	.bus_flags = DRM_BUS_FLAG_PIXDATA_POSEDGE,
>> >
>> >  	/* From datasheet, page 12 */
>> >  	.setup_time_ps = 3000,
>> >  	/* I guess this means latched input */
>> >
>> > @@ -258,7 +258,7 @@ static const struct drm_bridge_timings
>> > ti_ths8134_dac_timings = { */
>> >
>> >  static const struct drm_bridge_timings ti_ths8135_dac_timings = {
>> >
>> >  	/* From timing diagram, datasheet page 14 */
>> >
>> > -	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
>> > +	.bus_flags = DRM_BUS_FLAG_PIXDATA_POSEDGE,
>> >
>> >  	/* From datasheet, page 16 */
>> >  	.setup_time_ps = 2000,
>> >  	.hold_time_ps = 500,
>> >
>> > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>> > index bd850747ce54..85d4b51eae19 100644
>> > --- a/include/drm/drm_bridge.h
>> > +++ b/include/drm/drm_bridge.h
>> > @@ -244,14 +244,13 @@ struct drm_bridge_funcs {
>> >
>> >   */
>> >
>> >  struct drm_bridge_timings {
>> >
>> >  	/**
>> >
>> > -	 * @sampling_edge:
>> >
>> > +	 * @bus_flags:
>> >  	 *
>> >
>> > -	 * Tells whether the bridge samples the digital input signal
>> > -	 * from the display engine on the positive or negative edge of the
>> > -	 * clock, this should reuse the DRM_BUS_FLAG_PIXDATA_[POS|NEG]EDGE
>> > -	 * bitwise flags from the DRM connector (bit 2 and 3 valid).
>> > +	 * Tells what additional settings for the pixel data on the bus
>> > +	 * this bridge requires (like pixel signal polarity). See also
>> > +	 * &drm_display_info->bus_flags.
>> >
>> >  	 */
>> >
>> > -	u32 sampling_edge;
>> > +	u32 bus_flags;
>>
>> While I'm not opposed to extending the bridge structure to allow specifying
>> other flags, I think we're losing information here. The sampling_edge field
>> makes it clear that the DRM_BUS_FLAG_PIXDATA_(NEG|POS)EDGE flags specified
>> on which clock edge signals are sampled. bus_flags could be interpreted
>> differently, for instance as specifying on which clock edge signals are
>> output on the other side of the bridge.

Good point! I actually really don't like that we use the same flags here
but from a different perspective. Especially since the flags defines
document things differently:

/* drive data on pos. edge */
#define DRM_BUS_FLAG_PIXDATA_POSEDGE	(1<<2)
/* drive data on neg. edge */
#define DRM_BUS_FLAG_PIXDATA_NEGEDGE	(1<<3)

Using the opposite perspective would also need translation in crtc
drivers... So far no driver uses sampling_edge.

I would prefer if we always use the meaning as documented by the flags.

I guess we would need to convert DRM_BUS_FLAG_PIXDATA_POSEDGE ->
DRM_BUS_FLAG_PIXDATA_NEGEDGE.

Linus Walleij, you added sampling edge, any thoughts?


>>
>> We could easily fix this by specifying that the bus_flags field refers to
>> the input side of the bridge. We could also rename the field to
>> input_bus_flags. The rename could be delayed until needed, but that would
>> result in yet another change to all bridge drivers, so we may want to do it
>> now as your patch touches all the drivers already. Other options might also
>> be possible.

Naming the field input_bus_flags seems very sensible. How about:

struct drm_bridge_timings {
	/**
	 * @input_bus_flags:
	 *
	 * Specifies the settings for the pixel data on the input
	 * bus of this bridge (like pixel signal polarity). Note the
	 * flags are typically controller centric! See also
	 * &drm_display_info->bus_flags.
	 */
	u32 input_bus_flags;

> 
> And I should of course make sure to wake up before reviewing patches. 
> Obviously only one driver is currently affected by the rename. More will use 
> the flags later though, so the argument could still hold.

It is only one bridge driver making use of bridge timings. As far as I
can see currently no driver actually makes use of the bridge timings
sampling_edge currently...

But yes, agreed, we should make a sensible choice now to avoid churn
down the line.

--
Stefan

> 
>> >  	/**
>> >
>> >  	 * @setup_time_ps:
>> >  	 *
