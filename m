Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB33FECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D98214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D98214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeIQS2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:28:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54747 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeIQS2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:28:09 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1t8v-0004ww-8P; Mon, 17 Sep 2018 15:00:45 +0200
Date:   Mon, 17 Sep 2018 15:00:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, matt@softrans.com.au,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>, vkuznets@redhat.com,
        devel@linuxdriverproject.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
 support
In-Reply-To: <CAK8P3a1QfynDxkKBLXVa5Qj_z+7ct3QB5sDYuY5QV3ht-a0cTg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809171451380.16580@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de> <CAK8P3a1QfynDxkKBLXVa5Qj_z+7ct3QB5sDYuY5QV3ht-a0cTg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2018, Arnd Bergmann wrote:
> On Fri, Sep 14, 2018 at 2:52 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> A couple of architectures (s390, ia64, riscv, powerpc, arm64)
> implement the vdso as assembler code at the moment, so they
> won't be as easy to consolidate (other than outright replacing all
> the code).
> 
> The other five:
> arch/x86/entry/vdso/vclock_gettime.c
> arch/sparc/vdso/vclock_gettime.c
> arch/nds32/kernel/vdso/gettimeofday.c
> arch/mips/vdso/gettimeofday.c
> arch/arm/vdso/vgettimeofday.c
>
> are basically all minor variations of the same code base and could be
> consolidated to some degree.
> Any suggestions here? Should we plan to do that consolitdation based on
> your new version, or just add clock_gettime64 in arm32 and x86-32, and then
> be done with it? The other ones will obviously still be fast for 32-bit time_t
> and will have a working non-vdso sys_clock_getttime64().

In principle consolidating all those implementations should be possible to
some extent and probably worthwhile. What's arch specific are the actual
accessors to the hardware clocks.

> I also wonder about clock_getres(): half the architectures seem to implement
> it in vdso, but notably arm32 and x86 don't, and I had not expected it to be
> performance critical given that the result is easily cached in user space.

getres() is not really performance critical, but adding it does not create
a huge problem either.

Thanks,

	tglx

