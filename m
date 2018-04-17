Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeDQPQ5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:16:57 -0400
Received: from imap.thunk.org ([74.207.234.97]:51052 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751193AbeDQPQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:16:55 -0400
Date: Tue, 17 Apr 2018 11:16:50 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: repeatable boot randomness inside KVM guest
Message-ID: <20180417151650.GA16738@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20180414195921.GA10437@avx2>
 <20180414224419.GA21830@thunk.org>
 <20180415004134.GB15294@bombadil.infradead.org>
 <1523956414.3250.5.camel@HansenPartnership.com>
 <20180417114728.GA21954@bombadil.infradead.org>
 <1523966232.3250.15.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523966232.3250.15.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 12:57:12PM +0100, James Bottomley wrote:
> 
> You don't have to compromise the bootloader to influence this, you
> merely have to trick it into providing the random number you wanted. 
> The bigger you make the attack surface (the more inputs) the more
> likelihood of finding a trick that works.

There is a large class of devices where the bootloader can be
considered trusted.  For example, all modern Chrome and Android
devices have signed bootloaders by default.  And if you are using an
Amazon or Chrome VM, you are generally started it with a known,
trusted boot image.

The reason why it's useful to have the bootloader get the entropy is
because it may device-specific access and be able to leverage whatever
infrastructure was used to load the kernel and/or intialramfs to also
load the equivalent of /var/lib/systemd/random-seed (or
/var/lib/urandom, et. al) --- and do this early enough that we can
have truely secure randomness for those kernel faciliteis that need
access to real randomness to initialize the stack canary, or
initializing the slab cache.

There are other ways that this could be done, of course.  If the UEFI
boot services are still available, you might be able to ask the UEFI
services to give you randomness.  And yes, the hardware might be
backdoored to the fare-the-well by the MSS (for devices manufactured
in China) or by an NSA Tailored Access Operations intercepting a
computer shipment in transit.  But my vision was that this wouldn't
necessarily bump the entropy accounting or mark the CRNG as fully
intialized.  (If you work for the NSA and you're sure you won't do an
own-goal, you could enable a kernel boot option which marks the CRNG
initialized from entropy coming from UEFI or RDRAND or a TPM.  But I
don't think it should be the default.)

The only goal was to get enough uncertainty so we can secure early
kernel users of entropy for security features such as kernel ASLR, the
kernel stack canary, SLAB freelist randomization, etc.

And by the way --- if you think it is easy / possible to get secure
random numbers easily from either a TPMv1 or TPMv2 w/o any early boot
services (e.g., no interrupts, no DMA, no page tables, no memory
allocation) that would be really good to know.

Cheers,

> No, entropy mixing ensures that all you do with bad entropy is degrade
> the quality, but if the quality degrades to zero (as it might at boot
> when you've no other entropy sources so you feed in 100% bad entropy),
> then the random sequences become predictable.

Actually, if you have good entropy mixing, you can mix super-bad
entropy --- e.g., completely known by the attacker, and it won't make
the entropy pool any worse.  It can only help.

It does require that the entropy mixing algorithm should be
reversible, so that mixing in even a fully known sequence will not
cause uncertainty to be lost.  The input_pool in the random driver is
designed in such a way, which is why /dev/[u]random is world-writable.
Anyone can contribute potential uncertainty into the pool.  Regardless
of whether they have zero, partial, or full knowledge of the internal
random state, they won't have any more certainty of the pool after
they mix in their contribution.  And an attacker which does not know
the contribution, and who might have partial knowledge of the pool,
will less knowledge about the internal state afterwards.

Cheers,

					- Ted
