Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFA2C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB4824277
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB4824277
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeFVNKN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:10:13 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:38433 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbeFVNKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:10:12 -0400
Received: by mail-vk0-f66.google.com with SMTP id b77-v6so3874769vkb.5;
        Fri, 22 Jun 2018 06:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ut/4QJGsufGW+Nm0DUNoMHHNGmiTCJyMQmIVxxy7OL8=;
        b=Yor2td3E363M5Z+J7gyec4aENRyjB+NpwTa8InC+q4y+YgtZhqRG5FId0Raloj5PJz
         v0seikRU4q1okQyMXiGqtvv9G8Vu0oVhAwAOlRFp4tZ1FQFA5hgFdJVqkXToT/D7UKNh
         0W3VrDnTyuej8DXZaI1Wo8PSSW/dDlJlhe/EplDs/tQdKYooF5+ngXQzVkDjRm/e8S0X
         Y3iHzchVHttDyl8liCd7rTAXHTFdemCFko+aGHvn/ihL6Z7Z8IFbkNfNuHVtBWz6iz30
         NBkiDidWH/7b25+CTj4reALt98/xoQiOO8QeSWIMVjjxOuj3zzMMFzcAGuPaw6n+eR8w
         l6bw==
X-Gm-Message-State: APt69E3hf2jyCN4CkD4wNMkdUbMmKUhs5ksCgx4lRQvFPyw13Niddcx9
        eIQOymUA/a8OgSfIiSDUs1UMloAnfWSru1cmSgw=
X-Google-Smtp-Source: ADUXVKJ09BT6RLW5d2rMDWcp+dS5U3FSuZPqgNVIAgO75ZoTt2zWoPSgOE2s+BMqsytMworPNm05p31fAS5u4GGDY1o=
X-Received: by 2002:a1f:8307:: with SMTP id f7-v6mr900763vkd.3.1529673011210;
 Fri, 22 Jun 2018 06:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180622075421.16001-1-geert@linux-m68k.org> <alpine.DEB.2.21.1806221446230.2402@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806221446230.2402@nanos.tec.linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jun 2018 15:09:59 +0200
Message-ID: <CAMuHMdW9FUMQ568GTJG_p9J8jFbVLOR6hPhsxsaMTttQjp=Wzw@mail.gmail.com>
Subject: Re: [PATCH v2] time: Make sure jiffies_to_msecs() preserves non-zero
 time periods
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Jun 22, 2018 at 2:49 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 22 Jun 2018, Geert Uytterhoeven wrote:
> > For the common cases where 1000 is a multiple of HZ, or HZ is a multiple
> > of 1000, jiffies_to_msecs() never returns zero when passed a non-zero
> > time period.
> >
> > However, if HZ > 1000 and not an integer multiple of 1000 (e.g. 1024 or
> > 1200, as used on alpha and DECstation), jiffies_to_msecs() may return
> > zero for small non-zero time periods.  This may break code that relies
> > on receiving back a non-zero value.
> >
> > jiffies_to_usecs() does not need such a fix, as <linux/jiffies.h> does
> > not support values of HZ larger than 12287, thus rejecting any
> > problematic huge values of HZ.
>
> Sorry, I'm not understanding that sentence at all.

Sorry for being unclear.

1 jiffy can only be less than 1µs if HZ > 1000000.
But include/linux/jiffies.h checks if HZ >= 12288, and does #error otherwise.
In addition, there's a "BUILD_BUG_ON(HZ > USEC_PER_SEC)" in time.c

> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> This lacks a stable tag, right?

Up to the maintainer to add, isn't it?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
