Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeCUGdI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 02:33:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39081 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeCUGdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 02:33:04 -0400
X-Google-Smtp-Source: AG47ELsIM+C5TsO6ahJl34BKKSMgI2F+VDknbSOhgpAmrgI3c0to0uqdFhy21VnxaHg0EL1knQiVcw==
Date: Wed, 21 Mar 2018 07:32:56 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
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
Subject: Re: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Message-ID: <20180321063256.bdqcpvgb3auxzwzk@gmail.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
 <CA+55aFybTvLz47mw=AG21jCJv_hE2vaVyiJP_F-4vAD-3Gnc7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFybTvLz47mw=AG21jCJv_hE2vaVyiJP_F-4vAD-3Gnc7Q@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> And even if you ignore that "maintenance problems down the line" issue
> ("we can fix them when they happen") I don't want to see games like
> this, because I'm pretty sure it breaks the optimized xsave by tagging
> the state as being dirty.

That's true - and it would penalize the context switch cost of the affected task 
for the rest of its lifetime, as I don't think there's much that clears XINUSE 
other than a FINIT, which is rarely done by user-space.

> So no. Don't use vector stuff in the kernel. It's not worth the pain.

I agree, but:

> The *only* valid use is pretty much crypto, and even there it has had issues. 
> Benchmarks use big arrays and/or dense working sets etc to "prove" how good the 
> vector version is, and then you end up in situations where it's used once per 
> fairly small packet for an interrupt, and it's actually much worse than doing it 
> by hand.

That's mainly because the XSAVE/XRESTOR done by kernel_fpu_begin()/end() is so 
expensive, so this argument is somewhat circular.

IFF it was safe to just use the vector unit then vector unit based crypto would be 
very fast for small buffer as well, and would be even faster for larger buffer 
sizes as well. Saving and restoring up to ~1.5K of context is not cheap.

Thanks,

	Ingo
