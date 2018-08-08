Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23621C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD14215FA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD14215FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kobol.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbeHHMvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:51:46 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:60008 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726745AbeHHMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:51:46 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 701DD3A6FBA;
        Wed,  8 Aug 2018 12:27:28 +0200 (CEST)
X-Originating-IP: 209.85.216.171
Received: from mail-qt0-f171.google.com (mail-qt0-f171.google.com [209.85.216.171])
        (Authenticated sender: aditya@kobol.io)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 53104FF80A;
        Wed,  8 Aug 2018 10:27:26 +0000 (UTC)
Received: by mail-qt0-f171.google.com with SMTP id n6-v6so1769443qtl.4;
        Wed, 08 Aug 2018 03:27:26 -0700 (PDT)
X-Gm-Message-State: AOUpUlGbX0yXbh0MIQhojSj/9rOrqaGlfeVuD/QGHO7gyZHQqmv29dR1
        C+uPiLwvutE8mXDirrK4QqJ4f6bp5qfvKBOu814=
X-Google-Smtp-Source: AA+uWPyVaCBkR30/X70vhfJkiOJZbP99cHoHbO78gvxYIixzCL1EwdTubMW3JwKxQlbGaMCM54XGAMbOqGifv4wwfJc=
X-Received: by 2002:a0c:9692:: with SMTP id a18-v6mr1873869qvd.16.1533724045196;
 Wed, 08 Aug 2018 03:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
 <1533522556-55055-2-git-send-email-aditya@kobol.io> <20180806033802.GA32450@lunn.ch>
In-Reply-To: <20180806033802.GA32450@lunn.ch>
From:   Aditya Prayoga <aditya@kobol.io>
Date:   Wed, 8 Aug 2018 17:27:16 +0700
X-Gmail-Original-Message-ID: <CAFTRUBcQ1Kj8sPVFv=mSc1hdcUOTj9GT8ZfZckNmvVwgJWPczA@mail.gmail.com>
Message-ID: <CAFTRUBcQ1Kj8sPVFv=mSc1hdcUOTj9GT8ZfZckNmvVwgJWPczA@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] gpio: mvebu: Add support for multiple PWM
 lines per GPIO chip
To:     andrew@lunn.ch
Cc:     linux-gpio@vger.kernel.org, richard.genoud@gmail.com,
        gregory.clement@bootlin.com, Gauthier Provost <gauthier@kobol.io>,
        alban.browaeys@gmail.com, thierry.reding@gmail.com,
        linus.walleij@linaro.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>,
        ralph.sennhauser@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 10:38 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 06, 2018 at 10:29:15AM +0800, Aditya Prayoga wrote:
>
> Hi Aditya
>
> > +     item = kzalloc(sizeof(*item), GFP_KERNEL);
> > +     if (!item)
> > +             return -ENODEV;
>
> ENOMEM would be better, since it is a memory allocation which is
> failing.
>
> >
> > -             ret = gpiod_direction_output(desc, 0);
> > -             if (ret) {
> > -                     gpiochip_free_own_desc(desc);
> > -                     goto out;
> > -             }
> > +     spin_lock_irqsave(&mvpwm->lock, flags);
> > +     desc = gpiochip_request_own_desc(&mvchip->chip,
> > +                                      pwm->hwpwm, "mvebu-pwm");
> > +     if (IS_ERR(desc)) {
> > +             ret = PTR_ERR(desc);
> > +             goto out;
> > +     }
> >
> > -             mvpwm->gpiod = desc;
> > +     ret = gpiod_direction_output(desc, 0);
> > +     if (ret) {
> > +             gpiochip_free_own_desc(desc);
> > +             goto out;
> >       }
> > +     item->gpiod = desc;
> > +     item->device = pwm;
> > +     INIT_LIST_HEAD(&item->node);
> > +     list_add_tail(&item->node, &mvpwm->pwms);
> >  out:
> >       spin_unlock_irqrestore(&mvpwm->lock, flags);
> >       return ret;
>
> You don't cleanup item on the error path.
>
> > @@ -630,12 +639,20 @@ static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> >  static void mvebu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> >  {
> >       struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
> > +     struct mvebu_pwm_item *item, *tmp;
> >       unsigned long flags;
> >
> > -     spin_lock_irqsave(&mvpwm->lock, flags);
> > -     gpiochip_free_own_desc(mvpwm->gpiod);
> > -     mvpwm->gpiod = NULL;
> > -     spin_unlock_irqrestore(&mvpwm->lock, flags);
> > +     list_for_each_entry_safe(item, tmp, &mvpwm->pwms, node) {
> > +             if (item->device == pwm) {
> > +                     spin_lock_irqsave(&mvpwm->lock, flags);
> > +                     gpiochip_free_own_desc(item->gpiod);
> > +                     item->gpiod = NULL;
> > +                     item->device = NULL;
>
> Since you are about to free item, these two lines are pointless.
>
> > +                     list_del(&item->node);
> > +                     spin_unlock_irqrestore(&mvpwm->lock, flags);
> > +                     kfree(item);
> > +             }
> > +     }
> >  }
>
>    Andrew

Hi Andrew,

Thanks, I will fix it on next version.

Regards,

Aditya
