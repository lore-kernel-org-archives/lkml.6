Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD739C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF4C2151C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="19S9wKO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF4C2151C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeHXUJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbeHXUJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:09:05 -0400
Received: from mail-qt0-f180.google.com (mail-qt0-f180.google.com [209.85.216.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B1462151C;
        Fri, 24 Aug 2018 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535128420;
        bh=96ZmoABHwSDkgi5U/Jsp/8a3wEOmFjfxpiKylQsZi1w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=19S9wKO8EW9QmFjYQ4gaDkKGA3zEpYo7yTM6l5H603me0w1XkSuUHxuzn2qRPlwxL
         LtFO7Of/03EE+jWr38iRVMW4f7BAn0NIQ7634uJRsf3boJcaWOtsHaJxjUe+h4TNqS
         ofokS+zgCg+56Fd9+cO1GOAxBgQNhNkBGqpz9HD8=
Received: by mail-qt0-f180.google.com with SMTP id r13-v6so10762775qtr.11;
        Fri, 24 Aug 2018 09:33:40 -0700 (PDT)
X-Gm-Message-State: APzg51AnLERoALjS6Cxm9xD2GvczVVqGHz3KNTGr0ADUBD+Ng3ndfCJr
        FjNDu18WMHUTaHAvzav4JcHxtAFYAbYLs2WfoA==
X-Google-Smtp-Source: ANB0VdZmetmlKC/4xs1EKtGguGFRwRXtheb1elg7o2yF779HwoQu2fxDbmZlUM+w7tuq0De3WZPCeVNpXR3Qu0bclQU=
X-Received: by 2002:ac8:1909:: with SMTP id t9-v6mr2548035qtj.327.1535128419759;
 Fri, 24 Aug 2018 09:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180810130359.9882-1-peda@axentia.se> <20180810130359.9882-4-peda@axentia.se>
 <20180813135949.32vrlrevtazr5x7d@apu3b.nibble.pw> <0baac94e-f3d2-53fd-4af9-854bb4498345@axentia.se>
 <CAL_JsqJPzwpN2TFghy-FfHZppexG9gW4qBy6iYtGpyP_Bp6dUA@mail.gmail.com>
 <5c9853fc-e2ea-6983-ac88-b52b6e9e6ecd@axentia.se> <CAL_JsqJHRL0f2YwvOJBpggKRVQwPWy8j08-+_nd-VifOOKYqFA@mail.gmail.com>
 <56016787-0487-1571-7c28-2767033cda23@axentia.se> <20180824094701.1f17393f@bbrezillon>
In-Reply-To: <20180824094701.1f17393f@bbrezillon>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 24 Aug 2018 11:33:28 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+DaCQ09kwxy_m_Jfotejd-Oo7BV13R0s43r9LRq403LQ@mail.gmail.com>
Message-ID: <CAL_Jsq+DaCQ09kwxy_m_Jfotejd-Oo7BV13R0s43r9LRq403LQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] drm/atmel-hlcdc: iterate over all output endpoints
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Peter Rosin <peda@axentia.se>, Mark Rutland <mark.rutland@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 2:47 AM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Tue, 14 Aug 2018 17:05:29 +0200
> Peter Rosin <peda@axentia.se> wrote:
>
> > >>>>>> @@ -77,13 +79,29 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
> > >>>>>>
> > >>>>>>  int atmel_hlcdc_create_outputs(struct drm_device *dev)
> > >>>>>>  {
> > >>>>>> -    int endpoint, ret = 0;
> > >>>>>> -
> > >>>>>> -    for (endpoint = 0; !ret; endpoint++)
> > >>>>>> -            ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
> > >>>>>> +    struct of_endpoint endpoint;
> > >>>>>> +    struct device_node *node = NULL;
> > >>>>>> +    int count = 0;
> > >>>>>> +    int ret = 0;
> > >>>>>> +
> > >>>>>> +    for_each_endpoint_of_node(dev->dev->of_node, node) {
> > >>>>>> +            of_graph_parse_endpoint(node, &endpoint);
> > >>>
> > >>> I'd really like to kill off of_graph_parse_endpoint, not add more
> > >>> users (check the git history on this code). You should know what are
> > >>> possible port and endpoint numbers, so iterate over those.
> > >>
> > >> So, add a comment to that effect in the docs of the of_graph_parse_endpoint
> > >> function.
> > >>
> > >> How can the hlcdc driver know the actual number of endpoints? It's a
> > >> one-way signal path out from that port, and it can easily be routed to
> > >> 1, 2, 3 or even more places. As shown above, forcing the endpoint id
> > >> to start at zero is a nuisance, and I don't see the point of it.
> > >>
> > >> But I welcome suggestions on how to arrange the above dtsi/dts fragments
> > >> in a world where the endpoint id absolutely has to start at zero.
> > >
> > > Your dts file arrangement seems fine. Can't you just not exit the loop
> > > on -ENODEV? IOW, just iterate til you find an enabled endpoint.
> >
> > That would regress cases where two (or more) endpoints are enabled
> > (which is currently supported). As I see it, the driver will have a
> > very hard time knowing when to stop iterating with any solution not
> > involving the equivalent of the functions for_each_endpoint_of_node
> > and of_graph_parse_endpoint. Open-coding of_graph_parse_endpoint just
> > to avoid it is a bit more than silly IMHO...
>
> I agree, and actually, I think this is Rob who suggested to do what we
> do here :-) (iterate from 0 to X, and stop as soon as
> -ENODEV is returned).

By suggested, you mean implemented because that is what it currently
does. My suggestion now is to do this:

for (endpoint = 0; endpoint < SOME_REASONABLE_MAX_NUMBER_OF_ENDPOINTS;
endpoint++) {
  ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
  if (ret == -ENODEV)
    continue;
  // handle other errors?
}

And SOME_REASONABLE_MAX_NUMBER_OF_ENDPOINTS is something you make up
based on how many connections any board will have and physics (I
suppose you could have trees worth of buffers, but really what is the
worst case in an actual board design?). I would think 4 would be
plenty. If not, double it to 8.

Rob
