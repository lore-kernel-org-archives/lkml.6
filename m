Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeCTJ7E convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:59:04 -0400
Received: from smtp-out4.electric.net ([192.162.216.182]:63024 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752663AbeCTJ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:59:01 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Thomas Gleixner'" <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
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
        "indranil@chelsio.com" <indranil@chelsio.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Fenghua Yu <fenghua.yu@intel.com>, Eric Biggers <ebiggers3@gmail.com>
Subject: RE: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Thread-Topic: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Thread-Index: AQHTv43TjMVMzNQoikSg1VH837bpVaPXnqXggAAJp4CAAAH+gIABNhgtgAABOMA=
Date: Tue, 20 Mar 2018 09:59:40 +0000
Message-ID: <43d86d051123403496311bb70babadd5@AcuMS.aculab.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
 <alpine.DEB.2.21.1803200933320.6506@nanos.tec.linutronix.de>
 <20180320090802.qw4tqjmhy6yfd6sf@gmail.com>
 <alpine.DEB.2.21.1803201039460.6506@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1803201039460.6506@nanos.tec.linutronix.de>
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
> Sent: 20 March 2018 09:41
> On Tue, 20 Mar 2018, Ingo Molnar wrote:
> > * Thomas Gleixner <tglx@linutronix.de> wrote:
...
> > > And if we go down that road then we want a AVX based memcpy()
> > > implementation which is runtime conditional on the feature bit(s) and
> > > length dependent. Just slapping a readqq() at it and use it in a loop does
> > > not make any sense.
> >
> > Yeah, so generic memcpy() replacement is only feasible I think if the most
> > optimistic implementation is actually correct:
> >
> >  - if no preempt disable()/enable() is required
> >
> >  - if direct access to the AVX[2] registers does not disturb legacy FPU state in
> >    any fashion
> >
> >  - if direct access to the AVX[2] registers cannot raise weird exceptions or have
> >    weird behavior if the FPU control word is modified to non-standard values by
> >    untrusted user-space
> >
> > If we have to touch the FPU tag or control words then it's probably only good for
> > a specialized API.
> 
> I did not mean to have a general memcpy replacement. Rather something like
> magic_memcpy() which falls back to memcpy when AVX is not usable or the
> length does not justify the AVX stuff at all.

There is probably no point for memcpy().

Where it would make a big difference is memcpy_fromio() for PCIe devices
(where longer TLP make a big difference).
But any code belongs in its implementation not in every driver.
The implementation of memcpy_toio() is nothing like as critical.

If might be the code would need to fallback to 64bit accesses
if the AVX(2) registers can't currently be accessed - maybe some
obscure state....

However memcpy_to/fromio() are both horrid at the moment because
they result in byte copies!

	David
