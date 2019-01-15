Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668F1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3971920675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfAOPBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:01:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33389 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfAOPBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:01:42 -0500
Received: by mail-qk1-f194.google.com with SMTP id d15so1727212qkj.0;
        Tue, 15 Jan 2019 07:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/j2xo8vyz06xg1gQlvQEYwJpD6WHXsDfeyUW+0147bI=;
        b=XChiI9LVpdP21E9M1BNsF/4opcOvd3RVRf4P0jzJvaaYD3PfScOPTwoLSpaZVZjapk
         H7drWl6gyidFgDVdRtsKtSLlRHNkr6y0gED/HPE/XVBUHg9cfuXp3d2+QV+L0cdyCdZ/
         eP2TUAINwFOV517OKUXtJIksrCi82W2alWItH8OYHyzVU9pdIkX9bEDJQ0CgOiE0ztb+
         m0l28O43hGTk2FekD9zKBlzDghMdN07HqbMH1yNvgI5PkEEbfk3gJAg8q41wRBS/I+S0
         rWdyGqSYnOvdah3rJB+JqTnU/kIJIzVufHfDWoIbCXI4ltTOslUfOcA16SWLezsnMiQf
         Puow==
X-Gm-Message-State: AJcUukddl6JAB0EAsXSDy6xi7cH5ub8Rvmshvn7te49258faIIaRjZaH
        5hCoi7ly0oLN60ugy8s2xVXNDze/xTs+MwTwJd0=
X-Google-Smtp-Source: ALg8bN66ERQQcRHL6kpituOugRhaYl47wq+bMeU6L9UD0bbjiIXTK390uY37r+V2oE8uztNtYSgBmDdqY7/ckMkByIg=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr2882793qkf.107.1547564501193;
 Tue, 15 Jan 2019 07:01:41 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de> <20190110162435.309262-15-arnd@arndb.de>
 <87pnsz28k2.fsf@concordia.ellerman.id.au>
In-Reply-To: <87pnsz28k2.fsf@concordia.ellerman.id.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 15 Jan 2019 16:01:24 +0100
Message-ID: <CAK8P3a0uas76i2W1yjFvxHT-2=A8_egUZeAUM-Vya6386+87Xg@mail.gmail.com>
Subject: Re: [PATCH 14/15] arch: add split IPC system calls where needed
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
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
        Firoz Khan <firoz.khan@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 4:59 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> >  arch/m68k/kernel/syscalls/syscall.tbl     | 11 +++++++++++
> >  arch/mips/kernel/syscalls/syscall_o32.tbl | 11 +++++++++++
> >  arch/powerpc/kernel/syscalls/syscall.tbl  | 12 ++++++++++++
>
> I have some changes I'd like to make to our syscall table that will
> clash with this.
>
> I'll try and send them today.

Ok. Are those for 5.0 or 5.1? If they are intended for 5.0, it would be
nice for me to have a branch based on 5.0-rc1 that I can put
the other patches on top of.

> > diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> > index db3bbb8744af..1bffab54ff35 100644
> > --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> > +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> > @@ -425,3 +425,15 @@
> >  386  nospu   pkey_mprotect                   sys_pkey_mprotect
> >  387  nospu   rseq                            sys_rseq
> >  388  nospu   io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> > +# room for arch specific syscalls
> > +392  64      semtimedop                      sys_semtimedop
> > +393  common  semget                          sys_semget
> > +394  common  semctl                          sys_semctl                      compat_sys_semctl
> > +395  common  shmget                          sys_shmget
> > +396  common  shmctl                          sys_shmctl                      compat_sys_shmctl
> > +397  common  shmat                           sys_shmat                       compat_sys_shmat
> > +398  common  shmdt                           sys_shmdt
> > +399  common  msgget                          sys_msgget
> > +400  common  msgsnd                          sys_msgsnd                      compat_sys_msgsnd
> > +401  common  msgrcv                          sys_msgrcv                      compat_sys_msgrcv
> > +402  common  msgctl                          sys_msgctl                      compat_sys_msgctl
>
> We already have a gap at 366-377 from when we tried to add the split IPC
> calls a few years back.
>
> I guess I don't mind leaving that gap and using the common numbers as
> you've done here.
>
> But it would be good to add a comment pointing out that we have room
> at 366 for more arch specific syscalls as well.

Ah, I missed that. I've added this to my patch now:

index 5c0936d862fc..2ddfba536d5f 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -460,6 +460,7 @@
 363    spu     switch_endian                   sys_ni_syscall
 364    common  userfaultfd                     sys_userfaultfd
 365    common  membarrier                      sys_membarrier
+# 366-377 originally left for IPC, now unused
 378    nospu   mlock2                          sys_mlock2
 379    nospu   copy_file_range                 sys_copy_file_range
 380    common  preadv2                         sys_preadv2
         compat_sys_preadv2

       Arnd
