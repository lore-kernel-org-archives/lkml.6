Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCC9C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E282820693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E282820693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeJHUXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:23:55 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33489 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeJHUXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:23:55 -0400
Received: by mail-ua1-f68.google.com with SMTP id j13so573989ual.0;
        Mon, 08 Oct 2018 06:12:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NTjJFOhBXLemeKgWauqiChdiCqLQZLvRXHNh9E7TCG0=;
        b=YzJtj1adITQv1+BRDYBjOIPqlHwEXFTK0Y7PT0vJawLsJ9BPHwmEcZQFlnq2yCgYCx
         LPOtDipYVBU6CoaryjlJCDmJe+vUtj5KwrN1vgoqe0UO1fLJRvuD++2JmqjRmkM/OM5A
         qiWtx2DG9QlZDvaVLBVyuN+MXr25ox6CTpAeikop+DF6mxozpHd4h2GWt7+Vy0/0mS+/
         c65gPCFGhkZTPJ1ZsdxHYwN5RMKIUpzO8lGKYZu5JMKDyOs2OAOd/gEKpku8iuuwNQA5
         rzoOpNMShXPI72rRhgaUYKnOb2pu598kDDBeaYsiyKPiNzviEjXBAMOn6OXfSP1fgqo4
         EtgQ==
X-Gm-Message-State: ABuFfog9AsIOhFDHvqVrOxUG+ESJRLA52Jm5E3qTZgE0aLToyxBHMD1h
        6vae+zDzzpSUBTMrZegCfOjfERxYXHPFKIJj63Q=
X-Google-Smtp-Source: ACcGV604TH/kLWonhMlZrnbxwwU+jzO1CQO9epeRnIGWDYjx0tzXS3ufZSeEgPXhDzr0eiYWyQhc5bC50vZeFQtyMV4=
X-Received: by 2002:ab0:6093:: with SMTP id i19mr2584040ual.75.1539004334269;
 Mon, 08 Oct 2018 06:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181008111435.25994-1-geert+renesas@glider.be> <1539003375.11512.19.camel@pengutronix.de>
In-Reply-To: <1539003375.11512.19.camel@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Oct 2018 15:12:02 +0200
Message-ID: <CAMuHMdU_ECQxxD1HK5bq5QY7QnxzaBKSJsZFw+284oSnJfSFAA@mail.gmail.com>
Subject: Re: [PATCH] reset: Fix potential use-after-free in __of_reset_control_get()
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Mon, Oct 8, 2018 at 2:56 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Mon, 2018-10-08 at 13:14 +0200, Geert Uytterhoeven wrote:
> > Calling of_node_put() decreases the reference count of a device tree
> > object, and may free some data.
> >
> > However, the of_phandle_args structure embedding it is passed to
> > reset_controller_dev.of_xlate() after that, so it may still be accessed.
> >
> > Move the call to of_node_put() down to fix this.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/reset/core.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > index 225e34c56b94a2e3..bc9df10d31b4bae1 100644
> > --- a/drivers/reset/core.c
> > +++ b/drivers/reset/core.c
> > @@ -496,27 +496,28 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
> >                       break;
> >               }
> >       }
> > -     of_node_put(args.np);
> >
> >       if (!rcdev) {
> > -             mutex_unlock(&reset_list_mutex);
> > -             return ERR_PTR(-EPROBE_DEFER);
> > +             rstc = ERR_PTR(-EPROBE_DEFER);
> > +             goto out;
> >       }
> >
> >       if (WARN_ON(args.args_count != rcdev->of_reset_n_cells)) {
> > -             mutex_unlock(&reset_list_mutex);
> > -             return ERR_PTR(-EINVAL);
> > +             rstc = ERR_PTR(-EINVAL);
> > +             goto out;
> >       }
> >
> >       rstc_id = rcdev->of_xlate(rcdev, &args);
> >       if (rstc_id < 0) {
> > -             mutex_unlock(&reset_list_mutex);
> > -             return ERR_PTR(rstc_id);
> > +             rstc = ERR_PTR(rstc_id);
> > +             goto out;
> >       }
> >
> >       /* reset_list_mutex also protects the rcdev's reset_control list */
> >       rstc = __reset_control_get_internal(rcdev, rstc_id, shared);
> >
> > +out:
> > +     of_node_put(args.np);
> >       mutex_unlock(&reset_list_mutex);
>
> Thank you for the patch. I'd like to move of_node_put after mutex_unlock
> for symmetry. If you agree, I can switch the two when applying.

No objection, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
