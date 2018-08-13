Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C38C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAFA21778
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9PzNBzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAFA21778
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbeHMXgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 19:36:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbeHMXgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 19:36:08 -0400
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com [209.85.216.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE577218A4;
        Mon, 13 Aug 2018 20:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534193535;
        bh=CMNvPVc95jSorb/Nsog3ZwWkNDODmoPQzj7+MOr5iUg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A9PzNBzl7uU5Lr/QYi3QfajcDv9wONnvmsWPYcShHJrWFF2Wtp+k0B6+73Cl1sbHE
         zq4QsSJS42HVgYX/W3JUsC16WhjjXqTIqWhoZfte+Qna2bv5cNSHQM0UYwpl5wQ/bq
         qTZwxvpzBZLHAB0Av0lEC5TXREtlqFkIztUAB39M=
Received: by mail-qt0-f174.google.com with SMTP id z8-v6so18976788qto.9;
        Mon, 13 Aug 2018 13:52:15 -0700 (PDT)
X-Gm-Message-State: AOUpUlEibYWSOUYTtEMx2h6jXLpMUdXT61SKf8/adG4L8XL1KUqYbqkQ
        FE1VBTIM6xrsUwSTXfdEXj7POyX5Os+qOonLQA==
X-Google-Smtp-Source: AA+uWPymCqhZhMcuoX4Nvalbw0Gb/torwjnuy2irrg8S/EkoViu3KFnUBNsiIyjXK3sOOEMLVkk/s2DFJ7k35cS2f6A=
X-Received: by 2002:a0c:ca94:: with SMTP id a20-v6mr16708993qvk.37.1534193534814;
 Mon, 13 Aug 2018 13:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180810130359.9882-1-peda@axentia.se> <20180810130359.9882-4-peda@axentia.se>
 <20180813135949.32vrlrevtazr5x7d@apu3b.nibble.pw> <0baac94e-f3d2-53fd-4af9-854bb4498345@axentia.se>
In-Reply-To: <0baac94e-f3d2-53fd-4af9-854bb4498345@axentia.se>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 13 Aug 2018 14:52:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJPzwpN2TFghy-FfHZppexG9gW4qBy6iYtGpyP_Bp6dUA@mail.gmail.com>
Message-ID: <CAL_JsqJPzwpN2TFghy-FfHZppexG9gW4qBy6iYtGpyP_Bp6dUA@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] drm/atmel-hlcdc: iterate over all output endpoints
To:     Peter Rosin <peda@axentia.se>
Cc:     jmondi <jacopo@jmondi.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 8:25 AM Peter Rosin <peda@axentia.se> wrote:
>
> On 2018-08-13 15:59, jacopo mondi wrote:
> > Hi Peter,
> >
> > On Fri, Aug 10, 2018 at 03:03:58PM +0200, Peter Rosin wrote:
> >> This enables more flexible devicetrees. You can e.g. have two output
> >> nodes where one is not enabled, without the ordering affecting things.

Your DTs are not supposed to be flexible. They should be well defined
by the binding.

> >>
> >> Prior to this patch the active node had to have endpoint id zero.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 32 ++++++++++++++++++------
> >>  1 file changed, 25 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> >> index 8db51fb131db..16c1b2f54b42 100644
> >> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> >> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> >> @@ -31,14 +31,16 @@ static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
> >>      .destroy = drm_encoder_cleanup,
> >>  };
> >>
> >> -static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
> >> +static int atmel_hlcdc_attach_endpoint(struct drm_device *dev,
> >> +                                   struct of_endpoint *endpoint)
> >>  {
> >>      struct drm_encoder *encoder;
> >>      struct drm_panel *panel;
> >>      struct drm_bridge *bridge;
> >>      int ret;
> >>
> >> -    ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
> >> +    ret = drm_of_find_panel_or_bridge(dev->dev->of_node,
> >> +                                      endpoint->port, endpoint->id,
> >
> > You are refusing endpoint->port != 0 in the caller, so that could be
> > 0.
>
> Yes, it could. However, I intentionally did not write 0 here, so that
> the logic related to "port has to be zero" was in one place and not
> scattered about. I guess it's up to Boris?
>
> Maybe the port do not actually have to be zero at all? With the old
> code, it was kind of understandable that the port number was fixed,
> but for the code in my patch it does not matter at all AFAICT. There
> is nothing in the binding docs (except for the example) that hints
> that port has to be zero, so that's one thing in favor of just getting
> rid of the port number checking altogether...

The port numbering must be defined and fixed. If that is not clear in
the binding, fix the binding.

> >> @@ -77,13 +79,29 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
> >>
> >>  int atmel_hlcdc_create_outputs(struct drm_device *dev)
> >>  {
> >> -    int endpoint, ret = 0;
> >> -
> >> -    for (endpoint = 0; !ret; endpoint++)
> >> -            ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
> >> +    struct of_endpoint endpoint;
> >> +    struct device_node *node = NULL;
> >> +    int count = 0;
> >> +    int ret = 0;
> >> +
> >> +    for_each_endpoint_of_node(dev->dev->of_node, node) {
> >> +            of_graph_parse_endpoint(node, &endpoint);

I'd really like to kill off of_graph_parse_endpoint, not add more
users (check the git history on this code). You should know what are
possible port and endpoint numbers, so iterate over those.

> >> +
> >> +            if (endpoint.port)
> >> +                    continue;
> >> +
> >> +            ret = atmel_hlcdc_attach_endpoint(dev, &endpoint);
> >> +            if (ret == -ENODEV)
> >> +                    continue;
> >> +            if (ret) {
> >> +                    of_node_put(node);
> >> +                    break;
> >> +            }
> >> +            count++;
> >> +    }
> >>
> >>      /* At least one device was successfully attached.*/
> >> -    if (ret == -ENODEV && endpoint)
> >> +    if (ret == -ENODEV && count)
> >>              return 0;
> >>
> >>      return ret;
> >> --
> >> 2.11.0
> >>
>
