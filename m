Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDC3C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562F52084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfAUI4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:56:21 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33785 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbfAUI4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:56:18 -0500
Received: by mail-vs1-f67.google.com with SMTP id p74so12182062vsc.0;
        Mon, 21 Jan 2019 00:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/6v0ZVPaXQi5FWJ19dLuHcLgd/E9ZECv5IjLmf6PoI=;
        b=EyAzTbPENUpPmTYgJxaA1sXp7UQHbKfwqLjssiVYRmV6kNSCGAT9BG/JsSu5+RIxmy
         H9r4grTvIlZatxclZAGLWfkcrB+qY0TWen9dm+LUXI15aisNr8iFt2MPUfbstKCGHx1l
         e9kmDE4G29S90ispupcoxwnoQ/+W9J4tIyLFQd4CIJs5p3DJ8vR+mf6218hPExefSlAa
         pbT+I04ocE0trQ2YFzGQ8Mzp5XnYV6gDcq4tOz83gZVOcsX+ZKSDI+fDxhAy7dcUtCby
         O45ML/nX9aTj7ewUxjMnvODnVSYJGq4/70tFFd4qrbJRyarnlMCP7uQObSJWsXNZh3qP
         UDqQ==
X-Gm-Message-State: AJcUukdObH7NbWqu2LTNEGUl3d+7V8JwkmhidtHkHmiIiAXvvq5RY6EP
        t+wrENt6kUytwxj7JF/ttgWEdzcd/zAXe7D8KQU=
X-Google-Smtp-Source: ALg8bN6mqPPGjY0mRgSzvQIVAiUYVEkzmmA1fTVJs4P5AJXGDwVjqnqovDI8HCxNMByb80ziNpDqZXxAv1iGgV8yZxk=
X-Received: by 2002:a67:3885:: with SMTP id n5mr10358537vsi.96.1548060976721;
 Mon, 21 Jan 2019 00:56:16 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-27-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-27-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jan 2019 09:56:02 +0100
Message-ID: <CAMuHMdWiHTjDT9-tnjgJy9qCWRr+qUgsJa6LjpRDJQzhoJqnzw@mail.gmail.com>
Subject: Re: [PATCH v2 26/29] y2038: use time32 syscall names on 32-bit
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 5:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> This is the big flip, where all 32-bit architectures set COMPAT_32BIT_TIME
> abd use the _time32 system calls from the former compat layer instead
> of the system calls that take __kernel_timespec and similar arguments.
>
> The temporary redirects for __kernel_timespec, __kernel_itimerspec
> and __kernel_timex can get removed with this.
>
> It would be easy to split this commit by architecture, but with the new
> generated system call tables, it's easy enough to do it all at once,
> which makes it a little easier to check that the changes are the same
> in each table.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/kernel/syscalls/syscall.tbl       | 42 +++++------

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
