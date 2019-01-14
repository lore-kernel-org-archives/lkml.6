Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF1FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49382087E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LM/Agwxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfANOeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:34:13 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:48106 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfANOeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:34:13 -0500
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 892CF530;
        Mon, 14 Jan 2019 15:34:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547476449;
        bh=OCDfCwN5LkQQQWkDE4WjP/f3ekZEjYyuyjzjinYRlEg=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LM/AgwxvGnoe515B5u9vYRU+JMzRll57DohxILVE8g50SuHEJyB/FUTUKmpp61PVE
         g+8fiqMZ49LC2Q/l8g9CX6GEpPCIZ8W2Jz0pd9C3IlhSx5BElTFzRLAe6TE1c+j9Ds
         3gDsuaS4OYm3dpm6ie/2JPrBNa57UA5tHKo1cqvg=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH 1/3] drm: rcar-du: add missing of_node_put
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     kernel-janitors@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1547372691-28324-1-git-send-email-Julia.Lawall@lip6.fr>
 <1547372691-28324-2-git-send-email-Julia.Lawall@lip6.fr>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <78d7667d-f701-b908-9f24-0ee13be90947@ideasonboard.com>
Date:   Mon, 14 Jan 2019 14:34:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547372691-28324-2-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

Thank you for the patch,

On 13/01/2019 09:44, Julia Lawall wrote:
> Add an of_node_put when the result of of_graph_get_remote_port_parent is
> not available.
> 
> The semantic match that finds this problem is as follows
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

For this part at least:

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

But a little discussion below:


> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

This does indeed look like a missing of_node_put() but I don't think it
will be the only one in that code. It gets a bit tangled - and I think
there's possibly another missing put on the error path of

        if (!encoder) {
                dev_warn(rcdu->dev,
                         "no encoder found for endpoint %pOF, skipping\n",
                         ep->local_node);
                return -ENODEV;
        }

because that implies that no encoder was found, and thus -
                encoder = entity;

was not executed, and the tail of that function calls:

         of_node_put(encoder);

which would have been the final of_node_put(entity)


I think that part could be considered separate to this patch, but it's
also quite closely related. Either way - I think it needs a second pair
of eyes to see if I'm not crazy :)

Regards

Kieran

> 
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> index 9c7007d..bc3fcb3 100644
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
> 

