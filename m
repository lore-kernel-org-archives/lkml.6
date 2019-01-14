Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11565C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E047620873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfANQTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:19:54 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:36303
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726675AbfANQTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:19:53 -0500
X-IronPort-AV: E=Sophos;i="5.56,478,1539640800"; 
   d="scan'208";a="291882267"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 17:19:49 +0100
Date:   Mon, 14 Jan 2019 17:19:47 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kernel-janitors@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm: rcar-du: add missing of_node_put
In-Reply-To: <78d7667d-f701-b908-9f24-0ee13be90947@ideasonboard.com>
Message-ID: <alpine.DEB.2.20.1901141719000.3522@hadrien>
References: <1547372691-28324-1-git-send-email-Julia.Lawall@lip6.fr> <1547372691-28324-2-git-send-email-Julia.Lawall@lip6.fr> <78d7667d-f701-b908-9f24-0ee13be90947@ideasonboard.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jan 2019, Kieran Bingham wrote:

> Hi Julia,
>
> Thank you for the patch,
>
> On 13/01/2019 09:44, Julia Lawall wrote:
> > Add an of_node_put when the result of of_graph_get_remote_port_parent is
> > not available.
> >
> > The semantic match that finds this problem is as follows
> > (http://coccinelle.lip6.fr):
> >
> > // <smpl>
> > @r exists@
> > local idexpression e;
> > expression x;
> > @@
> > e = of_graph_get_remote_port_parent(...);
> > ... when != x = e
> >     when != true e == NULL
> >     when != of_node_put(e)
> >     when != of_fwnode_handle(e)
> > (
> > return e;
> > |
> > *return ...;
> > )
> > // </smpl>
> >
>
> For this part at least:
>
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>
> But a little discussion below:
>
>
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> This does indeed look like a missing of_node_put() but I don't think it
> will be the only one in that code. It gets a bit tangled - and I think
> there's possibly another missing put on the error path of
>
>         if (!encoder) {
>                 dev_warn(rcdu->dev,
>                          "no encoder found for endpoint %pOF, skipping\n",
>                          ep->local_node);
>                 return -ENODEV;
>         }
>
> because that implies that no encoder was found, and thus -
>                 encoder = entity;
>
> was not executed, and the tail of that function calls:
>
>          of_node_put(encoder);
>
> which would have been the final of_node_put(entity)

Looking at it again, I agree.  I can just extend this patch.

julia


>
>
> I think that part could be considered separate to this patch, but it's
> also quite closely related. Either way - I think it needs a second pair
> of eyes to see if I'm not crazy :)
>
> Regards
>
> Kieran
>
> >
> > ---
> >  drivers/gpu/drm/rcar-du/rcar_du_kms.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> > index 9c7007d..bc3fcb3 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> > @@ -331,6 +331,7 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
> >  		dev_dbg(rcdu->dev,
> >  			"connected entity %pOF is disabled, skipping\n",
> >  			entity);
> > +		of_node_put(entity);
> >  		return -ENODEV;
> >  	}
> >
> >
>
>
