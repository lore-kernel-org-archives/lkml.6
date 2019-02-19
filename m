Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02266C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C611621738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="z62YfArc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfBSQgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:36:36 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35873 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfBSQgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:36:35 -0500
Received: by mail-it1-f193.google.com with SMTP id h6so7729783itl.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 08:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fOTQ86NE8GSY6MHoe/MvhMiLDB3HABhTd81AyrO7PJE=;
        b=z62YfArcj++TWkWCd5ZXtjoj2WA9JMB+KMoBBWuDCClFBovwLZdMhM7YeDWQysQHHx
         iHMytDUzqyGY/SwhW7tO65A+Jhh2Nj21o7WvENPhXgSm9LJNg+h9Roppf252mJeMP5gm
         yAmht0yCdILJUDsvWqTMhsMr5pWS3GfrSurTdaqP4D21SFBoMWUmrxC2h+hKHabETvYr
         oaZV0pM2u+RleiF8/QUJlkCCosIWiS0GRQ0hbSRipfhcjvQnCKSwkOauvwUOg4h5dfqW
         GDoHCziGYEK/VFvq1nG5sKa0hOTsylxBe6Zr5KX+xJE511dBEWuU3wxLuz91mBxyzIUn
         KkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fOTQ86NE8GSY6MHoe/MvhMiLDB3HABhTd81AyrO7PJE=;
        b=sTEBUGaEcFdmoTaLDFJvB/WgNTfGI6wwUd5I/0PGk+KWIHn6DRvuRNV6uyPXO3lud/
         51hd0h9XQToof3xTgwT5+Nlz1SuDUaS7CF3nCX3CTIc7WlsKyDV0r/WUaME4j0vPLaur
         GNgNGgb91f/vykTcmNDaMaWoqzZb0A8iIJjyoIYHgMRpVbzwEhSFZWzDiMiySfESwqlJ
         9kCvrcQ6Not7vQmKJoUbBQhP9vedotRDcn2A3eUcD88nmwJIsAtekoPX4vMX6CmKx/Nq
         qavVZg3WzTfgtFjeiy7tZLEYmogmMJnJsSNRYYnuFwFFsrhVbv81h9fYbujy5vDtJ9IY
         4izg==
X-Gm-Message-State: AHQUAuaRrqa681fzVyXj0ooyeA/wcS+MQj0Hju365FLhxxe3bgmlTJhd
        kDSHMD3ospE5bWnjNMeiGQOhgNhz9TeFchvBORCTng==
X-Google-Smtp-Source: AHgI3Ia5Ql3zMgR0mBOy2uFIsH5ga+5uR2KbZp+DEk8cWYJUTm3uyvAB6O+cZvirdNWyzJcH89MamlUcc+3uMFA+aBE=
X-Received: by 2002:a5d:91d3:: with SMTP id k19mr17159916ior.258.1550594194250;
 Tue, 19 Feb 2019 08:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20190219160650.9614-1-brgl@bgdev.pl> <20190219160650.9614-2-brgl@bgdev.pl>
 <20190219161449.26e99a2b@why.wild-wind.fr.eu.org>
In-Reply-To: <20190219161449.26e99a2b@why.wild-wind.fr.eu.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 19 Feb 2019 17:36:23 +0100
Message-ID: <CAMRc=Md4UAYD-emar9yGnJCEnFDXkP2CR7HgjGedPoTPtYH5OQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] irq/irq_sim: add irq_set_type() callback
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 19 lut 2019 o 17:14 Marc Zyngier <marc.zyngier@arm.com> napisa=C5=82(a=
):
>
> On Tue, 19 Feb 2019 17:06:44 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Implement the irq_set_type() callback and call irqd_set_trigger_type()
> > internally so that users interested in the configured trigger type can
> > later retrieve it using irqd_get_trigger_type(). We only support edge
> > trigger types.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  kernel/irq/irq_sim.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> > index 98a20e1594ce..b992f88c5613 100644
> > --- a/kernel/irq/irq_sim.c
> > +++ b/kernel/irq/irq_sim.c
> > @@ -25,10 +25,22 @@ static void irq_sim_irqunmask(struct irq_data *data=
)
> >       irq_ctx->enabled =3D true;
> >  }
> >
> > +static int irq_sim_set_type(struct irq_data *data, unsigned int type)
> > +{
> > +     /* We only support rising and falling edge trigger types. */
> > +     if (type & ~IRQ_TYPE_EDGE_BOTH)
> > +             return -EINVAL;
> > +
> > +     irqd_set_trigger_type(data, type);
> > +
> > +     return 0;
> > +}
> > +
> >  static struct irq_chip irq_sim_irqchip =3D {
> >       .name           =3D "irq_sim",
> >       .irq_mask       =3D irq_sim_irqmask,
> >       .irq_unmask     =3D irq_sim_irqunmask,
> > +     .irq_set_type   =3D irq_sim_set_type,
> >  };
> >
> >  static void irq_sim_handle_irq(struct irq_work *work)
>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>

Thanks you! If you don't mind, I'll send this together with other
patches directly to Linus Walleij.

Bartosz
