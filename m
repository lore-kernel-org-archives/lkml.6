Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41BFC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758D921708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758D921708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kobol.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeHHN7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:59:40 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:53703 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeHHN7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:59:39 -0400
X-Originating-IP: 209.85.220.176
Received: from mail-qk0-f176.google.com (mail-qk0-f176.google.com [209.85.220.176])
        (Authenticated sender: aditya@kobol.io)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D79521BF207;
        Wed,  8 Aug 2018 11:40:19 +0000 (UTC)
Received: by mail-qk0-f176.google.com with SMTP id c192-v6so1180127qkg.12;
        Wed, 08 Aug 2018 04:40:19 -0700 (PDT)
X-Gm-Message-State: AOUpUlHgqVs/XYiRow8XfBl/15+q0R8lOW5I+zsEWyE4GfGje2kkGK2W
        7p3/vQnLTswzG+oNijINv1j1TtCWWUqoRfgXHqU=
X-Google-Smtp-Source: AA+uWPwsLCMWlprSXgnuqC+//fTkuq9ya6f7lac07BypF2CxSW/ZhNHPbk/GXpdlDjHkWlHuyqa2Rp8d0EKtwUloGsE=
X-Received: by 2002:a37:288d:: with SMTP id o13-v6mr1694155qko.205.1533728418781;
 Wed, 08 Aug 2018 04:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
 <1533522556-55055-3-git-send-email-aditya@kobol.io> <20180806135257.GB6584@lunn.ch>
In-Reply-To: <20180806135257.GB6584@lunn.ch>
From:   Aditya Prayoga <aditya@kobol.io>
Date:   Wed, 8 Aug 2018 18:40:09 +0700
X-Gmail-Original-Message-ID: <CAFTRUBdSkLWLi1QJ-303JFZFM83z0UugEDUbF1coTn7RT5EMNA@mail.gmail.com>
Message-ID: <CAFTRUBdSkLWLi1QJ-303JFZFM83z0UugEDUbF1coTn7RT5EMNA@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] gpio: mvebu: Allow to use non-default PWM counter
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

On Mon, Aug 6, 2018 at 8:53 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 06, 2018 at 10:29:16AM +0800, Aditya Prayoga wrote:
> > On multiple PWM lines, if the other PWM counter is unused, allocate it
> > to next PWM request. The priority would be:
> > 1. Default counter assigned to the bank
> > 2. Unused counter that is assigned to other bank
> > 3. Fallback to default counter
> >
> > For example on second bank there are three PWM request, first one would
> > use default counter (counter B), second one would try to use counter A,
> > and the third one would use counter B.
>
> Hi Aditya
>
> There are only two PWM counters for all the GPIO lines. So you cannot
> support 3 PWM requests. You have to enforce a maximum of two PWMs.
>
> When i implemented this PWM code, i only needed one PWM. So it took
> the easy option. GPIO bank 0 uses counter A, GPIO bank1 uses counter
> B. For the hardware you have, this is not sufficient, so you need to
> generalise this. Any PWM can use any counter, whatever is available
> when the PWM is requested.

Hi Andrew

Understood. I will change it in next version.

> Rather than have a linked list of PWM, i think it would be better to
> have a static array of two mvebu_pwm structures. Index 0 uses counter
> A, index 1 uses counter B. You can then keep with the concept of
> pwm->pgiod != NULL means the counter is in use. The request() call can
> then find an unused PWM, set pwm->gpiod, and point mvchip->mvpwm to
> one of the two static instances.

That was my initial idea to use static array but then I thought maybe
I could generalise it for future device by using linked list.

Regards,

Aditya
>
>     Andrew
