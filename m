Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38521C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117C72087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfB0Kxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:53:42 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35103 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfB0Kxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:53:41 -0500
Received: by mail-ua1-f67.google.com with SMTP id f88so14904489uaf.2;
        Wed, 27 Feb 2019 02:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NuTIOVOuY7I7P7hxVe+SwtAhqXFMqR8h72mwBUMo7PU=;
        b=uQ673d1ldAFqhwZgagYQlnVTQawR0ZQHAGbg4W2irHdIbn5w+hEnCUGZb+mID7hk85
         dSE8wunBhXmgAXhjLyyFvr8CgzCP0yrNHsr35O6E5VkLemxUxy152ubrOSD0Ybk4gRHW
         iVrrpwRrZfuj76Tcl8mmR0EeC4dKG6UKEPUMO9lk2WOgM7BK4wE2nlGWA11hdjT/CI1x
         jnW7KL5ECfN5POvI7ZBmL8D/h4oOOdj8pjAIDeCCch/af5vMgiBOFQO5yFoVZaYyNTbq
         OutW2ZbNUiPQLjNOG28C+M/C9ETn4wR82yqKexFIOLfDR7Uaaoy1qL9HdQqjMxZM+SSW
         DUwQ==
X-Gm-Message-State: AHQUAuaAvl7+a/ulAAv3e1FxN0+HjuojcTWgVVxM38ravIVILnWRGKry
        E0JaJ8RFsPGbM706dfqg1rCkPkDiTp7xAOYfhtU=
X-Google-Smtp-Source: APXvYqyfeoIG8f2ZcWyzxOfVBBhyxtwBWT9+fQns5TmJPu858m43fVEKZ27Li3vKpUd5I9tcSOYGO8B5pnD2f4ofCpk=
X-Received: by 2002:ab0:6950:: with SMTP id c16mr1728626uas.0.1551264820013;
 Wed, 27 Feb 2019 02:53:40 -0800 (PST)
MIME-Version: 1.0
References: <1551250826-10302-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <alpine.DEB.2.21.1902270920300.2671@hadrien> <TY2PR01MB4812FABCB851C22F4295B9D4D8740@TY2PR01MB4812.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB4812FABCB851C22F4295B9D4D8740@TY2PR01MB4812.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Feb 2019 11:53:28 +0100
Message-ID: <CAMuHMdVe6DB1eHg1VVLqsx5-Y-pnVup535XGLpBrR=UwY-1viQ@mail.gmail.com>
Subject: Re: [PATCH] phy: renesas: rcar-gen2: Fix memory leak at error paths
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shimoda-san,

On Wed, Feb 27, 2019 at 9:53 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Julia Lawall, Sent: Wednesday, February 27, 2019 5:25 PM
> > On Wed, 27 Feb 2019, Yoshihiro Shimoda wrote:
> > > This patch fixes memory leak at error paths of the probe function.
> > > In for_each_child_of_node, if the loop returns, the driver should
> > > call of_put_node() before returns.
> > >
> > > Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> > > Fixes: 1233f59f745 ("phy: Renesas R-Car Gen2 PHY driver")
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > ---
> > >  drivers/phy/renesas/phy-rcar-gen2.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/phy/renesas/phy-rcar-gen2.c b/drivers/phy/renesas/phy-rcar-gen2.c
> > > index 72eeb06..570b4e4 100644
> > > --- a/drivers/phy/renesas/phy-rcar-gen2.c
> > > +++ b/drivers/phy/renesas/phy-rcar-gen2.c
> > > @@ -285,6 +285,7 @@ static int rcar_gen2_phy_probe(struct platform_device *pdev)
> > >             error = of_property_read_u32(np, "reg", &channel_num);
> > >             if (error || channel_num > 2) {
> > >                     dev_err(dev, "Invalid \"reg\" property\n");
> > > +                   of_node_put(np);
> > >                     return error;
> > >             }
> > >             channel->select_mask = select_mask[channel_num];
> > > @@ -300,6 +301,7 @@ static int rcar_gen2_phy_probe(struct platform_device *pdev)
> > >                                                &rcar_gen2_phy_ops);
> > >                     if (IS_ERR(phy->phy)) {
> > >                             dev_err(dev, "Failed to create PHY\n");
> > > +                           of_node_put(np);
> > >                             return PTR_ERR(phy->phy);
> > >                     }
> > >                     phy_set_drvdata(phy->phy, phy);
> >
> > Hello,
> >
> > I was concerned about the assignment channel->of_node = np;.  Because
> > channels is allocated with a devm function, it will get freed on an error
> > return, so this pointer doesn't matter.  But don't you need an of_node_get
> > on this assignment?  Does the fact that you haven't seen a problem with
> > this in testing mean that the field is actually never accessed?
>
> The channel->of_node will be used in the rcar_gen2_phy_xlate() as drv->channels[i].of_node.
> The assignment is not used for any device tree APIs, just comparing the pointer.
> So, I don't think this driver needs an of_node_get() on this assignment.
> Is my understanding incorrect?
>
> ---
> static struct phy *rcar_gen2_phy_xlate(struct device *dev,
>                                        struct of_phandle_args *args)
> {
>         struct rcar_gen2_phy_driver *drv;
>         struct device_node *np = args->np;
>         int i;
>
>         drv = dev_get_drvdata(dev);
>         if (!drv)
>                 return ERR_PTR(-EINVAL);
>
>         for (i = 0; i < drv->num_channels; i++) {
>                 if (np == drv->channels[i].of_node)     // <--- here only
>                         break;
>         }
>
>         if (i >= drv->num_channels || args->args[0] >= 2)
>                 return ERR_PTR(-ENODEV);
>
>         return drv->channels[i].phys[args->args[0]].phy;
> }

I think that is OK.
You could mark rcar_gen2_channel.o_node const to indicate this, but I
don't think that matters much.

To make it really safe for future extension, you could call of_node_get().
However, then you have to make sure of_node_put() is always called later,
in driver remove and in all probe error paths, complicating the code.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
