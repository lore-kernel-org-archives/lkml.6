Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68812C2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4170221019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbfAUQbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:31:22 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44211 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730112AbfAUQbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:31:20 -0500
Received: by mail-qt1-f193.google.com with SMTP id n32so24127341qte.11;
        Mon, 21 Jan 2019 08:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugnN37Htp2pcGbvXPo+DEz/r4541Rca2swp85kVj/dg=;
        b=AN4J5uEie5Hx6iRzpgTqk2T78/TYbZGWKu5NP3ScooQUyeF+pmyzaxewwf+GzaK+uP
         nYxvf88tBZStbUoK/Lpu2lZTijjAkRYgGZdTml5XNBvpxoa8v7N78Gc64UoRdsFOM4eV
         92y+zLsPd9e7Vb0DeQ8153pnjbQ4v9+wUCBTLieS5wVDIHNRqZslR8xxxmdMciaITTjG
         QjZy8xIFdXDUdFOTyMMhQoc6kIUZ4QUoVLQIfpJBEdRRD6IcpD1CZs4f87OjXnqL5hO1
         fut8e9AbtYZy8M3vl2AkJoriRYJIB6vvIV0Ob/+TXIQThjD5KPlZZBzy3BNJO5njSqKk
         IW/g==
X-Gm-Message-State: AJcUukdhC7yC2jcZZEZAx/kA2Af/xMeH3SmcxCgjRSzE7Bk8qsfTVphi
        yFeYy2ypdj+52BDoVBK+QEffrKZNQpm0NdOBih0=
X-Google-Smtp-Source: ALg8bN4IjC8153m9pB3iBWOATh3R/RnsAQ6wVGb5LY7XqftLLWs9CXLGl7GxR+zlIVcd8dP96h71Ls+Fr/txo5y0uPg=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr27326381qte.212.1548088278474;
 Mon, 21 Jan 2019 08:31:18 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-30-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-30-arnd@arndb.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Jan 2019 17:31:01 +0100
Message-ID: <CAK8P3a2grsgvLeBHFoLnnpJti7qkZFfBPTrXf+CoihtOJKySzw@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit architectures
To:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     Matt Turner <mattst88@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 5:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> This adds 21 new system calls on each ABI that has 32-bit time_t
> today. All of these have the exact same semantics as their existing
> counterparts, and the new ones all have macro names that end in 'time64'
> for clarification.
>
> This gets us to the point of being able to safely use a C library
> that has 64-bit time_t in user space. There are still a couple of
> loose ends to tie up in various areas of the code, but this is the
> big one, and should be entirely uncontroversial at this point.

I've successfully tested this with musl and LTP now, using an
i386 kernel. The musl port I used is at
https://git.linaro.org/people/arnd.bergmann/musl-y2038.git/
This is just an updated version of what I used for testing last
year, using the current syscall assignment, and going back
to the time32 versions of getitimer/setitimer and
wait4/waitid/getusage.

It's certainly not intended for merging like this, but a proper
musl port is under discussion now, and this should be
sufficient if anyone else wants to try out the new syscall
ABI before we merge it.

The LTP I have is heavily hacked, and has a number of
failures resulting from differences between musl and glibc,
or from the way we convert between the kernel types and
the user space types.

The testing found one minor bug in all the kernel syscall tables:

> +418    common  mq_timedsend_time64             sys_mq_timedsend
> +419    common  mq_timedreceiv_time64           sys_mq_timedreceive

While this would have fit in with umount(), creat() and mknod(),
it was unintentional, and I've changed it back to
mq_timedreceive_time64 (with an added 'e').

       Arnd
