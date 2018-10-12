Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AC4C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E342098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PeViFxjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E342098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbeJLWSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:18:36 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35592 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbeJLWSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:18:35 -0400
Received: by mail-yw1-f67.google.com with SMTP id y76-v6so5048526ywd.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 07:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=OjHic1JoQAgtlZ2U8qLHTKC+Yp+yYxBigFZ1ybGKtzY=;
        b=PeViFxjI5lojXSrR8wjg5363ZA4plwdcThrAxQshw9po0ln92pU/b7+cB6lMY5BOR4
         m4aiVZsdjgOke1YpLiGASuBVB0JTw9zLBVqxrHEd36DumdIE06z6nJQu+PfUFBFupqaA
         OHsZOUasMyg+B97tK2BIu1p8PSi4jNSSJw6OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=OjHic1JoQAgtlZ2U8qLHTKC+Yp+yYxBigFZ1ybGKtzY=;
        b=GEeFLB0VRpw06gtOkz04I+jTEq6N+Cnc/VKaNLKKH0ILfKDLcHK5KlzQ5Yn5+SPFKS
         v6pFvmgYzc644nzvo0EzfogF69SwD8Kl9r6kA1HmNHG3IqbpoNLRbtQ4nMGaEzDWgak9
         xy5JFUhGKDnltsLtHboVuHQu2qmYei2QJN9WrZiA8cZyL1MpVUNKXJcqZL0+uNIFKJvC
         pEyCirBbAIXrXtP7a3d9wDTkRnAGUF5Ry5ZEo54IJHwTEFIBatW/LeiAMKf/s7T5ViNE
         WFzTHA/kw0XHOnG0wfMO1aMsoM4LRaGMvj9cKlS5HICr9Na9tHYAdgyWyu/ZFiE1fBe0
         Jwmw==
X-Gm-Message-State: ABuFfohYy6kwcXl0RTCy09bFjG6LKnI/U5AKazOEqhCaEWVBW3syoDDy
        MDD5F9Rl8ltukCi+Z2I5K1lz8rNOGs8=
X-Google-Smtp-Source: ACcGV63nIn+N1W7L2CwTEil+5aYebi3tTR+TnHMfwgGu8mhr4KhegHjFI47Oed1o0hFGuA1iocMbgg==
X-Received: by 2002:a0d:d801:: with SMTP id a1-v6mr3485499ywe.399.1539355547699;
        Fri, 12 Oct 2018 07:45:47 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id x64-v6sm291220ywx.103.2018.10.12.07.45.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 07:45:46 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id w80-v6so5005467ybe.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 07:45:45 -0700 (PDT)
X-Received: by 2002:a25:8091:: with SMTP id n17-v6mr3447657ybk.209.1539355545292;
 Fri, 12 Oct 2018 07:45:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 07:45:44
 -0700 (PDT)
In-Reply-To: <20181012142902.GD2420@thunk.org>
References: <20181011225421.GA21093@beast> <20181012142902.GD2420@thunk.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 12 Oct 2018 07:45:44 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLqg5sf=oCZ_mB+ozTF=kKS7y4SNBKb96a6sBR07BprNg@mail.gmail.com>
Message-ID: <CAGXu5jLqg5sf=oCZ_mB+ozTF=kKS7y4SNBKb96a6sBR07BprNg@mail.gmail.com>
Subject: Re: [PATCH] random: Move rand_initialize() earlier
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Tobin C. Harding" <me@tobin.cc>, Arnd Bergmann <arnd@arndb.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 7:29 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Thu, Oct 11, 2018 at 03:54:21PM -0700, Kees Cook wrote:
>> Right now rand_initialize() is run as an early_initcall(), but it only
>> depends on timekeeping_init() (for mixing ktime_get_real() into the
>> pools). However, the call to boot_init_stack_canary() for stack canary
>> initialization runs earlier, which triggers a warning at boot:
>>
>> random: get_random_bytes called from start_kernel+0x357/0x548 with crng_init=0
>>
>> Instead, this moves rand_initialize() to after timekeeping_init(), and moves
>> canary initialization here as well.
>>
>> Note that this warning may still remain for machines that do not have
>> UEFI RNG support (which initializes the RNG pools durting setup_arch()),
>> or for x86 machines without RDRAND (or booting without "random.trust=on"
>> or CONFIG_RANDOM_TRUST_CPU=y).
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> This seems reasonable to me.  Were you hoping to get this in for -rc8?
> It looks sane, and I don't see any _obvious_ unintended consequences
> of such a change, but it's rather late in the development cycle, and
> it isn't regression fix.

Yeah, for sure. I didn't mean this for 4.19. I assumed -next, and
likely further changes based on discussion, etc etc.

-Kees

-- 
Kees Cook
Pixel Security
