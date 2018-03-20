Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeCTSB2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 14:01:28 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37823 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTSB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 14:01:26 -0400
X-Google-Smtp-Source: AG47ELu5WMQhRdA52HcPK33gm0E0iNgtvYf4VfqimX8rkp6sIrk3l9WWWGJJIvanefWnIB8jB66fldLserlo3JZlsyk=
MIME-Version: 1.0
In-Reply-To: <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com> <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com> <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Mar 2018 11:01:25 -0700
X-Google-Sender-Auth: Eov2ollkCb-bBgt2F9K9CeixDYI
Message-ID: <CA+55aFybTvLz47mw=AG21jCJv_hE2vaVyiJP_F-4vAD-3Gnc7Q@mail.gmail.com>
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

On Tue, Mar 20, 2018 at 1:26 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> So assuming the target driver will only load on modern FPUs I *think* it should
> actually be possible to do something like (pseudocode):
>
>         vmovdqa %ymm0, 40(%rsp)
>         vmovdqa %ymm1, 80(%rsp)
>
>         ...
>         # use ymm0 and ymm1
>         ...
>
>         vmovdqa 80(%rsp), %ymm1
>         vmovdqa 40(%rsp), %ymm0
>
> ... without using the heavy XSAVE/XRSTOR instructions.

No. The above is buggy. It may *work*, but it won't work in the long run.

Pretty much every single vector extension has traditionally meant that
touching "old" registers breaks any new register use. Even if you save
the registers carefully like in your example code, it will do magic
and random things to the "future extended" version.

So I absolutely *refuse* to have anything to do with the vector unit.
You can only touch it in the kernel if you own it entirely (ie that
"kernel_fpu_begin()/_end()" thing). Anything else is absolutely
guaranteed to cause problems down the line.

And even if you ignore that "maintenance problems down the line" issue
("we can fix them when they happen") I don't want to see games like
this, because I'm pretty sure it breaks the optimized xsave by tagging
the state as being dirty.

So no. Don't use vector stuff in the kernel. It's not worth the pain.

The *only* valid use is pretty much crypto, and even there it has had
issues. Benchmarks use big arrays and/or dense working sets etc to
"prove" how good the vector version is, and then you end up in
situations where it's used once per fairly small packet for an
interrupt, and it's actually much worse than doing it by hand.

               Linus
