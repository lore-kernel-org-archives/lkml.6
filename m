Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90CCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4BD20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547814209;
	bh=vpMtqQTrQFgoVpfb0tpJ2Y9BBUX93b+3jkUKuw4MrSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gwvc5C6LUK1xUYwiiJgorM1pUWP54PxFkyswKWt86W7N5yC1CE+E5X+FP1G2JzD1U
	 Yh3+cIOthRc+mHmdg+M9FH2rSS0ABtUoI34VL3KqSqWu9JkWbOfk6dMvsR0FmUHWkz
	 uSi4/5Hxh4Xa54dElp8XQYPpKw2AQdLlV3f6G2QQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfARMX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:23:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbfARMX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:23:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D78B420652;
        Fri, 18 Jan 2019 12:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547814205;
        bh=vpMtqQTrQFgoVpfb0tpJ2Y9BBUX93b+3jkUKuw4MrSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KapLsCZYG4IJBDyQJTj8Bxdy8aSIprbFsJ3Z/W5Es5hSVtVh/oOS57xgc+Yd8ASya
         BpBgH/RhlBc5YRVGhdrjfdbiqKzaQ0Rpq7ryd2woFnjwexbPJKgoCGYX/LYPS1GenU
         U2t8KaBR9BKel5TcbzSEbPe/JZ/H7v/SBQf1rQ3M=
Date:   Fri, 18 Jan 2019 13:23:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Meelis Roos <mroos@linux.ee>
Cc:     Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-parisc <linux-parisc@vger.kernel.org>
Subject: Re: bisected: ttyS panic on pa-risc
Message-ID: <20190118122323.GA11909@kroah.com>
References: <af9136a8-ae68-5e69-1c1a-001221bb3958@linux.ee>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <af9136a8-ae68-5e69-1c1a-001221bb3958@linux.ee>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2019 at 05:54:50PM +0200, Meelis Roos wrote:
> My HP 9000 A500 (pa-risc architecture) paniced in 5.0-rc1. It happened after printing dmesg lines about ttyS and before moving on to scsi printk-s.
> I bisected it and the panic symptoms changed during that (some had backtrace, some had just panic).
> 
> This is one of the crashes I got:
> Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> serial 0000:00:04.0: enabling device (0146 -> 0147)
> printk: console [ttyS0] disabled
> 
> 0000:00:04.0: ttyS0 at MMIO 0xfffffffff8000000 (irq = 21, base_baud = 115200) is a 16550A
> printk: console [ttyS0] enabled
> printk: console [ttyS0] enabled
> printk: bootconsole [ttyB0] disabled
> printk: bootconsole [ttyB0] disabled
> 0000:00:04.0: ttyS1 at MMIO 0xfffffffff8000008 (irq = 21, base_baud = 115200) is a 16550A
> 0000:00:04.0: ttyS2 at MMIO 0xfffffffff8000010 (irq = 21, base_baud = 115200) is a 16550A
> serial 0000:00:05.0: enabling device (0140 -> 0143)
> 0000:00:05.0: ttyS3 at MMIO 0xfffffffff8005000 (irq = 22, base_baud = 115200) is a 16550A
> Backtrace:
>  [<0000000040502268>] pciserial_init_ports+0x128/0x240
>  [<00000000405040b8>] pciserial_init_one+0x1e0/0x2f0
>  [<00000000404b2b8c>] pci_device_probe+0xfc/0x180
>  [<0000000040513958>] really_probe+0x268/0x3d0
>  [<0000000040513d28>] driver_probe_device+0xf8/0x100
>  [<0000000040513e54>] __driver_attach+0x124/0x130
>  [<0000000040510dc4>] bus_for_each_dev+0x9c/0xe8
>  [<0000000040513040>] driver_attach+0x28/0x38
>  [<00000000405128c0>] bus_a
> 
> Normal dmesg excerpt from working kernel before the problem:
> 
> [    6.746131] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    6.771772] serial 0000:00:04.0: enabling device (0146 -> 0147)
> [    6.792657] printk: console [ttyS0] disabled
> [    6.829825] 0000:00:04.0: ttyS0 at MMIO 0xfffffffff8000000 (irq = 21, base_baud = 115200) is a 16550A
> [    6.837151] printk: console [ttyS0] enabled
> [    6.877768] printk: bootconsole [ttyB0] disabled
> [    6.904352] 0000:00:04.0: ttyS1 at MMIO 0xfffffffff8000008 (irq = 21, base_baud = 115200) is a 16550A
> [    6.961051] 0000:00:04.0: ttyS2 at MMIO 0xfffffffff8000010 (irq = 21, base_baud = 115200) is a 16550A
> [    6.969881] serial 0000:00:05.0: enabling device (0000 -> 0003)
> [    7.004160] serial 0000:00:05.0: enabling SERR and PARITY (0003 -> 0143)
> [    7.030298] 0000:00:05.0: ttyS3 at MMIO 0xfffffffff8005000 (irq = 22, base_baud = 115200) is a 16550A
> [    7.041663] serial 0000:00:05.0: Couldn't register serial port 0, irq 22, type 2, error -28
> [    7.145456] sym53c8xx 0000:00:01.0: enabling device (0000 -> 0003)
> 
> 
> Bisection leads to this commit:
> 
> 6d7f677a2afa1c82d7fc7af7f9159cbffd5dc010 is the first bad commit
> commit 6d7f677a2afa1c82d7fc7af7f9159cbffd5dc010
> Author: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
> Date:   Mon Dec 10 11:29:09 2018 +1300
> 
>     serial: 8250: Rate limit serial port rx interrupts during input overruns
> 
>     When a serial port gets faulty or gets flooded with inputs, its interrupt
>     handler starts to work double time to get the characters to the workqueue
>     for the tty layer to handle them. When this busy time on the serial/tty
>     subsystem happens during boot, where it is also busy on the userspace
>     trying to initialise, some processes can continuously get preempted
>     and will be on hold until the interrupts subside.
> 
>     The fix is to backoff on processing received characters for a specified
>     amount of time when an input overrun is seen (received a new character
>     before the previous one is processed). This only stops receive and will
>     continue to transmit characters to serial port. After the backoff period
>     is done, it receive will be re-enabled. This is optional and will only
>     be enabled by setting 'overrun-throttle-ms' in the dts.
> 
>     Signed-off-by: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> :040000 040000 4ea6cd68ededa0c9ffaa218668ffeb35557070a5 a011db1916fbf5cfdcfff836a81e4fb5ee737003 M      drivers
> :040000 040000 b1b1dc977965eb2db6b2cc79939446a1cf2f684d 41322ab1c199f504cfcc5b2ca211b4638d41351c M      include

