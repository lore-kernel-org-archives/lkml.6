Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C04C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B839218A6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfAHIJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:09:32 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39807 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfAHIJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:09:31 -0500
Received: by mail-vs1-f68.google.com with SMTP id h78so1928303vsi.6;
        Tue, 08 Jan 2019 00:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7ck5DCb+VZNgJcju6gjm7DHemmCktYRlDSseC4D+/E=;
        b=lHeU9iukkmbem5E01ULt/8yoya3priJyVw8Ti3Iubbhf0oZ3GUEuHMJqAQm+Lvp91U
         cf7MeOaRWN9ZFms6EH//embyTVSYd2BJnm9REYYQ3g0sErQud4dZeN/5g3iQMmUWH0vI
         VQCXXyv8RaTAKWnJ/4xEQ0/K7TogHklLikkVX5bJUkToI3ameOnBkYyg2800uIhfN3d1
         xNAPwFGZoWa3HcU002NfdO3Ws/jQqYCqhauXalesTxmRJSVyzmCNeFquXBXuX/tfuVcg
         4K2s+suJ68FKl8o1Vne9hEKBQ62USMn+4j0/8Swbo/RA6f9z1WAHUXt8wTt5FwE67MLh
         0gkA==
X-Gm-Message-State: AJcUukdsn4YN2GBdKvqWcc1L9p0piT8yMumxaraGXjuL2Je38+2aIsT/
        MTLdsB6UNqY1Eb99FaDB06P6ETo1HtolIVI5UoE=
X-Google-Smtp-Source: ALg8bN7fyru5bRUbN5kwcri6k3YPpDXsjxuU+EfH5O4PdTtn/kSfcp3SK+sv0CKspv/5CoY/r2xOTMwtZZ4kq+RxdV4=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr332513vsm.152.1546934970241;
 Tue, 08 Jan 2019 00:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20190107175127.21240-1-geert+renesas@glider.be>
In-Reply-To: <20190107175127.21240-1-geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Jan 2019 09:09:18 +0100
Message-ID: <CAMuHMdXQqAaXBBAs6e4wJHWTjDTikXjzt3N0bMmAwSgyMqEcRw@mail.gmail.com>
Subject: Re: [RFC] device-tree: resets properties, reset topology, and shared resets
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Auger Eric <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 6:51 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -459,6 +459,42 @@ static void __reset_control_put_internal(struct reset_control *rstc)
>         kref_put(&rstc->refcnt, __reset_control_release);
>  }
>
> +static bool __of_reset_is_exclusive(const struct device_node *node,
> +                                   const struct of_phandle_args *args,
> +                                   const char *id)
> +{
> +       struct of_phandle_args args2;
> +       struct device_node *node2;
> +       int index, ret;
> +       bool eq;
> +
> +       for_each_node_with_property(node2, "resets") {
> +               if (node == node2)
> +                       continue;
> +
> +               for (index = 0; ; index++) {
> +                       ret = of_parse_phandle_with_args(node2, "resets",
> +                                                        "#reset-cells", index,
> +                                                        &args2);
> +                       if (ret)
> +                               break;
> +
> +                       eq = (args2.np == args.np &&
> +                             args2.args_count == args.args_count &&
> +                             !memcmp(args2.args, args.args,
> +                                     args.args_count * sizeof(args.args[0])));

This is embarrasing: as kbuild test robot pointed out, these should be
"args->" instead of "args.".

I failed to notice, as I have a local follow-up patch extracting this
comparison into a common helper.

Nevertheless, this doesn't change anything w.r.t. the principle behind
this patch.
Thanks again!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
