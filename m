Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CE5C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514D020659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dPrpA2YH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfANSMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:12:45 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:55048 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfANSMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:12:45 -0500
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 01ECB530;
        Mon, 14 Jan 2019 19:12:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547489562;
        bh=Po9QtX/5cAR5h7sBsCY/t3DG/3aqOXT9HbC4ic+ks34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dPrpA2YH/5l0UxL5jggi2Sk3Sy5weEhVzvXdUr8xj4MaWoguTzrwmydsxSX781vN1
         4DuJdslqrQUYtCWnb0JJ0Fx7YifVsGYKzSDiBpKuv9YGlf6krZm/Z17NT/JhZ1iYM1
         3PDd3UNcSut38onXhhtG+lqbD1rz3bWvZ5WDnuHU=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        kernel-janitors@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3 v2] drm: rcar-du: add missing of_node_put
Date:   Mon, 14 Jan 2019 20:13:57 +0200
Message-ID: <10676089.h4Wfvzvksh@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <alpine.DEB.2.20.1901141743510.3522@hadrien>
References: <alpine.DEB.2.20.1901141743510.3522@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

Thank you for the patch.

On Monday, 14 January 2019 18:44:56 EET Julia Lawall wrote:
> Add an of_node_put when the result of of_graph_get_remote_port_parent is
> not available.
> 
> Add a second of_node_put if no encoder is selected (encoder remains NULL).
> 
> The semantic match that finds the first problem is as follows
> (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @r exists@
> local idexpression e;
> expression x;
> @@
> e = of_graph_get_remote_port_parent(...);
> ... when != x = e
>     when != true e == NULL
>     when != of_node_put(e)
>     when != of_fwnode_handle(e)
> (
> return e;
> 
> *return ...;
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

> ---
> v2: Add the second of_node_put(entity);, as suggested by Kieran Bingham.
> 
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> b/drivers/gpu/drm/rcar-du/rcar_du_kms.c index 9c7007d..f9a90ff 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> @@ -331,6 +331,7 @@ static int rcar_du_encoders_init_one(struct
> rcar_du_device *rcdu, dev_dbg(rcdu->dev,
>  			"connected entity %pOF is disabled, skipping\n",
>  			entity);
> +		of_node_put(entity);
>  		return -ENODEV;
>  	}
> 
> @@ -366,6 +367,7 @@ static int rcar_du_encoders_init_one(struct
> rcar_du_device *rcdu, dev_warn(rcdu->dev,
>  			 "no encoder found for endpoint %pOF, skipping\n",
>  			 ep->local_node);
> +		of_node_put(entity);
>  		return -ENODEV;
>  	}

-- 
Regards,

Laurent Pinchart