The patch below was just applied to my tree, hopefully ti fixes this
issue.

thanks,

greg k-h

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0002-serial-8250-Fix-serial8250-initialization-crash.patch"

From 352c4cf40c4a7d439fa5d30aa2160f54b394da82 Mon Sep 17 00:00:00 2001
From: He Zhe <zhe.he@windriver.com>
Date: Thu, 17 Jan 2019 17:00:19 +0800
Subject: serial: 8250: Fix serial8250 initialization crash

The initialization code of interrupt backoff work might reference NULL
pointer and cause the following crash, if no port was found.

[   10.017727] CPU 0 Unable to handle kernel paging request at virtual address 000001b0, epc == 807088e0, ra == 8070863c
---- snip ----
[   11.704470] [<807088e0>] serial8250_register_8250_port+0x318/0x4ac
[   11.747251] [<80708d74>] serial8250_probe+0x148/0x1c0
[   11.789301] [<80728450>] platform_drv_probe+0x40/0x94
[   11.830515] [<807264f8>] really_probe+0xf8/0x318
[   11.870876] [<80726b7c>] __driver_attach+0x110/0x12c
[   11.910960] [<80724374>] bus_for_each_dev+0x78/0xcc
[   11.951134] [<80725958>] bus_add_driver+0x200/0x234
[   11.989756] [<807273d8>] driver_register+0x84/0x148
[   12.029832] [<80d72f84>] serial8250_init+0x138/0x198
[   12.070447] [<80100e6c>] do_one_initcall+0x5c/0x2a0
[   12.110104] [<80d3a208>] kernel_init_freeable+0x370/0x484
[   12.150722] [<80a49420>] kernel_init+0x10/0xf8
[   12.191517] [<8010756c>] ret_from_kernel_thread+0x14/0x1c

This patch makes sure the initialization code can be reached only if a port
is found.

Fixes: 6d7f677a2afa ("serial: 8250: Rate limit serial port rx interrupts during input overruns")
Signed-off-by: He Zhe <zhe.he@windriver.com>
Reviewed-by: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 189ab1212d9a..e441221e04b9 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1070,15 +1070,16 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 
 			ret = 0;
 		}
-	}
 
-	/* Initialise interrupt backoff work if required */
-	if (up->overrun_backoff_time_ms > 0) {
-		uart->overrun_backoff_time_ms = up->overrun_backoff_time_ms;
-		INIT_DELAYED_WORK(&uart->overrun_backoff,
-				  serial_8250_overrun_backoff_work);
-	} else {
-		uart->overrun_backoff_time_ms = 0;
+		/* Initialise interrupt backoff work if required */
+		if (up->overrun_backoff_time_ms > 0) {
+			uart->overrun_backoff_time_ms =
+				up->overrun_backoff_time_ms;
+			INIT_DELAYED_WORK(&uart->overrun_backoff,
+					serial_8250_overrun_backoff_work);
+		} else {
+			uart->overrun_backoff_time_ms = 0;
+		}
 	}
 
 	mutex_unlock(&serial_mutex);
-- 
2.20.1


--Nq2Wo0NMKNjxTN9z--
