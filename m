Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328B8C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9132084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfAUI4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:56:04 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43884 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbfAUI4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:56:02 -0500
Received: by mail-ua1-f65.google.com with SMTP id z11so6652689uaa.10;
        Mon, 21 Jan 2019 00:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJScdj9p18oAEvTl9TNP9AzhiR3NeXZIyKQOy3xgTy8=;
        b=sm7UdR7+OQ0Ar8QgmbYdCAoxsTemEPC5AumhUeqc5KyfmeXT2Yy8MSYfhqRJghQOmW
         Q6YsuPhRMVRJBFtDUMRbdBgQ4XazTDkS9OXtKs31zpaS4sFcziyKkp/DPdXPRq9TlGQJ
         zL+z/qUXY/8XaSAf0s6EEKjo+iWv9kV8px2D0ikIntk2lZ2ISMej19JuPXf4yXZgOL/F
         z5c1tNnU8YE+rS33LuXuAL4Zaaoc/BYLBP/cWsmKWH2c7wiLVn3gZg/pySrCSmEm3i4s
         CbyGL0N+MTObVHBhNX8IqhmdRha7czFHOzdKQhOJKeQHLJAEBK14TME8FK0/yNO03L9q
         szPQ==
X-Gm-Message-State: AJcUukcB7/BZDJF49J99W58563FwdAMzDDfH4CcqxS+EMngNwU3FnnWF
        Z9waKt1LyOLZ0Qji99YCX5eTzHrUuD65YYNM53c=
X-Google-Smtp-Source: ALg8bN4uFN3zWGMaGcasO6usU7NqldPno3Vg0buANjUHshxvHAfNTtSuQ7VautHVX5df0UK1s1iotaDgJP2GFGxetwA=
X-Received: by 2002:ab0:7251:: with SMTP id d17mr11840905uap.0.1548060960356;
 Mon, 21 Jan 2019 00:56:00 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-15-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-15-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jan 2019 09:55:48 +0100
Message-ID: <CAMuHMdWaJyNqUeq4qu3AgU0fYrQdZ_zbo0DFFiM97Y5HESYYnA@mail.gmail.com>
Subject: Re: [PATCH v2 14/29] arch: add pkey and rseq syscall numbers everywhere
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

On Fri, Jan 18, 2019 at 5:20 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Most architectures define system call numbers for the rseq and pkey system
> calls, even when they don't support the features, and perhaps never will.
>
> Only a few architectures are missing these, so just define them anyway
> for consistency. If we decide to add them later to one of these, the
> system call numbers won't get out of sync then.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/kernel/syscalls/syscall.tbl   | 4 ++++

> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -388,6 +388,10 @@
>  378    common  pwritev2                        sys_pwritev2
>  379    common  statx                           sys_statx
>  380    common  seccomp                         sys_seccomp
> +381    common  pkey_alloc                      sys_pkey_alloc
> +382    common  pkey_free                       sys_pkey_free
> +383    common  pkey_mprotect                   sys_pkey_mprotect
> +384    common  rseq                            sys_rseq

Note that all architectures that already define pkey syscalls, list
pkey_mprotect
first.

Regardless, for m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

>  # room for arch specific calls
>  393    common  semget                          sys_semget
>  394    common  semctl                          sys_semctl

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
