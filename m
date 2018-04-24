Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932776AbeDXCIf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:08:35 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:57032 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932670AbeDXCIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:08:31 -0400
Date: Tue, 24 Apr 2018 04:08:25 +0200
From: Adam Borowski <kilobyte@angband.pl>
To: Pavel Machek <pavel@ucw.cz>
Cc: Paul Menzel <pmenzel+linux-kernel@molgen.mpg.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: How to disable Linux =?utf-8?Q?kernel_?=
 =?utf-8?Q?self-extraction_=28KERNEL=5FGZIP=2C_KERNEL=5FBZIP2=2C_=E2=80=A6?=
 =?utf-8?B?KT8=?=
Message-ID: <20180424020824.2vsddcdndjnvdm46@angband.pl>
References: <9468be0e-5eb9-246c-e60e-3d8019a42fd1@molgen.mpg.de>
 <20180422102033.GB26243@amd>
 <b22efb58-b63e-7130-f2d7-a9d28225ef9b@molgen.mpg.de>
 <20180422205208.GA8672@amd>
 <20180423170230.GA22412@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180423170230.GA22412@amd>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 07:02:30PM +0200, Pavel Machek wrote:
> > > >>I try to decrease boot time, and my system has an SSD and enough space, so
> > > >>loading 18 instead of 12 MB doesn’t make a difference, but the
> > > >>self-extraction is noticeable. So, I like to disable it.
> > > >
> > > >How long does GZIP extraction take on your hardware?
> > > 
> > > It’s hard to measure – at least I didn’t find a way to do so –, but counting
> > > from the last GRUB message to the first message of Linux (with `quiet`
> > > removed from the the command line), it takes roughly *two* seconds.

I took a somewhat different approach: I recorded the output from grub+kernel
to ttyrec over serial line, and rigged ttyrec2ansi to output timestamp
difference from the last checkpoint every time an '\e' or '\n' is seen.
'\e' is important, as there's no other marking for when grub stops the
interactive phase and starts the actual boot.

Turns out that, reading from SSD, grub is way way slower than it should take
normally.  The machine is old (AMD Phenom II X6 1055T), SSD is Crucial
CT240M500SSD1.

I also have the zstd patch applied, which adds another data point.

The two "Loading XXX ..." lines come from grub, those timestamped within []
brackets from the kernel, 〈〉are ttyrec timestamps, ⤸ is wrapped lines.


zstd:

Loading Linux 4.17.0-rc2-debug-00025-gd426b0ba363d ...〈0.739823〉
^MLoading initial ramdisk ...〈0.402010〉
^M[    0.000000] Linux version 4.17.0-rc2-debug-00025-gd426b0ba363d ⤸
(kilobyte@umbar) (gcc version 7.3.0 (Debian 7.3.0-16)) #1 SMP Mon Apr 23⤸
10:25:58 CEST 2018^M〈0.785922〉
[    0.000000] Command line: BOOT_IMAGE=/sys/boot/vmlinuz-4.17.0-rc2-debug-00025-gd426b0ba363d⤸
 root=UUID=b7c38da9-ae84-4083-a1f8-6d7b4fc33961 ro rootflags=subvol=sys syscall.x32=y⤸
 console=tty0 console=ttyS0,115200n8 no_console_suspend^M〈0.020199〉

gzip:

Loading Linux 4.17.0-rc2-debug-gz-00025-gd426b0ba363d ...〈0.724988〉
^MLoading initial ramdisk ...〈0.357951〉
^M[    0.000000] Linux version 4.17.0-rc2-debug-gz-00025-gd426b0ba363d ⤸
(kilobyte@umbar) (gcc version 7.3.0 (Debian 7.3.0-16)) #1 SMP Mon Apr 23 ⤸
23:15:07 CEST 2018^M〈0.777977〉
[    0.000000] Command line: BOOT_IMAGE=/sys/boot/vmlinuz-4.17.0-rc2-debug-gz-00025-gd426b0ba363d⤸
 root=UUID=b7c38da9-ae84-4083-a1f8-6d7b4fc33961 ro rootflags=subvol=sys syscall.x32=y⤸
 console=tty0 console=ttyS0,115200n8 no_console_suspend^M〈0.020117〉

lz4:

