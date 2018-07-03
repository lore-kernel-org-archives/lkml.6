Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22879C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7508246F3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJPAtcfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7508246F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeGCTn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:43:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39179 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbeGCTn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:43:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id t7-v6so2470778ljj.6;
        Tue, 03 Jul 2018 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=otEhbrSxAiwSkVsGYFqkupdLvN0fJkr4iKf47hI3MqY=;
        b=MJPAtcfuMe78EjleTg07lASnW0V1pAeUdsG3lkPWRjW+o7lAGeHkHd8CqLUZ7p8LSL
         9OLPGRSQ/+olBV0cQEZG6Pefp/03YuB6MlluiDHry+UaRKm+zn5Tk6ERoJQgIvgmoHYh
         OlT/blRHSmiTVGu6kAlTtSdcMYcfvsHnmd1nl9emucA1lbVnnEYcY6qgZMLxnzTbX3Pa
         a9mSloyT6tTCQM7Tl4LIo7CoAt8QyI7brW+JZeD04ZQXyNYMYhr95aFPmyLVnozb8RbL
         JEkH3L73bJQdCEwjQAH6UILATRlXlmBkx/i7jk3Rq4LCY4rHOxAlChMufi95NDpQSe/R
         W76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=otEhbrSxAiwSkVsGYFqkupdLvN0fJkr4iKf47hI3MqY=;
        b=ZvIkcNEBwcKwhIwn3zD+7F1WkQcGN/waE7IXY8Bx2B02X2MK71H+eMBKcNjGox30Z6
         goh238znqDaz72UafJOKMpMmuWGuFhKZR7wB+9y51TkGi0TZ/sy38sIHrYnK7Sq/Y0RX
         rg5dr+l02skQgjce7Pw7tvnr0IaLOHsUJP25e8r/dUOHah6oIsudHDFCTxTHxIhWANO2
         qcb2/Z3O/cf5oN3bWnpxMfrjYjIZyI/2PE3s89rTwGY2Z2I3B/5OlWWSiMfFgWba085x
         WXHePp9phdNZeHhoTo8w1VYOpdfQh+u8N4vvdznhnak7Iw1R8XQkutCWKysSsagl+7Hl
         KcCA==
X-Gm-Message-State: APt69E0rwK1Y48ESrq+5WYZWqfBAz95HqRyHe+y5Di3FKUo0sPHWwAEx
        cd2baAmnlK8/lO2TM/Y5Wnf6H/Ix8iJiUTt3s2s=
X-Google-Smtp-Source: AAOMgpeDwkX96/v71QSsPDbC7qRCsJ4ETx+0Q8BNbPyX8PMkI7O9PpGtYYejQNg7lcsR9iCruWkF1lDx+Fyqh8N7sGI=
X-Received: by 2002:a2e:4d9d:: with SMTP id c29-v6mr18119922ljd.132.1530647004330;
 Tue, 03 Jul 2018 12:43:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 12:43:23 -0700 (PDT)
In-Reply-To: <CAMuHMdUWATshtf8PX+QxwrOHaXt60j2e_GYx=L-UbWjYVL80yA@mail.gmail.com>
References: <20180629185107.GA37488@beast> <CAK8P3a30Q1ezvCWfudUY=z1q3NHdrkbwRsmSDso4s7TifQAmNQ@mail.gmail.com>
 <CACRpkdYbmu_Y6N1G3M3q3M=3ZaECFdgije6Qgwoo6qra4g06_A@mail.gmail.com> <CAMuHMdUWATshtf8PX+QxwrOHaXt60j2e_GYx=L-UbWjYVL80yA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Jul 2018 21:43:23 +0200
X-Google-Sender-Auth: c3yPQWra15U92mjaomEBqCLGvYo
Message-ID: <CAK8P3a13um6=hNz1EFNTCPA5Be2nH8Y1bD26cOry3GmFw8astA@mail.gmail.com>
Subject: Re: [PATCH] dma: ste_dma40: Remove VLA usage
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 5:28 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Jul 2, 2018 at 4:22 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Fri, Jun 29, 2018 at 11:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> > - Nobody uses this driver in practice, as the hardware platform
>> >   was a dead end
>>
>> Depends what you mean with dead end.
>>
>> The hardware was deployed in a few million handsets from Samsung
>> and Sony.
>>
>> Some have been picked up as targets for PostmarketOS:
>> https://wiki.postmarketos.org/wiki/Samsung_Galaxy_S_Advance_(samsung-i9070)
>> https://wiki.postmarketos.org/wiki/Samsung_Galaxy_SIII_mini_(samsung-i8190)
>>
>> So it is no more dead end than anything else discontinued, and it
>> has a living community who want it suppored by the mainline
>> kernel if possible.

I meant that when ST-Ericsson imploded, STMicroelectronics inherited the
SoC family but never did any follow-up chips. We only really ever supported the
original U8500 but not the later models (which have partial support), and that
is very unlikely to change, so all the devices that can run this
driver are already
known. This is only relevant because the dynamic allocation size depends on
the chip model.

> Mixup with SuperH-based ST40?

No, but I wouldn't be surprised to find an ST40 inside the D40 engine ;-)

      Arnd
