Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E94BC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D83721781
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D83721781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbeHMX5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 19:57:09 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34815 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbeHMX5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 19:57:09 -0400
Received: by mail-qk0-f196.google.com with SMTP id b66-v6so12056881qkj.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 14:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KcgaH03XTLwDDCE00jQnELxS4ukMAIjrnT45GxO3VNM=;
        b=iIL4U7qJCbIyjxI2re53beLvx0/Qy0ltnoU1RgcJXnEw+/atA+e5IrV9FBLAfkrTti
         UiU7i4u28VHV1YFldROhpZP158vOOu4bf2zws40dhZWeEvTu60hnH3lI57jQRrPLacRj
         ud2dbZyR4jUYz/UCyTPcy6YKpe1ta1nx/O/TZiPe+A1YQ0I40L7TKOwya7qPssppwusA
         h5Jhkl+8lhxBDcycuw/7FvaEdB+oAqtR9JlNQ9gCM3HP3Y2IfzmmOAAQWL0m96SNu7rq
         ntyot93n/xHIGspU2ALSwfs9nkBKCrDG7KbxuVPWNsZVVA4cO39Mvr8SKZtYCqdtaYnO
         xg2A==
X-Gm-Message-State: AOUpUlHTkOpw5Zzr43aSDNCsn+ZhIatFUlUb9zw1P+eEC5/XH9g0O6R7
        fYweGs0+V/p4GPdyocxpBOR8rN8XZ2y4hJdbdG0=
X-Google-Smtp-Source: AA+uWPxDsOI2s6LgTWPcgxL8ojTAGX3tbJ7p43HAqyQFPRKqvyXM9GgXGE7AuAruB6+2SezBmfPasS4dlVpD9IeNRl4=
X-Received: by 2002:a37:6ac3:: with SMTP id f186-v6mr18257816qkc.224.1534194792347;
 Mon, 13 Aug 2018 14:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180811095235.1938-1-stefan@agner.ch>
In-Reply-To: <20180811095235.1938-1-stefan@agner.ch>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 13 Aug 2018 23:12:55 +0200
Message-ID: <CAK8P3a1SOAYkbMV-YvQ9pVhAk7J6jt9Sc23gc1idj8u5ftyp=A@mail.gmail.com>
Subject: Re: [PATCH] ARM: require GCC for FRAME_POINTER
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 11:52 AM Stefan Agner <stefan@agner.ch> wrote:
>

> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 693f84392f1b..cb65cf67dfa2 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -54,7 +54,7 @@ config DEBUG_WX
>  # n, but then RMK will have to kill you ;).
>  config FRAME_POINTER
>         bool
> -       depends on !THUMB2_KERNEL
> +       depends on !THUMB2_KERNEL && CC_IS_GCC
>         default y if !ARM_UNWIND || FUNCTION_GRAPH_TRACER
>         help
>           If you say N here, the resulting kernel will be slightly smaller and

I suspect we actually need a bit more complexity here, as we have a couple
of options that do something like:

       select FRAME_POINTER if !MIPS && !PPC && !ARM_UNWIND && !S390
&& !MICROBLAZE && !ARC && !X86

This means that in configurations without ARM_UNWIND, we still
fail to build with clang. Maybe something like x86 would work, this currently
has

choice
        prompt "Choose kernel unwinder"
        default UNWINDER_ORC if X86_64
        default UNWINDER_FRAME_POINTER if X86_32

config UNWINDER_ORC
        bool "ORC unwinder"
        depends on X86_64
        select STACK_VALIDATION

config UNWINDER_FRAME_POINTER
        bool "Frame pointer unwinder"
        select FRAME_POINTER

config UNWINDER_GUESS
        bool "Guess unwinder"
        depends on EXPERT
        depends on !STACKDEPOT

endchoice

so we always get some form of unwinding, but have different levels of
functionality in them. Implementing ORC on ARM might be nice, but
that's a lot of work, so I'm not expecting you to do that.

The simplest approach would be to always force ARM_UNWIND=y
when not building with gcc:

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 43d598c9b1f9..b390ac99ba20 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -60,7 +60,7 @@ config FRAME_POINTER
          reported is severely limited.

 config ARM_UNWIND
-       bool "Enable stack unwinding support (EXPERIMENTAL)"
+       bool "Enable stack unwinding support (EXPERIMENTAL)" if CC_IS_GCC
        depends on AEABI
        default y
        help

      Arnd
