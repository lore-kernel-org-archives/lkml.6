Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbeCVKfG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 06:35:06 -0400
Received: from smtp-out4.electric.net ([192.162.216.184]:53778 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbeCVKfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 06:35:04 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
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
Subject: RE: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Thread-Topic: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Thread-Index: AQHTv43TjMVMzNQoikSg1VH837bpVaPXnqXggAAJp4CAAAH+gIADWB3UgAELVpA=
Date: Thu, 22 Mar 2018 10:35:43 +0000
Message-ID: <2f5cb27711e741fba77846574e72eb62@AcuMS.aculab.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
 <CA+55aFybTvLz47mw=AG21jCJv_hE2vaVyiJP_F-4vAD-3Gnc7Q@mail.gmail.com>
 <20180321074634.dzpyjz3ia46snodh@gmail.com>
 <CA+55aFyK6uJopBjZGyeDz0O+qzCac6AwPkJyOpuaT69inPgVgw@mail.gmail.com>
In-Reply-To: <CA+55aFyK6uJopBjZGyeDz0O+qzCac6AwPkJyOpuaT69inPgVgw@mail.gmail.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2MAZDmh011853

From: Sent: 21 March 2018 18:16
> To: Ingo Molnar
...
> All this to do a 32-byte PIO access, with absolutely zero data right
> now on what the win is?
> 
> Yes, yes, I can find an Intel white-paper that talks about setting WC
> and then using xmm and ymm instructions to write a single 64-byte
> burst over PCIe, and I assume that is where the code and idea came
> from. But I don't actually see any reason why a burst of 8 regular
> quad-word bytes wouldn't cause a 64-byte burst write too.

The big gain is from wide PCIe reads, not writes.
Writes to uncached locations (without WC) are almost certainly required
to generate the 'obvious' PCIe TLP, otherwise things are likely to break.

> So right now this is for _one_ odd rdma controller, with absolutely
> _zero_ performance numbers, and a very high likelihood that it does
> not matter in the least.
> 
> And if there are some atomicity concerns ("we need to guarantee a
> single atomic access for race conditions with the hardware"), they are
> probably bogus and misplaced anyway, since
> 
>  (a) we can't guarantee that AVX2 exists in the first place

Any code would need to be in memcpy_fromio(), not in every driver that
might benefit.
Then fallback code can be used if the registers aren't available.

>  (b) we can't guarantee that %ymm register write will show up on any
> bus as a single write transaction anyway

Misaligned 8 byte accesses generate a single PCIe TLP.
I can look at what happens for AVX2 transfers later.
I've got code that mmap()s PCIe addresses into user space, and can
look at the TLP (indirectly through tracing on an fpga target).
Just need to set something up that uses AVX copies.

> So as far as I can tell, there are basically *zero* upsides, and a lot
> of potential downsides.

There are some upsides.
I'll do a performance measurement for reads.

	David
