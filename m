Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeDQLra (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:47:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752357AbeDQLr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:47:29 -0400
Date: Tue, 17 Apr 2018 04:47:28 -0700
From: Matthew Wilcox <willy@infradead.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: repeatable boot randomness inside KVM guest
Message-ID: <20180417114728.GA21954@bombadil.infradead.org>
References: <20180414195921.GA10437@avx2>
 <20180414224419.GA21830@thunk.org>
 <20180415004134.GB15294@bombadil.infradead.org>
 <1523956414.3250.5.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1523956414.3250.5.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 10:13:34AM +0100, James Bottomley wrote:
> On Sat, 2018-04-14 at 17:41 -0700, Matthew Wilcox wrote:
> > On Sat, Apr 14, 2018 at 06:44:19PM -0400, Theodore Y. Ts'o wrote:
> > > What needs to happen is freelist should get randomized much later
> > > in the boot sequence.  Doing it later will require locking; I don't
> > > know enough about the slab/slub code to know whether the slab_mutex
> > > would be sufficient, or some other lock might need to be added.
> > 
> > Could we have the bootloader pass in some initial randomness?
> 
> Where would the bootloader get it from (securely) that the kernel
> can't?

In this particular case, qemu is booting the kernel, so it can apply to
/dev/random for some entropy.

> For example, if you compile in a TPM driver, the kernel will
> pick up 32 random entropy bytes from the TPM to seed the pool, but I
> think it happens too late to help with this problem currently.  IMA
> also needs the TPM very early in the boot sequence, so I was wondering
> about using the initial EFI driver, which is present on boot, and then
> transitioning to the proper kernel TPM driver later, which would mean
> we could seed the pool earlier.
> 
> As long as you mix it properly and limit the amount, it shouldn't
> necessarily be a source of actual compromise, but having an external
> input to our cryptographically secure entropy pool is an additional
> potential attack vector.

I thought our model was that if somebody had compromised the bootloader,
all bets were off.  And also that we were free to mix in as many
untrustworthy bytes of alleged entropy into the random pool as we liked.