Loading Linux 4.17.0-rc2-debug-none-00025-gd426b0ba363d ...〈0.799969〉
^MLoading initial ramdisk ...〈0.424959〉
^M[    0.000000] Linux version 4.17.0-rc2-debug-lz4-00025-gd426b0ba363d ⤸
(kilobyte@umbar) (gcc version 7.3.0 (Debian 7.3.0-16)) #1 SMP Tue Apr 24 ⤸
00:34:59 CEST 2018^M〈0.732925〉
[    0.000000] Command line: BOOT_IMAGE=/sys/boot/vmlinuz-4.17.0-rc2-debug-lz4-00025-gd426b0ba363d⤸
 root=UUID=b7c38da9-ae84-4083-a1f8-6d7b4fc33961 ro rootflags=subvol=sys syscall.x32=y⤸
 console=tty0 console=ttyS0,115200n8 no_console_suspend^M〈0.021019〉

zstd again:

Loading Linux 4.17.0-rc2-debug-00025-gd426b0ba363d ...〈0.728852〉
^MLoading initial ramdisk ...〈0.399968〉
^M[    0.000000] Linux version 4.17.0-rc2-debug-00025-gd426b0ba363d ⤸
(kilobyte@umbar) (gcc version 7.3.0 (Debian 7.3.0-16)) #1 SMP Mon Apr 23 ⤸
10:25:58 CEST 2018^M〈0.786964〉
[    0.000000] Command line: BOOT_IMAGE=/sys/boot/vmlinuz-4.17.0-rc2-debug-00025-gd426b0ba363d⤸
 root=UUID=b7c38da9-ae84-4083-a1f8-6d7b4fc33961 ro rootflags=subvol=sys syscall.x32=y⤸
 console=tty0 console=ttyS0,115200n8 no_console_suspend^M〈0.020071〉

lz4 rigged for no compression:

Loading Linux 4.17.0-rc2-debug-none-00025-gd426b0ba363d-dirty ...〈0.479834〉
^MLoading initial ramdisk ...〈2.246985〉
^M[    0.000000] Linux version 4.17.0-rc2-debug-none-00025-gd426b0ba363d-dirty ⤸
(kilobyte@umbar) (gcc version 7.3.0 (Debian 7.3.0-16)) #5 SMP Tue Apr 24 ⤸
02:57:18 CEST 2018^M〈0.711949〉
[    0.000000] Command line: BOOT_IMAGE=/sys/boot/vmlinuz-4.17.0-rc2-debug-none-00025-gd426b0ba363d-dirty⤸
 root=UUID=b7c38da9-ae84-4083-a1f8-6d7b4fc33961 ro rootflags=subvol=sys syscall.x32=y⤸
 console=tty0 console=ttyS0,115200n8 no_console_suspend^M〈0.021902〉

Sizes of relevant files:

14826134 initrd.img-4.17.0-rc2-debug-00025-gd426b0ba363d    (zstd)
14826352 initrd.img-4.17.0-rc2-debug-gz-00025-gd426b0ba363d
14826909 initrd.img-4.17.0-rc2-debug-lz4-00025-gd426b0ba363d
14826761 initrd.img-4.17.0-rc2-debug-none-00025-gd426b0ba363d-dirty
 6567408 vmlinuz-4.17.0-rc2-debug-00025-gd426b0ba363d       (zstd)
 7230960 vmlinuz-4.17.0-rc2-debug-gz-00025-gd426b0ba363d
 8775152 vmlinuz-4.17.0-rc2-debug-lz4-00025-gd426b0ba363d
27821552 vmlinuz-4.17.0-rc2-debug-none-00025-gd426b0ba363d-dirty
(I did not alter initrd compression, which is zstd in all cases).

> > So yes, looks like uncompressed kernel image may be good idea.

Seems like the time to actually read this far bigger file from the disk
using grub's inefficient way, takes longer than the gains from faster
decompression.  You can eliminate the decompression step altogether by
avoiding copying, but it still looks like it's not a win.

I've seen u-boot taking ~60 seconds to read from a SD card, too.

Another surprise is that zstd is a notch _slower_ than gzip (in userspace
it's drastically faster for the same compression ratio), but reduced disk
space is still nice.  It's worth investigating why it's not as fast as it
should be.
 
> Actually... Compressors usually have a mode when they store the data
> uncompressed. So you should be able to prepare .gz image which is not
> really compressed inside, and thus really fast to uncompress.

I can't seem to find any.  IIRC xz format can store uncompressed blocks but
the tool doesn't appear to expose this as an option.

> Or maybe even better -- there should be some compression algorithms
> that are fast enough to uncompress that there should be no
> slowdown. Maybe use one of those?

Perhaps my method is totally wrong, but differences in decompression speed
are surprisingly small, dwarfed by whatever else the kernel does between
messages.

I did not test xz, nor ran tests more than once, but it's 4am so these are
things to do todorrow.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢰⠒⠀⣿⡁ 
⢿⡄⠘⠷⠚⠋⠀ ... what's the frequency of that 5V DC?
⠈⠳⣄⠀⠀⠀⠀
