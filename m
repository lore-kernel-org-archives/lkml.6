Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6185AC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F2F21736
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2lu9qZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F2F21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbeHNRUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729560AbeHNRUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:20:43 -0400
Received: from mail-qt0-f172.google.com (mail-qt0-f172.google.com [209.85.216.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F683217C3;
        Tue, 14 Aug 2018 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534257196;
        bh=dLD7XVH0gg4ak0Iyde8k/ZMFx0eP3gzOP+3VwI9umP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l2lu9qZ+nIoY2MAbisxdnQGrHWWk2OJE1mx2ATZleJnsEXOmBL/Rpv+4VRyvkceBL
         9z2b8JKX4dUEMK8gJLdTjLoCpYX2URlXSDawAHpSluJEiFVsv43I8OiniHxmXk/jVx
         tkqy2LIIYY8DiH6i5n/0CIcXSKP2A0A/VrWtaopA=
Received: by mail-qt0-f172.google.com with SMTP id q12-v6so21309770qtp.6;
        Tue, 14 Aug 2018 07:33:16 -0700 (PDT)
X-Gm-Message-State: AOUpUlG51hy8loFgKbQyDUGU6R6LQjv+XvjHr3xnZE+Ukk9KuYwEcDxn
        kkK/pUDq7e28ArObTp7INxbP0Gv7jbtHzuK83g==
X-Google-Smtp-Source: AA+uWPyvUe7CWp0BXEEyumvSHyGvPrGnGAB0+zJHE2SOJ4pUzgqmAZGcmZo6H9KokJBGMJg+Ha/xUYL0ZVQsBJj1aVM=
X-Received: by 2002:a0c:98c1:: with SMTP id g1-v6mr19297171qvd.27.1534257195702;
 Tue, 14 Aug 2018 07:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180810130359.9882-1-peda@axentia.se> <20180810130359.9882-4-peda@axentia.se>
 <20180813135949.32vrlrevtazr5x7d@apu3b.nibble.pw> <0baac94e-f3d2-53fd-4af9-854bb4498345@axentia.se>
 <CAL_JsqJPzwpN2TFghy-FfHZppexG9gW4qBy6iYtGpyP_Bp6dUA@mail.gmail.com> <5c9853fc-e2ea-6983-ac88-b52b6e9e6ecd@axentia.se>
In-Reply-To: <5c9853fc-e2ea-6983-ac88-b52b6e9e6ecd@axentia.se>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Aug 2018 08:33:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJHRL0f2YwvOJBpggKRVQwPWy8j08-+_nd-VifOOKYqFA@mail.gmail.com>
Message-ID: <CAL_JsqJHRL0f2YwvOJBpggKRVQwPWy8j08-+_nd-VifOOKYqFA@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] drm/atmel-hlcdc: iterate over all output endpoints
To:     Peter Rosin <peda@axentia.se>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        jmondi <jacopo@jmondi.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
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

On Tue, Aug 14, 2018 at 12:36 AM Peter Rosin <peda@axentia.se> wrote:
>
> On 2018-08-13 22:52, Rob Herring wrote:
> > On Mon, Aug 13, 2018 at 8:25 AM Peter Rosin <peda@axentia.se> wrote:
> >>
> >> On 2018-08-13 15:59, jacopo mondi wrote:
> >>> Hi Peter,
> >>>
> >>> On Fri, Aug 10, 2018 at 03:03:58PM +0200, Peter Rosin wrote:
> >>>> This enables more flexible devicetrees. You can e.g. have two output
> >>>> nodes where one is not enabled, without the ordering affecting things.
> >
> > Your DTs are not supposed to be flexible. They should be well defined
> > by the binding.
>
> I feel the need to explain the situation with more words...
>
> We have a board with this atmel-hlcdc wired to both an LVDS encoder
> and an HDMI encoder. Depending on how we integrate this board, only
> one of these paths make sense. Hence, I would like to do the following
> in a .dtsi for that board:
>
> / {
>         hlcdc-display-controller {
>                 ...
>                 port@0 {
>                         hlcdc_lvds: endpoint@0 {
>                                 reg = <0>;
>                                 remote-endpoint = <&lvds_encoder_input>;
>                         };
>
>                         hlcdc_hdmi: endpoint@1 {
>                                 reg = <1>;
>                                 remote-endpoint = <&hdmi_encoder_input>;
>                         };
>                 };
>         };
>
>         lvds_encoder: lvds-encoder {
>                 status = "disabled";
>
>                 ...
>
>                 ports {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>
>                         port@0 {
>                                 reg = <0>;
>
>                                 lvds_encoder_input: endpoint {
>                                         remote-endpoint = <&hlcdc_lvds>;
>                                 };
>                         };
>
>                         port@1 {
>                                 reg = <1>;
>
>                                 lvds_encoder_output: endpoint {
>                                 };
>                         };
>                 };
>         };
> };
>
> &i2c2 {
>         ...
>         hdmi_encoder: hdmi-encoder@70 {
>                 status = "disabled";
>
>                 ...
>
>                 port {
>                         hdmi_encoder_input: endpoint {
>                                 remote-endpoint = <&hlcdc_hdmi>;
>                         };
>                 };
>         };
> };
>
>
> And then, depending on what components are fitted and what LVDS panel has
> been attached to the LVDS encoder output, this can be used as follows
> in the .dts file for LVDS case:
>
> / {
>         panel: panel {
>                 compatible = "litemax,dlf2118", "panel-lvds";
>
>                 ...
>
>                 port {
>                         panel_input: endpoint {
>                                 remote-endpoint = <&lvds_encoder_output>;
>                         };
>                 };
>         };
> };
>
>
> &lvds_encoder {
>         status = "okay";
> };
>
> &lvds_encoder_output {
>         remote-endpoint = <&panel_input>;
> };
>
>
> For the HDMI case, it would be this in the .dts file:
>
> &hdmi_encoder {
>         status = "okay";
> };
>
>
> The above seem so much better than just having the following in
> the .dtsi file
>
> / {
>         hlcdc-display-controller {
>                 ...
>                 port@0 {
>                         hlcdc_lvds: endpoint {
>                                 remote-endpoint = <&encoder_input>;
>                         };
>                 };
>         };
> };
>
> and pushing the lvds-encoder and hdmi-encoder nodes (slightly modified) down
> to the relevant .dts files. Especially so since we have to this point
> delivered several variants with different LVDS panels. The duplication
> is ugly, and the number of different panels is expected to grow...
>
> But maybe I have misunderstood what endpoints are all about, but to me
> the actual endpoint id is not that interesting and I see nothing in the
> graph binding that suggests that endpoint id 0 has to be up and kicking
> in order for endpoint id 1 to be examined at all.

I guess it depends if the numbering is significant. For a one to many
fan out like this, not so much. For a muxed input, then it would be.

> For ports, yes, you are right that the port id needs to be defined and
> fixed for a specific function, so scratch that. It was just a "maybe"
> question anyway...
>
> >>>>
> >>>> Prior to this patch the active node had to have endpoint id zero.
> >>>>
> >>>> Signed-off-by: Peter Rosin <peda@axentia.se>
> >>>> ---
> >>>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 32 ++++++++++++++++++------
> >>>>  1 file changed, 25 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> >>>> index 8db51fb131db..16c1b2f54b42 100644
> >>>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> >>>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> >>>> @@ -31,14 +31,16 @@ static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
> >>>>      .destroy = drm_encoder_cleanup,
> >>>>  };
> >>>>
> >>>> -static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
> >>>> +static int atmel_hlcdc_attach_endpoint(struct drm_device *dev,
> >>>> +                                   struct of_endpoint *endpoint)
> >>>>  {
> >>>>      struct drm_encoder *encoder;
> >>>>      struct drm_panel *panel;
> >>>>      struct drm_bridge *bridge;
> >>>>      int ret;
> >>>>
> >>>> -    ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
> >>>> +    ret = drm_of_find_panel_or_bridge(dev->dev->of_node,
> >>>> +                                      endpoint->port, endpoint->id,
> >>>
> >>> You are refusing endpoint->port != 0 in the caller, so that could be
> >>> 0.
> >>
> >> Yes, it could. However, I intentionally did not write 0 here, so that
> >> the logic related to "port has to be zero" was in one place and not
> >> scattered about. I guess it's up to Boris?
> >>
> >> Maybe the port do not actually have to be zero at all? With the old
> >> code, it was kind of understandable that the port number was fixed,
> >> but for the code in my patch it does not matter at all AFAICT. There
> >> is nothing in the binding docs (except for the example) that hints
> >> that port has to be zero, so that's one thing in favor of just getting
> >> rid of the port number checking altogether...
> >
> > The port numbering must be defined and fixed. If that is not clear in
> > the binding, fix the binding.
>
> Ok, so the code in my patch does the right thing forcing the port
> number to zero.
>
> >>>> @@ -77,13 +79,29 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
> >>>>
> >>>>  int atmel_hlcdc_create_outputs(struct drm_device *dev)
> >>>>  {
> >>>> -    int endpoint, ret = 0;
> >>>> -
> >>>> -    for (endpoint = 0; !ret; endpoint++)
> >>>> -            ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
> >>>> +    struct of_endpoint endpoint;
> >>>> +    struct device_node *node = NULL;
> >>>> +    int count = 0;
> >>>> +    int ret = 0;
> >>>> +
> >>>> +    for_each_endpoint_of_node(dev->dev->of_node, node) {
> >>>> +            of_graph_parse_endpoint(node, &endpoint);
> >
> > I'd really like to kill off of_graph_parse_endpoint, not add more
> > users (check the git history on this code). You should know what are
> > possible port and endpoint numbers, so iterate over those.
>
> So, add a comment to that effect in the docs of the of_graph_parse_endpoint
> function.
>
> How can the hlcdc driver know the actual number of endpoints? It's a
> one-way signal path out from that port, and it can easily be routed to
> 1, 2, 3 or even more places. As shown above, forcing the endpoint id
> to start at zero is a nuisance, and I don't see the point of it.
>
> But I welcome suggestions on how to arrange the above dtsi/dts fragments
> in a world where the endpoint id absolutely has to start at zero.

Your dts file arrangement seems fine. Can't you just not exit the loop
on -ENODEV? IOW, just iterate til you find an enabled endpoint.

Rob
