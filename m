Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BD7C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72786208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72786208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934524AbeGJQSx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:18:53 -0400
Received: from mailoutvs59.siol.net ([185.57.226.250]:51605 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934265AbeGJQSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:18:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 1640E522280;
        Tue, 10 Jul 2018 18:18:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wbibwnb8HJYA; Tue, 10 Jul 2018 18:18:45 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 59DBB522281;
        Tue, 10 Jul 2018 18:18:45 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id D7A77522280;
        Tue, 10 Jul 2018 18:18:43 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH 16/17] drm/sun4i: tcon-top: Remove mux configuration at probe time
Date:   Tue, 10 Jul 2018 18:18:43 +0200
Message-ID: <1843348.gnui32CGBV@jernej-laptop>
In-Reply-To: <CAGb2v64rjUnwnXbWxTSYJyhMyCV5QmV9YSr+Jryx3nEeMP8GJg@mail.gmail.com>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-17-jernej.skrabec@siol.net> <CAGb2v64rjUnwnXbWxTSYJyhMyCV5QmV9YSr+Jryx3nEeMP8GJg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 10. julij 2018 ob 18:09:26 CEST je Chen-Yu Tsai napisal(a):
> On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > Now that R40 TCON migrated to runtime mux configuration, old code can be
> > removed.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 81 +++-----------------------
> >  1 file changed, 7 insertions(+), 74 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c index c09b15b64192..78795d6cb174
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > @@ -87,34 +87,6 @@ int sun8i_tcon_top_de_config(struct device *dev, int
> > mixer, int tcon)> 
> >  }
> >  EXPORT_SYMBOL(sun8i_tcon_top_de_config);
> > 
> > -static int sun8i_tcon_top_get_connected_ep_id(struct device_node *node,
> > -                                             int port_id)
> > -{
> > -       struct device_node *ep, *remote, *port;
> > -       struct of_endpoint endpoint;
> > -
> > -       port = of_graph_get_port_by_id(node, port_id);
> > -       if (!port)
> > -               return -ENOENT;
> > -
> > -       for_each_available_child_of_node(port, ep) {
> > -               remote = of_graph_get_remote_port_parent(ep);
> > -               if (!remote)
> > -                       continue;
> > -
> > -               if (of_device_is_available(remote)) {
> > -                       of_graph_parse_endpoint(ep, &endpoint);
> > -
> > -                       of_node_put(remote);
> > -
> > -                       return endpoint.id;
> > -               }
> > -
> > -               of_node_put(remote);
> > -       }
> > -
> > -       return -ENOENT;
> > -}
> > 
> >  static struct clk_hw *sun8i_tcon_top_register_gate(struct device *dev,
> >  
> >                                                    const char *parent,
> > 
> > @@ -149,11 +121,9 @@ static int sun8i_tcon_top_bind(struct device *dev,
> > struct device *master,> 
> >         struct platform_device *pdev = to_platform_device(dev);
> >         struct clk_hw_onecell_data *clk_data;
> >         struct sun8i_tcon_top *tcon_top;
> > 
> > -       bool mixer0_unused = false;
> > 
> >         struct resource *res;
> >         void __iomem *regs;
> > 
> > -       int ret, i, id;
> > -       u32 val;
> > +       int ret, i;
> > 
> >         tcon_top = devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
> >         if (!tcon_top)
> > 
> > @@ -198,49 +168,12 @@ static int sun8i_tcon_top_bind(struct device *dev,
> > struct device *master,> 
> >                 goto err_assert_reset;
> >         
> >         }
> > 
> > -       val = 0;
> > -
> > -       /* check if HDMI mux output is connected */
> > -       if (sun8i_tcon_top_get_connected_ep_id(dev->of_node, 5) >= 0) {
> > -               /* find HDMI input endpoint id, if it is connected at
> > all*/
> > -               id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 4);
> > -               if (id >= 0)
> > -                       val = FIELD_PREP(TCON_TOP_HDMI_SRC_MSK, id + 1);
> > -               else
> > -                       DRM_DEBUG_DRIVER("TCON TOP HDMI input is not
> > connected\n"); -       } else {
> > -               DRM_DEBUG_DRIVER("TCON TOP HDMI output is not
> > connected\n"); -       }
> > -
> > -       writel(val, regs + TCON_TOP_GATE_SRC_REG);
> > -
> > -       val = 0;
> > -
> > -       /* process mixer0 mux output */
> > -       id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 1);
> > -       if (id >= 0) {
> > -               val = FIELD_PREP(TCON_TOP_PORT_DE0_MSK, id);
> > -       } else {
> > -               DRM_DEBUG_DRIVER("TCON TOP mixer0 output is not
> > connected\n"); -               mixer0_unused = true;
> > -       }
> > -
> > -       /* process mixer1 mux output */
> > -       id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 3);
> > -       if (id >= 0) {
> > -               val |= FIELD_PREP(TCON_TOP_PORT_DE1_MSK, id);
> > -
> > -               /*
> > -                * mixer0 mux has priority over mixer1 mux. We have to
> > -                * make sure mixer0 doesn't overtake TCON from mixer1.
> > -                */
> > -               if (mixer0_unused && id == 0)
> > -                       val |= FIELD_PREP(TCON_TOP_PORT_DE0_MSK, 1);
> > -       } else {
> > -               DRM_DEBUG_DRIVER("TCON TOP mixer1 output is not
> > connected\n"); -       }
> > -
> > -       writel(val, regs + TCON_TOP_PORT_SEL_REG);
> > +       /*
> > +        * Default register values might have some reserved bits set,
> > which
> > +        * prevents TCON TOP from working properly. Set them to 0 here.
> > +        */
> > +       writel(0, regs + TCON_TOP_GATE_SRC_REG);
> > +       writel(0, regs + TCON_TOP_PORT_SEL_REG);
> 
> Would it make sense to just force a reset using the reset control?

I wrote TCON TOP driver for H6 at first. For some reason, some registers had 
reserved bits set after reset line was released. TCON TOP was not used in U-
Boot, so I guess this counts as full reset.

I never tried to find out how it behaves on R40 because setting those 
registers to 0 seems like simple, good enough solution, which works 
everywhere.

Best regards,
Jernej



