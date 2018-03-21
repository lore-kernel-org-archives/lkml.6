Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeCUPq0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752409AbeCUPqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:46:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DBE21840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELvVGswXvzullpBSOsb66lL5mRfnIOWxMS7ptTd6IdTJbL53fYVWXpRRjvC9eQGfZeTC/xqMjqSW7aFLBIOhr+g=
MIME-Version: 1.0
In-Reply-To: <20180321063256.bdqcpvgb3auxzwzk@gmail.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com> <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com> <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com> <CA+55aFybTvLz47mw=AG21jCJv_hE2vaVyiJP_F-4vAD-3Gnc7Q@mail.gmail.com>
 <20180321063256.bdqcpvgb3auxzwzk@gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 21 Mar 2018 15:45:55 +0000
X-Gmail-Original-Message-ID: <CALCETrXQRLEh_oQ5O-u31HT8AC0Gyb=_qwYJe2D0uyG07fNcoA@mail.gmail.com>
Message-ID: <CALCETrXQRLEh_oQ5O-u31HT8AC0Gyb=_qwYJe2D0uyG07fNcoA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Wed, Mar 21, 2018 at 6:32 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> And even if you ignore that "maintenance problems down the line" issue
>> ("we can fix them when they happen") I don't want to see games like
>> this, because I'm pretty sure it breaks the optimized xsave by tagging
>> the state as being dirty.
>
> That's true - and it would penalize the context switch cost of the affected task
> for the rest of its lifetime, as I don't think there's much that clears XINUSE
> other than a FINIT, which is rarely done by user-space.
>
>> So no. Don't use vector stuff in the kernel. It's not worth the pain.
>
> I agree, but:
>
>> The *only* valid use is pretty much crypto, and even there it has had issues.
>> Benchmarks use big arrays and/or dense working sets etc to "prove" how good the
>> vector version is, and then you end up in situations where it's used once per
>> fairly small packet for an interrupt, and it's actually much worse than doing it
>> by hand.
>
> That's mainly because the XSAVE/XRESTOR done by kernel_fpu_begin()/end() is so
> expensive, so this argument is somewhat circular.

If we do the deferred restore, then the XSAVE/XRSTOR happens at most
once per kernel entry, which isn't so bad IMO.  Also, with PTI, kernel
entries are already so slow that this will be mostly in the noise :(

--Andy
