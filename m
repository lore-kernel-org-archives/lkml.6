Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BD7C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B85208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B85208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeGKHND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:13:03 -0400
Received: from mailoutvs12.siol.net ([185.57.226.203]:48173 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726532AbeGKHND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:13:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id B3DA4521679;
        Wed, 11 Jul 2018 09:10:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oO_tCHqkpfz4; Wed, 11 Jul 2018 09:10:11 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 02C8A52160C;
        Wed, 11 Jul 2018 09:10:11 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id CD0E9521670;
        Wed, 11 Jul 2018 09:10:09 +0200 (CEST)
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
Subject: Re: [PATCH v2 10/18] drm/sun4i: mixer: Read id from DT
Date:   Wed, 11 Jul 2018 09:10:04 +0200
Message-ID: <3034661.dpXlJLpBba@jernej-laptop>
In-Reply-To: <CAGb2v66vU4gBewGjLL-Ohx6mvKOVu4dDdwKNsXrkr3nZsSq3Cg@mail.gmail.com>
References: <20180710203511.18454-1-jernej.skrabec@siol.net> <20180710203511.18454-11-jernej.skrabec@siol.net> <CAGb2v66vU4gBewGjLL-Ohx6mvKOVu4dDdwKNsXrkr3nZsSq3Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 11. julij 2018 ob 05:11:56 CEST je Chen-Yu Tsai napisal(a):
> On Wed, Jul 11, 2018 at 4:35 AM, Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > Currently, TCON supports 2 ways to match TCON with engine (mixer in this
> > case). Old way is to just traverse of graph backwards and compare node
> > pointer. New way is to match TCON and engine by their respective ids.
> > All SoCs with DE2 enabled till now used the old way, which means mixer
> > id was never used and thus never implemented.
> > 
> > However, for R40, only the new way will be used. To prepare for that,
> > implement mixer id fetching from DT.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun8i_mixer.c | 40 +++++++++++++++++++++++++++--
> >  1 file changed, 38 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > b/drivers/gpu/drm/sun4i/sun8i_mixer.c index aa81b9838ae8..4bd4d8ccb34f
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > @@ -22,6 +22,7 @@
> > 
> >  #include <linux/component.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/of_device.h>
> > 
> > +#include <linux/of_graph.h>
> > 
> >  #include <linux/reset.h>
> >  
> >  #include "sun4i_drv.h"
> > 
> > @@ -322,6 +323,42 @@ static struct regmap_config sun8i_mixer_regmap_config
> > = {> 
> >         .max_register   = 0xbfffc, /* guessed */
> >  
> >  };
> > 
> > +static int sun8i_mixer_of_get_id(struct device_node *node)
> > +{
> > +       struct device_node *port, *ep;
> > +       int ret = -EINVAL;
> > +
> > +       /* output is port 1 */
> > +       port = of_graph_get_port_by_id(node, 1);
> > +       if (!port)
> > +               return -EINVAL;
> > +
> > +       /* try to find downstream endpoint */
> > +       for_each_available_child_of_node(port, ep) {
> > +               struct device_node *remote;
> > +               u32 reg;
> > +
> > +               remote = of_graph_get_remote_endpoint(ep);
> > +               if (!remote)
> > +                       continue;
> > +
> > +               ret = of_property_read_u32(remote, "reg", &reg);
> > +               if (!ret) {
> > +                       of_node_put(remote);
> > +                       of_node_put(ep);
> > +                       of_node_put(port);
> > +
> > +                       return reg;
> > +               }
> > +
> > +               of_node_put(remote);
> > +       }
> > +
> > +       of_node_put(port);
> > +
> > +       return ret;
> > +}
> > +
> 
> The above looks good.
> 
> >  static int sun8i_mixer_bind(struct device *dev, struct device *master,
> >  
> >                               void *data)
> >  
> >  {
> > 
> > @@ -353,8 +390,7 @@ static int sun8i_mixer_bind(struct device *dev, struct
> > device *master,> 
> >         dev_set_drvdata(dev, mixer);
> >         mixer->engine.ops = &sun8i_engine_ops;
> >         mixer->engine.node = dev->of_node;
> > 
> > -       /* The ID of the mixer currently doesn't matter */
> > -       mixer->engine.id = -1;
> > +       mixer->engine.id = sun8i_mixer_of_get_id(dev->of_node);
> 
> Should you be handling error codes?

Sadly, no. Other supported DE2 SoC miss reg property in DT and it would break 
them. Additionally, V3s has only one mixer and thus technically doesn't 
violate binding with omiting mixer id.

Anyway, it was -1 all the time before and not really used, so having negative 
value doesn't change anything for other SoCs. If this fails and it's needed, 
it would stop at mixer <-> TCON matching stage anyway.

I guess I should add comment for that.

Best regards,
Jernej



