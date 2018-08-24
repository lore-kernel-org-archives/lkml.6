Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FDEC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3A92157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3A92157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeHXLUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:20:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42877 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbeHXLUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:20:39 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D9FFC20732; Fri, 24 Aug 2018 09:47:12 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 714BA206DE;
        Fri, 24 Aug 2018 09:47:02 +0200 (CEST)
Date:   Fri, 24 Aug 2018 09:47:01 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, jmondi <jacopo@jmondi.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 3/4] drm/atmel-hlcdc: iterate over all output
 endpoints
Message-ID: <20180824094701.1f17393f@bbrezillon>
In-Reply-To: <56016787-0487-1571-7c28-2767033cda23@axentia.se>
References: <20180810130359.9882-1-peda@axentia.se>
        <20180810130359.9882-4-peda@axentia.se>
        <20180813135949.32vrlrevtazr5x7d@apu3b.nibble.pw>
        <0baac94e-f3d2-53fd-4af9-854bb4498345@axentia.se>
        <CAL_JsqJPzwpN2TFghy-FfHZppexG9gW4qBy6iYtGpyP_Bp6dUA@mail.gmail.com>
        <5c9853fc-e2ea-6983-ac88-b52b6e9e6ecd@axentia.se>
        <CAL_JsqJHRL0f2YwvOJBpggKRVQwPWy8j08-+_nd-VifOOKYqFA@mail.gmail.com>
        <56016787-0487-1571-7c28-2767033cda23@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 17:05:29 +0200
Peter Rosin <peda@axentia.se> wrote:

> >>>>>> @@ -77,13 +79,29 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
> >>>>>>
> >>>>>>  int atmel_hlcdc_create_outputs(struct drm_device *dev)
> >>>>>>  {
> >>>>>> -    int endpoint, ret = 0;
> >>>>>> -
> >>>>>> -    for (endpoint = 0; !ret; endpoint++)
> >>>>>> -            ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
> >>>>>> +    struct of_endpoint endpoint;
> >>>>>> +    struct device_node *node = NULL;
> >>>>>> +    int count = 0;
> >>>>>> +    int ret = 0;
> >>>>>> +
> >>>>>> +    for_each_endpoint_of_node(dev->dev->of_node, node) {
> >>>>>> +            of_graph_parse_endpoint(node, &endpoint);  
> >>>
> >>> I'd really like to kill off of_graph_parse_endpoint, not add more
> >>> users (check the git history on this code). You should know what are
> >>> possible port and endpoint numbers, so iterate over those.  
> >>
> >> So, add a comment to that effect in the docs of the of_graph_parse_endpoint
> >> function.
> >>
> >> How can the hlcdc driver know the actual number of endpoints? It's a
> >> one-way signal path out from that port, and it can easily be routed to
> >> 1, 2, 3 or even more places. As shown above, forcing the endpoint id
> >> to start at zero is a nuisance, and I don't see the point of it.
> >>
> >> But I welcome suggestions on how to arrange the above dtsi/dts fragments
> >> in a world where the endpoint id absolutely has to start at zero.  
> > 
> > Your dts file arrangement seems fine. Can't you just not exit the loop
> > on -ENODEV? IOW, just iterate til you find an enabled endpoint.  
> 
> That would regress cases where two (or more) endpoints are enabled
> (which is currently supported). As I see it, the driver will have a
> very hard time knowing when to stop iterating with any solution not
> involving the equivalent of the functions for_each_endpoint_of_node
> and of_graph_parse_endpoint. Open-coding of_graph_parse_endpoint just
> to avoid it is a bit more than silly IMHO...

I agree, and actually, I think this is Rob who suggested to do what we
do here :-) (iterate from 0 to X, and stop as soon as
-ENODEV is returned).
