Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754025AbeBUMSX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:18:23 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:47290 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbeBUMSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:18:21 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
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
Subject: Re: [PATCH v4 04/16] of: changesets: Introduce changeset helper methods
Date: Wed, 21 Feb 2018 14:19:02 +0200
Message-ID: <2176862.3cxL0kyTvc@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAMuHMdVJfKXWNFaN259JQ1bOVZQSbC-=u4Kmys2PE+HLa=xQKw@mail.gmail.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com> <20180220231046.32638-5-laurent.pinchart+renesas@ideasonboard.com> <CAMuHMdVJfKXWNFaN259JQ1bOVZQSbC-=u4Kmys2PE+HLa=xQKw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wednesday, 21 February 2018 12:21:50 EET Geert Uytterhoeven wrote:
> On Wed, Feb 21, 2018 at 12:10 AM, Laurent Pinchart wrote:
> > From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> > 
> > Changesets are very powerful, but the lack of a helper API
> > makes using them cumbersome. Introduce a simple copy based
> > API that makes things considerably easier.
> > 
> > To wit, adding a property using the raw API.
> > 
> >         struct property *prop;
> >         prop = kzalloc(sizeof(*prop)), GFP_KERNEL);
> >         prop->name = kstrdup("compatible");
> >         prop->value = kstrdup("foo,bar");
> >         prop->length = strlen(prop->value) + 1;
> >         of_changeset_add_property(ocs, np, prop);
> > 
> > while using the helper API
> > 
> >         of_changeset_add_property_string(ocs, np, "compatible",
> >         
> >                         "foo,bar");
> > 
> > Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> > [Fixed memory leak in __of_changeset_add_update_property_copy()]
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> You missed one fix I have in my topic/overlays branch
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/co
> mmit/?h=topic/overlays&id=150f95b9dec77ce371c229f7ac4d6dd8620bef4a
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > 
> > +/**
> > + * of_changeset_add_property_u32 - Create a new u32 property
> > + *
> > + * @ocs:       changeset pointer
> > + * @np:                device node pointer
> > + * @name:      name of the property
> > + * @val:       value in host endian format
> > + *
> > + * Adds a u32 property to the changeset.
> > + *
> > + * Returns zero on success, a negative error value otherwise.
> > + */
> > +static inline int of_changeset_add_property_u32(struct of_changeset *ocs,
> > +               struct device_node *np, const char *name, u32 val)
> > +{
> > +       val = cpu_to_be32(val);
> 
> You must use an intermediate, to avoid complaints from sparse:
> 
>     __be32 x = cpu_to_be32(val);
> 
> > +       return __of_changeset_add_update_property_copy(ocs, np, name,
> > &val,
> > +                       sizeof(val), false);
> 
> s/val/x/

I'll fix both in the next version, thanks.

> > +}
> > +
> > +/**
> > + * of_changeset_update_property_u32 - Update u32 property
> > + *
> > + * @ocs:       changeset pointer
> > + * @np:                device node pointer
> > + * @name:      name of the property
> > + * @val:       value in host endian format
> > + *
> > + * Updates a u32 property to the changeset.
> > + *
> > + * Returns zero on success, a negative error value otherwise.
> > + */
> > +static inline int of_changeset_update_property_u32(
> > +       struct of_changeset *ocs, struct device_node *np,
> > +       const char *name, u32 val)
> > +{
> > +       val = cpu_to_be32(val);
> 
> Oh, a new one.
> 
> > +       return __of_changeset_add_update_property_copy(ocs, np, name,
> > &val,
> > +                       sizeof(val), true);
> > +}

-- 
Regards,

Laurent Pinchart
