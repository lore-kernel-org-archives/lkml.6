Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeDQPUt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:20:49 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52674 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751836AbeDQPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:20:48 -0400
Message-ID: <1523978443.3310.3.camel@HansenPartnership.com>
Subject: Re: repeatable boot randomness inside KVM guest
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date: Tue, 17 Apr 2018 16:20:43 +0100
In-Reply-To: <20180417140722.GC21954@bombadil.infradead.org>
References: <20180414195921.GA10437@avx2> <20180414224419.GA21830@thunk.org>
         <20180415004134.GB15294@bombadil.infradead.org>
         <1523956414.3250.5.camel@HansenPartnership.com>
         <20180417114728.GA21954@bombadil.infradead.org>
         <1523966232.3250.15.camel@HansenPartnership.com>
         <20180417140722.GC21954@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-17 at 07:07 -0700, Matthew Wilcox wrote:
> On Tue, Apr 17, 2018 at 12:57:12PM +0100, James Bottomley wrote:
> > On Tue, 2018-04-17 at 04:47 -0700, Matthew Wilcox wrote:
> > > On Tue, Apr 17, 2018 at 10:13:34AM +0100, James Bottomley wrote:
> > > > On Sat, 2018-04-14 at 17:41 -0700, Matthew Wilcox wrote:
> > > > > On Sat, Apr 14, 2018 at 06:44:19PM -0400, Theodore Y. Ts'o
> > > > > wrote:
> > > > > > What needs to happen is freelist should get randomized much
> > > > > > later in the boot sequence.  Doing it later will require
> > > > > > locking; I don't know enough about the slab/slub code to
> > > > > > know whether the slab_mutex would be sufficient, or some
> > > > > > other lock might need to be added.
> > > > > 
> > > > > Could we have the bootloader pass in some initial randomness?
> > > > 
> > > > Where would the bootloader get it from (securely) that the
> > > > kernel can't?
> > > 
> > > In this particular case, qemu is booting the kernel, so it can
> > > apply to /dev/random for some entropy.
> > 
> > Well, yes, but wouldn't qemu virtualize /dev/random anyway so the
> > guest  kernel can get it from the HWRNG provided by qemu?
> 
> The part of Ted's mail that I snipped explained that virtio-rng
> relies on being able to kmalloc memory, so by definition it can't
> provide entropy before kmalloc is initialised.

That sounds fixable ...

> > > I thought our model was that if somebody had compromised the
> > > bootloader, all bets were off.
> > 
> > You don't have to compromise the bootloader to influence this, you
> > merely have to trick it into providing the random number you
> > wanted.  The bigger you make the attack surface (the more inputs)
> > the more likelihood of finding a trick that works.
> > 
> > >   And also that we were free to mix in as many untrustworthy
> > > bytes of alleged entropy into the random pool as we liked.
> > 
> > No, entropy mixing ensures that all you do with bad entropy is
> > degrade the quality, but if the quality degrades to zero (as it
> > might at boot when you've no other entropy sources so you feed in
> > 100% bad entropy), then the random sequences become predictable.
> 
> I don't understand that.  If I estimate that I have 'k' bytes of
> entropy in my pool, and then I mix in 'n' entirely predictable bytes,
> I should still have k bytes of entropy in the pool.  If I withdraw k
> bytes from the pool, then yes the future output from the pool may be
> entirely predictable, but I have to know what those k bytes were.

If that were true, why are we debating this?  I thought the problem was
the alleged random sequences for slub placement were repeating on
subsequent VM boots meaning there's effectively no entropy in the pool
and we need to add some.

James
