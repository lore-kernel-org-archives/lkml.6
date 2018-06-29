Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51114C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F338F27FED
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b="R0miTZ5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F338F27FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=horus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936344AbeF2OrU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:47:20 -0400
Received: from mail.horus.com ([78.46.148.228]:49689 "EHLO mail.horus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932254AbeF2OrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:47:18 -0400
Received: from [192.168.1.20] (193-83-224-126.adsl.highway.telekom.at [193.83.224.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "E-Mail Matthias Reichl", Issuer "HiassofT CA 2014" (verified OK))
        by mail.horus.com (Postfix) with ESMTPSA id 36ED5640AA;
        Fri, 29 Jun 2018 16:47:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1530283636;
        bh=suzBgkz9DDBpuE5IJKzep1xm+U7pdwQVFTQ2tMp1q5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R0miTZ5sOAwh7vOcNWjcwR9kXDBxnKfeHOEdPzff1qGvEwxIEsXkIN3wRDbzXtNaI
         KmU09W5CoXByQmV94Sji+aUHxnbzPHdff48naT8IwEFAColgHsOsyg56oE5JEntxyh
         0QyzG+xdFVkEHW8PYjbyf4St8Bk6VR7y54el5ZJg=
Received: by camel2.lan (Postfix, from userid 1000)
        id B69761C78CA; Fri, 29 Jun 2018 16:47:14 +0200 (CEST)
Date:   Fri, 29 Jun 2018 16:47:14 +0200
From:   Matthias Reichl <hias@horus.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>,
        Phil Elwell <phil@raspberrypi.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] Arm: mm: ftrace: Only set text back to ro after kernel
 has been marked ro
Message-ID: <20180629144714.hkvwqzpikweyihmo@camel2.lan>
Mail-Followup-To: Matthias Reichl <hias@horus.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>, Phil Elwell <phil@raspberrypi.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <CAGXu5jLaQozk-TuZd8o=CK2kBcj3EFqD+VQtGX-DehU=c_TAkg@mail.gmail.com>
 <20170823150351.606ba09f@gandalf.local.home>
 <20171205114709.f6aj6i426keq2cn5@camel2.lan>
 <20171205131416.GW10595@n2100.armlinux.org.uk>
 <20171205132339.behn34z6b7ci2m4j@camel2.lan>
 <5b9b86cf-4b62-c984-fe52-a22df8fce33c@raspberrypi.org>
 <20171205133601.GX10595@n2100.armlinux.org.uk>
 <CAGXu5jJb0PCSuC4DuOkh5-901iVLcmmPpn1G7UBq3-r9DaeMvw@mail.gmail.com>
 <20171205200935.GY10595@n2100.armlinux.org.uk>
 <CAGXu5jKvVpyLs0+zP34mG=XyGSkzeKFj6WtW+tTfKv7tLKsD2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKvVpyLs0+zP34mG=XyGSkzeKFj6WtW+tTfKv7tLKsD2g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2017 at 12:14:46PM -0800, Kees Cook wrote:
> On Tue, Dec 5, 2017 at 12:09 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Tue, Dec 05, 2017 at 11:35:59AM -0800, Kees Cook wrote:
> >> We don't _need_ to, but they're all contiguous, so the ro_perms array
> >> used by set_kernel_text_*() is actually only a single entry:
> >>
> >> static struct section_perm ro_perms[] = {
> >>         /* Make kernel code and rodata RX (set RO). */
> >>         {
> >>                 .name   = "text/rodata RO",
> >>                 .start  = (unsigned long)_stext,
> >>                 .end    = (unsigned long)__init_begin,
> >> ...
> >
> > Well, they may not be contiguous - it depends on DEBUG_ALIGN_RODATA.
> 
> Maybe I'm picking a slightly wrong word. I guess I meant adjacent. The
> range _stext to __init_begin is all read-only, though there may be
> padding (controlled by DEBUG_ALIGN_RODATA), to allow a split for NX
> markings on rodata.
> 
> > Either way, we have __start_rodata_section_aligned, which is either
> > the start of the read-only data section, or the start of the first
> > section beyond __start_rodata if DEBUG_ALIGN_RODATA is not set.
> >
> > Given that __start_rodata_section_aligned will always be less than
> > __init_begin, is there any reason not to make the above end at
> > __start_rodata_section_aligned, thereby allowing more of the read-only
> > data (in the case of DEBUG_ALIGN_RODATA=n) or all of the read-only
> > data (in the case of DEBUG_ALIGN_RODATA=y) to remain write-protected?
> 
> Sure, there's no reason not to split this into two entries. It'll
> require some reworking of the function calls to get it right,
> obviously.

Gentle ping, arm is still oopsing when the function tracer is
enabled at boot time.

Tested on bcm2835 (RPiB+) with current mainline tree
(githash 90368a37fbbe) and bcm2835_defconfig.

arm64 seems to be fine, tested on bcm2837 (RPi3) with same tree and
arm64 defconfig plus function tracer enabled.

earlycon log on bvm2835:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.18.0-rc2+ (hias@camel2) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1 Fri Jun 29 10:55:21 CEST 2018
[    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] OF: fdt: Machine model: Raspberry Pi Model B Plus Rev 1.2
[    0.000000] earlycon: pl11 at MMIO32 0x20201000 (options '')
[    0.000000] bootconsole [pl11] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] cma: Reserved 32 MiB at 0x13c00000
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] random: get_random_bytes called from start_kernel+0x88/0x464 with crng_init=0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 89408
[    0.000000] Kernel command line: bcm2708_fb.fbwidth=1280 bcm2708_fb.fbheight=1024 bcm2708_fb.fbswap=1 dma.dmachans=0x7f35 bcm2708.boardrev=0x10 bcm2708.serial=0x59ce1e57 bcm2708.uart_clock=48000000 bcm2708.disk_led_gpio=47 bcm2708.disk_led_active_low=0 smsc95xx.macaddr=B8:27:EB:CE:1E:57 vc_mem.mem_base=0x1ec00000 vc_mem.mem_size=0x20000000  root=/dev/mmcblk0p2 rw rootwait elevator=noop earlycon=pl011,mmio32,0x20201000 console=/dev/ttyAMA0,115200 ftrace=function
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 311736K/360448K available (7168K kernel code, 610K rwdata, 2328K rodata, 1024K init, 675K bss, 15944K reserved, 32768K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xd6800000 - 0xff800000   ( 656 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd6000000   ( 352 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0x(ptrval) - 0x(ptrval)   (8160 kB)
[    0.000000]       .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
[    0.000000]       .data : 0x(ptrval) - 0x(ptrval)   ( 611 kB)
[    0.000000]        .bss : 0x(ptrval) - 0x(ptrval)   ( 676 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] ftrace: allocating 27246 entries in 80 pages
[    0.000000] Starting tracer 'function'
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000054] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 2147483647500ns
[    0.008887] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
[    0.018977] bcm2835: system timer (irq = 27)
[    0.028348] Console: colour dummy device 80x30
[    0.033444] Calibrating delay loop... 695.09 BogoMIPS (lpj=3475456)
[    0.100506] pid_max: default: 32768 minimum: 301
[    0.107059] Unable to handle kernel paging request at virtual address c0a07250
[    0.114665] pgd = (ptrval)
[    0.117541] [c0a07250] *pgd=00a0840e(bad)
[    0.121858] Internal error: Oops: 80d [#1] ARM
[    0.126369] Modules linked in:
[    0.129491] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc2+ #1
[    0.135755] Hardware name: BCM2835
[    0.139240] PC is at uts_ns_init+0x40/0x58
[    0.143395] LR is at   (null)
[    0.146406] pc : [<c0b0fde4>]    lr : [<00000000>]    psr: 60000053
[    0.152757] sp : c0c01f88  ip : c0c07120  fp : c0c01fa4
[    0.158054] r10: d5fff9c0  r9 : c0b59a28  r8 : c0c04040
[    0.163352] r7 : c0c04048  r6 : ffffffff  r5 : c0c98980  r4 : c0c989cc
[    0.169969] r3 : c0a07250  r2 : 00000000  r1 : c0209384  r0 : d3a1b300
[    0.176586] Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
[    0.183906] Control: 00c5387d  Table: 00004008  DAC: 00000051
[    0.189730] Process swapper (pid: 0, stack limit = 0x(ptrval))
[    0.195645] Stack: (0xc0c01f88 to 0xc0c02000)
[    0.200072] 1f80:                   00000004 00000186 00000000 c0c98980 c0c01ff4 c0c01fa8
[    0.208369] 1fa0: c0b00ebc c0b0fdb0 ffffffff ffffffff 00000000 c0b00864 00000000 c0b59a28
[    0.216665] 1fc0: 1297841c 00000000 00000000 c0b00330 00000051 00c0387d 00000c42 15feca00
[    0.224961] 1fe0: 410fb767 00c5387d 00000000 c0c01ff8 00000000 c0b00b40 00000000 00000000
[    0.233301] [<c0b0fde4>] (uts_ns_init) from [<c0b00ebc>] (start_kernel+0x388/0x464)
[    0.241081] [<c0b00ebc>] (start_kernel) from [<00000000>] (  (null))
[    0.247541] Code: e3a03701 e59f0014 ebdbe4f1 e59f3010 (e5830000) 
[    0.253755] ---[ end trace fe6d5629dd3ec6e3 ]---
[    0.258446] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.265255] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
[    2.749496] random: fast init done

so long,

Hias
