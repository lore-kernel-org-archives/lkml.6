Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbeFEQVt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:21:49 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42160 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeFEQVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:21:47 -0400
X-Google-Smtp-Source: ADUXVKLrU6II8S+uMImQ8y90rASeD9HT+ok/GwOLwdYPAgC0Blx02Z6/Mz5km2befm23TFPd2c4QfsBErWwH3SMkBIg=
MIME-Version: 1.0
In-Reply-To: <1526907189-10031-1-git-send-email-sudeep.holla@arm.com>
References: <1526898749-17263-1-git-send-email-sudeep.holla@arm.com> <1526907189-10031-1-git-send-email-sudeep.holla@arm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 19:21:46 +0300
Message-ID: <CAHp75Vd_rQFX1s6jCbj-uLC3K70sSD=s0rt3sWme_f2m90NE5A@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: base: cacheinfo: use OF property_read_u32
 instead of get_property,read_number
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 3:53 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> of_property_read_u32 searches for a property in a device node and read
> a 32-bit value from it. Instead of using of_get_property to get the
> property and then read 32-bit value using of_read_number, we can
> simplify it by using of_property_read_u32.
>

LGTM.
Thanks!

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/cacheinfo.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>
> Hi Andy,
>
> Ignore my comment on compile errors error with Werror=incompatible-pointer-types
> I was so hung up on _u64 version and didn't realise that we were using 32-bit
> with of_read_number originally.
>
> Regards,
> Sudeep
>
> v1->v2:
>         - Replaced use of of_property_read_u64 with of_property_read_u32
>         - Also removed the local variables as Andy initially suggested
>
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 2880e2ab01f5..5d5b5988e88b 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -74,52 +74,48 @@ static inline int get_cacheinfo_idx(enum cache_type type)
>  static void cache_size(struct cacheinfo *this_leaf, struct device_node *np)
>  {
>         const char *propname;
> -       const __be32 *cache_size;
>         int ct_idx;
>
>         ct_idx = get_cacheinfo_idx(this_leaf->type);
>         propname = cache_type_info[ct_idx].size_prop;
>
> -       cache_size = of_get_property(np, propname, NULL);
> -       if (cache_size)
> -               this_leaf->size = of_read_number(cache_size, 1);
> +       if (of_property_read_u32(np, propname, &this_leaf->size))
> +               this_leaf->size = 0;
>  }
>
>  /* not cache_line_size() because that's a macro in include/linux/cache.h */
>  static void cache_get_line_size(struct cacheinfo *this_leaf,
>                                 struct device_node *np)
>  {
> -       const __be32 *line_size;
>         int i, lim, ct_idx;
>
>         ct_idx = get_cacheinfo_idx(this_leaf->type);
>         lim = ARRAY_SIZE(cache_type_info[ct_idx].line_size_props);
>
>         for (i = 0; i < lim; i++) {
> +               int ret;
> +               u32 line_size;
>                 const char *propname;
>
>                 propname = cache_type_info[ct_idx].line_size_props[i];
> -               line_size = of_get_property(np, propname, NULL);
> -               if (line_size)
> +               ret = of_property_read_u32(np, propname, &line_size);
> +               if (!ret) {
> +                       this_leaf->coherency_line_size = line_size;
>                         break;
> +               }
>         }
> -
> -       if (line_size)
> -               this_leaf->coherency_line_size = of_read_number(line_size, 1);
>  }
>
>  static void cache_nr_sets(struct cacheinfo *this_leaf, struct device_node *np)
>  {
>         const char *propname;
> -       const __be32 *nr_sets;
>         int ct_idx;
>
>         ct_idx = get_cacheinfo_idx(this_leaf->type);
>         propname = cache_type_info[ct_idx].nr_sets_prop;
>
> -       nr_sets = of_get_property(np, propname, NULL);
> -       if (nr_sets)
> -               this_leaf->number_of_sets = of_read_number(nr_sets, 1);
> +       if (of_property_read_u32(np, propname, &this_leaf->number_of_sets))
> +               this_leaf->number_of_sets = 0;
>  }
>
>  static void cache_associativity(struct cacheinfo *this_leaf)
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
