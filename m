Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F8FC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C8C2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfAUI4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:56:31 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37589 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729971AbfAUI40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:56:26 -0500
Received: by mail-vs1-f66.google.com with SMTP id n13so12183765vsk.4;
        Mon, 21 Jan 2019 00:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZ5xKfwCuPvjsbs8ypviK2wVON115JbrXd6QLz3o9YM=;
        b=bHADKebxrqlhIG5XMxev/TeKvRHwYPxkUnLwFwnvUCi/5vHpmRA63HSlijAEcbAxvc
         NMngcDHCI1ROYq98D8pE/SJBcFeSaytXK212uzydt7PN3WPWtHACtTz5UcFPNTiCBY2k
         Dee+Xgwe/Xt4yhjiBttzSLjHem8ZB6zDmvkX5zfEnNMaFhYSxWBbDiwlFU8eyez5VccI
         kM7SH9oZWvvF+avF6RQ/Zt0VHy7Hns8qSRl7woVXnAzfUIVMXTm8bqx6/vdkKCo2THsL
         YDq1XtzmWmG7QLD5iCWT9vvJQjC5Uu9hTgDqDFsBy1nsaH2xcQGCyN6qeyqs9GPdozA8
         h74w==
X-Gm-Message-State: AJcUukeODy/Zyn10VHLunphFNiXdTmE4OBhNYsXwZj0LujD7kPSb3BhJ
        8tkLSjd2nX0KJ5xKLZPFuhAkcJLaK0n4POVaujM=
X-Google-Smtp-Source: ALg8bN6oQTjQTvMkhu0RSRQU3eG9DnGNZiAO15hurqtwS01M6srTDPs1MhTBku760Abay4RjwT0+IVQlARbp3cdEMM8=
X-Received: by 2002:a67:c202:: with SMTP id i2mr11527790vsj.11.1548060984197;
 Mon, 21 Jan 2019 00:56:24 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-30-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-30-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jan 2019 09:56:11 +0100
Message-ID: <CAMuHMdV2z_nacfpuqatsy6cer_7xy+7-i0MhJNbNdcz7Aw-fSw@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit architectures
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

On Fri, Jan 18, 2019 at 5:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
> This adds 21 new system calls on each ABI that has 32-bit time_t
> today. All of these have the exact same semantics as their existing
> counterparts, and the new ones all have macro names that end in 'time64'
> for clarification.
>
> This gets us to the point of being able to safely use a C library
> that has 64-bit time_t in user space. There are still a couple of
> loose ends to tie up in various areas of the code, but this is the
> big one, and should be entirely uncontroversial at this point.
>
> In particular, there are four system calls (getitimer, setitimer,
> waitid, and getrusage) that don't have a 64-bit counterpart yet,
> but these can all be safely implemented in the C library by wrapping
> around the existing system calls because the 32-bit time_t they
> pass only counts elapsed time, not time since the epoch. They
> will be dealt with later.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/kernel/syscalls/syscall.tbl       | 20 +++++++++

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
