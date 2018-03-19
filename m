Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934225AbeCSPw2 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:52:28 -0400
Received: from smtp-out6.electric.net ([192.162.217.194]:50695 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934079AbeCSPwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:52:22 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Thomas Gleixner'" <tglx@linutronix.de>
CC: "'Rahul Lakkireddy'" <rahul.lakkireddy@chelsio.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>,
        "indranil@chelsio.com" <indranil@chelsio.com>
Subject: RE: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Thread-Topic: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Thread-Index: AQHTv43TjMVMzNQoikSg1VH837bpVaPXnqXggAAJp4CAAAH+gIAABvGAgAADNbA=
Date: Mon, 19 Mar 2018 15:53:00 +0000
Message-ID: <ba8ac1f8c1f444da857b6a46c4153672@AcuMS.aculab.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
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

From: Thomas Gleixner
> Sent: 19 March 2018 15:37
...
> > If system call entry reset the AVX registers then any FP save/restore
> > would be faster because the AVX registers wouldn't need to be saved
> > (and the cpu won't save them).
> > I believe the instruction to reset the AVX registers is fast.
> > The AVX registers only ever need saving if the process enters the
> > kernel through an interrupt.
> 
> Wrong. The x8664 ABI clearly states:
> 
>    Linux Kernel code is not allowed to change the x87 and SSE units. If
>    those are changed by kernel code, they have to be restored properly
>    before sleeping or leav- ing the kernel.
> 
> That means the syscall interface relies on FPU state being not changed by
> the kernel. So if you want to clear AVX on syscall entry you need to save
> it first and then restore before returning. That would be a huge
> performance hit.

The x87 and SSE registers can't be changed - they can contain callee-saved
registers.
But (IIRC) the AVX and AVX2 registers are all caller-saved.
So the system call entry stub functions are allowed to change them.
Which means that the syscall entry code can also change them.
Of course it must not leak kernel values back to userspace.

It is a few years since I looked at the AVX and fpu save code.

	David
