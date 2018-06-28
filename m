Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4B0C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452C126C4B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 452C126C4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932724AbeF1EuU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:50:20 -0400
Received: from mailoutvs12.siol.net ([185.57.226.203]:38710 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932131AbeF1EuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:50:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id B1DCA52076D;
        Thu, 28 Jun 2018 06:50:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sA3p3Wh25wn0; Thu, 28 Jun 2018 06:50:16 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id DCED65207A5;
        Thu, 28 Jun 2018 06:50:15 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id 02F8D52076D;
        Thu, 28 Jun 2018 06:50:14 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v3 10/24] drm/sun4i: tcon: Generalize engine search algorithm
Date:   Thu, 28 Jun 2018 06:48:50 +0200
Message-ID: <1812731.FQOhD8MfmX@jernej-laptop>
In-Reply-To: <CAGb2v66ndyhVFKsOt=g45MJ-cBun8WvRrDsb9XO2hteSX2oe5A@mail.gmail.com>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-11-jernej.skrabec@siol.net> <CAGb2v66ndyhVFKsOt=g45MJ-cBun8WvRrDsb9XO2hteSX2oe5A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 28. junij 2018 ob 04:06:52 CEST je Chen-Yu Tsai napisal(a):
> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > Current "old" method to find engine worked pretty well for DE2. However,
> > it doesn't work when TCON TOP is between  mixer (engine) and TCON. TCON
> > TOP has multiple input ports, but current engine search algorithm
> > expects only one.
> > 
> > This can be fixed by first looking for output port id and selecting
> > matching input by subtracting 1 for the next round. This work even if
> > there is only one input and output.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > b/drivers/gpu/drm/sun4i/sun4i_tcon.c index 08747fc3ee71..264bcc43da11
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > @@ -791,12 +791,14 @@ static int sun4i_tcon_init_regmap(struct device
> > *dev,
> > 
> >   */
> >  
> >  static struct sunxi_engine *
> >  sun4i_tcon_find_engine_traverse(struct sun4i_drv *drv,
> > 
> > -                               struct device_node *node)
> > +                               struct device_node *node,
> > +                               u32 port_id)
> > 
> >  {
> >  
> >         struct device_node *port, *ep, *remote;
> >         struct sunxi_engine *engine = ERR_PTR(-EINVAL);
> > 
> > +       u32 reg = 0;
> > 
> > -       port = of_graph_get_port_by_id(node, 0);
> > +       port = of_graph_get_port_by_id(node, port_id);
> > 
> >         if (!port)
> >         
> >                 return ERR_PTR(-EINVAL);
> > 
> > @@ -826,8 +828,20 @@ sun4i_tcon_find_engine_traverse(struct sun4i_drv
> > *drv,
> > 
> >                 if (remote == engine->node)
> >                 
> >                         goto out_put_remote;
> > 
> > +       /*
> > +        * According to device tree binding input ports have even id
> > +        * number and output ports have odd id. Since component with
> > +        * more than one input and one output (TCON TOP) exits, correct
> > +        * remote input id has to be calculated by subtracting 1 from
> > +        * remote output id. If this for some reason can't be done, 0
> > +        * is used as input port id.
> > +        */
> 
> You need to call
> 
>     of_node_put(port);
> 
> to drop the reference to the original port.

Thanks for noticing it. I guess I should send fix patch, since patches from 
drm-misc-next can't be dropped.

Best regards,
Jernej

> Otherwise,
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 
> > +       port = of_graph_get_remote_port(ep);
> > +       if (!of_property_read_u32(port, "reg", &reg) && reg > 0)
> > +               reg -= 1;
> > +
> > 
> >         /* keep looking through upstream ports */
> > 
> > -       engine = sun4i_tcon_find_engine_traverse(drv, remote);
> > +       engine = sun4i_tcon_find_engine_traverse(drv, remote, reg);
> > 
> >  out_put_remote:
> >         of_node_put(remote);
> > 
> > @@ -950,7 +964,7 @@ static struct sunxi_engine
> > *sun4i_tcon_find_engine(struct sun4i_drv *drv,> 
> >         /* Fallback to old method by traversing input endpoints */
> >         of_node_put(port);
> > 
> > -       return sun4i_tcon_find_engine_traverse(drv, node);
> > +       return sun4i_tcon_find_engine_traverse(drv, node, 0);
> > 
> >  }
> >  
> >  static int sun4i_tcon_bind(struct device *dev, struct device *master,
> > 
> > --
> > 2.18.0




