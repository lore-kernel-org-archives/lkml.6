Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E362C63685
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6E6204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUljuw5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6E6204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeINAED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:04:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728054AbeINAED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:04:03 -0400
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com [209.85.216.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D93C520881;
        Thu, 13 Sep 2018 18:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536864797;
        bh=OCF47b1SCCgXQmRJpWT+Aw08WChat+m+RUxJrMv2HqU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fUljuw5DLv52OBjqBUZUK73ndiIxFZqW6U8S+wKI5TgxX5B22eaZkj586lJnh3MKo
         Uu6ihx2wndWclAtox+hpIDnJ8w6XUpXajpmxKwjFLRyfaYRNEJs/9PFD38/AQ9U+Ks
         WmQ05MRk93qLI+F704kX4m99S5DLiGH4Qh/QuXno=
Received: by mail-qt0-f179.google.com with SMTP id g53-v6so6389135qtg.10;
        Thu, 13 Sep 2018 11:53:16 -0700 (PDT)
X-Gm-Message-State: APzg51AiOjzjm1XuoWS+qV35a5E+XIXP2f4ZkwB+DhppzwogxLVv2XkP
        uExJDLw8yeaHNqgfyIYl14tK9VL3DPE6Hm/peQ==
X-Google-Smtp-Source: ANB0VdZ0mJkt6+qd/iAt6zGWFKups27BrBjx7leVBFIlEmHzyRiB8rWIpd3T8BJ12BpP3hRjHCcyEYNCwwt11WU3uHo=
X-Received: by 2002:ac8:46d3:: with SMTP id h19-v6mr6249502qto.188.1536864796052;
 Thu, 13 Sep 2018 11:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <0ee4683a7d3927c2ef20b1e106720e6154811cd7.1535980468.git.michal.simek@xilinx.com>
In-Reply-To: <0ee4683a7d3927c2ef20b1e106720e6154811cd7.1535980468.git.michal.simek@xilinx.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 13 Sep 2018 13:53:03 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+yzot-NUEYGKW7jQFkFdi3O75j-3fTB0VZ_o+13J6pTA@mail.gmail.com>
Message-ID: <CAL_Jsq+yzot-NUEYGKW7jQFkFdi3O75j-3fTB0VZ_o+13J6pTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] of: base: Introduce of_alias_check_id() to check
 alias IDs
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 8:14 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> The function travers the lookup table to check if the request alias
> id is compatible with the device driver match structure.
> This function will be used by serial drivers to check if requested alias
> is allocated or free to use.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> Based on discussion with Rob
> https://lkml.org/lkml/2018/4/27/397
> nbits is passed to the function not to limit only to 32/64bit fields.
>
> ---
>  drivers/of/base.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h |  3 +++
>  2 files changed, 51 insertions(+)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 466e3c8582f0..236a85d69957 100644
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
> @@ -1893,6 +1894,53 @@ int of_alias_get_id(struct device_node *np, const char *stem)
>  EXPORT_SYMBOL_GPL(of_alias_get_id);
>
>  /**
> + * of_alias_get_alias_list - Get alias list for the given device driver
> + * @matches:   Array of OF device match structures to search in
> + * @stem:      Alias stem of the given device_node
> + * @bitmap:    Bitmap field pointer
> + * @nbits:     Maximum number of alias ID which can be recorded it bitmap
> + *
> + * The function travels the lookup table to record alias ids for the given
> + * device match structures and alias stem.
> + */
> +void of_alias_get_alias_list(const struct of_device_id *matches,
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
> +                                __func__, app->stem);
> +                       continue;
> +               }
> +
> +               if (app->id >= nbits) {
> +                       pr_debug("%s: ID %d greater then bitmap field %d\n",
> +                               __func__, app->id, nbits);
> +                       continue;
> +               }
> +
> +               if (of_match_node(matches, app->np)) {
> +                       pr_debug("%s: Allocated ID %d\n", __func__, app->id);
> +                       set_bit(app->id, bitmap);
> +               }
> +               /* Alias exist but it not compatible with matches */
> +       }
> +       mutex_unlock(&of_mutex);
> +}
> +EXPORT_SYMBOL_GPL(of_alias_get_alias_list);
> +
> +/**
>   * of_alias_get_highest_id - Get highest alias id for the given stem
>   * @stem:      Alias stem to be examined
>   *
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 4d25e4f952d9..e474710e3930 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -387,6 +387,9 @@ extern int of_phandle_iterator_args(struct of_phandle_iterator *it,
>  extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
>  extern int of_alias_get_id(struct device_node *np, const char *stem);
>  extern int of_alias_get_highest_id(const char *stem);
> +extern void of_alias_get_alias_list(const struct of_device_id *matches,
> +                                   const char *stem, unsigned long *bitmap,
> +                                   unsigned int nbits);

You should go ahead and add an empty function too as the other 2 alias
functions have one.

With that, I'm assuming this is going with your serial patches:

Reviewed-by: Rob Herring <robh@kernel.org>
