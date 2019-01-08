Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8EAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDDE206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UQnVCg2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfAHX64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:58:56 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45865 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAHX64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:58:56 -0500
Received: by mail-vs1-f66.google.com with SMTP id x28so3625849vsh.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D12Busqs0cpAq4JPnmNc/P2HdhaEpP7WoJt9GZgEn30=;
        b=UQnVCg2G9OP5YZIF8ztfUcIlMuY73QF6LvkoYCn2peqSYN8CReLA4qX2m3O/BhoEb/
         ZV/f+jm6wbe8hW939mHxD2xAHAuDkFmeFeXE6lOaO3/kVQ59wgcDO+tz3NvFnq0ImUuD
         fJUFBAWET6oUs6Z9bTdZ0knSVHVjdpcho/Idk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D12Busqs0cpAq4JPnmNc/P2HdhaEpP7WoJt9GZgEn30=;
        b=Qo1eNQlkzBRWnlNtlEFajlP4ZiaUgR1HKMCiyVuW198H1lbO/qoGaJbORr2hWcFLyx
         ZaVJDGbcaKU4VIR9A6dERQec68z75GLwlsNnkikNlawdy12Cxdv6mwgMCaBmICIl5fRm
         e3tYefKSG+uMA7+5dIh61nvxQQ40+yjjNe5uC3C9YlD9HhadhguKUrogjQjz5uEw7aJK
         mPDgmgsB3yLBYwNPXCV1C6Ue8K3u7FVDAoM2El34FUvv/wL+iukQkOcRRUPQsW8Jx1H0
         A52JRWRaJLzQYj3+sl9bnIsvYum+5J1tsGfRCtv+45lsCvrld7TIhEw12lGXSCliDp+a
         yIlw==
X-Gm-Message-State: AJcUukc2NNJwSMxqIy1SM9zV2Y5LZxxfEdQ1/sBo/8iSbZA1HHJaeaWu
        2GbZIB4UAfwb/fijISe1MCHy6inegug=
X-Google-Smtp-Source: ALg8bN5iNGhAA05eD7EtQa5LfJQzgnovyCU1E1NjkV4K3uOdwjaOrJQUJSLgnYloRKnbrcpRufVsig==
X-Received: by 2002:a67:81d2:: with SMTP id c201mr1585290vsd.240.1546991933927;
        Tue, 08 Jan 2019 15:58:53 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id x66sm19563289vkx.23.2019.01.08.15.58.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 15:58:52 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id w72so1288984vkd.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:58:51 -0800 (PST)
X-Received: by 2002:a1f:a8c5:: with SMTP id r188mr1421446vke.44.1546991931435;
 Tue, 08 Jan 2019 15:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20181226075436.11018-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20181226075436.11018-1-christophe.jaillet@wanadoo.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 8 Jan 2019 15:58:40 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKhBmBX90aXi3J57cVAZ2aSrRggzwNpvfnxYufZLoYCeA@mail.gmail.com>
Message-ID: <CAGXu5jKhBmBX90aXi3J57cVAZ2aSrRggzwNpvfnxYufZLoYCeA@mail.gmail.com>
Subject: Re: [PATCH 1/2] um: vector: Fix a potential NULL pointer dereference
 in 'vector_net_open()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-um@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 1:57 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'create_queue()' returns NULL in case of memory allocation failure. So we
> must check if it succeeds in order to avoid potential NULL pointer
> dereference.
>
> For 'vp->rx_queue', the dereference would occur just one line after the
> failed allocation. For 'vp->tx_queue', it would occur later during normal
> processing.
>
> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/um/drivers/vector_kern.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 046fa9ea0ccc..5b917716289d 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1182,6 +1182,8 @@ static int vector_net_open(struct net_device *dev)
>                         vp->rx_header_size,
>                         MAX_IOV_SIZE
>                 );
> +               if (!vp->rx_queue)
> +                       goto out_close;
>                 vp->rx_queue->queue_depth = get_depth(vp->parsed);
>         } else {
>                 vp->header_rxbuffer = kmalloc(
> @@ -1198,6 +1200,8 @@ static int vector_net_open(struct net_device *dev)
>                         vp->header_size,
>                         MAX_IOV_SIZE
>                 );
> +               if (!vp->tx_queue)
> +                       goto out_close;
>         } else {
>                 vp->header_txbuffer = kmalloc(vp->header_size, GFP_KERNEL);
>                 if (vp->header_txbuffer == NULL)
> --
> 2.19.1
>


-- 
Kees Cook
