Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52239C5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9302086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfARROx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:14:53 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36022 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfARROv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:14:51 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so8465175qkf.3;
        Fri, 18 Jan 2019 09:14:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cM6Ct6RNNXTziZEbUSSe56myHuH3NS1roB2yrpi3ejY=;
        b=b4hmzZrSqTo83uQbV1cw3TwQ8sG4zLm9cH3DbGueMW5YR7PG1tKkjf9bntVC9hoC+P
         nIUDpuYJp5xaHTnAoIY99ITinIWaZOYuFRIh9miXdLiNPj9TtmsF1QUUE6yjIGR3E+0+
         752KuxfxqBWV9gapXXssOhugThp6KVC7ueoylPJ4o6cFQAhbHoEVlt3AeHJASFqVAWdT
         xbbeON+ILVtJwwozSxoMGkwjFNaFynN67iaQC49tJlkNFZRTTxnyTAnNb5nVdl7dL7X6
         UyqwC37DjATpiItosXgz3EGI+hVddTusaWtUE5mDlh0zrAPlPWFYzHsV+dQJuN9tUAeJ
         fv1w==
X-Gm-Message-State: AJcUukdL3RtRDY3mzEj7cxG6ICjiNuWOBfiK8DJgnYyzr4AzmTSnkc3x
        okIAgWH2ZLnW4yoX0SMH6bdXaSPWVu8MN9x7TkU=
X-Google-Smtp-Source: ALg8bN6YuxAZx88mWjLK6OJGww6yso8mTxW2uQ+U16+TTtpFWJaRgawaUEpqTv2Trum/q/Wu6cLlwpnMJ3TVNfmaobA=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr15079174qkf.107.1547831689678;
 Fri, 18 Jan 2019 09:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
In-Reply-To: <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Jan 2019 18:14:33 +0100
Message-ID: <CAK8P3a3xUpbk+Wpo5kdDtZ81jQuzEZH6jdmJJNeNM+acueg+Dw@mail.gmail.com>
Subject: Re: [PATCH v2 00/29] y2038: add time64 syscalls
To:     Dennis Clarke <dclarke@blastwave.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
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

On Fri, Jan 18, 2019 at 5:57 PM Dennis Clarke <dclarke@blastwave.org> wrote:
>
> On 1/18/19 11:18 AM, Arnd Bergmann wrote:
> > This is a minor update of the patches I posted last week, I
> > would like to add this into linux-next now, but would still do
> > changes if there are concerns about the contents. The first
> > version did not see a lot of replies, which could mean that
> > either everyone is happy with it, or that it was largely ignored.
> >
> > See also the article at https://lwn.net/Articles/776435/.
>
> I would be happy to read "Approaching the kernel year-2038 end game"
> however it is behind a pay wall.  Perhaps it may be best to just
> host interesting articles about open source idea elsewhere.

It's a short summary of the current state. You can also find a
video and slides from my ELC presentation online for a little more
context.

Generally speaking, I'd recommend paying for the subscription to
lwn.net to anyone interested in the kernel, but it should become
visible to everyone with the next day (a week after the initial
publication). In the meantime, you can find the article at
https://lwn.net/SubscriberLink/776435/a59d93d01d1addfc/.

Finally, I've made a list of the remaining work that Deepa
and I are planning to still continue (this should be mostly
complete but may be missing a few things):

syscalls
 - merge big series for 5.1, to allow time64 syscalls
 - waitid/wait4/getrusage should get a replacement based on __kernel_timespec
 - getitimer/setitimer should probably follow getrusage
 - vdso, waiting for consolidation series from Vincenzo Frascino before
   adding time64 entry points

file systems
 - range checks on timestamps
 - xfs
 - NFS
 - hfs/hfsplus
 - coda
 - hostfs
 - relatime_need_update

drivers
 - media
 - alsa
 - sockets
 - af_packet
 - ppp ioctl
 - rtc ioctl
 - omap3isp

core kernel
 - fix ELF core files (elfcore.h)
 - syscall Audit code (kernel/audit.c, kernel/auditsc.c)
 - make all time32 code conditional
 - remove include/linux/timekeeping32.h
 - remove compat_time* from time32.h
 - remove timeval
 - remove timespec
 - remove time_t

     Arnd
