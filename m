Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C4AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70FF208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70FF208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeIYDNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:13:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35689 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeIYDNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:13:06 -0400
Received: by mail-qk1-f195.google.com with SMTP id a189-v6so2788559qkb.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 14:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zDodXbsZUsy2u0OQ08f+IIYrIUczPRmlYOGOO3BVDk=;
        b=gV6zzo4dofF7HFCYGtacjvJVn8ILz1s/Hl1aPifw12Kp3HtZ3JmqbSK15m2rqF2UOp
         D1YI0/mvjE5LQZgFvJwHpyUkMxrLfG2085QdivDxEKqKEr1Jn8LU+RWgoMLeGsNVq0fg
         MwO/hpLw7QAGlBz/fu2l8OCYVlQ71tjXA2tEhywscUBb6h9noNxcz2/b39L8f+JcFtYK
         wXwK7YLRBUf0gxakcoH08Zt3ilM8CEPN1plvVkpEdPBBSYx56CXX+iplbsKHlts9B2Jf
         QpD0P62sjgOtz6ID8PkbrrCSnv7yM1AhQfLi+TtIChNnZxnhKgOkpIcLpYl/VdD2QzRP
         DxZg==
X-Gm-Message-State: ABuFfohRPZpQg1FnSTYk+4mcybY/fCLr+yOC/Jo70+g2ohYYskE7K4p4
        VJ2YYz0unT6kyZrj69uEyPJCT87y6f++ZYVz9oI=
X-Google-Smtp-Source: ACcGV60BGJO3SghtiVGii9XAIpYvmMZo1rdarQWMgiLYobaezhC043FBG974ih3e5+Uz+GxP8y65vd3ciGArAGsAN+c=
X-Received: by 2002:a37:c542:: with SMTP id p63-v6mr492329qki.330.1537823338999;
 Mon, 24 Sep 2018 14:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180914125006.349747096@linutronix.de> <CAK8P3a1QfynDxkKBLXVa5Qj_z+7ct3QB5sDYuY5QV3ht-a0cTg@mail.gmail.com>
 <alpine.DEB.2.21.1809171451380.16580@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809171451380.16580@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 24 Sep 2018 23:08:42 +0200
Message-ID: <CAK8P3a0rGy_8meAp2fKzH1SW8SjRX-vj2rnLjPab_Gr0fOK_gQ@mail.gmail.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI support
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, matt@softrans.com.au,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>, vkuznets@redhat.com,
        devel@linuxdriverproject.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 3:00 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, 14 Sep 2018, Arnd Bergmann wrote:
> > On Fri, Sep 14, 2018 at 2:52 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > A couple of architectures (s390, ia64, riscv, powerpc, arm64)
> > implement the vdso as assembler code at the moment, so they
> > won't be as easy to consolidate (other than outright replacing all
> > the code).
> >
> > The other five:
> > arch/x86/entry/vdso/vclock_gettime.c
> > arch/sparc/vdso/vclock_gettime.c
> > arch/nds32/kernel/vdso/gettimeofday.c
> > arch/mips/vdso/gettimeofday.c
> > arch/arm/vdso/vgettimeofday.c
> >
> > are basically all minor variations of the same code base and could be
> > consolidated to some degree.
> > Any suggestions here? Should we plan to do that consolitdation based on
> > your new version, or just add clock_gettime64 in arm32 and x86-32, and then
> > be done with it? The other ones will obviously still be fast for 32-bit time_t
> > and will have a working non-vdso sys_clock_getttime64().
>
> In principle consolidating all those implementations should be possible to
> some extent and probably worthwhile. What's arch specific are the actual
> accessors to the hardware clocks.

Ok.

> > I also wonder about clock_getres(): half the architectures seem to implement
> > it in vdso, but notably arm32 and x86 don't, and I had not expected it to be
> > performance critical given that the result is easily cached in user space.
>
> getres() is not really performance critical, but adding it does not create
> a huge problem either.

Right, I'd just not add a getres_time64() to the vdso then.

        Arnd
