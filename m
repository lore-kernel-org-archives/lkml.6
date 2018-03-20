Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753585AbeCTNcc convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:32:32 -0400
Received: from smtp-out4.electric.net ([192.162.216.195]:65048 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753354AbeCTNaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:30:17 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Ingo Molnar'" <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
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
Thread-Index: AQHTv43TjMVMzNQoikSg1VH837bpVaPXnqXggAAJp4CAAAH+gIABSo1ogAApUxA=
Date: Tue, 20 Mar 2018 13:30:59 +0000
Message-ID: <f3bfbb3d269f4dc29260bc8a6ae6ef22@AcuMS.aculab.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
 <alpine.DEB.2.21.1803200933320.6506@nanos.tec.linutronix.de>
 <20180320090802.qw4tqjmhy6yfd6sf@gmail.com>
 <alpine.DEB.2.21.1803201039460.6506@nanos.tec.linutronix.de>
 <20180320105427.bm4od7cpessbraag@gmail.com>
In-Reply-To: <20180320105427.bm4od7cpessbraag@gmail.com>
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

From: Ingo Molnar
> Sent: 20 March 2018 10:54
...
> Note that a generic version might still be worth trying out, if and only if it's
> safe to access those vector registers directly: modern x86 CPUs will do their
> non-constant memcpy()s via the common memcpy_erms() function - which could in
> theory be an easy common point to be (cpufeatures-) patched to an AVX2 variant, if
> size (and alignment, perhaps) is a multiple of 32 bytes or so.
> 
> Assuming it's correct with arbitrary user-space FPU state and if it results in any
> measurable speedups, which might not be the case: ERMS is supposed to be very
> fast.
> 
> So even if it's possible (which it might not be), it could end up being slower
> than the ERMS version.

Last I checked memcpy() was implemented as 'rep movsb' on the latest Intel cpus.
Since memcpy_to/fromio() get aliased to memcpy() this generates byte copies.
The previous 'fastest' version of memcpy() was ok for uncached locations.

For PCIe I suspect that the actual instructions don't make a massive difference.
I'm not even sure interleaving two transfers makes any difference.
What makes a huge difference for memcpy_fromio() is the size of the register.
The time taken for a read will be largely independent of the width of the
register used.

	David
