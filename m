Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AB8C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F51216C1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F51216C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030405AbeF1SZr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:25:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57621 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966247AbeF1SZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:25:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3F45920750; Thu, 28 Jun 2018 20:25:43 +0200 (CEST)
Received: from localhost (unknown [88.128.80.178])
        by mail.bootlin.com (Postfix) with ESMTPSA id ED4E9206ED;
        Thu, 28 Jun 2018 20:25:42 +0200 (CEST)
Date:   Thu, 28 Jun 2018 20:25:43 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH v3 10/24] drm/sun4i: tcon: Generalize engine search
 algorithm
Message-ID: <20180628182543.yyja6hiry7rx7fu2@flea>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-11-jernej.skrabec@siol.net>
 <CAGb2v66ndyhVFKsOt=g45MJ-cBun8WvRrDsb9XO2hteSX2oe5A@mail.gmail.com>
 <1812731.FQOhD8MfmX@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1812731.FQOhD8MfmX@jernej-laptop>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 06:48:50AM +0200, Jernej Škrabec wrote:
> Dne četrtek, 28. junij 2018 ob 04:06:52 CEST je Chen-Yu Tsai napisal(a):
> > On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> 
> wrote:
> > > Current "old" method to find engine worked pretty well for DE2. However,
> > > it doesn't work when TCON TOP is between  mixer (engine) and TCON. TCON
> > > TOP has multiple input ports, but current engine search algorithm
> > > expects only one.
> > > 
> > > This can be fixed by first looking for output port id and selecting
> > > matching input by subtracting 1 for the next round. This work even if
> > > there is only one input and output.
> > > 
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > > 
> > >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 22 ++++++++++++++++++----
> > >  1 file changed, 18 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > b/drivers/gpu/drm/sun4i/sun4i_tcon.c index 08747fc3ee71..264bcc43da11
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > @@ -791,12 +791,14 @@ static int sun4i_tcon_init_regmap(struct device
> > > *dev,
> > > 
> > >   */
> > >  
> > >  static struct sunxi_engine *
> > >  sun4i_tcon_find_engine_traverse(struct sun4i_drv *drv,
> > > 
> > > -                               struct device_node *node)
> > > +                               struct device_node *node,
> > > +                               u32 port_id)
> > > 
> > >  {
> > >  
> > >         struct device_node *port, *ep, *remote;
> > >         struct sunxi_engine *engine = ERR_PTR(-EINVAL);
> > > 
> > > +       u32 reg = 0;
> > > 
> > > -       port = of_graph_get_port_by_id(node, 0);
> > > +       port = of_graph_get_port_by_id(node, port_id);
> > > 
> > >         if (!port)
> > >         
> > >                 return ERR_PTR(-EINVAL);
> > > 
> > > @@ -826,8 +828,20 @@ sun4i_tcon_find_engine_traverse(struct sun4i_drv
> > > *drv,
> > > 
> > >                 if (remote == engine->node)
> > >                 
> > >                         goto out_put_remote;
> > > 
> > > +       /*
> > > +        * According to device tree binding input ports have even id
> > > +        * number and output ports have odd id. Since component with
> > > +        * more than one input and one output (TCON TOP) exits, correct
> > > +        * remote input id has to be calculated by subtracting 1 from
> > > +        * remote output id. If this for some reason can't be done, 0
> > > +        * is used as input port id.
> > > +        */
> > 
> > You need to call
> > 
> >     of_node_put(port);
> > 
> > to drop the reference to the original port.
> 
> Thanks for noticing it. I guess I should send fix patch, since patches from 
> drm-misc-next can't be dropped.

Yeah, please send additional patches for all the issues pointed out by
Chen-Yu.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
