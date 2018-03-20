Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbeCTPJ6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:09:58 -0400
Received: from smtp-out6.electric.net ([192.162.217.187]:53574 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeCTPJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:09:56 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Andy Lutomirski'" <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>,
        "indranil@chelsio.com" <indranil@chelsio.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Fenghua Yu <fenghua.yu@intel.com>, Eric Biggers <ebiggers3@gmail.com>,
        Rik van Riel <riel@redhat.com>
Subject: RE: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Thread-Topic: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Thread-Index: AQHTv43TjMVMzNQoikSg1VH837bpVaPXnqXggAAJp4CAAAH+gIABjnG2gAAB3qA=
Date: Tue, 20 Mar 2018 15:10:39 +0000
Message-ID: <c1eac43cd8e143d09477a34ed6de6302@AcuMS.aculab.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
 <CALCETrVMF140-XZLi9nARPeAmyi8QRRzLRm6SSpB0BkAUSGakg@mail.gmail.com>
In-Reply-To: <CALCETrVMF140-XZLi9nARPeAmyi8QRRzLRm6SSpB0BkAUSGakg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2KFA42N021052

From: Andy Lutomirski
> Sent: 20 March 2018 14:57
...
> I'd rather see us finally finish the work that Rik started to rework
> this differently.  I'd like kernel_fpu_begin() to look like:
> 
> if (test_thread_flag(TIF_NEED_FPU_RESTORE)) {
>   return; // we're already okay.  maybe we need to check
> in_interrupt() or something, though?
> } else {
>   XSAVES/XSAVEOPT/XSAVE;
>   set_thread_flag(TIF_NEED_FPU_RESTORE):
> }
> 
> and kernel_fpu_end() does nothing at all.

I guess it might need to set (clear?) the CFLAGS bit for a process
that isn't using the fpu at all - which seems a sensible feature.
 
> We take the full performance hit for a *single* kernel_fpu_begin() on
> an otherwise short syscall or interrupt, but there's no additional
> cost for more of them or for long-enough-running things that we
> schedule in the middle.

It might be worth adding a parameter to kernel_fpu_begin() to indicate
which registers are needed, and a return value to say what has been
granted.
Then a driver could request AVX2 (for example) and use a fallback path
if the register set isn't available (for any reason).
A call from an ISR could always fail.

> As I remember, the main hangup was that this interacts a bit oddly
> with PKRU, but that's manageable.

WTF PKRU ??

	Dvaid
