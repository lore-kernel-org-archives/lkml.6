Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8BFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CA2206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbfAPAJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 19:09:27 -0500
Received: from ozlabs.org ([203.11.71.1]:51685 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbfAPAJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 19:09:26 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43fSHb5L9yz9sBQ;
        Wed, 16 Jan 2019 11:09:15 +1100 (AEDT)
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
In-Reply-To: <CAK8P3a3eUzGDrJtV2ySpgHwjKHwZYr+1xHp6tChCt1gWi=mJ+g@mail.gmail.com>
References: <20190110162435.309262-1-arnd@arndb.de> <20190110162435.309262-15-arnd@arndb.de> <87pnsz28k2.fsf@concordia.ellerman.id.au> <CAK8P3a0uas76i2W1yjFvxHT-2=A8_egUZeAUM-Vya6386+87Xg@mail.gmail.com> <CAK8P3a3eUzGDrJtV2ySpgHwjKHwZYr+1xHp6tChCt1gWi=mJ+g@mail.gmail.com>
Date:   Wed, 16 Jan 2019 11:09:12 +1100
Message-ID: <874la9zcnr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Tue, Jan 15, 2019 at 4:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Mon, Jan 14, 2019 at 4:59 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> > Arnd Bergmann <arnd@arndb.de> writes:
>> > >  arch/m68k/kernel/syscalls/syscall.tbl     | 11 +++++++++++
>> > >  arch/mips/kernel/syscalls/syscall_o32.tbl | 11 +++++++++++
>> > >  arch/powerpc/kernel/syscalls/syscall.tbl  | 12 ++++++++++++
>> >
>> > I have some changes I'd like to make to our syscall table that will
>> > clash with this.
>> >
>> > I'll try and send them today.
>>
>> Ok. Are those for 5.0 or 5.1? If they are intended for 5.0, it would be
>> nice for me to have a branch based on 5.0-rc1 that I can put
>> the other patches on top of.
>
> There is also another change that I considered:
>
> At the end of my series, we have a lot of entries like
>
> 245     32      clock_settime                   sys_clock_settime32
> 245     64      clock_settime                   sys_clock_settime
> 245     spu     clock_settime                   sys_clock_settime
>
> which could be folded into
>
> 245     32      clock_settime                   sys_clock_settime32
> 245     spu64 clock_settime                   sys_clock_settime
>
> if we just add another option to the ABI field. Any thoughts on
> that?

My series splits spu out into a separate field. So the above would be:

245     32	-	clock_settime                   sys_clock_settime32
245     64	spu	clock_settime                   sys_clock_settime

cheers
