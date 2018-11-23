Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2376C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDE420663
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDE420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408644AbeKWTVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:21:02 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:54123 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731622AbeKWTVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:21:01 -0500
Subject: Re: NO_BOOTMEM breaks alpha pc164
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org
References: <8c8e3dba-7adf-96c6-195c-311050256743@linux.ee>
 <20181123071448.GE5704@rapoport-lnx>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <fa3cf3b2-116d-ccf3-b17f-75b5ad9476b0@linux.ee>
Date:   Fri, 23 Nov 2018 10:37:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181123071448.GE5704@rapoport-lnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> When it hangs, it hangs right after starting init. "random: crng init done" is printed
>> after starting init and nothing more appears on serial console.
> 
> Can you please send the kernel log for the broken boot case?
> What happens if you try to boot with "init=/bin/sh" added to the kernel
> command line? Is the system able to start shell?

Here it is, with init=/bin/sh:

aboot> b 1/test root=/dev/sda2 console=ttyS0 init=/bin/sh
aboot: loading uncompressed test...
aboot: loading compressed test...
aboot: PHDR 0 vaddr 0xfffffc0000310000 offset 0x2000 size 0x7953a4
aboot: bss at 0xfffffc0000aa53a4, size 0x163634
aboot: zero-filling 1455668 bytes at 0xfffffc0000aa53a4
aboot: starting kernel test with arguments root=/dev/sda2 console=ttyS0 init=/bin/sh
[    0.000000] Linux version 4.19.0-06942-g6471f52af786 (mroos@pc164) (gcc version 7.3.0 (Gentoo 7.3.0-r3 p1.4)) #114 Thu Nov 22 04:16:19 EET 2018
[    0.000000] Booting on EB164 variation PC164 using machine vector PC164 from SRM
[    0.000000] Major Options: EV56 LEGACY_START VERBOSE_MCHECK DISCONTIGMEM MAGIC_SYSRQ
[    0.000000] Command line: root=/dev/sda2 console=ttyS0 init=/bin/sh
[    0.000000] Raw memory layout:
[    0.000000]  memcluster  0, usage 1, start        0, end      192
[    0.000000]  memcluster  1, usage 0, start      192, end    32651
[    0.000000]  memcluster  2, usage 1, start    32651, end    32768
[    0.000000] Initializing bootmem allocator on Node ID 0
[    0.000000]  memcluster  1, usage 0, start      192, end    32651
[    0.000000]  Detected node memory:   start      192, end    32651
[    0.000000] 1024K Bcache detected; load hit latency 30 cycles, load miss latency 212 cycles
[    0.000000] pci: cia revision 2
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 32427
[    0.000000] Kernel command line: root=/dev/sda2 console=ttyS0 init=/bin/sh
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 131072 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 249704K/261208K available (5435K kernel code, 372K rwdata, 1736K rodata, 208K init, 1421K bss, 11504K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=128
[    0.000000] NR_IRQS: 35
[    0.000000] clocksource: rpcc: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 3822520893 ns
[    0.001953] Console: colour VGA+ 80x25
[    0.024414] printk: console [ttyS0] enabled
[    0.025390] Calibrating delay loop... 985.92 BogoMIPS (lpj=480768)
[    0.034179] pid_max: default: 32768 minimum: 301
[    0.036132] Mount-cache hash table entries: 1024 (order: 0, 8192 bytes)
[    0.037109] Mountpoint-cache hash table entries: 1024 (order: 0, 8192 bytes)
[    0.046874] devtmpfs: initialized
[    0.048828] random: get_random_u32 called from bucket_table_alloc.isra.18+0xbc/0x270 with crng_init=0
[    0.050781] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1866466235866741 ns
[    0.051757] futex hash table entries: 256 (order: -1, 6144 bytes)
[    0.053710] NET: Registered protocol family 16
[    0.056640] pci: passed tb register update test
[    0.057617] pci: passed sg loopback i/o read test
[    0.058593] pci: passed tbia test
[    0.059570] pci: passed pte write cache snoop test
[    0.060546] pci: failed valid tag invalid pte reload test (mcheck; workaround available)
[    0.061523] pci: passed pci machine check test
[    0.063476] PCI host bridge to bus 0000:00
[    0.064453] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.065429] pci_bus 0000:00: root bus resource [mem 0x00000000-0x1fffffff]
[    0.066406] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.070312] pci 0000:00:0b.0: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.071289] pci 0000:00:0b.0: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.072265] pci 0000:00:0b.0: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.073242] pci 0000:00:0b.0: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.076171] pci: enabling save/restore of SRM state
[    0.077148] pci 0000:00:06.0: BAR 0: assigned [mem 0x03000000-0x03ffffff pref]
[    0.078124] pci 0000:00:06.0: BAR 2: assigned [mem 0x02800000-0x02ffffff]
[    0.079101] pci 0000:00:09.0: BAR 6: assigned [mem 0x02200000-0x0223ffff pref]
[    0.080078] pci 0000:00:05.0: BAR 6: assigned [mem 0x02240000-0x0225ffff pref]
[    0.081054] pci 0000:00:06.0: BAR 6: assigned [mem 0x02260000-0x0226ffff pref]
[    0.082031] pci 0000:00:06.0: BAR 1: assigned [mem 0x02270000-0x02273fff]
[    0.083007] pci 0000:00:05.0: BAR 2: assigned [mem 0x02274000-0x02274fff]
[    0.083984] pci 0000:00:05.0: BAR 0: assigned [io  0x8000-0x80ff]
[    0.084960] pci 0000:00:05.0: BAR 1: assigned [mem 0x02275000-0x022750ff]
[    0.085937] pci 0000:00:09.0: BAR 0: assigned [io  0x8400-0x847f]
[    0.086914] pci 0000:00:09.0: BAR 1: assigned [mem 0x02276000-0x0227607f]
[    0.087890] pci 0000:00:0b.0: BAR 4: assigned [io  0x8480-0x848f]
[    0.088867] SMC FDC37C93X Ultra I/O Controller found @ 0x370
[    0.100585] pci 0000:00:06.0: vgaarb: setting as boot VGA device
[    0.100585] pci 0000:00:06.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.101562] pci 0000:00:06.0: vgaarb: bridge control possible
[    0.102539] vgaarb: loaded
[    0.104492] SCSI subsystem initialized
[    0.107421] clocksource: Switched to clocksource rpcc
[    0.132812] NET: Registered protocol family 2
[    0.135742] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 8192 bytes)
[    0.136718] TCP established hash table entries: 2048 (order: 1, 16384 bytes)
[    0.137695] TCP bind hash table entries: 2048 (order: 1, 16384 bytes)
[    0.138671] TCP: Hash tables configured (established 2048 bind 2048)
[    0.140624] UDP hash table entries: 256 (order: 0, 8192 bytes)
[    0.142578] UDP-Lite hash table entries: 256 (order: 0, 8192 bytes)
[    0.144531] NET: Registered protocol family 1
[    0.148437] srm_env: version 0.0.6 loaded successfully
[    0.149413] Using epoch 2000 for rtc year 18
[    0.152343] platform rtc-alpha: rtc core: registered rtc-alpha as rtc0
[    0.154296] workingset: timestamp_bits=55 max_order=15 bucket_order=0
[    0.188476] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.189453] io scheduler noop registered
[    0.191406] io scheduler cfq registered (default)
[    0.194335] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.196288] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.198242] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    0.249999] random: fast init done
[    0.352538] sym0: <875> rev 0x3 at pci 0000:00:05.0 irq 18
[    0.356445] Floppy drive(s): fd0 is 2.88M
[    0.445312] sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
[    0.446288] sym0: open drain IRQ line driver, using on-chip SRAM
[    0.447265] sym0: using LOAD/STORE-based firmware.
[    0.449218] sym0: SCSI BUS has been reset.
[    0.450195] scsi host0: sym-2.2.3
[    0.453124] Linux Tulip driver version 1.1.15-NAPI (Feb 27, 2007)
[    0.458984] tulip0: Old format EEPROM on 'Accton EN1207' board.  Using substitute media control info
[    0.459960] tulip0: EEPROM default media type Autosense
[    0.461913] tulip0: Index #0 - Media 10base2 (#1) described by a 21140 non-MII (0) block
[    0.462890] tulip0: Index #1 - Media 10baseT (#0) described by a 21140 non-MII (0) block
[    0.463866] tulip0: Index #2 - Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block
[    0.464843] tulip0: Index #3 - Media 100baseTx (#3) described by a 21140 non-MII (0) block
[    0.465820] tulip0: Index #4 - Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block
[    0.467773] net eth0: Digital DS21140 Tulip rev 34 at MMIO 0x2276000, 00:00:e8:3c:4e:c2, IRQ 19
[    0.474609] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.475585] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.479491] NET: Registered protocol family 10
[    0.483398] FDC 0 is a post-1991 82077
[    0.494140] Segment Routing with IPv6
[    0.495116] NET: Registered protocol family 17
[    0.496093] atkbd serio0: keyboard reset failed on isa0060/serio0
[    0.499023] platform rtc-alpha: setting system clock to 2018-11-23 09:35:28 UTC (1542965728)
[    0.554687] atkbd serio1: keyboard reset failed on isa0060/serio1
[    0.630859] atkbd serio0: keyboard reset failed on isa0060/serio0
[    0.696288] atkbd serio1: keyboard reset failed on isa0060/serio1
[    3.818357] scsi 0:0:0:0: Direct-Access     COMPAQ   BF0369A4BC       HPB7 PQ: 0 ANSI: 3
[    3.819333] scsi target0:0:0: tagged command queuing enabled, command queue depth 16.
[    3.820310] scsi target0:0:0: Beginning Domain Validation
[    3.827146] scsi target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
[    3.831052] scsi target0:0:0: Domain Validation skipping write tests
[    3.832029] scsi target0:0:0: Ending Domain Validation
[    3.833982] scsi 0:0:0:0: Power-on or device reset occurred
[    7.982417] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    7.983394] sd 0:0:0:0: [sda] 71132000 512-byte logical blocks: (36.4 GB/33.9 GiB)
[    7.985347] sd 0:0:0:0: [sda] Write Protect is off
[    7.987300] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[    7.999019]  sda: sda1 sda2 sda4
[    8.006831] sd 0:0:0:0: [sda] Attached SCSI disk
[    8.032222] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[    8.033199] VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
[    8.048824] devtmpfs: mounted
[    8.049800] Freeing unused kernel memory: 208K
[    8.050777] This architecture does not have kernel memory protection.
[    8.051753] Run /bin/sh as init process
[    8.366206] random: crng init done
sh: cannot set terminal process


> You can try applying the below patch to enable debug printouts from
> memblock, maybe it'll shed some more light.

Will try.

-- 
Meelis Roos <mroos@linux.ee>
