Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbeCUSPh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 14:15:37 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:38133 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeCUSPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 14:15:34 -0400
X-Google-Smtp-Source: AG47ELuvwwPRYrwjfZsm0plzlGbNagYJbCPs+GfuCgdUHKFmRkYA+wIoaux1T0IlYh9piwty8dZUKvEEBdCE5RpkU8U=
MIME-Version: 1.0
In-Reply-To: <20180321074634.dzpyjz3ia46snodh@gmail.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com> <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com> <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com> <CA+55aFybTvLz47mw=AG21jCJv_hE2vaVyiJP_F-4vAD-3Gnc7Q@mail.gmail.com>
 <20180321074634.dzpyjz3ia46snodh@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Mar 2018 11:15:32 -0700
X-Google-Sender-Auth: Sq0edLDRaZQ8jmfOFGtImab0SOA
Message-ID: <CA+55aFyK6uJopBjZGyeDz0O+qzCac6AwPkJyOpuaT69inPgVgw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        David Laight <David.Laight@aculab.com>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>,
        "indranil@chelsio.com" <indranil@chelsio.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Fenghua Yu <fenghua.yu@intel.com>, Eric Biggers <ebiggers3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 12:46 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> So I added a bit of instrumentation and the current state of things is that on
> 64-bit x86 every single task has an initialized FPU, every task has the exact
> same, fully filled in xfeatures (XINUSE) value:

Bah. Your CPU is apparently some old crud that barely has AVX. Of
course all those features are enabled.

> Note that this is with an AVX (128-bit) supporting CPU:

That's weak even by modern standards.

I have MPX bounds and MPX CSR on my old Skylake.

And the real worry is things like AVX-512 etc, which is exactly when
things like "save and restore one ymm register" will quite likely
clear the upper bits of the zmm register.

And yes, we can have some statically patched code that takes that into
account, and saves the whole zmm register when AVX512 is on, but the
whole *point* of the dynamic XSAVES thing is actually that Intel wants
to be able enable new user-space features without having to wait for
OS support. Literally. That's why and how it was designed.

And saving a couple of zmm registers is actually pretty hard. They're
big. Do you want to allocate 128 bytes of stack space, preferably
64-byte aligned, for a save area? No. So now it needs to be some kind
of per-thread (or maybe per-CPU, if we're willing to continue to not
preempt) special save area too.

And even then, it doesn't solve the real worry of "maybe there will be
odd interactions with future extensions that we don't even know of".

All this to do a 32-byte PIO access, with absolutely zero data right
now on what the win is?

Yes, yes, I can find an Intel white-paper that talks about setting WC
and then using xmm and ymm instructions to write a single 64-byte
burst over PCIe, and I assume that is where the code and idea came
from. But I don't actually see any reason why a burst of 8 regular
quad-word bytes wouldn't cause a 64-byte burst write too.

So right now this is for _one_ odd rdma controller, with absolutely
_zero_ performance numbers, and a very high likelihood that it does
not matter in the least.

And if there are some atomicity concerns ("we need to guarantee a
single atomic access for race conditions with the hardware"), they are
probably bogus and misplaced anyway, since

 (a) we can't guarantee that AVX2 exists in the first place

 (b) we can't guarantee that %ymm register write will show up on any
bus as a single write transaction anyway

So as far as I can tell, there are basically *zero* upsides, and a lot
of potential downsides.

                Linus
