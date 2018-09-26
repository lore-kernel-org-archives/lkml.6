Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E99C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AC921537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hp8K5uiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AC921537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeI0Ffs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:35:48 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41754 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0Ffs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:35:48 -0400
Received: by mail-yw1-f66.google.com with SMTP id q129-v6so310022ywg.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 16:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J4hnax56MWeBuquh4FUCFu79TGgJ3rZfC7klKDFSzWE=;
        b=Hp8K5uiSwrR07FSa5kIMrD64+v3ydwDDZ2hHUpzBVrelF6bUxasuumC8ylGESdh1fX
         ewl2tE3sCv0In1Hv7VxIo9Rw219sASTc0Oh0xbkLVWpKyci3+2ysVWnYeJMQ/1R+AqI7
         hQCtKsY0XS2cuhZvOfIUynlnzWD3HNXPra0hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J4hnax56MWeBuquh4FUCFu79TGgJ3rZfC7klKDFSzWE=;
        b=qlFI3DkakCR5lM50SbtSBiRhybaaHhbtBNjTuL1WwsmWdqISO9XPReeUDCa8/qjyma
         hnTm8DPodyz7LB63yIsjmqOfoW4MrZukWTwKBoUiMF+n6/JGmh4z9NGm7pQQwWj9DYxH
         xcTMR7y2cBRI5mQ1pv9TllFZbpyqfOfgD97zk1u1Q9oW/l6FtqOx3+0k/5OtGsxpJTIX
         hNqe/E5j7V6Pjyj6W1x0Z7CSIRgKiJUf0P4DC30WSaV8a6wNEQ0vE5dvei5HXw8g38Aj
         fJPOQped0vCpp7j82TvDyr6bF1FtcyMpAc7e6qFm+v4ddLCINB+3LSiOdvNHLN3zrpTU
         wIQA==
X-Gm-Message-State: ABuFfoj6qP49QwB1dcxZlYyqVMf7qRMK1TSP/9vRbyGje+ZSiMbN68/9
        27LDN0/HyCOEYBrNXK/GMr4hhyOAcq4=
X-Google-Smtp-Source: ACcGV60v/Q1Q7rTg9JfCcSU5zH7gZG5iAG2fdbgOVZCB9X8D4niqrfDQv15EGQLNw0VKOYI7Yj6Jtw==
X-Received: by 2002:a0d:e20d:: with SMTP id l13-v6mr4352608ywe.216.1538004029248;
        Wed, 26 Sep 2018 16:20:29 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id m1-v6sm146303ywf.96.2018.09.26.16.20.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 16:20:29 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id p206-v6so296748ywg.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 16:20:28 -0700 (PDT)
X-Received: by 2002:a81:2288:: with SMTP id i130-v6mr4508506ywi.288.1538003620110;
 Wed, 26 Sep 2018 16:13:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 16:13:39
 -0700 (PDT)
In-Reply-To: <20180924101150.23349-4-brgl@bgdev.pl>
References: <20180924101150.23349-1-brgl@bgdev.pl> <20180924101150.23349-4-brgl@bgdev.pl>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 26 Sep 2018 16:13:39 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+GGbRyQDU=TKKXb9EbRSczEJYqjTaDSsmeBeQn3Qdu_g@mail.gmail.com>
Message-ID: <CAGXu5j+GGbRyQDU=TKKXb9EbRSczEJYqjTaDSsmeBeQn3Qdu_g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] devres: provide devm_kstrdup_const()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 3:11 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> Provide a resource managed version of kstrdup_const(). This variant
> internally calls devm_kstrdup() on pointers that are outside of
> .rodata section and returns the string as is otherwise.
>
> Also provide a corresponding version of devm_kfree().
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/base/devres.c  | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/device.h |  3 +++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index 438c91a43508..48185d57bc5b 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -11,6 +11,8 @@
>  #include <linux/slab.h>
>  #include <linux/percpu.h>
>
> +#include <asm/sections.h>
> +
>  #include "base.h"
>
>  struct devres_node {
> @@ -822,6 +824,28 @@ char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp)
>  }
>  EXPORT_SYMBOL_GPL(devm_kstrdup);
>
> +/**
> + * devm_kstrdup_const - resource managed conditional string duplication
> + * @dev: device for which to duplicate the string
> + * @s: the string to duplicate
> + * @gfp: the GFP mask used in the kmalloc() call when allocating memory
> + *
> + * Strings allocated by devm_kstrdup_const will be automatically freed when
> + * the associated device is detached.
> + *
> + * RETURNS:
> + * Source string if it is in .rodata section otherwise it falls back to
> + * devm_kstrdup.
> + */
> +const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp)
> +{
> +       if (is_kernel_rodata((unsigned long)s))
> +               return s;
> +
> +       return devm_kstrdup(dev, s, gfp);
> +}
> +EXPORT_SYMBOL(devm_kstrdup_const);
> +
>  /**
>   * devm_kvasprintf - Allocate resource managed space and format a string
>   *                  into that.
> @@ -895,6 +919,20 @@ void devm_kfree(struct device *dev, const void *p)
>  }
>  EXPORT_SYMBOL_GPL(devm_kfree);
>
> +/**
> + * devm_kfree_const - Resource managed conditional kfree
> + * @dev: device this memory belongs to
> + * @p: memory to free
> + *
> + * Function calls devm_kfree only if @p is not in .rodata section.
> + */
> +void devm_kfree_const(struct device *dev, const void *p)
> +{
> +       if (!is_kernel_rodata((unsigned long)p))
> +               devm_kfree(dev, p);
> +}
> +EXPORT_SYMBOL(devm_kfree_const);
> +
>  /**
>   * devm_kmemdup - Resource-managed kmemdup
>   * @dev: Device this memory belongs to
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 33f7cb271fbb..79ccc6eb0975 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -693,7 +693,10 @@ static inline void *devm_kcalloc(struct device *dev,
>         return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
>  }
>  extern void devm_kfree(struct device *dev, const void *p);
> +extern void devm_kfree_const(struct device *dev, const void *p);

With devm_kfree and devm_kfree_const both taking "const", how are
devm_kstrdup_const() and devm_kfree_const() going to be correctly
paired at compile time? (i.e. I wasn't expecting the prototype change
to devm_kfree())

-Kees

>  extern char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
> +extern const char *devm_kstrdup_const(struct device *dev,
> +                                     const char *s, gfp_t gfp);
>  extern void *devm_kmemdup(struct device *dev, const void *src, size_t len,
>                           gfp_t gfp);
>
> --
> 2.18.0
>



-- 
Kees Cook
Pixel Security
