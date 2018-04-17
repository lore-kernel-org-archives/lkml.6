Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeDQVlF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:41:05 -0400
Received: from imap.thunk.org ([74.207.234.97]:53362 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbeDQVlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:41:03 -0400
Date: Tue, 17 Apr 2018 17:40:59 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: repeatable boot randomness inside KVM guest
Message-ID: <20180417214059.GA23194@thunk.org>
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
 <20180417151650.GA16738@thunk.org>
 <1523979759.3310.7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523979759.3310.7.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 04:42:39PM +0100, James Bottomley wrote:
> Depends how the parameter is passed.  If it can be influenced from the
> command line then a large class of "trusted boot" systems actually
> don't verify the command line, so you can boot a trusted system and
> still inject bogus command line parameters.  This is definitely true of
> PC class secure boot.  Not saying it will always be so, just
> illustrating why you don't necessarily want to expand the attack
> surface.

Sure, this is why I don't really like the scheme of relying on the
command line.  For one thing, the command-line is public, so if the
attacker can read /proc/cmdline, they'll have access to the entropy.

What I would prefer is an extension to the boot protocol so that some
number of bytes would be passed to the kernel as a separate bag of
bytes alongside the kernel command line and the initrd.

The kernel would mix that into the random driver (which is written so
the basic input pool and primary_crng can accept input in super-early
boot).  This woud be done *before* we relocate the kernel, so that
kernel ASLR code can relocate the kernel test to a properly
unpredictable number --- so this really is quite super-early boot.

> OK, in the UEFI ideal world where every component is a perfectly
> written OS, perhaps you're right.  In the more real world, do you trust
> the people who wrote the bootloader to understand and correctly
> implement the cryptographically secure process of obtaining a random
> input?

In the default setup, I would expect the bootloader (such as grub)
would read the random initialization data from disk.  So it would work
much like systemd reading from /var/lib/systemd/random-seed.  And I
would trust the bootloader implementors to be able to do this about as
well as I would trust the systemd implementors.  :-)  It's not that
hard, after all....

						- Ted
