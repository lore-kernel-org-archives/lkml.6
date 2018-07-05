Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213E7C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDEA23F4B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="u6oXUR/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDEA23F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbeGEO3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:29:48 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:40078 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753353AbeGEO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:29:46 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 7CF625C0744;
        Thu,  5 Jul 2018 16:29:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530800985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HeefCNDPa+MUQbzYJKDSCief4qAZY8xwLJCebEcAJBc=;
        b=u6oXUR/5azrzSN9y4X2jGADlnd2sDY7Vv5/bD0prlkre5EGSF6CIsh4UuIyLXEvp3+v84D
        e/4QzLvvV5ZkLZNNFtYEo4CTnV27+W/Z5yKw1iwzJSf76cE51nMhZImexHZ0qoqYjwhEsG
        Hp/+yfUq+49HHsh5Anymnh5mqDo3o7A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Jul 2018 16:29:45 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Vinod <vkoul@kernel.org>, Angelo Dureghello <angelo@sysam.it>
Cc:     dmaengine@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] Serial/dma stall/failure after "dmaengine: fsl-edma:
 extract common fsl-edma code (no changes in behavior intended)"
In-Reply-To: <20180705124526.GA3620@jerusalem>
References: <CAJKOXPcVFrkEA4YV3gi-gPYhtTXHeKtv4CvL29gstfTacz2sMg@mail.gmail.com>
 <20180705073552.GI22377@vkoul-mobl> <20180705081253.GA3513@jerusalem>
 <20180705124526.GA3620@jerusalem>
