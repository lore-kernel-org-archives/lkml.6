Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9303C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF222089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfAUUkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:40:22 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40807 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfAUUkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:40:20 -0500
Received: by mail-qt1-f194.google.com with SMTP id k12so25000217qtf.7;
        Mon, 21 Jan 2019 12:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dkvN5kxF5ScgcD3pJdfvtsR7PQS22YCBaQenUgPUi4M=;
        b=WxIbvVFxTx0suXOVY5LfjO8lIw0TcCbFhtasyWeTACtU9Rd0rCx9k0eylQMgWCXgdz
         S0iTVwiLW8cU3cPWBDQEHhT2/9NyhuRvx1oFfd6R8rwDFxjrjHWgJmY0x8FsLQlbWMOB
         xgJTTueMBUTkhWTCS/3cmwPN1ZZnyA9JlP7mnzwlhrJGrkX1OvBvLz2e3VZWyfg5Jhi8
         F+W6T0PjHCKtEj9zVh+Mh5BAGS8+dlPFidGUI2/h5ZV5ySJmVbhKMags2M2zO8uEzyL/
         Jrwvs9hZGOOg6Ydk44MjI1TWIf5xlrrXu83fBVjN61IIodAq1pqMwrLTa80la9AnFzGE
         VAag==
X-Gm-Message-State: AJcUukcx0EZGJ8H4hV3AAcPKqP+AZd52MhJMpZxCDf8NYpPmKK/sASWX
        yDOH1rIX2NWgENIKUWCBA6AiHzj+sXZ9mPFXPPM=
X-Google-Smtp-Source: ALg8bN6NJA3JpmMy0Rnw4UHCeBwdUwtaoF1faqE/rX9S/LB1A3Pp1thWOe1j9+1qk4H6TfQ6cwy2yDs31Lm4Qgs2hsM=
X-Received: by 2002:a05:6214:1087:: with SMTP id o7mr27413754qvr.115.1548103218172;
 Mon, 21 Jan 2019 12:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-30-arnd@arndb.de>
 <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
 <CAK8P3a0V+xboaGAF2nqrYtpjXXA7y0LcvCKi4ngLTus1D_XZBA@mail.gmail.com>
 <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com>
 <20190119142852.cntdihah4mpa3lgx@e5254000004ec.dyn.armlinux.org.uk>
 <CAMuHMdXzQNEEDjWrmTph8Krovj1g2WhnBUaM=FvKB+J2fZqctA@mail.gmail.com> <CAK8P3a04UC2dHVqx1gHXJQzsDw446h1ghLEuRe0xmUyJgrOktw@mail.gmail.com>
In-Reply-To: <CAK8P3a04UC2dHVqx1gHXJQzsDw446h1ghLEuRe0xmUyJgrOktw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Jan 2019 21:40:01 +0100
Message-ID: <CAK8P3a11Pme2d6VbTb2t7fi_vd7UmNuN-yOf2zT59KPzbCT1Lw@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit architectures
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 6:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jan 21, 2019 at 9:19 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Regardless, I'm wondering what to do with the holes marked "room for
> > arch specific calls".
> > When is a syscall really arch-specific, and can it be added there, and
> > when does it turn out (later) that it isn't, breaking the
> > synchronization again?
>
> We've had a bit of that already, with cacheflush(), which exists on
> a couple of architectures, including some that use the first
> 'arch specific' slot (244) of the asm-generic table. I think this
> will be rare enough that we can figure out a solution when we
> get there.
>
> > The pkey syscalls may be a bad example, as AFAIU they can be implemented
> > on some architectures, but not on some others.  Still, I had skipped them
> > when adding new syscalls to m68k.
> >
> > Perhaps we should get rid of the notion of "arch-specific syscalls", and
> > reserve a slot everywhere anyway?
>
> I don't mind calling the hole something else if that helps. Out of
> principle I would already assume that anything we add for x86
> or the generic table should be added everywhere, but we can
> make it broader than that.

Applying this fixup below,

     ARnd

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl
b/arch/x86/entry/syscalls/syscall_32.tbl
index d9c2d2eea044..955ab6a3b61f 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -398,7 +398,7 @@
 384    i386    arch_prctl              sys_arch_prctl
 __ia32_compat_sys_arch_prctl
 385    i386    io_pgetevents           sys_io_pgetevents_time32
 __ia32_compat_sys_io_pgetevents
 386    i386    rseq                    sys_rseq
 __ia32_sys_rseq
-# room for arch specific syscalls
+# don't use numbers 387 through 392, add new calls at the end
 393    i386    semget                  sys_semget
 __ia32_sys_semget
 394    i386    semctl                  sys_semctl
 __ia32_compat_sys_semctl
 395    i386    shmget                  sys_shmget
 __ia32_sys_shmget
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl
b/arch/x86/entry/syscalls/syscall_64.tbl
index 43a622aec07e..2ae92fddb6d5 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -343,6 +343,8 @@
 332    common  statx                   __x64_sys_statx
 333    common  io_pgetevents           __x64_sys_io_pgetevents
 334    common  rseq                    __x64_sys_rseq
+# don't use numbers 387 through 423, add new calls after the last
+# 'common' entry

 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/uapi/asm-generic/unistd.h
b/include/uapi/asm-generic/unistd.h
index 53831e4a4c86..acf9a07ab2ff 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -740,7 +740,7 @@ __SC_COMP_3264(__NR_io_pgetevents,
sys_io_pgetevents_time32, sys_io_pgetevents,
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_kexec_file_load 294
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
-/* 295 through 402 are unassigned to sync up with generic numbers */
+/* 295 through 402 are unassigned to sync up with generic numbers, don't use */
 #if __BITS_PER_LONG == 32
 #define __NR_clock_gettime64 403
 __SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
