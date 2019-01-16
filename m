Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033B6C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2690206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfAPAKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 19:10:22 -0500
Received: from ozlabs.org ([203.11.71.1]:46203 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbfAPAKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 19:10:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43fSJm5W6fz9sBQ;
        Wed, 16 Jan 2019 11:10:16 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@arndb.de>
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
        the arch/x86 maintainers <x86@kernel.org>,
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
Subject: Re: [PATCH 14/15] arch: add split IPC system calls where needed
In-Reply-To: <CAK8P3a0uas76i2W1yjFvxHT-2=A8_egUZeAUM-Vya6386+87Xg@mail.gmail.com>
References: <20190110162435.309262-1-arnd@arndb.de> <20190110162435.309262-15-arnd@arndb.de> <87pnsz28k2.fsf@concordia.ellerman.id.au> <CAK8P3a0uas76i2W1yjFvxHT-2=A8_egUZeAUM-Vya6386+87Xg@mail.gmail.com>
Date:   Wed, 16 Jan 2019 11:10:16 +1100
Message-ID: <871s5dzclz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:
> On Mon, Jan 14, 2019 at 4:59 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>> >  arch/m68k/kernel/syscalls/syscall.tbl     | 11 +++++++++++
>> >  arch/mips/kernel/syscalls/syscall_o32.tbl | 11 +++++++++++
>> >  arch/powerpc/kernel/syscalls/syscall.tbl  | 12 ++++++++++++
>>
>> I have some changes I'd like to make to our syscall table that will
>> clash with this.
>>
>> I'll try and send them today.
>
> Ok. Are those for 5.0 or 5.1? If they are intended for 5.0, it would be
> nice for me to have a branch based on 5.0-rc1 that I can put
> the other patches on top of.

For 5.1.

I can put them in a topic branch for you.

>> > diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
>> > index db3bbb8744af..1bffab54ff35 100644
>> > --- a/arch/powerpc/kernel/syscalls/syscall.tbl
>> > +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
>> > @@ -425,3 +425,15 @@
>> >  386  nospu   pkey_mprotect                   sys_pkey_mprotect
>> >  387  nospu   rseq                            sys_rseq
>> >  388  nospu   io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
>> > +# room for arch specific syscalls
>> > +392  64      semtimedop                      sys_semtimedop
>> > +393  common  semget                          sys_semget
>> > +394  common  semctl                          sys_semctl                      compat_sys_semctl
>> > +395  common  shmget                          sys_shmget
>> > +396  common  shmctl                          sys_shmctl                      compat_sys_shmctl
>> > +397  common  shmat                           sys_shmat                       compat_sys_shmat
>> > +398  common  shmdt                           sys_shmdt
>> > +399  common  msgget                          sys_msgget
>> > +400  common  msgsnd                          sys_msgsnd                      compat_sys_msgsnd
>> > +401  common  msgrcv                          sys_msgrcv                      compat_sys_msgrcv
>> > +402  common  msgctl                          sys_msgctl                      compat_sys_msgctl
>>
>> We already have a gap at 366-377 from when we tried to add the split IPC
>> calls a few years back.
>>
>> I guess I don't mind leaving that gap and using the common numbers as
>> you've done here.
>>
>> But it would be good to add a comment pointing out that we have room
>> at 366 for more arch specific syscalls as well.
>
> Ah, I missed that. I've added this to my patch now:
>
> index 5c0936d862fc..2ddfba536d5f 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -460,6 +460,7 @@
>  363    spu     switch_endian                   sys_ni_syscall
>  364    common  userfaultfd                     sys_userfaultfd
>  365    common  membarrier                      sys_membarrier
> +# 366-377 originally left for IPC, now unused
>  378    nospu   mlock2                          sys_mlock2
>  379    nospu   copy_file_range                 sys_copy_file_range
>  380    common  preadv2                         sys_preadv2
>          compat_sys_preadv2

Thanks.

cheers
