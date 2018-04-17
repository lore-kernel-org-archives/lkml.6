Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeDQL5R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:57:17 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50610 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752546AbeDQL5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:57:16 -0400
Message-ID: <1523966232.3250.15.camel@HansenPartnership.com>
Subject: Re: repeatable boot randomness inside KVM guest
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date: Tue, 17 Apr 2018 12:57:12 +0100
In-Reply-To: <20180417114728.GA21954@bombadil.infradead.org>
References: <20180414195921.GA10437@avx2> <20180414224419.GA21830@thunk.org>
         <20180415004134.GB15294@bombadil.infradead.org>
         <1523956414.3250.5.camel@HansenPartnership.com>
         <20180417114728.GA21954@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-17 at 04:47 -0700, Matthew Wilcox wrote:
> On Tue, Apr 17, 2018 at 10:13:34AM +0100, James Bottomley wrote:
> > On Sat, 2018-04-14 at 17:41 -0700, Matthew Wilcox wrote:
> > > On Sat, Apr 14, 2018 at 06:44:19PM -0400, Theodore Y. Ts'o wrote:
> > > > What needs to happen is freelist should get randomized much
> > > > later in the boot sequence.  Doing it later will require
> > > > locking; I don't know enough about the slab/slub code to know
> > > > whether the slab_mutex would be sufficient, or some other lock
> > > > might need to be added.
> > > 
> > > Could we have the bootloader pass in some initial randomness?
> > 
> > Where would the bootloader get it from (securely) that the kernel
> > can't?
> 
> In this particular case, qemu is booting the kernel, so it can apply
> to /dev/random for some entropy.

Well, yes, but wouldn't qemu virtualize /dev/random anyway so the guest
 kernel can get it from the HWRNG provided by qemu?

> > For example, if you compile in a TPM driver, the kernel will
> > pick up 32 random entropy bytes from the TPM to seed the pool, but
> > I think it happens too late to help with this problem
> > currently.  IMA also needs the TPM very early in the boot sequence,
> > so I was wondering about using the initial EFI driver, which is
> > present on boot, and then transitioning to the proper kernel TPM
> > driver later, which would mean we could seed the pool earlier.
> > 
> > As long as you mix it properly and limit the amount, it shouldn't
> > necessarily be a source of actual compromise, but having an
> > external input to our cryptographically secure entropy pool is an
> > additional potential attack vector.
> 
> I thought our model was that if somebody had compromised the
> bootloader, all bets were off.

You don't have to compromise the bootloader to influence this, you
merely have to trick it into providing the random number you wanted. 
The bigger you make the attack surface (the more inputs) the more
likelihood of finding a trick that works.

>   And also that we were free to mix in as many untrustworthy bytes of
> alleged entropy into the random pool as we liked.

No, entropy mixing ensures that all you do with bad entropy is degrade
the quality, but if the quality degrades to zero (as it might at boot
when you've no other entropy sources so you feed in 100% bad entropy),
then the random sequences become predictable.

James
