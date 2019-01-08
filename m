Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12448C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EDE206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MLyoBp9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfAHX6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:58:30 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46889 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAHX6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:58:30 -0500
Received: by mail-vs1-f66.google.com with SMTP id n10so3621844vso.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Rq1RR32Yo1OSw9ZEivGXt/TVRkkkDhP2USLpqLUiRU=;
        b=MLyoBp9eups2GG36uZK1GuxUMoQ00RfHRfBKCDKLMZr4j1vEtGL1gcgvOe37fa+PyG
         M3Z5Nd6X4NeDopxBG4i/WSPZpPcBY1H8A8G1oKiGFl9TdZKC2t8nkQrsOYVMU1mkjRAi
         SfsEkOry2WAbmsWrT0/MFKiSJK+TM/T19QhW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Rq1RR32Yo1OSw9ZEivGXt/TVRkkkDhP2USLpqLUiRU=;
        b=RnVQ4fVvV6TSVU+7zLmPlNmIii7Ww5kFRNsMQtxJQD+1TKhEAzNyiCnAaL9Ld0MAS8
         1bq+rnruzdebU0vYUuXL/Zde/D6Tb1UJtz0LL74gKK/cp5owOQR3an6VKU+fiENhsJ/x
         CGgk1/lMIegv2L7e5kBc/X3RP3Yk4NUOoUsg7UbWGwfikuXu/IRECM0FOKVpQPWcXXUl
         I0LsUirq/PvuecdoCC5fvlsBmVUk+6jZhdWv5IMUaGkw16bMcWo1JEH2Ols+MYjvvPbk
         xXuszGFBqTFcSFolO9g2VhcXSktuVkRqdVeI3ltqF/WPz3u7yMrGMrDSMPvgV5YFz75f
         LDbw==
X-Gm-Message-State: AJcUukeYfiEOFVH8osHh4gbe5LDMpixcXUSZU5JkwipOFdhUgU2Ru/YE
        s50MeBfCCIpyrNepOLqTLLCSAEaEZ+M=
X-Google-Smtp-Source: ALg8bN4WHt2FjIPlOVRM/Co+P5fFpGgwnLooG5HnUwU1IbezcKbGeG72Ettd7e+TM6K6mRbFF/QZkg==
X-Received: by 2002:a67:c31d:: with SMTP id r29mr1628781vsj.130.1546991907899;
        Tue, 08 Jan 2019 15:58:27 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id q193sm23667220vsd.0.2019.01.08.15.58.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 15:58:26 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id o130so1280636vke.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:58:26 -0800 (PST)
X-Received: by 2002:a1f:3d10:: with SMTP id k16mr1423433vka.13.1546991905899;
 Tue, 08 Jan 2019 15:58:25 -0800 (PST)
MIME-Version: 1.0
References: <20181226075449.11071-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20181226075449.11071-1-christophe.jaillet@wanadoo.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 8 Jan 2019 15:58:14 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKogPgKdL9kZEEbaNYL44LQ8o7EupDiwN+DE42JtckkHg@mail.gmail.com>
Message-ID: <CAGXu5jKogPgKdL9kZEEbaNYL44LQ8o7EupDiwN+DE42JtckkHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] um: vector: Use 'kmalloc_array' instead of 'kmalloc'
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
> Use 'kmalloc_array' instead of 'kmalloc' when appropriate.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

Richard, can you take these?

> ---
> I don't know why it has not already been replaced in 6da2ec56059c
> ("treewide: kmalloc() -> kmalloc_array()".

Hm, not sure. I'd guess it was from the ()s and some Coccinelle rule
missing handling that. I thought I caught them all. :P

> ---
>  arch/um/drivers/vector_kern.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 5b917716289d..dee5246bda81 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -507,12 +507,12 @@ static struct vector_queue *create_queue(
>                 return NULL;
>         result->max_depth = max_size;
>         result->dev = vp->dev;
> -       result->mmsg_vector = kmalloc(
> -               (sizeof(struct mmsghdr) * max_size), GFP_KERNEL);
> +       result->mmsg_vector = kmalloc_array(max_size, sizeof(struct mmsghdr),
> +                                           GFP_KERNEL);
>         if (result->mmsg_vector == NULL)
>                 goto out_mmsg_fail;
> -       result->skbuff_vector = kmalloc(
> -               (sizeof(void *) * max_size), GFP_KERNEL);
> +       result->skbuff_vector = kmalloc_array(max_size, sizeof(void *),
> +                                             GFP_KERNEL);
>         if (result->skbuff_vector == NULL)
>                 goto out_skb_fail;
>
> --
> 2.19.1
>


-- 
Kees Cook
