Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C869C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1F620C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551284780;
	bh=3aDddNXzOYAQ1VIq+hs4flrv1eXkpN8lxrAqx/9/n4w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=neHW+0z2BgGJ62UDy+keN4O4pt5D8AdWDpRTX8StTdzJ/56Dst+TvXb7dLIxpJkCm
	 6BzlKUSRBL/723y0XnWDwtndPKcuMnDbKmTMUy8XOx53aj4hsrfXQmXV4j9dLt7Gfz
	 1nzkeRHRcZVvHKNX+gE6xZIAf+LqTfHIcyrxVO34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfB0Q0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:26:18 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35594 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfB0Q0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:26:18 -0500
Received: by mail-lf1-f66.google.com with SMTP id m73so7401080lfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 08:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0djYkdMavFxoz/THKVe2hUSfl9fmomvVQvt2WEt+eUI=;
        b=ehfWuSXEXxLj46LjvPhyqf7lTKmuT+T22aj8Rkb5b2h5ON12wqhqsBzJPSWOwMH8kl
         R57eG7WRxp8Cxbh1tbtapn7C4AlgoM6bgOT5MzOTsxENOy0HlRH9MH9yPCdLEi6am+0t
         vccTnofAp6jZOvrUPDlIYjvvfHCECZq7sYSAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0djYkdMavFxoz/THKVe2hUSfl9fmomvVQvt2WEt+eUI=;
        b=HXNWtnA6UgWkm5OvS8fsyzHVuEIv9PKVvUVjdPYZqEC0gWiQ0lTEtjzAoLsoy6T7kK
         Zu8sP6sqRO4AP3096avnPwyrAa8Be+pGxss20tzIHcUzPrbNaRfZDnMzYxx2KBEF5khH
         bXGSozo5SGqJhVn/QZ0HFxZGcxhajU4i/WRbPiajyecR4AMSJ82wy+4dF7FiT7LNhHWO
         n+SJ64GABDxC9G8YbVvK/g++FGvfGzsyvOqStSiVj2DtiZiIXd4BrhLo5Gvy47VKS6QG
         YTMNJWNN6yP3OcMuw+XvHO3AEGijzFLcxnStEkVi7LmZQItWtTEQbceuKyS35Xt/lYgm
         KR3g==
X-Gm-Message-State: AHQUAubEA+p2Hf2DihvcUSSYrXEdmqaQt+KQVvUAZVhqrqgb5Z39+H/U
        Fv+svHpfjdmqJwJbhjagoPtGiBm4W+M=
X-Google-Smtp-Source: AHgI3IYubLi7PBTDnozYrNnE1sEwW15NkgnCvZsvpM4Cxj/xHq9UOxlIyPA+DQbJ0vftddzAk8Jt6A==
X-Received: by 2002:ac2:5390:: with SMTP id g16mr1522625lfh.12.1551284775598;
        Wed, 27 Feb 2019 08:26:15 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id a26sm180314lfl.45.2019.02.27.08.26.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 08:26:15 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id x206so4953591lff.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 08:26:15 -0800 (PST)
X-Received: by 2002:a19:3f44:: with SMTP id m65mr1359682lfa.136.1551284317220;
 Wed, 27 Feb 2019 08:18:37 -0800 (PST)
MIME-Version: 1.0
References: <20190225124330.613028745@infradead.org> <20190225125232.191698923@infradead.org>
 <20190227140830.GP32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190227140830.GP32494@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Feb 2019 08:18:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg6P=hDhq+kPs0TCCvN7_q3usW5WNWzfdCBcLX_syoVxg@mail.gmail.com>
Message-ID: <CAHk-=wg6P=hDhq+kPs0TCCvN7_q3usW5WNWzfdCBcLX_syoVxg@mail.gmail.com>
Subject: Re: [PATCH 5/6] objtool: Add UACCESS validation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 6:08 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> So KASAN is wildly unhappy..

Yeah, well, with KASAN you definitely end up doing lots and lots for
calls for just regular memory accesses.

Which we obviously need to do for most uaccess cases.

I think you should just say "ok, kasan reporting will possibly run with AC on".

Again, having AC on isn't fatal. It just makes the window where you
can incorrectly access user space through a wild pointer bigger.

So the whole "run with AC on" thing isn't a big deal, apart from the
scheduling case.

And we know how to fix the scheduling case by just doing the
save/restore thing..

                   Linus
