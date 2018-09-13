Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04220C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D86220882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D86220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kobol.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeIMQYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:24:11 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:56585 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeIMQYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:24:11 -0400
X-Greylist: delayed 109733 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Sep 2018 12:24:09 EDT
X-Originating-IP: 209.85.216.169
Received: from mail-qt0-f169.google.com (mail-qt0-f169.google.com [209.85.216.169])
        (Authenticated sender: aditya@kobol.io)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BFEB620014;
        Thu, 13 Sep 2018 11:15:08 +0000 (UTC)
Received: by mail-qt0-f169.google.com with SMTP id h4-v6so4911008qtj.7;
        Thu, 13 Sep 2018 04:15:08 -0700 (PDT)
X-Gm-Message-State: APzg51BL/4pRicXC+TlW8RAiRvyMjPwJPBXeRdW0IObuF3BnTDsjLz2P
        TVDwHnBkElLA4Se3JRjKgnZm382ko9F1NCxEHAw=
X-Google-Smtp-Source: ANB0VdaNHJ6C64plegJ8VY3an7XQ7icHZk3cYFUyTEdqF27OQQD6O5dDinX8pWLspsYThIKZcv3eJFjo6D1n2BZCmZc=
X-Received: by 2002:ac8:690b:: with SMTP id e11-v6mr4820235qtr.214.1536837307630;
 Thu, 13 Sep 2018 04:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <1536727915-113932-1-git-send-email-aditya@kobol.io>
 <1536727915-113932-2-git-send-email-aditya@kobol.io> <20180912130102.GB24595@lunn.ch>
In-Reply-To: <20180912130102.GB24595@lunn.ch>
From:   Aditya Prayoga <aditya@kobol.io>
Date:   Thu, 13 Sep 2018 18:14:58 +0700
X-Gmail-Original-Message-ID: <CAFTRUBfceT3-nh3P+s_qP4_6ii_Owjjap2bCequOsxHOKrG0xg@mail.gmail.com>
Message-ID: <CAFTRUBfceT3-nh3P+s_qP4_6ii_Owjjap2bCequOsxHOKrG0xg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: mvebu: Add support for multiple PWM lines
 per GPIO chip
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-gpio@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>,
        ralph.sennhauser@gmail.com, gregory.clement@bootlin.com,
        Gauthier Provost <gauthier@kobol.io>,
        Dennis Gilmore <dennis@ausil.us>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 8:01 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> >  static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> >  {
> >       struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
> >       struct mvebu_gpio_chip *mvchip = mvpwm->mvchip;
> >       struct gpio_desc *desc;
> > +     struct mvebu_pwm *counter;
> >       unsigned long flags;
> >       int ret = 0;
> >
> >       spin_lock_irqsave(&mvpwm->lock, flags);
> >
> > -     if (mvpwm->gpiod) {
> > -             ret = -EBUSY;
> > -     } else {
> > -             desc = gpiochip_request_own_desc(&mvchip->chip,
> > -                                              pwm->hwpwm, "mvebu-pwm");
> > -             if (IS_ERR(desc)) {
> > -                     ret = PTR_ERR(desc);
> > +     counter = mvpwm;
> > +     if (counter->gpiod) {
> > +             counter = mvebu_pwm_get_avail_counter();
> > +             if (!counter) {
> > +                     ret = -EBUSY;
>
> I don't understand this bit of code. Please could you explain what is
> going on.
Check whether bank's default counter is already used. If it's used then
try to find and check other counter. If it also being used that mean both,
counter A and counter B, already assigned to some PWM device so
return EBUSY.

>
> >                       goto out;
> >               }
> >
> > -             ret = gpiod_direction_output(desc, 0);
> > -             if (ret) {
> > -                     gpiochip_free_own_desc(desc);
> > -                     goto out;
> > -             }
> > +             pwm->chip_data = counter;
> > +     }
> >
> > -             mvpwm->gpiod = desc;
> > +     desc = gpiochip_request_own_desc(&mvchip->chip,
> > +                                      pwm->hwpwm, "mvebu-pwm");
> > +     if (IS_ERR(desc)) {
> > +             ret = PTR_ERR(desc);
> > +             goto out;
> >       }
> > +
> > +     ret = gpiod_direction_output(desc, 0);
> > +     if (ret) {
> > +             gpiochip_free_own_desc(desc);
> > +             goto out;
> > +     }
> > +
> > +     regmap_update_bits(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF +
> > +                        mvchip->offset, BIT(pwm->hwpwm),
> > +                        counter->id ? BIT(pwm->hwpwm) : 0);
> > +     regmap_read(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF +
> > +                 mvchip->offset, &counter->blink_select);
> > +
> > +     counter->gpiod = desc;
> >  out:
> >       spin_unlock_irqrestore(&mvpwm->lock, flags);
> >       return ret;
> > @@ -632,6 +666,11 @@ static void mvebu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> >       struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
> >       unsigned long flags;
> >
> > +     if (pwm->chip_data) {
> > +             mvpwm = (struct mvebu_pwm *) pwm->chip_data;
> > +             pwm->chip_data = NULL;
> > +     }
> > +
> >       spin_lock_irqsave(&mvpwm->lock, flags);
> >       gpiochip_free_own_desc(mvpwm->gpiod);
> >       mvpwm->gpiod = NULL;
> > @@ -648,6 +687,9 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
> >       unsigned long flags;
> >       u32 u;
> >
> > +     if (pwm->chip_data)
> > +             mvpwm = (struct mvebu_pwm *) pwm->chip_data;
> > +
>
> You should not need a cast here, if chip_data is a void *.
>
> What is pwm->chip_data is a NULL? Don't you then use an uninitialized
> mvpwm?

mvpwm is declared and initialized as:
struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
so it's not an uninitialized variable.
pwm->chip_data is set when the pwm use counter other then default.
pwm->chip_data take precedence over to_mvebu_pwm(chip).

After looked at other PWM driver, i think i should use pwm_set_chip_data()
and pwm_get_chip_data() instead of directly access pwm->chip_data.

Now i think it would be better if i use
struct mvebu_pwm *mvpwm = pwm_get_chip_data(pwm);
and pwm_set_chip_data() would be called during mvebu_pwm_probe() to
set the data to bank's default counter.

Aditya

>         Andrew
