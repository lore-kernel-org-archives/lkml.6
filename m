Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A4B13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E46420893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E46420893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeG3KaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:30:04 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:46805 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeG3KaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:30:04 -0400
Received: by mail-ua0-f194.google.com with SMTP id u11-v6so2604586uan.13;
        Mon, 30 Jul 2018 01:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvCQ7edsbYhJlOYLjjDa9s3rQv+dh0CEJfUkdPJvV68=;
        b=lxmrml31K3gKu3vaGSPCJNALq36Hy+ibuC3XxZQbuL3w7DdLElrKbW+RUc67Vetxjl
         ruiwWGbwKnnu54K7ODJ3AbsednHtKoOQxK6m8atAItI+5QI0rOL6l6jB7pPpm082ngRl
         OMJU2HXnVLd2tljwjOoySV8YuSVNIpYrmY9Jk5KTG1CLFYGRiYfSwZgaoHp4GgQ+cwvN
         wqanBZ/GP9qwZB1u1v0YoIIruhLFhly7M5XDACwKuFD/sLLnrY3GuX1vZx5RmDhqKlH8
         mm1ZL5PAnLAGZUmh0BP57laUAP1ESwjabR8TiJklIJ0D2mMPeczZu4NCzZ+HSynA5YJQ
         hlhw==
X-Gm-Message-State: AOUpUlGIKrqlFWqDcocUmRJGxwUA/HlpzdbPjHOSYTmaeZXE3xr9Fyr2
        0DPAy/094JhVcjuvk9aQ7MBnO71QHOvH5lhfqdg=
X-Google-Smtp-Source: AAOMgpcF80mFy82CyRmfYiTfC6zVDSaemnTHgE69IZ0D4ciU47LCwqalZfjiR7U5GyaY2CrC1ppoRTecqufcsnZ3Qa8=
X-Received: by 2002:ab0:5b57:: with SMTP id v23-v6mr11520706uae.72.1532940965371;
 Mon, 30 Jul 2018 01:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <1532939768-7018-1-git-send-email-phil.edworthy@renesas.com> <1532939768-7018-2-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1532939768-7018-2-git-send-email-phil.edworthy@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Jul 2018 10:55:53 +0200
Message-ID: <CAMuHMdUWWb7uyiG6NdRaJxM0X4JfioWx=o9J7jD18rgiTz1m4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: Add of_clk_get_by_name_optional() function
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Simon Horman <horms@verge.net.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Mon, Jul 30, 2018 at 10:36 AM Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> Quite a few drivers get an optional clock, e.g. a clock required
> to access peripheral's registers that is always enabled on some
> devices.
>
> This function behaves the same as of_clk_get_by_name() except that
> it will return NULL instead of -ENOENT. This makes error checking
> for users easier and allows clk_prepare_enable, etc to be called
> on the returned reference without additional checks.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Thanks for your patch!

> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -54,7 +54,8 @@ EXPORT_SYMBOL(of_clk_get);
>
>  static struct clk *__of_clk_get_by_name(struct device_node *np,
>                                         const char *dev_id,
> -                                       const char *name)
> +                                       const char *name,
> +                                       bool optional)
>  {
>         struct clk *clk = ERR_PTR(-ENOENT);
>
> @@ -73,6 +74,8 @@ static struct clk *__of_clk_get_by_name(struct device_node *np,
>                 if (!IS_ERR(clk)) {
>                         break;
>                 } else if (name && index >= 0) {
> +                       if (optional && PTR_ERR(clk) == -ENOENT)
> +                               clk = NULL;

This only handles the "name && index >= 0" case.
If that condition is never true, the loop will end, eventually, and the last
value of clk will be returned. Hence there should be a similar check at the
end of the function.

>                         if (PTR_ERR(clk) != -EPROBE_DEFER)
>                                 pr_err("ERROR: could not get clock %pOF:%s(%i)\n",
>                                         np, name ? name : "", index);

Hence if not found, this will always print an error, even if the clock is
optional?

> @@ -106,15 +109,38 @@ struct clk *of_clk_get_by_name(struct device_node *np, const char *name)
>         if (!np)
>                 return ERR_PTR(-ENOENT);
>
> -       return __of_clk_get_by_name(np, np->full_name, name);
> +       return __of_clk_get_by_name(np, np->full_name, name, false);
>  }
>  EXPORT_SYMBOL(of_clk_get_by_name);
>
> +/**
> + * of_clk_get_by_name_optional() - Parse and lookup an optional clock referenced
> + * by a device node
> + * @np: pointer to clock consumer node
> + * @name: name of consumer's clock input, or NULL for the first clock reference
> + *
> + * This function parses the clocks and clock-names properties,
> + * and uses them to look up the struct clk from the registered list of clock
> + * providers.
> + * It behaves the same as of_clk_get_by_name(), except when no clock is found.
> + * In this case, instead of returning -ENOENT, it returns NULL.
> + */
> +struct clk *of_clk_get_by_name_optional(struct device_node *np,
> +                                       const char *name)
> +{
> +       if (!np)
> +               return ERR_PTR(-ENOENT);

Shouldn't this return NULL?
Or let __of_clk_get_by_name() handle that (cfr. above)?

Hmm, of_clk_get_by_name() has a similar check, while the current
__of_clk_get_by_name() already handle np == NULL, too.

> +
> +       return __of_clk_get_by_name(np, np->full_name, name, true);
> +}
> +EXPORT_SYMBOL(of_clk_get_by_name_optional);
> +
>  #else /* defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK) */
>
>  static struct clk *__of_clk_get_by_name(struct device_node *np,
>                                         const char *dev_id,
> -                                       const char *name)
> +                                       const char *name,
> +                                       bool optional)
>  {
>         return ERR_PTR(-ENOENT);
>  }
> @@ -197,7 +223,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
>         struct clk *clk;
>
>         if (dev && dev->of_node) {
> -               clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id);
> +               clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id, false);
>                 if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
>                         return clk;
>         }
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 4f750c4..8cb5455 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -777,6 +777,7 @@ static inline void clk_bulk_disable_unprepare(int num_clks,
>  #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
>  struct clk *of_clk_get(struct device_node *np, int index);
>  struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
> +struct clk *of_clk_get_by_name_optional(struct device_node *np, const char *name);
>  struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
>  #else
>  static inline struct clk *of_clk_get(struct device_node *np, int index)

No dummy version of of_clk_get_by_name_optional() for the !CLK || !COMMON_CLK
case?

It seems of_clk_get_by_name() and of_clk_get_by_name_optional() can just
be simple wrappers around __of_clk_get_by_name(), differing only in the
value of the "optional" parameter. Hence I think it makes sense to move them
to the header file, and make them static inline.
Then only __of_clk_get_by_name() needs a (static inline) dummy for the !OF ||
!COMMON_CLK case.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
