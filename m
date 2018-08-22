Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F247C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C5E214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C5E214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbeHVR57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:57:59 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34883 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbeHVR57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:57:59 -0400
Received: by mail-qt0-f193.google.com with SMTP id f19-v6so839460qtf.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 07:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1SDKLNzSyj8xOwIVfYVd0QgaiIjTSnBiUTw+pmXl/wA=;
        b=ku93J6yvcgyyGLS7pYmDbSLVouQlrrFjXUb1ZRTdAlDj45yIKGK1x8pkN/towJKI53
         0W9a5U/6xRoY9JwXlAEf2HIq+m2WBWQ7GhNVzH6Ytxi3nRGMuyAD68Zrl4cqYzA9ujGe
         55fAtZGqwNdeCmESPKtQZfboJvchJxacqOHq1dZ/ph2xcYzQ44AwYa/JjdeIBj6Mw8Fw
         5eJ4TICAdkKR7Y+qh2NE5EkR4qSwA96jwP7BtmRvwjdewr2CwoJDvK7lLvhl+McKOATl
         2HScBFH2FG7sS3C4Qjxq1WUhKumcokd9lDa09a7TOREQdZYO8vInZO1X68Mddg/mpY6I
         magg==
X-Gm-Message-State: AOUpUlEYQJYyeROiiWePO7rwlIWAbvCeXjy305QJ37+OI4wLoeMtuyK9
        /F4TgojFgB93X1t8rD7ai8ThJgEjF9NaC6HhE6s=
X-Google-Smtp-Source: AA+uWPzZo8tPyPakuINZHDuClasIZVmlk3+keWQa0Gxueo7D6RppGTyBQfxpmIu/bXtW3Q+ghcueN2LXE5OWZNOVCes=
X-Received: by 2002:a0c:8b67:: with SMTP id d39-v6mr50550447qvc.180.1534948369919;
 Wed, 22 Aug 2018 07:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180821222416.7771-1-stefan@agner.ch> <CAK8P3a0oaMS12R4tazChMHENQduO0-Wb-gw-inKjH0oz7_5s3g@mail.gmail.com>
In-Reply-To: <CAK8P3a0oaMS12R4tazChMHENQduO0-Wb-gw-inKjH0oz7_5s3g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Aug 2018 16:32:33 +0200
Message-ID: <CAK8P3a03TFBi+kNccTm4WE7u9QdKfbA-Van0WpHH6VzDLtLCtw@mail.gmail.com>
Subject: Re: [PATCH] ARM: use choice for kernel unwinders
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 12:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Aug 22, 2018 at 12:24 AM Stefan Agner <stefan@agner.ch> wrote:
> >
> > While in theory multiple unwinders could be compiled in, it does
> > not make sense in practise. Use a choice to make the unwinder
> > selection mutually exclusive and mandatory.
> >
> > Already before this commit it has not been possible to deselect
> > FRAME_POINTER. Remove the obsolete comment.
> >
> > Furthermore, to produce a meaningful backtrace with FRAME_POINTER
> > enabled the kernel needs a specific function prologue:
> >     mov    ip, sp
> >     stmfd    sp!, {fp, ip, lr, pc}
> >     sub    fp, ip, #4
> >
> > To get to the required prologue gcc uses apcs and no-sched-prolog.
> > This compiler options are not available on clang, and clang is not
> > able to generate the required prologue. Make the FRAME_POINTER
> > config symbol depending on !clang.
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
>
> Looks ok to me. I've added it to my randconfig test environment, you
> will hear from me within a day if I run into build regressions.

I needed a small hunk to avoid a warning:

WARNING: unmet direct dependencies detected for FRAME_POINTER
  Depends on [n]: DEBUG_KERNEL [=y] && (M68K || UML || SUPERH) ||
ARCH_WANT_FRAME_POINTERS [=n]
  Selected by [y]:
  - LOCKDEP [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
&& !MIPS && !PPC && !ARM_UNWIND [=n] && !S390 && !MICROBLAZE && !ARC
&& !X86
  - UNWINDER_FRAME_POINTER [=y] && <choice> && !THUMB2_KERNEL [=n] &&
!CC_IS_CLANG [=n]

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 6e27419b90c0..08f914be6248 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -57,6 +57,7 @@ choice
 config UNWINDER_FRAME_POINTER
        bool "Frame pointer unwinder"
        depends on !THUMB2_KERNEL && !CC_IS_CLANG
+       select ARCH_WANT_FRAME_POINTERS
        select FRAME_POINTER
        help
          This option enables the frame pointer unwinder for unwinding
