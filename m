Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932981AbeBUKV5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:21:57 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34003 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932631AbeBUKVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:21:52 -0500
X-Google-Smtp-Source: AG47ELsa9eOZB7q+lxPhLROnxm/cK6g1fI2oN2hEP+TEx/1/np01nJzaLRmoYJZWMrdCTZcrCT0Kpy6klBdri5zSOOk=
MIME-Version: 1.0
In-Reply-To: <20180220231046.32638-5-laurent.pinchart+renesas@ideasonboard.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com> <20180220231046.32638-5-laurent.pinchart+renesas@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Feb 2018 11:21:50 +0100
X-Google-Sender-Auth: hssHMDE-t_z5XBxKm4JdIqPpmhs
Message-ID: <CAMuHMdVJfKXWNFaN259JQ1bOVZQSbC-=u4Kmys2PE+HLa=xQKw@mail.gmail.com>
Subject: Re: [PATCH v4 04/16] of: changesets: Introduce changeset helper methods
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Matt Porter <mporter@konsulko.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Wed, Feb 21, 2018 at 12:10 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
>
> Changesets are very powerful, but the lack of a helper API
> makes using them cumbersome. Introduce a simple copy based
> API that makes things considerably easier.
>
> To wit, adding a property using the raw API.
>
>         struct property *prop;
>         prop = kzalloc(sizeof(*prop)), GFP_KERNEL);
>         prop->name = kstrdup("compatible");
>         prop->value = kstrdup("foo,bar");
>         prop->length = strlen(prop->value) + 1;
>         of_changeset_add_property(ocs, np, prop);
>
> while using the helper API
>
>         of_changeset_add_property_string(ocs, np, "compatible",
>                         "foo,bar");
>
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> [Fixed memory leak in __of_changeset_add_update_property_copy()]
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

You missed one fix I have in my topic/overlays branch
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/commit/?h=topic/overlays&id=150f95b9dec77ce371c229f7ac4d6dd8620bef4a

> --- a/include/linux/of.h
> +++ b/include/linux/of.h

> +/**
> + * of_changeset_add_property_u32 - Create a new u32 property
> + *
> + * @ocs:       changeset pointer
> + * @np:                device node pointer
> + * @name:      name of the property
> + * @val:       value in host endian format
> + *
> + * Adds a u32 property to the changeset.
> + *
> + * Returns zero on success, a negative error value otherwise.
> + */
> +static inline int of_changeset_add_property_u32(struct of_changeset *ocs,
> +               struct device_node *np, const char *name, u32 val)
> +{
> +       val = cpu_to_be32(val);

You must use an intermediate, to avoid complaints from sparse:

    __be32 x = cpu_to_be32(val);

> +       return __of_changeset_add_update_property_copy(ocs, np, name, &val,
> +                       sizeof(val), false);

s/val/x/

> +}
> +
> +/**
> + * of_changeset_update_property_u32 - Update u32 property
> + *
> + * @ocs:       changeset pointer
> + * @np:                device node pointer
> + * @name:      name of the property
> + * @val:       value in host endian format
> + *
> + * Updates a u32 property to the changeset.
> + *
> + * Returns zero on success, a negative error value otherwise.
> + */
> +static inline int of_changeset_update_property_u32(
> +       struct of_changeset *ocs, struct device_node *np,
> +       const char *name, u32 val)
> +{
> +       val = cpu_to_be32(val);

Oh, a new one.

> +       return __of_changeset_add_update_property_copy(ocs, np, name, &val,
> +                       sizeof(val), true);
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
