Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbeDXXHH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 19:07:07 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:40510 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeDXXHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 19:07:05 -0400
Date: Wed, 25 Apr 2018 01:06:58 +0200
From: Adam Borowski <kilobyte@angband.pl>
To: Paul Menzel <pmenzel+linux-kernel@molgen.mpg.de>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: How to disable Linux =?utf-8?Q?kernel_?=
 =?utf-8?Q?self-extraction_=28KERNEL=5FGZIP=2C_KERNEL=5FBZIP2=2C_=E2=80=A6?=
 =?utf-8?B?KT8=?=
Message-ID: <20180424230658.qbj2bdvbapep7sgl@angband.pl>
References: <9468be0e-5eb9-246c-e60e-3d8019a42fd1@molgen.mpg.de>
 <20180422102033.GB26243@amd>
 <b22efb58-b63e-7130-f2d7-a9d28225ef9b@molgen.mpg.de>
 <20180422205208.GA8672@amd>
 <20180423170230.GA22412@amd>
 <20180424020824.2vsddcdndjnvdm46@angband.pl>
 <bb5bf465-bf71-4ddb-2a7e-866bb0f76606@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nmlv7amipqrff7ob"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb5bf465-bf71-4ddb-2a7e-866bb0f76606@molgen.mpg.de>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nmlv7amipqrff7ob
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 24, 2018 at 11:08:34AM +0200, Paul Menzel wrote:
> On 04/24/18 04:08, Adam Borowski wrote:
> > On Mon, Apr 23, 2018 at 07:02:30PM +0200, Pavel Machek wrote:
> > > > > > > I try to decrease boot time, and my system has an SSD and enough space, so
> > > > > > > loading 18 instead of 12 MB doesn’t make a difference, but the
> > > > > > > self-extraction is noticeable. So, I like to disable it.
> > > > > > 
> > > > > > How long does GZIP extraction take on your hardware?
> > > > > 
> > > > > It’s hard to measure – at least I didn’t find a way to do so –, but counting
> > > > > from the last GRUB message to the first message of Linux (with `quiet`
> > > > > removed from the the command line), it takes roughly *two* seconds.
> > 
> > I took a somewhat different approach: I recorded the output from grub+kernel
> > to ttyrec over serial line, and rigged ttyrec2ansi to output timestamp
> > difference from the last checkpoint every time an '\e' or '\n' is seen.
> > '\e' is important, as there's no other marking for when grub stops the
> > interactive phase and starts the actual boot.
> 
> Nice work. It’d be great, if you shared these patches, so others and I can
> reproduce it.

ttyrec2ansi.c attached.  To use: save the serial output as ttyrec (via the
eponymous tool, termrec, conversion from a similar format, etc), pipe
through modified ttyrec2ansi to a terminal, "less -R".


