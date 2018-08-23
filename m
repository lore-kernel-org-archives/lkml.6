Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434FFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6D421557
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IFMjWgBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6D421557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeHWVOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:14:31 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44002 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeHWVOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:14:31 -0400
Received: by mail-yw1-f68.google.com with SMTP id l189-v6so2264977ywb.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QY1lH/N3MSTVgyfE/7bddl2ZK9bnJ4OVyKzVjpFys6A=;
        b=IFMjWgBcQSrR9h6qB2ySilCAAkeoeXDCVPVgZE5jqAen1uP18UYMaaXiUBdqBRFShZ
         ZSh3kl1UlISGrls663DIoESvVSzkcedN/S9/58Q4RSSzSPPFNP8afgcnbCCErkSc0K8/
         FpcqLGqQNGsj5Lb4uASYO4PcLaAgqTJVzDElQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QY1lH/N3MSTVgyfE/7bddl2ZK9bnJ4OVyKzVjpFys6A=;
        b=fUQ5Jk06DijWrQcVXv9cx0nFy0ncwJkBQ15eSo7bjmF+r4SkGjqz5sBgT8tvMUlBca
         QFBu7HEmLn7MV5jvADOcZAF9lm1AOC7Crnaq+cMoikVdVvKh1pel/HGe+D+Sa6NM8e+j
         Br+T4+/e9HZmPQjvcUy1qmIegpCDXEcHOZQJuIF/YHGwCwjzsmHzI/21D95cXjrlinMb
         TgEjlwKnztwriTXBhcTf1aM0SHWDeMX5ytgddXWOhEj2KsrJRxjmVPLLg2KZlm2+MpTe
         o5kdLz8x3GSlCRiOMlstIPrWx0+adLOoc5PAcG6nrbSX+yujyYeJ2oP6Js4GJs3KiT4B
         sP0A==
X-Gm-Message-State: APzg51D/HtSM5dp5+JRVLumPk9b+xY+JXx0z0BP+ilnVg+lc07Sr1rbr
        mtpMpl3LblXUYHuydZP9oqye2q3yCtw=
X-Google-Smtp-Source: ANB0VdbRjmGW9L+kelwqKC/9B21zmuQiUq8F38Ph8GwPJgIy/VnXoUwpAr8LgRT5E6l6uUABrF/zrQ==
X-Received: by 2002:a81:4c12:: with SMTP id z18-v6mr3453728ywa.161.1535046223271;
        Thu, 23 Aug 2018 10:43:43 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id d70-v6sm3690114ywe.97.2018.08.23.10.43.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 10:43:42 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id n207-v6so2267462ywn.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:43:42 -0700 (PDT)
X-Received: by 2002:a81:9b85:: with SMTP id s127-v6mr3379434ywg.47.1535046221725;
 Thu, 23 Aug 2018 10:43:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 10:43:41
 -0700 (PDT)
In-Reply-To: <20180823173125.GA24762@embeddedor.com>
References: <20180823173125.GA24762@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 23 Aug 2018 10:43:41 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJY71FoVrQBXZ=Vx1O90bL3BoyAVBwugfh4XJL84=my0Q@mail.gmail.com>
Message-ID: <CAGXu5jJY71FoVrQBXZ=Vx1O90bL3BoyAVBwugfh4XJL84=my0Q@mail.gmail.com>
Subject: Re: [PATCH] usb: iowarrior: replace kmalloc with kmalloc_array
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 10:31 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> A common flaw in the kernel is integer overflow during memory allocation
> size calculations. In an effort to reduce the frequency of these bugs,
> kmalloc_array was implemented, which allocates memory for an array,
> while at the same time detects integer overflow.
>
> This patch replaces cases of:
>
> kmalloc(a * b, gfp)
>
> with:
>         kmalloc_array(a * b, gfp)

nit: this should be "kmalloc_array(a, b, gfp)" (This was a typo from
my treewide commit message... :P)

> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/usb/misc/iowarrior.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
> index c2991b8..7a22400 100644
> --- a/drivers/usb/misc/iowarrior.c
> +++ b/drivers/usb/misc/iowarrior.c
> @@ -808,7 +808,7 @@ static int iowarrior_probe(struct usb_interface *interface,
>                          dev->int_in_endpoint->bInterval);
>         /* create an internal buffer for interrupt data from the device */
>         dev->read_queue =
> -           kmalloc(((dev->report_size + 1) * MAX_INTERRUPT_BUFFER),
> +           kmalloc_array(dev->report_size + 1, MAX_INTERRUPT_BUFFER,
>                     GFP_KERNEL);

For this patch with the commit log updated:

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
