Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211BEC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CD32087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CD32087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeIXNmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:42:03 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42090 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeIXNmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:42:02 -0400
Received: by mail-ua1-f68.google.com with SMTP id w7-v6so7899970uan.9;
        Mon, 24 Sep 2018 00:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAy+4XAGynZsXsMJ7Bb2zxVPQ3Ox0Qbap7Ecu5LmvCg=;
        b=epwhy+GtysaAG2Utk40NRu0D8gr2QV4RZJH5jfI04Et25azquzZP7V9aVgzZZc3tgM
         oe33DDucctA7w6m4v3shCIQP62cq4DMzmq+OMRXxer8kk9+OdCGdQoQTZ0yFmRgiyn1q
         9UPK5TgA6OruPt9ETrWLYB1vEwfAFMdNCUmYymm3r8DeC9lwuHrz9W41oEpCcnwcDjaa
         kngaA6mvpqoCxoMoZUgGvlepchAZxqtP6gRUFL/N/YYf6/suNV0fqANkrLPoC+Sq8Tqp
         IyyyepWcg6/C6jR/TI0lzbdFNS/UPfOSPl136vrm2i2xOEGe0s3fU8RZ+0VsL6UX/WiB
         UzsQ==
X-Gm-Message-State: ABuFfohu+X6Lb6gUkKfzvuZmcSHqOASE0DUfhFrajtduC138rZj+/AF/
        ZodwSFuJo9TDjkVk4+Le72Zph7gXSYIEil+jZZQ=
X-Google-Smtp-Source: ACcGV627EwPoT1OvRVfam/8glgPl2ZEak2ssSyu0Pkpc5KpPgZdQSGld3FuhnqoHXy3plSO5HRRJyP3e7au/V9E65PU=
X-Received: by 2002:ab0:5a25:: with SMTP id l34-v6mr2304539uad.75.1537774875495;
 Mon, 24 Sep 2018 00:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537443710.git.michal.simek@xilinx.com>
In-Reply-To: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537443710.git.michal.simek@xilinx.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Sep 2018 09:41:03 +0200
Message-ID: <CAMuHMdW5zze-KJhK=diR-WKbhO_vsMV2b7WuLHmcT2FtRD4J7Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/2] of: base: Introduce of_alias_get_alias_list()
 to check alias IDs
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Thu, Sep 20, 2018 at 1:42 PM Michal Simek <michal.simek@xilinx.com> wrote:
> The function travels the lookup table to record alias ids for the given
> device match structures and alias stem.
> This function will be used by serial drivers to check if requested alias
> is allocated or free to use.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

I know this has already been applied, it just drew my attention.

> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -16,6 +16,7 @@
>
>  #define pr_fmt(fmt)    "OF: " fmt
>
> +#include <linux/bitmap.h>
>  #include <linux/console.h>
>  #include <linux/ctype.h>
>  #include <linux/cpu.h>
> @@ -1943,6 +1944,57 @@ int of_alias_get_id(struct device_node *np, const char *stem)
>  EXPORT_SYMBOL_GPL(of_alias_get_id);
>
>  /**
> + * of_alias_get_alias_list - Get alias list for the given device driver
> + * @matches:   Array of OF device match structures to search in
> + * @stem:      Alias stem of the given device_node
> + * @bitmap:    Bitmap field pointer
> + * @nbits:     Maximum number of alias ID which can be recorded it bitmap

IDs

> + *
> + * The function travels the lookup table to record alias ids for the given
> + * device match structures and alias stem.
> + *
> + * Return:     0 or -ENOSYS when !CONFIG_OF
> + */
> +int of_alias_get_alias_list(const struct of_device_id *matches,
> +                            const char *stem, unsigned long *bitmap,
> +                            unsigned int nbits)
> +{
> +       struct alias_prop *app;
> +
> +       /* Zero bitmap field to make sure that all the time it is clean */
> +       bitmap_zero(bitmap, nbits);
> +
> +       mutex_lock(&of_mutex);
> +       pr_debug("%s: Looking for stem: %s\n", __func__, stem);
> +       list_for_each_entry(app, &aliases_lookup, link) {
> +               pr_debug("%s: stem: %s, id: %d\n",
> +                        __func__, app->stem, app->id);
> +
> +               if (strcmp(app->stem, stem) != 0) {
> +                       pr_debug("%s: stem comparison doesn't passed %s\n",

didn't pass?

> +                                __func__, app->stem);
> +                       continue;
> +               }
> +
> +               if (app->id >= nbits) {
> +                       pr_debug("%s: ID %d greater then bitmap field %d\n",

than
%u for unsigned int

> +                               __func__, app->id, nbits);
> +                       continue;

Shouldn't this return an error, if of_match_node() below would have matched?

> +               }
> +
> +               if (of_match_node(matches, app->np)) {
> +                       pr_debug("%s: Allocated ID %d\n", __func__, app->id);
> +                       set_bit(app->id, bitmap);
> +               }
> +               /* Alias exist but it not compatible with matches */

exists but is npt

> +       }
> +       mutex_unlock(&of_mutex);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_alias_get_alias_list);
> +
> +/**
>   * of_alias_get_highest_id - Get highest alias id for the given stem
>   * @stem:      Alias stem to be examined
>   *

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