userland lz4:
diff --git a/lib/lz4.c b/lib/lz4.c
index 213b085..39d2cff 100644
--- a/lib/lz4.c
+++ b/lib/lz4.c
@@ -499,6 +499,7 @@ LZ4_FORCE_INLINE U32 LZ4_hashPosition(const void* const p, tableType_t const tab
 
 static void LZ4_putPositionOnHash(const BYTE* p, U32 h, void* tableBase, tableType_t const tableType, const BYTE* srcBase)
 {
+    return;
     switch (tableType)
     {
     case byPtr: { const BYTE** hashTable = (const BYTE**)tableBase; hashTable[h] = p; return; }

Somehow this affects only /usr/bin/lz4 not /usr/bin/lz4c, which I did not
bother to fix but hacked via:

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index f2014876405f..91534a801090 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -332,7 +332,7 @@ cmd_lzo = (cat $(filter-out FORCE,$^) | \
 
 quiet_cmd_lz4 = LZ4     $@
 cmd_lz4 = (cat $(filter-out FORCE,$^) | \
-       lz4c -l -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
+       lz4 -l -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
        (rm -f $@ ; false)
 
 # U-Boot mkimage


I have serious doubts this approach is sound, but worked well enough at
least to spot the GRUB read slowness issue.

> > Turns out that, reading from SSD, grub is way way slower than it should take
> > normally.  The machine is old (AMD Phenom II X6 1055T), SSD is Crucial
> > CT240M500SSD1.
> 
> What firmware does the device (mainboard) have? Legacy BIOS or UEFI (or even
> coreboot ;-)). It’s my understanding, that GRUB does not have a native
> driver with the legacy BIOS and UEFI, and just uses the BIOS calls or the
> UEFI equivalent.

An old machine -- real BIOS.

> > I also have the zstd patch applied, which adds another data point.
> > 
> > The two "Loading XXX ..." lines come from grub, those timestamped within []
> > brackets from the kernel, 〈〉are ttyrec timestamps, ⤸ is wrapped lines.
> > 
> > 
> > zstd:
> > 
> > Loading Linux 4.17.0-rc2-debug-00025-gd426b0ba363d ...〈0.739823〉
> > ^MLoading initial ramdisk ...〈0.402010〉
> > ^M[    0.000000] Linux version 4.17.0-rc2-debug-00025-gd426b0ba363d ⤸
> > (kilobyte@umbar) (gcc version 7.3.0 (Debian 7.3.0-16)) #1 SMP Mon Apr 23⤸
> > 10:25:58 CEST 2018^M〈0.785922〉
> > 
> > gzip:
> > 
> > Loading Linux 4.17.0-rc2-debug-gz-00025-gd426b0ba363d ...〈0.724988〉
> > ^MLoading initial ramdisk ...〈0.357951〉
> > ^M[    0.000000] Linux version 4.17.0-rc2-debug-gz-00025-gd426b0ba363d ⤸
> > (kilobyte@umbar) (gcc version 7.3.0 (Debian 7.3.0-16)) #1 SMP Mon Apr 23 ⤸
> > 23:15:07 CEST 2018^M〈0.777977〉
> > 
> > lz4:
> > 
> > Loading Linux 4.17.0-rc2-debug-none-00025-gd426b0ba363d ...〈0.799969〉
> > ^MLoading initial ramdisk ...〈0.424959〉
> > ^M[    0.000000] Linux version 4.17.0-rc2-debug-lz4-00025-gd426b0ba363d ⤸
> > (kilobyte@umbar) (gcc version 7.3.0 (Debian 7.3.0-16)) #1 SMP Tue Apr 24 ⤸
> > 00:34:59 CEST 2018^M〈0.732925〉
> > 
> > zstd again:
> > 
> > Loading Linux 4.17.0-rc2-debug-00025-gd426b0ba363d ...〈0.728852〉
> > ^MLoading initial ramdisk ...〈0.399968〉
> > ^M[    0.000000] Linux version 4.17.0-rc2-debug-00025-gd426b0ba363d ⤸
> > (kilobyte@umbar) (gcc version 7.3.0 (Debian 7.3.0-16)) #1 SMP Mon Apr 23 ⤸
> > 10:25:58 CEST 2018^M〈0.786964〉
> > 
> > lz4 rigged for no compression:
> > 
> > Loading Linux 4.17.0-rc2-debug-none-00025-gd426b0ba363d-dirty ...〈0.479834〉
> > ^MLoading initial ramdisk ...〈2.246985〉
> 
> Just to be sure. The 2.2 seconds are from loading the 27 MB Linux kernel
> image, right?

I don't see any other obvious explanation, yeah.

> > ^M[    0.000000] Linux version 4.17.0-rc2-debug-none-00025-gd426b0ba363d-dirty ⤸
> > (kilobyte@umbar) (gcc version 7.3.0 (Debian 7.3.0-16)) #5 SMP Tue Apr 24 ⤸
> > 02:57:18 CEST 2018^M〈0.711949〉

lz4 rigged for no compression, re-run:

Loading Linux 4.17.0-rc2-debug-none-00025-gd426b0ba363d-dirty ...〈0.476784〉
^MLoading initial ramdisk ...〈2.229852〉
^M[    0.000000] Linux version 4.17.0-rc2-debug-none-00025-gd426b0ba363d-dirty ⤸
(kilobyte@umbar) (gcc version 7.3.0 (Debian 7.3.0-16)) #5 SMP Tue Apr 24 ⤸
02:57:18 CEST 2018^M〈0.711020〉

xz:

Loading Linux 4.17.0-rc2-debug-xz-00025-gd426b0ba363d ...〈0.489154〉
^MLoading initial ramdisk ...〈0.278774〉
^M[    0.000000] Linux version 4.17.0-rc2-debug-xz-00025-gd426b0ba363d ⤸
(kilobyte@umbar) (gcc version 7.3.0 (Debian 7.3.0-16)) #1 SMP Tue Apr 24 ⤸
11:30:49 CEST 2018^M〈1.221916〉


> > Sizes of relevant files:
> > 
> > 14826134 initrd.img-4.17.0-rc2-debug-00025-gd426b0ba363d    (zstd)
> > 14826352 initrd.img-4.17.0-rc2-debug-gz-00025-gd426b0ba363d
> > 14826909 initrd.img-4.17.0-rc2-debug-lz4-00025-gd426b0ba363d
> > 14826761 initrd.img-4.17.0-rc2-debug-none-00025-gd426b0ba363d-dirty
    14825759 initrd.img-4.17.0-rc2-debug-xz-00025-gd426b0ba363d
> >  6567408 vmlinuz-4.17.0-rc2-debug-00025-gd426b0ba363d       (zstd)
> >  7230960 vmlinuz-4.17.0-rc2-debug-gz-00025-gd426b0ba363d
> >  8775152 vmlinuz-4.17.0-rc2-debug-lz4-00025-gd426b0ba363d
> > 27821552 vmlinuz-4.17.0-rc2-debug-none-00025-gd426b0ba363d-dirty
     5654000 vmlinuz-4.17.0-rc2-debug-xz-00025-gd426b0ba363d
> > (I did not alter initrd compression, which is zstd in all cases).
> 
> Does the size of the uncompressed image match the size in
> `arch/x86/boot/compressed/vmlinux.bin`?

Nearly -- lz4 has a weird inefficient way of storing length of literals: a
long run is stored as 255 255 255 255 255 255 255 42 to say 7*255+42, at a
cost of 0.4% space.  It might be good to use a more faithful null
compressor, although sticking with real lz4 might be safer.

> > > > So yes, looks like uncompressed kernel image may be good idea.
> > 
> > Seems like the time to actually read this far bigger file from the disk
> > using grub's inefficient way, takes longer than the gains from faster
> > decompression.  You can eliminate the decompression step altogether by
> > avoiding copying, but it still looks like it's not a win.
> > 
> > I've seen u-boot taking ~60 seconds to read from a SD card, too.
> 
> I could test on my coreboot systems, if GRUB is faster with the native AHCI
> driver.

Yeah -- this machine's SSD is no speed demon, mere 500MB/s, but that's wee
bit faster than the ridiculous slowness of GRUB.

And it's not just GRUB:

Retrieving file: /initrd.img-4.16.0-00199-ge68d78e24cde〈0.004987〉
6042402 bytes read in 354 ms (16.3 MiB/s)〈0.380119〉
Retrieving file: /vmlinuz-4.16.0-00199-ge68d78e24cde〈0.004918〉
15809024 bytes read in 68814 ms (223.6 KiB/s)〈68.842893〉
append: root=/dev/mmcblk0p5 ro console=ttyS0,115200n8 rootwait⤸
 earlycon=uart,mmio32,0x01c28000 loglevel=8〈0.009030〉
Retrieving file: /dtbs/4.16.0-00199-ge68d78e24cde/allwinner/sun50i-a64-pine64-plus.dtb〈0.007933〉
19458 bytes read in 524 ms (36.1 KiB/s)〈0.550027〉
## Flattened Device Tree blob at 4fa00000〈0.003124〉
   Booting using the fdt blob at 0x4fa00000〈0.003997〉
   Loading Ramdisk to 49a3c000, end 49fff322 ... OK〈0.010845〉
   Loading Device Tree to 0000000049a34000, end 0000000049a3bc01 ... OK〈0.007020〉
〈0.005008〉
Starting kernel ...〈0.002145〉
〈0.000886〉
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]〈0.018013〉
[    0.000000] Linux version 4.16.0-00199-ge68d78e24cde (kilobyte@sirius) ⤸
(gcc version 7.3.0 (Debian 7.3.0-14)) #1 SMP PREEMPT Fri Apr 6 03:17:52 CEST 2018〈0.013964〉


> > Another surprise is that zstd is a notch _slower_ than gzip (in userspace
> > it's drastically faster for the same compression ratio), but reduced disk
> > space is still nice.  It's worth investigating why it's not as fast as it
> > should be.
> 
> Maybe that should be done in a separate thread. I’ll split it out.

It'd be good to gather data for initrd compression as well to get both in
one go.  In these existing logs, all had zstd:

AMD Phenom II:
[    2.367726] Decompressing using zstd.〈0.003109〉
[    2.515786] Freeing initrd memory: 14480K〈0.148877〉

Allwinner A64:
[    1.924208] Decompressing using zstd.〈0.003906〉
[    2.230483] Freeing initrd memory: 5900K〈0.306135〉

Lemme re-run with other compressors.
 
> > Perhaps my method is totally wrong, but differences in decompression speed
> > are surprisingly small, dwarfed by whatever else the kernel does between
> > messages.
> > 
> > I did not test xz, nor ran tests more than once, but it's 4am so these are
> > things to do tomorrow.
> 
> It’d be interesting to find out, what is happening in the first 700 ms,
> before the first Linux message is transmitted over serial line. It could be,
> that the serial line affects the time stamps for example, or takes so long
> to set up the serial console.

printk only gathers data in a buffer during early init, waiting until not
only the kernel is decompressed, but also a bunch of various other kinds of
initialization are done before the serial line is set up, right?  Not sure
if there's a way to time early init, when all in-kernel timestamps show up
as [    0.000000].

As for the serial line, it _is_ slow: at 115200 it takes 5ms to send a line
which slows down boot considerably, especially with debug output (~1000
lines here) -- but 12ms for the first wrapped line is a far cry from 700ms.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢰⠒⠀⣿⡁ 
⢿⡄⠘⠷⠚⠋⠀ Certified airhead; got the CT scan to prove that!
⠈⠳⣄⠀⠀⠀⠀ 

--nmlv7amipqrff7ob
Content-Type: text/x-csrc; charset=utf-8
Content-Disposition: attachment; filename="ttyrec2ansi.c"
Content-Transfer-Encoding: 8bit

#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdint.h>

#include <sys/types.h>
#include <sys/param.h>
#ifdef __ANDROID__
  #include <sys/endian.h>
#endif
#ifdef __sun
# include <sys/isa_defs.h>
# define LITTLE_ENDIAN 1234
# define BIG_ENDIAN    4321
# ifdef _LITTLE_ENDIAN
#  define BYTE_ORDER LITTLE_ENDIAN
# else
#  define BYTE_ORDER BIG_ENDIAN
# endif
#endif

#ifndef htole32
 #if BYTE_ORDER == LITTLE_ENDIAN
  #define htole32(x) (x)
 #else
  #if BYTE_ORDER == BIG_ENDIAN
   #define htole32(x) \
       ((((x) & 0xff000000) >> 24) | (((x) & 0x00ff0000) >>  8) | \
        (((x) & 0x0000ff00) <<  8) | (((x) & 0x000000ff) << 24))
  #else
   #error No endianness given.
  #endif
 #endif
#endif

struct ttyrec_header
{
    uint32_t sec;
    uint32_t usec;
    uint32_t len;
};

#define BUFFER_SIZE 4096


int main(void)
{
    struct ttyrec_header th;
    char buf[BUFFER_SIZE];
    int s, n, r;
    uint64_t t0=0, t;

    while (1)
    {
        if (fread(&th, 1, 12, stdin)!=12)
            return 0;
        n=htole32(th.len);
        while (n>0)
        {
            s=(n>BUFFER_SIZE)?BUFFER_SIZE:n;
            if ((r=fread(buf, 1, s, stdin))<=0)
            {
                fprintf(stderr, "%s\n", r?strerror(errno):"File was truncated");
                return 1;
            }
            for (int i=0; i<r; i++)
            {
                t=((uint64_t)htole32(th.sec))*1000000+htole32(th.usec);
                if (buf[i]=='\e'||buf[i]=='\n')
                {
                    printf("〈%lu.%06lu〉", (t-t0)/1000000, (t-t0)%1000000);
                    t0=t;
                }
                fwrite(buf+i, 1, 1, stdout);
            }
            n-=r;
        }
    }

    return 0;
}

--nmlv7amipqrff7ob--
