Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754684AbeCVMsG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:48:06 -0400
Received: from smtp-out6.electric.net ([192.162.217.184]:55229 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753742AbeCVMsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:48:04 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        "'Ingo Molnar'" <mingo@kernel.org>
CC: "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Rahul Lakkireddy'" <rahul.lakkireddy@chelsio.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'hpa@zytor.com'" <hpa@zytor.com>,
        "'davem@davemloft.net'" <davem@davemloft.net>,
        "'akpm@linux-foundation.org'" <akpm@linux-foundation.org>,
        "'ganeshgr@chelsio.com'" <ganeshgr@chelsio.com>,
        "'nirranjan@chelsio.com'" <nirranjan@chelsio.com>,
        "'indranil@chelsio.com'" <indranil@chelsio.com>,
        "'Andy Lutomirski'" <luto@kernel.org>,
        "'Peter Zijlstra'" <a.p.zijlstra@chello.nl>,
        "'Fenghua Yu'" <fenghua.yu@intel.com>,
        "'Eric Biggers'" <ebiggers3@gmail.com>
Subject: RE: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Thread-Topic: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Thread-Index: AQHTv43TjMVMzNQoikSg1VH837bpVaPXnqXggAAJp4CAAAH+gIADWB3UgAELVpCAACZUYA==
Date: Thu, 22 Mar 2018 12:48:50 +0000
Message-ID: <b4658ee26be34c47807de0e5e13e7b31@AcuMS.aculab.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
 <CA+55aFybTvLz47mw=AG21jCJv_hE2vaVyiJP_F-4vAD-3Gnc7Q@mail.gmail.com>
 <20180321074634.dzpyjz3ia46snodh@gmail.com>
 <CA+55aFyK6uJopBjZGyeDz0O+qzCac6AwPkJyOpuaT69inPgVgw@mail.gmail.com>
 <2f5cb27711e741fba77846574e72eb62@AcuMS.aculab.com>
In-Reply-To: <2f5cb27711e741fba77846574e72eb62@AcuMS.aculab.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2MCmGiI023332

From: David Laight
> Sent: 22 March 2018 10:36
...
> Any code would need to be in memcpy_fromio(), not in every driver that
> might benefit.
> Then fallback code can be used if the registers aren't available.
> 
> >  (b) we can't guarantee that %ymm register write will show up on any
> > bus as a single write transaction anyway
> 
> Misaligned 8 byte accesses generate a single PCIe TLP.
> I can look at what happens for AVX2 transfers later.
> I've got code that mmap()s PCIe addresses into user space, and can
> look at the TLP (indirectly through tracing on an fpga target).
> Just need to set something up that uses AVX copies.

On my i7-7700 reads into xmm registers generate 16 byte TLP and
reads into ymm registers 32 byte TLP.
I don't think I've a system that supports avx-512

With my lethargic fpga slave 32 bytes reads happen every 144 clocks
and 16 byte ones every 126 (+/- the odd clock).
Single bytes ones happen every 108, 8 byte 117.
So I have (about) 110 clock overhead on every read cycle.
These clocks are the 62.5MHz clock on the fpga.

So if we needed to do PIO reads using the AVX2 (or better AVX-512)
registers would make a significant difference.
Fortunately we can 'dma' most of the data we need to transfer.

I've traced writes before, they are a lot faster and are limited
by things in the fpga fabric (they appear back to back).

	David
