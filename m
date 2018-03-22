Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754448AbeCVKrb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 06:47:31 -0400
Received: from smtp-out4.electric.net ([192.162.216.182]:55187 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754375AbeCVKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 06:47:27 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        Alexander Duyck <alexander.duyck@gmail.com>
CC: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        "Nirranjan Kirubaharan" <nirranjan@chelsio.com>,
        Indranil Choudhury <indranil@chelsio.com>
Subject: RE: [RFC PATCH 2/3] x86/io: implement 256-bit IO read and write
Thread-Topic: [RFC PATCH 2/3] x86/io: implement 256-bit IO read and write
Thread-Index: AQHTwXzSw7n4cdHVjE+3sRSKJWyME6PcEb/A
Date: Thu, 22 Mar 2018 10:48:19 +0000
Message-ID: <035ac754e54a4b14844f3300ae1432a9@AcuMS.aculab.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <6ec3e7e0c70e85a804933f27bb4275d5363c044b.1521469118.git.rahul.lakkireddy@chelsio.com>
 <alpine.DEB.2.21.1803191525010.2010@nanos.tec.linutronix.de>
 <20180320133206.GB25574@chelsio.com>
 <CAKgT0UeTHPVrxEUbEszxm1MyJsQDSLfyM8txHq=r7GVkPD37nQ@mail.gmail.com>
 <CA+55aFydu4+MZ=-5L7wDr2LvNH6Dbmi4qLnfHAAOrHKZCb5wdA@mail.gmail.com>
In-Reply-To: <CA+55aFydu4+MZ=-5L7wDr2LvNH6Dbmi4qLnfHAAOrHKZCb5wdA@mail.gmail.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2MAmQ7c015605

From: Linus Torvalds
> Sent: 22 March 2018 01:27
> On Tue, Mar 20, 2018 at 7:42 AM, Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> >
> > Instead of framing this as an enhanced version of the read/write ops
> > why not look at replacing or extending something like the
> > memcpy_fromio or memcpy_toio operations?
> 
> Yes, doing something like "memcpy_fromio_avx()" is much more
> palatable, in that it works like the crypto functions do - if you do
> big chunks, the "kernel_fpu_begin/end()" isn't nearly the issue it can
> be otherwise.
> 
> Note that we definitely have seen hardware that *depends* on the
> regular memcpy_fromio()" not doing big reads. I don't know how
> hardware people screw it up, but it's clearly possible.

I wonder if that hardware works with the current kernel on recent cpus?
I bet it doesn't like the byte accesses that get generated either.

> So it really needs to be an explicitly named function that basically a
> driver can use to say "my hardware really likes big aligned accesses"
> and explicitly ask for some AVX version if possible.

For x86 being able to request a copy done as 'rep movsx' (for each x)
would be useful.
For io copies the cost of the memory access is probably much smaller
that the io access, so really fancy copies are unlikely make much
difference unless the width of the io access changes.

	David
