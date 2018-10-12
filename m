Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08508C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C9D20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C9D20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeJLQOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:14:19 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33092 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeJLQOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:14:19 -0400
Received: by mail-qt1-f196.google.com with SMTP id q40-v6so13077940qte.0;
        Fri, 12 Oct 2018 01:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVTc9GMyO4KMDgHn2AwcyLnvejB7nu3G4J6uCPyXugA=;
        b=uEjDZZjTIHcffonJ7AZEq65bVnWjHHLrPnCTDmnTpNhhOx8Wop3Ob9Off0bJ4CqXkw
         4x6dYpzuv/7ly/fbmD9F1GSxZNCzxm7/h/6Y2A1YkTBy0GDWkF5gfhS33PRzqSbVozVL
         Y+dGrj8oxcKs7JwlWWucvmRuspRK42hZGOKMYjM+15vk5OXiZ0Wxu8sfF8PpX+0/9tUK
         TLblUhfQZ5IwOSUuKNAhWRkFtYK3ZNk9z5wtYIhNmpLC8OIYvjl+WLFGWfg160pEYeqg
         isljHyb1pbZwqsQye/mLkduPSJTz+HFxKZ8FNsLNGSfmajCFptgs48hgSdHkIjZn1+5J
         gAbA==
X-Gm-Message-State: ABuFfojyzwlFlQQUAMCv568acWOSckdDVHF8fzyWvL2Ezvzm/tIl5iuw
        ibq0RbqV6/9+4HZVAbpOXysqt4aOSsudHKD44fg=
X-Google-Smtp-Source: ACcGV63AxG9fp3LcM+/I7F3rmu0mnOCK3HfKij5zqtlmzY/4IsTW0RdT+8tEoxurFrNT69QjensD9fL0PKRtsCV5zVc=
X-Received: by 2002:ac8:2bf0:: with SMTP id n45-v6mr4908822qtn.152.1539333776301;
 Fri, 12 Oct 2018 01:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181011225421.GA21093@beast>
In-Reply-To: <20181011225421.GA21093@beast>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Oct 2018 10:42:39 +0200
Message-ID: <CAK8P3a3N6txZf8tzTdLvLwByrsWQvN_JSabV2TGe+zZenMWWxg@mail.gmail.com>
Subject: Re: [PATCH] random: Move rand_initialize() earlier
To:     Kees Cook <keescook@chromium.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        tcharding <me@tobin.cc>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 12:54 AM Kees Cook <keescook@chromium.org> wrote:
>
> Right now rand_initialize() is run as an early_initcall(), but it only
> depends on timekeeping_init() (for mixing ktime_get_real() into the
> pools). However, the call to boot_init_stack_canary() for stack canary
> initialization runs earlier, which triggers a warning at boot:
>
> random: get_random_bytes called from start_kernel+0x357/0x548 with crng_init=0
>
> Instead, this moves rand_initialize() to after timekeeping_init(), and moves
> canary initialization here as well.
>
> Note that this warning may still remain for machines that do not have
> UEFI RNG support (which initializes the RNG pools during setup_arch()),
> or for x86 machines without RDRAND (or booting without "random.trust=on"
> or CONFIG_RANDOM_TRUST_CPU=y).
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Alternatively, ktime_get_real() could get mixed into the pools after
> timekeeping_init(), and rand_initialize() could be run MUCH early,
> like after setup_arch()...

I wonder if mixing in ktime_get_real() is flawed to start with:
This depends on read_persistent_clock64() actually returning
a meaningful time, but in many cases it does not; x86 being
a notable exception.

We have three ways of setting the initial time:

* At early boot using read_persistent_clock64(). This may read
  the time from the hypervisor (if any), and on some older
  architectures that have a custom RTC abstraction, it
  reads from the RTC directly. We generally move away from
  the RTC method in favor of the proper rtc class interfaces
  (see below)

* At late_initcall time, in rtc_hctosys(). If an RTC driver has
  been loaded successfully at this time, it will be read from
  there. We also move away from this.

* From user space, which reads the RTC time or NTP,
  and then sets the system time from that.

The latter two end up in do_settimeofday64(), but there
is no mixing in of the time into the random seed that I can
see, and it's not clear whether there should be (it
can be called with arbitrary times from user space,
provided CAP_SYS_TIME permissions).

       Arnd
