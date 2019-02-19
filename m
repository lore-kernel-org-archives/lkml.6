Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372D4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104182146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfBSK1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:27:54 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35625 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfBSK1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:27:54 -0500
X-Originating-IP: 90.88.30.68
Received: from windsurf.home (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 49DC61C001E;
        Tue, 19 Feb 2019 10:27:48 +0000 (UTC)
Date:   Tue, 19 Feb 2019 11:27:47 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190219112747.7db95e58@windsurf.home>
In-Reply-To: <CAK8P3a2mjjr94hwj_eXxfyKDKDuA=MogXW7xJygh-X0Hqgf6rg@mail.gmail.com>
References: <20190211172948.3322-1-will.deacon@arm.com>
        <CAK8P3a2Pr2oWYB7QHQMaHRq6H8h9xMwhhyJz5Pu67bVe4GaK9g@mail.gmail.com>
        <20190218162954.GB16713@fuggles.cambridge.arm.com>
        <CAK8P3a1TY9S=zYsdZ5O021p2yYcZhehVuwB3_65dR6x6zbkTYQ@mail.gmail.com>
        <20190218175625.GD16713@fuggles.cambridge.arm.com>
        <CAK8P3a2mjjr94hwj_eXxfyKDKDuA=MogXW7xJygh-X0Hqgf6rg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 18 Feb 2019 21:37:25 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> > > I would say we should strengthen the behavior of outX() where possible.
> > > I don't know if arm64 actually has a way of doing that, my understanding
> > > earlier was that the AXI bus was already posted, so there is not much
> > > you can do here to define __io_paw() in a way that will prevent posted
> > > writes.  
> >
> > If we could map I/O space using different page table attributes (probably by
> > hacking pci_remap_iospace() ?) then we could disable the
> > early-write-acknowledge hint and implement __io_paw() as a completion
> > barrier, although it would be at the mercy of the system as to whether or
> > not that requires a response from the RC.  
> 
> Ah, it seems we actually do that on 32-bit ARM, at least on one platform,
> see 6a02734d420f ("ARM: mvebu: map PCI I/O regions strongly ordered")
> and prior commits.

Yes, some Marvell Armada 32-bit platforms have an errata that require
the PCI MEM and PCI I/O regions to be mapped strongly ordered.

BTW, this requirement prevents us from using the pci_remap_iospace()
API from drivers/pci, because it assumes page attributes of
pgprot_device(PAGE_KERNEL). That's why we're still using the
ARM-specific pci_ioremap_io() function.

> > I would still prefer to document the weaker semantics as the portable
> > interface, unless there are portable drivers relying on this today (which
> > would imply that it's widely supported by other architectures).  
> 
> I don't know of any portable driver that actually relies on it, but
> that's mainly because there are very few portable drivers that
> use inb()/outb() in the first place. How many of those require
> the non-posted behavior I don't know
> 
> Adding Thomas, Gregory and Russell to Cc, as they were involved
> in the discussion that led to the 32-bit change, maybe they are
> aware of a specific example.

I'm just arriving in the middle of this thread, and I'm not sure to
understand what is the question. If the question is whether PCI I/O is
really used in practice, then I've never seen it be used with Marvell
platforms (but I'm also not aware of all PCIe devices people are
using). I personally have a hacked-up version of the e1000e driver
that intentionally does some PCI I/O accesses, that I use as a way to
validate that PCI I/O support is minimally working, but that's it.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
