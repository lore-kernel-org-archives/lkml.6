Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74574C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6F7214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbfAJPy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:54:56 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:58531 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729132AbfAJPy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:54:56 -0500
To:     Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Meelis Roos <mroos@linux.ee>
Subject: bisected: ttyS panic on pa-risc
Message-ID: <af9136a8-ae68-5e69-1c1a-001221bb3958@linux.ee>
Date:   Thu, 10 Jan 2019 17:54:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My HP 9000 A500 (pa-risc architecture) paniced in 5.0-rc1. It happened after printing dmesg lines about ttyS and before moving on to scsi printk-s.
I bisected it and the panic symptoms changed during that (some had backtrace, some had just panic).

This is one of the crashes I got:
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial 0000:00:04.0: enabling device (0146 -> 0147)
printk: console [ttyS0] disabled

0000:00:04.0: ttyS0 at MMIO 0xfffffffff8000000 (irq = 21, base_baud = 115200) is a 16550A
printk: console [ttyS0] enabled
printk: console [ttyS0] enabled
printk: bootconsole [ttyB0] disabled
printk: bootconsole [ttyB0] disabled
0000:00:04.0: ttyS1 at MMIO 0xfffffffff8000008 (irq = 21, base_baud = 115200) is a 16550A
0000:00:04.0: ttyS2 at MMIO 0xfffffffff8000010 (irq = 21, base_baud = 115200) is a 16550A
serial 0000:00:05.0: enabling device (0140 -> 0143)
0000:00:05.0: ttyS3 at MMIO 0xfffffffff8005000 (irq = 22, base_baud = 115200) is a 16550A
Backtrace:
  [<0000000040502268>] pciserial_init_ports+0x128/0x240
  [<00000000405040b8>] pciserial_init_one+0x1e0/0x2f0
  [<00000000404b2b8c>] pci_device_probe+0xfc/0x180
  [<0000000040513958>] really_probe+0x268/0x3d0
  [<0000000040513d28>] driver_probe_device+0xf8/0x100
  [<0000000040513e54>] __driver_attach+0x124/0x130
  [<0000000040510dc4>] bus_for_each_dev+0x9c/0xe8
  [<0000000040513040>] driver_attach+0x28/0x38
  [<00000000405128c0>] bus_a

Normal dmesg excerpt from working kernel before the problem:

[    6.746131] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    6.771772] serial 0000:00:04.0: enabling device (0146 -> 0147)
[    6.792657] printk: console [ttyS0] disabled
[    6.829825] 0000:00:04.0: ttyS0 at MMIO 0xfffffffff8000000 (irq = 21, base_baud = 115200) is a 16550A
[    6.837151] printk: console [ttyS0] enabled
[    6.877768] printk: bootconsole [ttyB0] disabled
[    6.904352] 0000:00:04.0: ttyS1 at MMIO 0xfffffffff8000008 (irq = 21, base_baud = 115200) is a 16550A
[    6.961051] 0000:00:04.0: ttyS2 at MMIO 0xfffffffff8000010 (irq = 21, base_baud = 115200) is a 16550A
[    6.969881] serial 0000:00:05.0: enabling device (0000 -> 0003)
[    7.004160] serial 0000:00:05.0: enabling SERR and PARITY (0003 -> 0143)
[    7.030298] 0000:00:05.0: ttyS3 at MMIO 0xfffffffff8005000 (irq = 22, base_baud = 115200) is a 16550A
[    7.041663] serial 0000:00:05.0: Couldn't register serial port 0, irq 22, type 2, error -28
[    7.145456] sym53c8xx 0000:00:01.0: enabling device (0000 -> 0003)


Bisection leads to this commit:

6d7f677a2afa1c82d7fc7af7f9159cbffd5dc010 is the first bad commit
commit 6d7f677a2afa1c82d7fc7af7f9159cbffd5dc010
Author: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
Date:   Mon Dec 10 11:29:09 2018 +1300

     serial: 8250: Rate limit serial port rx interrupts during input overruns

     When a serial port gets faulty or gets flooded with inputs, its interrupt
     handler starts to work double time to get the characters to the workqueue
     for the tty layer to handle them. When this busy time on the serial/tty
     subsystem happens during boot, where it is also busy on the userspace
     trying to initialise, some processes can continuously get preempted
     and will be on hold until the interrupts subside.

     The fix is to backoff on processing received characters for a specified
     amount of time when an input overrun is seen (received a new character
     before the previous one is processed). This only stops receive and will
     continue to transmit characters to serial port. After the backoff period
     is done, it receive will be re-enabled. This is optional and will only
     be enabled by setting 'overrun-throttle-ms' in the dts.

     Signed-off-by: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

:040000 040000 4ea6cd68ededa0c9ffaa218668ffeb35557070a5 a011db1916fbf5cfdcfff836a81e4fb5ee737003 M      drivers
:040000 040000 b1b1dc977965eb2db6b2cc79939446a1cf2f684d 41322ab1c199f504cfcc5b2ca211b4638d41351c M      include


-- 
Meelis Roos <mroos@linux.ee>
