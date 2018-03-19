Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755741AbeCSOw3 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:52:29 -0400
Received: from smtp-out4.electric.net ([192.162.216.184]:56504 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755504AbeCSOw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:52:27 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Rahul Lakkireddy'" <rahul.lakkireddy@chelsio.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>,
        "indranil@chelsio.com" <indranil@chelsio.com>
Subject: RE: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Thread-Topic: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Thread-Index: AQHTv43TjMVMzNQoikSg1VH837bpVaPXnqXg
Date: Mon, 19 Mar 2018 14:53:17 +0000
Message-ID: <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
In-Reply-To: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
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

From: Rahul Lakkireddy
> Sent: 19 March 2018 14:21
> 
> This series of patches add support for 256-bit IO read and write.
> The APIs are readqq and writeqq (quad quadword - 4 x 64), that read
> and write 256-bits at a time from IO, respectively.

Why not use the AVX2 registers to get 512bit accesses.

> Patch 1 adds u256 type and adds necessary non-atomic accessors.  Also
> adds byteorder conversion APIs.
> 
> Patch 2 adds 256-bit read and write to x86 via VMOVDQU AVX CPU
> instructions.
> 
> Patch 3 updates cxgb4 driver to use the readqq API to speed up
> reading on-chip memory 256-bits at a time.

Calling kernel_fpu_begin() is likely to be slow.
I doubt you want to do it every time around a loop of accesses.

In principle it ought to be possible to get access to one or two
(eg) AVX registers by saving them to stack and telling the fpu
save code where you've put them.
Then the IPI fp save code could then copy the saved values over
the current values if asked to save the fp state for a process.
This should be reasonable cheap - especially if there isn't an
fp save IPI.

OTOH, for x86, if the code always runs in process context (eg from a
system call) then, since the ABI defines them all as caller-saved
the AVX(2) registers, it is only necessary to ensure that the current
FPU registers belong to the current process once.
The registers can be set to zero by an 'invalidate' instruction on
system call entry (hope this is done) and after use.

	David
