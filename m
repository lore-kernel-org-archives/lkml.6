Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeEGPzz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 11:55:55 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:53782 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeEGPzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 11:55:54 -0400
Date: Mon, 7 May 2018 11:55:43 -0400
From: Rich Felker <dalias@libc.org>
To: Rob Landley <rob@landley.net>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to
 device tree
Message-ID: <20180507155543.GJ1392@brightrain.aerifal.cx>
References: <20171117191706.GF1627@brightrain.aerifal.cx>
 <7193aa1b-50e3-11d4-f93d-f567e2e06b8c@physik.fu-berlin.de>
 <20180105212857.GR1627@brightrain.aerifal.cx>
 <20180503013708.GC1392@brightrain.aerifal.cx>
 <20180503023320.GD1392@brightrain.aerifal.cx>
 <048ab147-21b8-045d-d21c-e1be2dd0e954@physik.fu-berlin.de>
 <87k1sgtf8t.wl-ysato@users.sourceforge.jp>
 <5f690985-e905-deb9-aa4f-51561463ae22@physik.fu-berlin.de>
 <20180507144519.GH1392@brightrain.aerifal.cx>
 <9f476147-7370-de56-db4e-6745a325a2ca@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f476147-7370-de56-db4e-6745a325a2ca@landley.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 10:28:37AM -0500, Rob Landley wrote:
> 
> 
> On 05/07/2018 09:45 AM, Rich Felker wrote:
> > On Mon, May 07, 2018 at 01:00:17PM +0200, John Paul Adrian Glaubitz wrote:
> >> On 05/07/2018 03:40 AM, Yoshinori Sato wrote:
> >>>> @Yoshinori:
> >>>>
> >>>> Did the HDL-160U LANDISK device you have use u-boot by default or
> >>>> did you convert it from lilo?
> >>>
> >>> Yes.
> >>> Replace sh-lilo's second stage with u-boot.
> >>> With this method it is unnecessary to rewrite Flash for boot.
> >>
> >> Great, thank you. I will give it a try on my USL-5P and write down
> >> the individual steps once I have figured it out.
> > 
> > Please let me know once you figure it out. I haven't made much
> > progress yet and it would be really helpful to have some simple
> > directions/outline of what to do, especially one that's not in terms
> > of black box tools ("run this command") but how it all works (where
> > the different bootloader components live when installed -- MBRs?
> > partition boot records? files in a filesystem (who interprets it?)?
> > etc.)
> 
> U-boot 101. The workflow you want is usually:
> 
> 1) get u-boot to load and run on the board, with serial console and a basic
> knowledge of where the DRAM is. (This often involves fighting with dram refresh
> init, often by convincing u-boot NOT to do it because your stage 1 bootloader
> already did, which involves a rolled up newspaper and a lot of swearing because
> it ASSUMES. Oh it assumes. Or sometimes there's an sram->dram relocation which
> means somewhere, there's a magic linker script you will learn to hate. Well,
> Rich might be comfortable with that area, I still stub my toes there a lot.)
> 
> 2) Getting u-boot reading/writing a flash area it can store its environment
> variables in, so they can persist. (It's a driver.)
> 
> 3) get u-boot talking to the network card, with either dhcp or static IP.
> (Another driver, and some magic environment variables the driver consumes.)
> 
> 4) tftp fetch an ELF kernel (or uimage if you must) into DRAM starting at a
> known address. (This is a u-boot command line command. You'll need a tftp server
> set up on another machine for it to fetch from.)
> 
> 5) tftp fetch any other data (initrd.cpio.gz, board.dtb). (Same command,
> different parameters.)
> 
> 6) boot the kernel with all that gorp (a big long command line command) which
> will need a kernel command line (generally stored in another persistent
> environjment variable).
> 
> 7) make a "go" script that does all that in one commend. There's a command to
> run an environment variable's contents as a set of semicolon-separated command
> line commands (that's how u-boot implements scripts), and there's a magic
> environment variable whose contents get run on startup (bootup? startup? I
> forget, it's in the source and docs and a buncha examples out there). It's
> cleaner to have the magic one do "run $othervar" rather than putting a lot of
> plumbing in the magic one. And you will totally want a "wait 3 seconds for a key
> to be pressed and do a shell prompt if it is" header on that or you have to
> reflash the bootloader to get your shell prompt back, which is sad.
> 
> 8) Once you've got tftp working, there's a copy command to copy flash memory to
> dram, and a corresponding "write to flash from dram" command with dram start
> address and flash start address and length arguments. This is how the boot
> without tftp is implemented in u-boot, and how updating the saved image it
> auto-boots to if you don't press a key is implemented.
> 
> (You can usually configure/build uboot in a couple different ways, with a
> brain-dead built in shell or with busybox hush glued into it. Depends on how big
> you want the image to be. Not sure how much of that is upstream and how much is
> vendor forks I've used, though. Been a while.)

This sounds like a pain, but none of it seems relevant to the setup
we're using. This U-Boot variant does not install on flash or use
flash; it runs from disk in place of LILO or another MBR-based
bootloader. I'm just trying to understand where/how the binary blobs
are installed on the disk so I can reproduce that when making new disk
images with my kernel and filesystem.

Rich
