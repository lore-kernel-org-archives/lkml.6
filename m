Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeEGPwm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 11:52:42 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:53774 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752051AbeEGPwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 11:52:41 -0400
Date: Mon, 7 May 2018 11:52:26 -0400
From: Rich Felker <dalias@libc.org>
To: Rob Landley <rob@landley.net>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to
 device tree
Message-ID: <20180507155226.GI1392@brightrain.aerifal.cx>
References: <7193aa1b-50e3-11d4-f93d-f567e2e06b8c@physik.fu-berlin.de>
 <20180105212857.GR1627@brightrain.aerifal.cx>
 <20180503013708.GC1392@brightrain.aerifal.cx>
 <20180503023320.GD1392@brightrain.aerifal.cx>
 <048ab147-21b8-045d-d21c-e1be2dd0e954@physik.fu-berlin.de>
 <87k1sgtf8t.wl-ysato@users.sourceforge.jp>
 <5f690985-e905-deb9-aa4f-51561463ae22@physik.fu-berlin.de>
 <9051f0a5-bc75-b49e-c8c3-aa877be1979e@landley.net>
 <20180507144306.GG1392@brightrain.aerifal.cx>
 <775bc754-0181-6a13-d625-825bf601eb77@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <775bc754-0181-6a13-d625-825bf601eb77@landley.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 10:13:32AM -0500, Rob Landley wrote:
> 
> 
> On 05/07/2018 09:43 AM, Rich Felker wrote:
> > On Mon, May 07, 2018 at 08:40:35AM -0500, Rob Landley wrote:
> >> On 05/07/2018 06:00 AM, John Paul Adrian Glaubitz wrote:
> >>> I have been able to boot my own kernel on my USL-5P device, but
> >>> I could never get it to detect the IDE controller. Do I need
> >>> an additional patch for that?
> >>
> >> On a related note, is there a list of boards anywhere? I'm working on a 7760
> >> system at $DAYJOB, Rich has a landisk which according to
> >> https://www.openbsd.org/landisk.html is an SH7751R, and Sato-san says that
> >> QEMU's -r2d emulates that too? ("RTS7751R2Dplus is QEMU-SH4 target. So easy
> >> trying.")
> >>
> >> What other boards do we need to covert to device tree? arch/sh/boards has 15 C
> >> files and 19 subdirectories, but I dunno the status of any of them...
> > 
> > I think asking "what we need to convert" is at least slightly
> > mis-framed. Once the basics for device tree support are in place
> > (basically patches 06-09), which boards are supported by device tree
> > is mostly a matter of (1) whether the hardware drivers you want to use
> > have bindings and use modern kernel interfaces, and (2) someone
> > writing the dts files.
> 
> (3) being able to test the result on real hardware.
> 
> We can _add_ device tree support without that, but can we remove the old board
> files without it?

As far as what Linus told me when I joined as maintainer, we can
remove whatever we like. But I don't want to be user-hostile.

OTOH I don't think there are SH users keeping up with bleeding-edge
kernels, and I don't think distros (Debian?) are shipping kernels
anyway since the kernel is currently highly board-specific. So the
only users who would be affected by removal are ones building their
own latest kernels, and it seems plausible they'd be happy with doing
a little testing to provide feedback to get things working with DT if
they don't work out of the box.

> > I don't mind holding off a little bit on removal of the legacy board
> > file support if it's hard to get enough hardware working right away
> > with device tree, but I do want to move towards getting rid of it as
> > soon as we can, since it's a large volume of code cutting into my
> > ability to have a good maintainer-level understanding of the arch/sh
> > tree and has a lot of crufty, unmaintained parallel infrastructure
> > duplicating stuff that can be done in cleaner and more modern ways
> > (see the threads on early platform device stuff, rtc drivers, etc.).
> 
> The process may include a deprecation of hardware nobody has anymore, with call
> for testers, for a year or so before deleting stuff. (And then the old stuff's
> in git if somebody finds a board and wants to fish it out.)
> 
> Also, I'd really like QEMU support to act as a first class board. At least 256
> megs of ram (so you can do native compiles on it),

Unfortunately the r2d has some hardware mapped just above 64M
physical, so it's not easy to extend its memory size. I think device
tree will solve this by letting us pass multiple physical ranges that
can be used as ram, which I don't know how to do with the old
kconfig-based memory base/size.

Of course there's no limit (except the usual 2G one) on virtual
memory, so another solution is just adding large swap. I think with a
virtio block device it would be fast.

> serial support that works
> (enabling the FIFO broke it because they don't implement the '15 bits of silence
> triggers a flush timer' part, so data gets stranded in the buffer until enough
> comes in to fill it the rest of the way which is a pain to type at when it's a
> serial console), multiple hard drives, and so on.

Let's look at how the kernel detects the buffer capability. It might
be a one-line fix on the qemu side, telling it to claim to emulate an
older model, and it's probably easy to add a kernel cmdline option to
work around it too.

> I'd be fine with virtio but there's no virtio devices on that target I've
> noticed yet, although maybe I just haven't figured out how to enable it...

I'm running qemu-sh4-system with -M r2d and virtio 9p & network,
rootfs on 9p. If you want to try reproducing my setup I can run
through my .config and command line options with you and see if we can
get something in suitable form for writeup.

Rich
