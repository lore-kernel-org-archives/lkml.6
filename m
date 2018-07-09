Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5C9C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D4520852
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D4520852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754547AbeGINt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:49:27 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:44046 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754437AbeGINt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:49:26 -0400
Received: by mail-ua0-f194.google.com with SMTP id k25-v6so2805004uao.11;
        Mon, 09 Jul 2018 06:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4EP56gWygSpMIW2crmjJAlppCFZ79R7CPiarpHWzqM=;
        b=ER4xS4XM7gfWc3yHmGDw+6t/p9ySgSYxxb3MnsxyFtwylvJs7I41WBpxwe2KbHRueF
         brl4ikP96Rk99QSW6BiZuBzGO4IHg/Cb+cP4gCTlJBCYyT2XUIkJrL6iL0dQScuKhrmk
         L/efMVzkfAQvr90cquCHnCIfcQn2I13a3ciwAkPYqlzYiru3SquJ2zX/klbTOm6Jrfhe
         Cf4eaLeQZF+tsLveBcxpv8qmdweVQf35HuNZpIYUKXrjNzTO/0mhNB9P2kkg6UXrsflf
         juN5ucSMJow5HoBBYh5XDP10UKeZpK7KIX+T6IETUmCRA7vRhBBay2aCnjqelh7KBTii
         mgwA==
X-Gm-Message-State: APt69E2cfg6pxVFpyVKp/fvLpf2C4c6ByAEQRYvXF2TzcUSoXR1BvdVg
        KMIlPW+UER4Im06mfKzVfOppwhFLnF2ZyhA9nEA=
X-Google-Smtp-Source: AAOMgpeMrTOQL6nB/kXcDTLyA4eydET8iF9R20d3wf1PVchsiIzKof1zycIXlL0shMau9hfyKkfeR6xDV9ddkG7NzU8=
X-Received: by 2002:ab0:1b6c:: with SMTP id n44-v6mr12660217uai.4.1531144165351;
 Mon, 09 Jul 2018 06:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180709124741.21037-1-abrodkin@synopsys.com> <3d3ec70d99524a6fa7a38e7d2e0fdf98@AcuMS.aculab.com>
In-Reply-To: <3d3ec70d99524a6fa7a38e7d2e0fdf98@AcuMS.aculab.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Jul 2018 15:49:14 +0200
Message-ID: <CAMuHMdWQNZ-Dpakqk7mTJ-O_H0QnCd-KUWpWNJC_d6Yw8GH0Kg@mail.gmail.com>
Subject: Re: [PATCH] atomic{64}_t: Explicitly specify data storage length and alignment
To:     David Laight <David.Laight@aculab.com>
Cc:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 3:29 PM David Laight <David.Laight@aculab.com> wrote:
> From: Alexey Brodkin
> > Sent: 09 July 2018 13:48
> > Atomic instructions require data they operate on to be aligned
> > according to data size. I.e. 32-bit atomic values must be 32-bit
> > aligned while 64-bit values must be 64-bit aligned.
> >
> > Otherwise even if CPU may handle not-aligend normal data access,
> > still atomic instructions fail and typically raise an exception
> > leaving us dead in the water.
> ...
> > diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
> > index 8d28eb010d0d..b94b749b5952 100644
> > --- a/include/asm-generic/atomic64.h
> > +++ b/include/asm-generic/atomic64.h
> > @@ -13,7 +13,7 @@
> >  #define _ASM_GENERIC_ATOMIC64_H
> >
> >  typedef struct {
> > -     long long counter;
> > +     u64 __aligned(8) counter;
> >  } atomic64_t;
>
> Apart from the fact that this changes the value from signed to unsigned
> should most of the architectures be using this generic definition?

64-bit architectures use the one from include/linux/types.h instead.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
