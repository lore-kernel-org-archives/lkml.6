Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD885C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D70625A51
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D70625A51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeF1CHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:07:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45824 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbeF1CHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:07:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id x22-v6so4180530edq.12;
        Wed, 27 Jun 2018 19:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zAoDKEwFWEsueY9Xm6382wQLdyv9JXF2Al9X3/9CIB8=;
        b=BKkonpR8kC2e5Bfo0ZcyAWLH/5iCiedyaLy+S5lDLgXVITONH1cJcJrbICEX/HBr5J
         /ZE6z39TnMNvUp93VGOqe8FTiM9GfGSAJ91WRqD3MNXuFSAtO0+zZFLHbur5A/jD+zxt
         FI3oDL7p9ux5+GN4IxV4ULKQiCsuTY3iR/bny/yIobm53crJfkxO0AqwlIZGJXzeZPZl
         aphgzGLEWAaAQ6Dgy17gJTP01L990Up1q6+uW1PodFuMwSwhJqlejARsDdmsyqf6g1+A
         XB1wpXqYxg2EbIruBo0NHqsjWtAfZg0qzcLXQB2VsjFF3LWSw6WKFMYs4pvoOCfA3278
         YU4Q==
X-Gm-Message-State: APt69E0EecBf9b0UE6JBjlivTWFtsFewl12X+KuVHdgwYvLJhRWowiyZ
        br7zL9Fmjk+R4e/8AKyIazeZwBGl
X-Google-Smtp-Source: AAOMgpfvLRMk3M6Egq0+1A2P5CXI52cb+gk74QPoeVZcA6cf83TB0A8jgbCIRodz3aus86tNos4aWw==
X-Received: by 2002:a50:8b66:: with SMTP id l93-v6mr7466768edl.44.1530151633312;
        Wed, 27 Jun 2018 19:07:13 -0700 (PDT)
Received: from mail-wr0-f174.google.com (mail-wr0-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id v37-v6sm2798752edm.0.2018.06.27.19.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 19:07:12 -0700 (PDT)
Received: by mail-wr0-f174.google.com with SMTP id f16-v6so3813686wrm.3;
        Wed, 27 Jun 2018 19:07:12 -0700 (PDT)
X-Received: by 2002:adf:f98a:: with SMTP id f10-v6mr6932404wrr.105.1530151632556;
 Wed, 27 Jun 2018 19:07:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 19:06:52
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-11-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-11-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 10:06:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v66ndyhVFKsOt=g45MJ-cBun8WvRrDsb9XO2hteSX2oe5A@mail.gmail.com>
Message-ID: <CAGb2v66ndyhVFKsOt=g45MJ-cBun8WvRrDsb9XO2hteSX2oe5A@mail.gmail.com>
Subject: Re: [PATCH v3 10/24] drm/sun4i: tcon: Generalize engine search algorithm
To:     Jernej Skrabec <jernej.skrabec@siol.net>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Current "old" method to find engine worked pretty well for DE2. However,
> it doesn't work when TCON TOP is between  mixer (engine) and TCON. TCON
> TOP has multiple input ports, but current engine search algorithm
> expects only one.
>
> This can be fixed by first looking for output port id and selecting
> matching input by subtracting 1 for the next round. This work even if
> there is only one input and output.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 08747fc3ee71..264bcc43da11 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -791,12 +791,14 @@ static int sun4i_tcon_init_regmap(struct device *dev,
>   */
>  static struct sunxi_engine *
>  sun4i_tcon_find_engine_traverse(struct sun4i_drv *drv,
> -                               struct device_node *node)
> +                               struct device_node *node,
> +                               u32 port_id)
>  {
>         struct device_node *port, *ep, *remote;
>         struct sunxi_engine *engine = ERR_PTR(-EINVAL);
> +       u32 reg = 0;
>
> -       port = of_graph_get_port_by_id(node, 0);
> +       port = of_graph_get_port_by_id(node, port_id);
>         if (!port)
>                 return ERR_PTR(-EINVAL);
>
> @@ -826,8 +828,20 @@ sun4i_tcon_find_engine_traverse(struct sun4i_drv *drv,
>                 if (remote == engine->node)
>                         goto out_put_remote;
>
> +       /*
> +        * According to device tree binding input ports have even id
> +        * number and output ports have odd id. Since component with
> +        * more than one input and one output (TCON TOP) exits, correct
> +        * remote input id has to be calculated by subtracting 1 from
> +        * remote output id. If this for some reason can't be done, 0
> +        * is used as input port id.
> +        */

You need to call

    of_node_put(port);

to drop the reference to the original port.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> +       port = of_graph_get_remote_port(ep);
> +       if (!of_property_read_u32(port, "reg", &reg) && reg > 0)
> +               reg -= 1;
> +
>         /* keep looking through upstream ports */
> -       engine = sun4i_tcon_find_engine_traverse(drv, remote);
> +       engine = sun4i_tcon_find_engine_traverse(drv, remote, reg);
>
>  out_put_remote:
>         of_node_put(remote);
> @@ -950,7 +964,7 @@ static struct sunxi_engine *sun4i_tcon_find_engine(struct sun4i_drv *drv,
>
>         /* Fallback to old method by traversing input endpoints */
>         of_node_put(port);
> -       return sun4i_tcon_find_engine_traverse(drv, node);
> +       return sun4i_tcon_find_engine_traverse(drv, node, 0);
>  }
>
>  static int sun4i_tcon_bind(struct device *dev, struct device *master,
> --
> 2.18.0
>
