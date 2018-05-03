Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeECBhb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 21:37:31 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:53652 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeECBh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 21:37:29 -0400
Date: Wed, 2 May 2018 21:37:08 -0400
From: Rich Felker <dalias@libc.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Rob Landley <rob@landley.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to
 device tree
Message-ID: <20180503013708.GC1392@brightrain.aerifal.cx>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
 <c1ec211d-cbe2-1139-edb0-8baa0e7364e8@physik.fu-berlin.de>
 <8c75b447-fc14-871e-1a04-733132527b65@landley.net>
 <E7B2D113-C30D-4A32-AFB6-DC91DDADE0E8@physik.fu-berlin.de>
 <20171117191706.GF1627@brightrain.aerifal.cx>
 <7193aa1b-50e3-11d4-f93d-f567e2e06b8c@physik.fu-berlin.de>
 <20180105212857.GR1627@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180105212857.GR1627@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2018 at 04:28:57PM -0500, Rich Felker wrote:
> On Fri, Nov 17, 2017 at 08:54:47PM +0100, John Paul Adrian Glaubitz wrote:
> > On 11/17/2017 08:17 PM, Rich Felker wrote:
> > > There were significant problems that I don't think were ever
> > > addressed, including incompatible changes in how boot command line was
> > > handled and possibly ambiguity about what a physical address means
> > > (zero based vs based in the zone SH3/4 excludes from MMU mapping) in
> > > the contract for how the bootloader passes a DTB pointer in to the
> > > kernel, or something similar.
> > 
> > I see, thanks for the heads-up.
> > 
> > > This is a large part of why I want to get to the point where I can
> > > build and boot a kernel on the LANDISK -- not being able to test any
> > > of this is a blocker for moving everything to device tree.
> > 
> > I can actually help you with that. I know what to do to get the kernel
> > to boot on the LANDISK device. I've got everything working except
> > being unable to detect the IDE controller. The attached config builds
> > a kernel which boots with the attached output.
> > 
> > Furthermore, in order to install the kernel, you need to use the
> > cross-LILO version from [1] which allows to install the bootloader
> > on an x86 machine into the SuperH LANDISK image.
> > 
> > Instructions can be found in [2]. A base filesystem can be found in [3].
> > 
> > And I could also send you an USL-5P which is also a LANDISK device,
> > just in a different form-factor.
> > 
> > Adrian
> > 
> > > [1]http://iohack.osdn.jp/kogiidena/debian26/base/landisk-tools-20070612.tgz
> > > [2] https://www.with.de/fw/pub/Computing/PlextorPX-EH/LANDISKdebian.pdf
> > > [3] http://iohack.osdn.jp/kogiidena/debian26/base/
> 
> I'm trying to reproduce this but can't find any documentation for
> cross-LILO in [2], much less any code except possibly the binary
> "lilo.x86" in [1]. Googling cross-lilo isn't finding anything
> meaningful except this thread. Is there anywhere to find source and
> information on what it's doing, or is this going to be something I
> have to reverse-engineer?

Progress on all this! I've got my LANDISK working again, but with the
disk image Sato-san provided me, which is using (a patched?) U-Boot
and a kernel based on this patch series. I don't know how to recreate
the U-Boot setup from scratch, but I might be able to figure out how
to replace the kernel image it's using. It's possible I may be able to
get lilo working too -- I tried building it but I'm still not sure how
to use it, and in any case I need to image the existing system before
I clobber it since I'm not sure I have the original image.

On a better note, I've reviewed this patch series in more depth and
understand it pretty well now, and have classified the patches as
follows:

01-04 -- about P1 vs absolute interpretation of "physical addresses",
and can be completely dropped if we just use the latter. The former
does not work with full-32-bit address space.

05 -- change in command line interpretation. Something like this might
be desired at some point, if we make it non-conflicting with current
use, but it's independent and not needed.

06-09 -- extending arch/sh device tree support with functionality
needed to get traditional sh systems using it. These look roughly ok,
but might need minor cleanup. Just applying these and linking in a
minimal DTB, I should be able to get a non-board-specific kernel that
boots and shows console messages until it gets stuck with no interrupt
controller or devices. This is the milestone I'm looking to get to
first.

10 -- LANDISK board-specific init stuff, moved into of-generic.c. This
is not where it belongs, but I don't know where it should be, or if we
can get it to book without this. If not, it can be applied as a hack
for testing.

11-13,19 -- new style device tree drivers for clock, pci bus, and irq
controller. They'll have to go through subsystem maintainers unless we
want to move them into arch/sh/drivers. Without these the system is
not going to be usable to the point of reaching userspace.

14,20 -- device trees. The evt2irq/irq2evt macros probably don't make
sense and should be either irqdomain mappings or just removed. But
these can be used out-of-tree anyway to make a DTB while testing.

15-17 -- might also be needed for PCI to work. Not sure about them.

Rich
