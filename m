Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E2AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23622205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="evzm6hh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfANWBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:01:31 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:58626 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfANWBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:01:31 -0500
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3B87A530;
        Mon, 14 Jan 2019 23:01:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547503288;
        bh=9TMMwkd3VuWBrwETYkOZnVdU8DkQmY7nw0beCVasr3k=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=evzm6hh6eikfecFbR63EOmuo9EjsAI63SgJdDdUv1CAAk7jEQdMnzFjtLRb/WrNhg
         H9OJSdBSAXJBuLA1mzx+RA390rZ1fuVfsC+JU9iB84qYmtySefdeIBLKNnAKGQWcL3
         upovEHBCI0I7/NcXUUwHru3MwZelFoWnIdqh28GI=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH 1/3 v2] drm: rcar-du: add missing of_node_put
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kernel-janitors@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.20.1901141743510.3522@hadrien>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <d492e274-fc01-98eb-4f99-a6af611d4c30@ideasonboard.com>
Date:   Mon, 14 Jan 2019 22:01:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1901141743510.3522@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

On 14/01/2019 16:44, Julia Lawall wrote:
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
> |
> *return ...;
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Thankyou for the update.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>


> 
> ---
> v2: Add the second of_node_put(entity);, as suggested by Kieran Bingham.
> 
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> index 9c7007d..f9a90ff 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> @@ -331,6 +331,7 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
>  		dev_dbg(rcdu->dev,
>  			"connected entity %pOF is disabled, skipping\n",
>  			entity);
> +		of_node_put(entity);
>  		return -ENODEV;
>  	}
> 
> @@ -366,6 +367,7 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
>  		dev_warn(rcdu->dev,
>  			 "no encoder found for endpoint %pOF, skipping\n",
>  			 ep->local_node);
> +		of_node_put(entity);
>  		return -ENODEV;
>  	}
> 

