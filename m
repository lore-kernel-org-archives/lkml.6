Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1226AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7CB20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544097575;
	bh=GLNI3V7OWlsBjpdfkkg5ruwoHYTSysEbRDy8GHiz/sg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LLWF3S+MrDrKATx11bfnfjEfY/lrl/Z2mAEctu24T1XoIwjbTlySX27CthuQ3uNyX
	 WKmg1Va1jC+QcPNGlBGIYPYtfyo48PFJ1R065O7CYQoYVoosXYculxyaJ4j4/zd7W+
	 XZT40gauv51wpESsRCwzjBtqxAypynQqBqJGxICA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7CB20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbeLFL7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:59:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbeLFL7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:59:34 -0500
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B56D21479;
        Thu,  6 Dec 2018 11:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544097573;
        bh=GLNI3V7OWlsBjpdfkkg5ruwoHYTSysEbRDy8GHiz/sg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PIxcIVBsmc113tpfT6Fw6crfj4Q+3iGkbTmwxoxP+yoF5JTbF1g+OsWU5jk+0biZd
         zKuyye8LAVt+ZmfaCo1g2H0TDUINh1Sr7RqPCb4E4J1BiXmbSzsc5jlftswVsBYhDK
         O8Ie6sdlHPNZesaTAHpDnc0GJ0J77/MI5mwabvw0=
Received: by mail-lj1-f169.google.com with SMTP id l15-v6so148939lja.9;
        Thu, 06 Dec 2018 03:59:33 -0800 (PST)
X-Gm-Message-State: AA+aEWZ6Q3ALFTaoyDbz1BebfjyiOBdBJ9c7T9tTESISDidnQmxgYBsY
        +75JkcArsgWF3zIjRPDaxw+sLH+rdo8yXqdHB7w=
X-Google-Smtp-Source: AFSGD/UOEQ/d5Szqfk3tYVr6oqTQOnKDUExOqOfrpJcqMD+b0yuqCGtsp3/Fk3L5ZM5Qjb0+NcKnT3bHCY8LPQqeS+E=
X-Received: by 2002:a2e:5d12:: with SMTP id r18-v6mr19989675ljb.89.1544097571560;
 Thu, 06 Dec 2018 03:59:31 -0800 (PST)
MIME-Version: 1.0
References: <1544089549-23629-1-git-send-email-krzk@kernel.org> <CACRpkda9UAGxMrP27qYe-ZC=3RehesAPsUAnt71Jx5Dd+rpSqQ@mail.gmail.com>
In-Reply-To: <CACRpkda9UAGxMrP27qYe-ZC=3RehesAPsUAnt71Jx5Dd+rpSqQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 6 Dec 2018 12:59:20 +0100
X-Gmail-Original-Message-ID: <CAJKOXPe9==fqWE5LaofpgRcFJmCx2Wxb=YP3i65eLe2Kr3VEzg@mail.gmail.com>
Message-ID: <CAJKOXPe9==fqWE5LaofpgRcFJmCx2Wxb=YP3i65eLe2Kr3VEzg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Fix return value of gpio_to_desc() stub if !GPIOLIB
To:     linus.walleij@linaro.org
Cc:     dmitry.torokhov@gmail.com, bgolaszewski@baylibre.com,
        geert+renesas@glider.be, jmkrzyszt@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 at 12:55, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Dec 6, 2018 at 10:45 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> > If CONFIG_GPOILIB is not set, the stub of gpio_to_desc() should return
> > the same type of error as regular version: NULL.  All the callers
> > compare the return value of gpio_to_desc() against NULL, so returned
> > ERR_PTR would be treated as non-error case leading to dereferencing of
> > error value.
> >
> > Fixes: 79a9becda894 ("gpiolib: export descriptor-based GPIO interface")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  include/linux/gpio/consumer.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> > index ed070512b40e..3b01fbcafc94 100644
> > --- a/include/linux/gpio/consumer.h
> > +++ b/include/linux/gpio/consumer.h
> > @@ -505,7 +505,7 @@ static inline int gpiod_set_consumer_name(struct gpio_desc *desc,
> >
> >  static inline struct gpio_desc *gpio_to_desc(unsigned gpio)
> >  {
> > -       return ERR_PTR(-EINVAL);
> > +       return NULL;
>
> I suppose this is consistent with comitt:
> 22c403676dbbb7c6f186099527af7f065498ef45
> "gpio: return NULL from gpiod_get_optional when GPIOLIB is disabled"
>
> So in that way it should be fine.
>
> I'm just wondering where you see this problem, because IMO
> a driver that is using GPIO should either
> depends on GPIOLIB or
> select GPIOLIB
> it is extremely uncommon for a GPIO line to actually be optional at
> compile time (as opposed to optional at runtime) so I would very
> much like to look closer at this.

No, I did not hit this error. Maybe I should mention this explicitly
that this case is rather theoretical (feel free to change the commit
msg respectively). What is however important, it misleads developers
which test for ERR_PTR, like before this fix:
2d88a331e48095cf60ad9bdf3177bd401bf99727 ("leds: leds-gpio: Fix return
value check in create_gpio_led()")

Best regards,
Krzysztof
