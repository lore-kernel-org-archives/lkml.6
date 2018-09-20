Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0E3ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F486206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F486206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbeITNcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:32:19 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33369 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeITNcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:32:19 -0400
Received: by mail-vs1-f68.google.com with SMTP id y12-v6so2664572vsm.0;
        Thu, 20 Sep 2018 00:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgHK0g1TNeBP1LovKtjlx3BZ7u4dZzivFCtnc+HMrAA=;
        b=PpMflKrEPIB5vnXGzdU+5J94HGg6c7HUfGBYcDy1XSpHe5HbXGS9PIuP2M58W/XJVl
         ug+cis/HCOHhZYACMkUZdLlQUcXQSTWG0iMOMT3HZJ5iWkMeZdEmZVPNGIYDYwmvyM1p
         EgmjLzbZqusKSMo/hjGUiZT5aj2VKPJgrVs00Cq7fKo0KIxzXfAWEYHGI2Kmb504eo6A
         jrLGy0jvgW7uFj7wXVh6vf24FKQBYXHH1cIx7NyoD2DXXfmZHA5AZ6s7KEqvU6uABM21
         m80RGo+Rxuz9HU6MKuEwoqJ3BmxmXc49Utg9dODpEoE0mmc6piUUsLGLAxgc7d30bpfd
         Jfsw==
X-Gm-Message-State: APzg51CELJQL5gD6ipbFSTNnkSIwuNGKekUpFLOfpeoNUpbY7RsVbSp8
        bbVjyprUNEHS2IvY7E/XkX4rAjA1BS0arXUXFCk=
X-Google-Smtp-Source: ANB0VdbJpljKboScH/kQnNgyT/fDKtqSFv6xAKkuSfT47eKO0VLj21x/E0NrlrXwF3g8NiTOJqO4mG7PSvMrKBML2KM=
X-Received: by 2002:a67:3481:: with SMTP id m1-v6mr10758044vsi.52.1537429810270;
 Thu, 20 Sep 2018 00:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com> <20180918173428.GA21591@kroah.com>
 <CANiq72=ZU61EaoWm2N4G1SZF0QUvzquULo50uEvDRU-hitOJVQ@mail.gmail.com>
 <20180919211458.GA8757@kroah.com> <20180919230504.GA20280@nautica>
 <CANiq72=C==Us7YjkzwVW7QHXnuGxHTowriYjX3Wsff19JO=uHw@mail.gmail.com>
 <20180920001024.GD20280@nautica> <20180920072205.GC11963@kroah.com> <20180920073650.GA6001@nautica>
In-Reply-To: <20180920073650.GA6001@nautica>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Sep 2018 09:49:58 +0200
Message-ID: <CAMuHMdXfSOxigSkV2Ui2akpUoSrkFu3HyVoJiQyTbZY0kGpRWg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Compiler Attributes: naked can be shared
To:     asmadeus@codewreck.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        efriedma@codeaurora.org, Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 9:37 AM Dominique Martinet
<asmadeus@codewreck.org> wrote:
> Greg Kroah-Hartman wrote on Thu, Sep 20, 2018:
> > "Fixes:" is not just for stable, we use it wherever we have a patch that
> > we know fixes a problem introduced in another patch.
> >
> > For this instance, I think we should just revert the offending patch,
> > which should resolve the issue for everyone and then you can try to redo
> > your series to get it right the next time.
> >
> > Sound good?
>
> Except that 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h
> mutually exclusive") itself fixes cafa0010cd51 ("Raise the minimum
> required gcc version to 4.6"), which breaks clang altogether (as used by
> example by bcc for most BPF programs, that I caught before -rc1 got
> released so we got both in rc1)
>
> I'm not aware of anything that would break if both were to be reverted,
> I have no opinion on which way to go.

I guess reverting them makes no difference for gcc >= 4.6.

For older compilers (which were declared unsupported by cafa0010cd51),
you also need
https://lore.kernel.org/lkml/20180814160208.4f4dd7ca142912f5894ddddd@linux-foundation.org/

Been there, done that, happy gcc-4.1.2 ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