Message-ID: <61369179096430c875b71ef1f09b094c@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-0.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[44.48%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.2018 14:45, Angelo Dureghello wrote:
> Hi Vinod,
> 
> On Thu, Jul 05, 2018 at 10:12:53AM +0200, Angelo Dureghello wrote:
>> Hi Vinod,
>>
>> On Thu, Jul 05, 2018 at 01:05:52PM +0530, Vinod wrote:
>> > On 04-07-18, 10:54, Krzysztof Kozlowski wrote:
>> > > Hi,
>> > >
>> > > The commit 6ad069123f03bebe4315dea13d44845854ca6043 ("dmaengine:
>> > > fsl-edma: extract common fsl-edma code (no changes in behavior
>> > > intended)"), even though marked as no changes in behavior intended...
>> > > make serial console with DMA broken after boot. The console just hangs
>> > > - is not responsive even to SysRq. Usually after finishing boot -
>> > > before or after login prompt. Sometimes login is allowed and then it
>> > > hangs during printing dmesg.
>> > >
>> > > Board: Toradex Colibri VF50 (NXP VF500, Cortex A5, serial configured
>> > > with DMA) on Iris Carrier.
>> >
>> > Angelo ?
>> >
>> sorry for this. As said i couldn't test it in any of those arm boards
>> but i take a look.
>>
>> The only code part that changes is the initial setting up of the registers.
>> I am checking that.
>>
>> Regards,
>> Angelo
>>
> 
> I cannot find anything obviously wrong.
> And i cannot test on Vybrid.
> I will try to get a Vybrid V50 board to test this issue. It would
> require some days and also i wil be 3 weeks off on July.
> 
> So please revert my patch.

Vinod, before reverting, let me quickly look into it.

--
Stefan

> 
> Regards,
> Angelo
> 
>> > >
>> > > Commit found with bisect:
>> > > git bisect start
>> > > # bad: [bce40927669338cc4a361fc97d46bf650573ce5c] Add linux-next
>> > > specific files for 20180704
>> > > git bisect bad bce40927669338cc4a361fc97d46bf650573ce5c
>> > > # good: [410da1e12ffed61129d61df5b7adce4d08c7f17c] net/smc: fix up
>> > > merge error with poll changes
>> > > git bisect good 410da1e12ffed61129d61df5b7adce4d08c7f17c
>> > > # good: [decd57900d6fd743f7ddc1329400f4bd9cf54284] Merge
>> > > remote-tracking branch 'crypto/master'
>> > > git bisect good decd57900d6fd743f7ddc1329400f4bd9cf54284
>> > > # good: [e9484bb660753ca8a35d219db000fff967b70a2c] Merge
>> > > remote-tracking branch 'tip/auto-latest'
>> > > git bisect good e9484bb660753ca8a35d219db000fff967b70a2c
>> > > # bad: [20adee487b5f252d3f38197d43487c004273d3d0] Merge
>> > > remote-tracking branch 'slave-dma/next'
>> > > git bisect bad 20adee487b5f252d3f38197d43487c004273d3d0
>> > > # good: [2df2577dce1d5fd98cac342fe857677a0556421b] Merge
>> > > remote-tracking branch 'tty/tty-next'
>> > > git bisect good 2df2577dce1d5fd98cac342fe857677a0556421b
>> > > # good: [03b17ed8410a61f4f337c7bcfded1f744182edd5] spi: spi-fsl-dspi:
>> > > Fix imprecise abort on VF500 during probe
>> > > git bisect good 03b17ed8410a61f4f337c7bcfded1f744182edd5
>> > > # good: [85e1d42663a0c163002961d2685be952067b0dc2] staging:
>> > > mt7621-eth: Fix memory leak in mtk_add_mac() error path
>> > > git bisect good 85e1d42663a0c163002961d2685be952067b0dc2
>> > > # good: [b244f917acb7e1f492c40f6f4cf7be860a5065a5] staging: rtl8188eu:
>> > > remove blank lines
>> > > git bisect good b244f917acb7e1f492c40f6f4cf7be860a5065a5
>> > > # good: [b244f917acb7e1f492c40f6f4cf7be860a5065a5] staging: rtl8188eu:
>> > > remove blank lines
>> > > git bisect good b244f917acb7e1f492c40f6f4cf7be860a5065a5
>> > > # good: [b244f917acb7e1f492c40f6f4cf7be860a5065a5] staging: rtl8188eu:
>> > > remove blank lines
>> > > git bisect good b244f917acb7e1f492c40f6f4cf7be860a5065a5
>> > > # good: [6c796f514b7f8d0fef4733b971a5ded9e9a74490] Merge
>> > > remote-tracking branch 'staging/staging-next'
>> > > git bisect good 6c796f514b7f8d0fef4733b971a5ded9e9a74490
>> > > # good: [14dfa379ffd3ffd73729a72c289e9db6780a60ab] Merge branch
>> > > 'topic/ste' into next
>> > > git bisect good 14dfa379ffd3ffd73729a72c289e9db6780a60ab
>> > > # good: [c1199875d327a9b3bbb3fb1cca0d467d3e625fbb] dmaengine:
>> > > imx-sdma: Use GFP_NOWAIT for dma allocations
>> > > git bisect good c1199875d327a9b3bbb3fb1cca0d467d3e625fbb
>> > > # bad: [15efb0b488596a929bc00ce23aeb746ee6a7c14d] dmaengine: fsl-edma:
>> > > fix trailing whitespace
>> > > git bisect bad 15efb0b488596a929bc00ce23aeb746ee6a7c14d
>> > > # bad: [5c1355ad87a2c138049bfafa753b44046492aebc] dmaengine: fsl-edma:
>> > > add ColdFire mcf5441x edma support
>> > > git bisect bad 5c1355ad87a2c138049bfafa753b44046492aebc
>> > > # bad: [6ad069123f03bebe4315dea13d44845854ca6043] dmaengine: fsl-edma:
>> > > extract common fsl-edma code (no changes in behavior intended)
>> > > git bisect bad 6ad069123f03bebe4315dea13d44845854ca6043
>> > > # first bad commit: [6ad069123f03bebe4315dea13d44845854ca6043]
>> > > dmaengine: fsl-edma: extract common fsl-edma code (no changes in
>> > > behavior intended)
>> > >
>> > > Defconfig and boot log attached. I could not find any obvious error in boot log.
>> > >
>> > > Let me know if you need more data.
>> > >
>> > > Best regards,
>> > > Krzysztof
>> >
>> >
>> > > [    0.000000] Memory policy: Data cache writeback
>> > > [    0.000000] cma: Reserved 16 MiB at 0x87000000
>> > > [    0.000000] CPU: All CPU(s) started in SVC mode.
>> > > [    0.000000] random: get_random_bytes called from start_kernel+0xa0/0x3fc with crng_init=0
>> > > [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 32512
>> > > [    0.000000] Kernel command line: ip=:::::eth0: root=/dev/nfs console=tty1 console=ttyLP0,115200n8 consoleblank=0
>> > > [    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
>> > > [    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
>> > > [    0.000000] Memory: 103836K/131072K available (6144K kernel code, 192K rwdata, 1604K rodata, 1024K init, 142K bss, 10852K reserved, 16384K cma-reserved)
>> > > [    0.000000] Virtual kernel memory layout:
>> > > [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>> > > [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>> > > [    0.000000]     vmalloc : 0x88800000 - 0xff800000   (1904 MB)
>> > > [    0.000000]     lowmem  : 0x80000000 - 0x88000000   ( 128 MB)
>> > > [    0.000000]     modules : 0x7f000000 - 0x80000000   (  16 MB)
>> > > [    0.000000]       .text : 0x(ptrval) - 0x(ptrval)   (7136 kB)
>> > > [    0.000000]       .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
>> > > [    0.000000]       .data : 0x(ptrval) - 0x(ptrval)   ( 193 kB)
>> > > [    0.000000]        .bss : 0x(ptrval) - 0x(ptrval)   ( 143 kB)
>> > > [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
>> > > [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
>> > > [    0.000058] sched_clock: 64 bits at 132MHz, resolution 7ns, wraps every 2199023255551ns
>> > > [    0.000133] clocksource: arm_global_timer: mask: 0xffffffffffffffff max_cycles: 0x1e7178659b, max_idle_ns: 440795204301 ns
>> > > [    0.000232] Switching to timer-based delay loop, resolution 7ns
>> > > [    0.001506] Console: colour dummy device 80x30
>> > > [    0.002451] console [tty1] enabled
>> > > [    0.002550] Calibrating delay loop (skipped), value calculated using timer frequency.. 264.00 BogoMIPS (lpj=1320000)
>> > > [    0.002649] pid_max: default: 32768 minimum: 301
>> > > [    0.003151] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
>> > > [    0.003263] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
>> > > [    0.005190] CPU: Testing write buffer coherency: ok
>> > > [    0.007551] Setting up static identity map for 0x80100000 - 0x80100060
>> > > [    0.010355] devtmpfs: initialized
>> > > [    0.027419] VFP support v0.3: implementor 41 architecture 2 part 30 variant 5 rev 1
>> > > [    0.028335] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
>> > > [    0.028470] futex hash table entries: 256 (order: -1, 3072 bytes)
>> > > [    0.031116] pinctrl core: initialized pinctrl subsystem
>> > > [    0.034483] NET: Registered protocol family 16
>> > > [    0.038696] DMA: preallocated 256 KiB pool for atomic coherent allocations
>> > > [    0.042265] cpuidle: using governor menu
>> > > [    0.042687] hw-breakpoint: found 2 (+1 reserved) breakpoint and 1 watchpoint registers.
>> > > [    0.042783] hw-breakpoint: maximum watchpoint size is 4 bytes.
>> > > [    0.055428] vf610-pinctrl 40048000.iomuxc: initialized IMX pinctrl driver
>> > > [    0.125877] +V3.3: supplied by 3.3V
>> > > [    0.128267] SCSI subsystem initialized
>> > > [    0.129203] usbcore: registered new interface driver usbfs
>> > > [    0.129526] usbcore: registered new interface driver hub
>> > > [    0.129925] usbcore: registered new device driver usb
>> > > [    0.132755] i2c i2c-0: IMX I2C adapter registered
>> > > [    0.133005] i2c i2c-0: using dma0chan0 (tx) and dma0chan1 (rx) for DMA transfers
>> > > [    0.133778] pps_core: LinuxPPS API ver. 1 registered
>> > > [    0.133856] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
>> > > [    0.134029] PTP clock support registered
>> > > [    0.138089] clocksource: Switched to clocksource arm_global_timer
>> > > [    0.178733] NET: Registered protocol family 2
>> > > [    0.180526] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes)
>> > > [    0.180694] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
>> > > [    0.180788] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
>> > > [    0.180869] TCP: Hash tables configured (established 1024 bind 1024)
>> > > [    0.181366] UDP hash table entries: 256 (order: 0, 4096 bytes)
>> > > [    0.181484] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
>> > > [    0.182137] NET: Registered protocol family 1
>> > > [    0.183893] RPC: Registered named UNIX socket transport module.
>> > > [    0.183996] RPC: Registered udp transport module.
>> > > [    0.184043] RPC: Registered tcp transport module.
>> > > [    0.184085] RPC: Registered tcp NFSv4.1 backchannel transport module.
>> > > [    0.186339] hw perfevents: enabled with armv7_cortex_a5 PMU driver, 3 counters available
>> > > [    0.190606] Initialise system trusted keyrings
>> > > [    0.191215] workingset: timestamp_bits=30 max_order=15 bucket_order=0
>> > > [    0.211916] NFS: Registering the id_resolver key type
>> > > [    0.212112] Key type id_resolver registered
>> > > [    0.212167] Key type id_legacy registered
>> > > [    0.212344] ntfs: driver 2.1.32 [Flags: R/W].
>> > > [    0.214186] fuse init (API version 7.27)
>> > > [    0.228202] Key type asymmetric registered
>> > > [    0.228304] Asymmetric key parser 'x509' registered
>> > > [    0.228413] io scheduler noop registered
>> > > [    0.229036] io scheduler cfq registered (default)
>> > > [    0.229121] io scheduler mq-deadline registered
>> > > [    0.229171] io scheduler kyber registered
>> > > [    0.244133] 40027000.serial: ttyLP0 at MMIO 0x40027000 (irq = 19, base_baud = 4125000) is a FSL_LPUART
>> > > [    0.769644] console [ttyLP0] enabled
>> > > [    0.775130] 40028000.serial: ttyLP1 at MMIO 0x40028000 (irq = 20, base_baud = 4125000) is a FSL_LPUART
>> > > [    0.786693] 40029000.serial: ttyLP2 at MMIO 0x40029000 (irq = 21, base_baud = 4125000) is a FSL_LPUART
>> > > [    0.802286] brd: module loaded
>> > > [    0.830071] loop: module loaded
>> > > [    0.836930] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xf1
>> > > [    0.843499] nand: Macronix NAND 128MiB 3,3V 8-bit
>> > > [    0.848347] nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
>> > > [    0.856436] Bad block table found at page 65472, version 0x01
>> > > [    0.862594] Bad block table found at page 65408, version 0x01
>> > > [    0.868726] nand_read_bbt: bad block at 0x0000013c0000
>> > > [    0.874135] 6 fixed-partitions partitions found on MTD device vf610_nfc
>> > > [    0.880908] Creating 6 MTD partitions on "vf610_nfc":
>> > > [    0.886046] 0x000000000000-0x000000020000 : "vf-bcb"
>> > > [    0.892637] 0x000000020000-0x000000180000 : "u-boot"
>> > > [    0.899247] 0x000000180000-0x0000001c0000 : "u-boot-env"
>> > > [    0.905999] 0x0000001c0000-0x000004080000 : "ubi1"
>> > > [    0.913304] 0x000004080000-0x000007f40000 : "ubi2"
>> > > [    0.920544] 0x000007f40000-0x000007f80000 : "reserved"
>> > > [    0.932515] libphy: Fixed MDIO Bus: probed
>> > > [    0.951887] libphy: fec_enet_mii_bus: probed
>> > > [    0.958566] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>> > > [    0.965935] usbcore: registered new interface driver usb-storage
>> > > [    0.972581] usbcore: registered new interface driver usbserial_generic
>> > > [    0.979465] usbserial: USB Serial support registered for generic
>> > > [    0.985705] usbcore: registered new interface driver ftdi_sio
>> > > [    0.991776] usbserial: USB Serial support registered for FTDI USB Serial Device
>> > > [    0.999432] usbcore: registered new interface driver pl2303
>> > > [    1.005220] usbserial: USB Serial support registered for pl2303
>> > > [    1.024975] snvs_rtc 400a7000.snvs:snvs-rtc-lp: rtc core: registered 400a7000.snvs:snvs-rtc-lp as rtc0
>> > > [    1.034957] i2c /dev entries driver
>> > > [    1.043842] imx2-wdt 4003e000.wdog: timeout 60 sec (nowayout=0)
>> > > [    1.051554] sdhci: Secure Digital Host Controller Interface driver
>> > > [    1.057817] sdhci: Copyright(c) Pierre Ossman
>> > > [    1.062382] sdhci-pltfm: SDHCI platform and OF driver helper
>> > > [    1.069803] sdhci-esdhc-imx 400b2000.esdhc: Got CD GPIO
>> > > [    1.104211] mmc0: SDHCI controller on 400b2000.esdhc [400b2000.esdhc] using ADMA
>> > > [    1.128652] NET: Registered protocol family 17
>> > > [    1.133569] Key type dns_resolver registered
>> > > [    1.138440] Registering SWP/SWPB emulation handler
>> > > [    1.145779] registered taskstats version 1
>> > > [    1.150109] Loading compiled-in X.509 certificates
>> > > [    1.159775] VCC_USB[1-4]: supplied by 5V
>> > > [    1.169813] ci_hdrc ci_hdrc.1: EHCI Host Controller
>> > > [    1.175111] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 1
>> > > [    1.208308] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
>> > > [    1.216835] hub 1-0:1.0: USB hub found
>> > > [    1.220977] hub 1-0:1.0: 1 port detected
>> > > [    1.230260] snvs_rtc 400a7000.snvs:snvs-rtc-lp: setting system clock to 1970-01-01 00:00:00 UTC (0)
>> > > [    1.338443] Micrel KSZ8041 400d1000.ethernet-1:00: attached PHY driver [Micrel KSZ8041] (mii_bus:phy_addr=400d1000.ethernet-1:00, irq=POLL)
>> > > [    1.368009] mmc0: new high speed SDHC card at address aaaa
>> > > [    1.377866] mmcblk0: mmc0:aaaa SL16G 14.8 GiB
>> > > [    1.390488]  mmcblk0: p1 p2
>> > > [    1.748191] usb 1-1: new high-speed USB device number 2 using ci_hdrc
>> > > [    3.449105] fec 400d1000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
>> > > [    3.508218] Sending DHCP requests ., OK
>> > > [    3.572142] IP-Config: Got DHCP answer from 192.168.10.1, my address is 192.168.10.17
>> > > [    3.580129] IP-Config: Complete:
>> > > [    3.583423]      device=eth0, hwaddr=00:14:2d:2c:a1:2e, ipaddr=192.168.10.17, mask=255.255.255.0, gw=192.168.10.1
>> > > [    3.593813]      host=192.168.10.17, domain=, nis-domain=(none)
>> > > [    3.599833]      bootserver=192.168.10.1, rootserver=192.168.10.1, rootpath=/srv/nfs/colibri_vf,v4,tcp
>> > > [    3.599854]      nameserver0=192.168.10.1
>> > > [    3.676511] VFS: Mounted root (nfs4 filesystem) on device 0:13.
>> > > [    3.684257] devtmpfs: mounted
>> > > [    3.693865] Freeing unused kernel memory: 1024K
>> > > [    3.700956] random: fast init done
>> > > [    4.950401] systemd[1]: System time before build time, advancing clock.
>> > > [    5.136393] random: systemd: uninitialized urandom read (16 bytes read)
>> > > [    5.186057] systemd[1]: systemd 232 running in system mode. (-PAM -AUDIT -SELINUX -IMA -APPARMOR -SMACK +SYSVINIT +UTMP -LIBCRYPTSETUP -GCRYPT -GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID -ELFUTILS +KMOD -IDN)
>> > > [    5.206664] systemd[1]: Detected architecture arm.
>> > >
>> >
>> >
>> > --
>> > ~Vinod
>> --
>> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
