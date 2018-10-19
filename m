Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77723ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299E321476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qK/NpUos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299E321476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeJSNwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 09:52:45 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40395 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeJSNwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 09:52:45 -0400
Received: by mail-yb1-f193.google.com with SMTP id w7-v6so12816846ybm.7;
        Thu, 18 Oct 2018 22:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eb1sNu7vwkhAV8SYThQXrELMLdSP8J/VlT3hm+kXBzc=;
        b=qK/NpUosz+N9ASOTImq+A1qJklDPq3yUmFClxfk51wEq3dwJc9LdLqLRywz067bOzZ
         uKhXMlw1blIXP0eTewvTP6Ec8PQ1irSCZKC01jIFlq+LRf4t3JBmzmhWRkI7w8quonNo
         SETo+oOoyxaBWyliz/tnDMR31SAY+oWbWCB0UM+vON/vwGhoNjBMkcEtU7bmWjPtxjyb
         mogeTHx0IctCzhmtTOWwRhw5jr2RYSoy1S8Gy8JczvCWyT0QgfMIe+4uXs6+2ar5tEJt
         sAPFp538RmxwbFN7SQhhBXE+J9HtMAPxL6xEmn5Kvz59XKyg5h7C+9j95ptThQgzxxMT
         /SYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eb1sNu7vwkhAV8SYThQXrELMLdSP8J/VlT3hm+kXBzc=;
        b=bQiw6V/YNwe4F33TJWZ0i8Kll2S/rACXavhKAjKGSnmM/BJoAYi+sGjkVC8KMbBetc
         A7MTHPMV0cTt0T0IBzSP0VrvcL9rauUHNaZc6j/YOxcfySKUeD+WfEWGrd1TcATInFii
         OS/skGt2hGdMagXO8n+l+em/Su3yoYc6GlyB6isRwBKbqOg7TLiXPMQ3cd9hTH0fVsWp
         dv4FS78mE4Zm+mVHD+nqyO7SHr6DdvjS1SFKVT52vuiy+2Pe5tmfAIaig5HG8Hs0cJJN
         3829IDKJaGry94ooOXbtuVO7iwBVUuHZEpmatmwiXoMcGJNW0nKWS0cBu7p+SlVbbHhB
         /hHw==
X-Gm-Message-State: ABuFfojcaqzquJd5XJaIAmg7QmiNRgSTqlFlnzk0e3uf/jeucS5iY8K1
        /f3BKT9aSLGgE9bF5khhncQKC1ILup2pdz8xk2g=
X-Google-Smtp-Source: ACcGV63qthnU3XVxbvoGFzMx0ARva3JJADVgc4LcfrDJZy1BcaYoUBsyDpak7r3oL34vFfv55ViEHbIy/p44Er1EAcw=
X-Received: by 2002:a25:483:: with SMTP id 125-v6mr20609823ybe.280.1539928092180;
 Thu, 18 Oct 2018 22:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181019111805.28860f73@canb.auug.org.au>
In-Reply-To: <20181019111805.28860f73@canb.auug.org.au>
From:   Or Gerlitz <gerlitz.or@gmail.com>
Date:   Fri, 19 Oct 2018 08:48:00 +0300
Message-ID: <CAJ3xEMjgaWC=QrrgLGoXBd6ahwi3tbEbSfBoso+FFp1uB6dy5A@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        linux-next <linux-next@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Mark Bloch <markb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Paul Blakey <paulb@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 3:19 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the net-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/infiniband/hw/mlx5/flow.c: In function 'mlx5_ib_handler_MLX5_IB_METHOD_CREATE_FLOW':
> drivers/infiniband/hw/mlx5/flow.c:163:12: error: 'struct mlx5_flow_act' has no member named 'has_flow_tag'; did you mean 'flow_tag'?
>    flow_act.has_flow_tag = true;
>             ^~~~~~~~~~~~
>             flow_tag
>
> Caused by commit
>
>   d5634fee245f ("net/mlx5: Add a no-append flow insertion mode")
>
> interacting with commit
>
>   ba4a41198324 ("RDMA/mlx5: Add support for flow tag to raw create flow")
>
> from the rdma tree.
>
> I have applied the following merge fix patch for today:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 19 Oct 2018 11:10:39 +1100
> Subject: [PATCH] net/mlx5: fix up for has_flow_tag changing to a flag
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/infiniband/hw/mlx5/flow.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/flow.c b/drivers/infiniband/hw/mlx5/flow.c
> index e57435cb6d96..f86cdcafdafc 100644
> --- a/drivers/infiniband/hw/mlx5/flow.c
> +++ b/drivers/infiniband/hw/mlx5/flow.c
> @@ -160,7 +160,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
>                         ret = -EINVAL;
>                         goto err_out;
>                 }
> -               flow_act.has_flow_tag = true;
> +               flow_act.flags |= FLOW_ACT_HAS_TAG;
>         }
>
>         flow_handler = mlx5_ib_raw_fs_rule_add(dev, fs_matcher, &flow_act,


yeah, this is the correct resolution, thanks for addressing!
