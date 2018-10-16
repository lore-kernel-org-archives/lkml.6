Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75193C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CED520866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMF4QNud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CED520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeJPMB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728643AbeJPMB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6C3A21470;
        Tue, 16 Oct 2018 04:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663214;
        bh=Uzfu1a7X+39a2EhuTuVTd4zO37Lp3mIK3H0Ca3+MJ30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uMF4QNudmuSJT9Du91ZCM+eKF4be12moaUGJVB4ZndL04KWACqAfZvR+1OBl0UcQP
         0g88jkQJ8+02bH6yNH0P6Z5y0ck0B1HrgVmx4Cg2gczEvzUIvbMRKtAswAT7v+mBa9
         vvNbCq2h2OvSsV/WXeE5scJ3yyGNA9bMDvm8V+OI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 076/100] Revert "serial: 8250_dw: Fix runtime PM handling"
Date:   Tue, 16 Oct 2018 00:11:57 -0400
Message-Id: <20181016041221.135528-76-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit beeeac43b6fae5f5eaf707b6fcc2bf1e09deb785 ]

This reverts commit d76c74387e1c978b6c5524a146ab0f3f72206f98.

While commit d76c74387e1c ("serial: 8250_dw: Fix runtime PM handling")
fixes runtime PM handling when using kgdb, it introduces a traceback for
everyone else.

BUG: sleeping function called from invalid context at
	/mnt/host/source/src/third_party/kernel/next/drivers/base/power/runtime.c:1034
in_atomic(): 1, irqs_disabled(): 1, pid: 1, name: swapper/0
7 locks held by swapper/0/1:
 #0: 000000005ec5bc72 (&dev->mutex){....}, at: __driver_attach+0xb5/0x12b
 #1: 000000005d5fa9e5 (&dev->mutex){....}, at: __device_attach+0x3e/0x15b
 #2: 0000000047e93286 (serial_mutex){+.+.}, at: serial8250_register_8250_port+0x51/0x8bb
 #3: 000000003b328f07 (port_mutex){+.+.}, at: uart_add_one_port+0xab/0x8b0
 #4: 00000000fa313d4d (&port->mutex){+.+.}, at: uart_add_one_port+0xcc/0x8b0
 #5: 00000000090983ca (console_lock){+.+.}, at: vprintk_emit+0xdb/0x217
 #6: 00000000c743e583 (console_owner){-...}, at: console_unlock+0x211/0x60f
irq event stamp: 735222
__down_trylock_console_sem+0x4a/0x84
console_unlock+0x338/0x60f
__do_softirq+0x4a4/0x50d
irq_exit+0x64/0xe2
CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc5 #6
Hardware name: Google Caroline/Caroline, BIOS Google_Caroline.7820.286.0 03/15/2017
Call Trace:
 dump_stack+0x7d/0xbd
 ___might_sleep+0x238/0x259
 __pm_runtime_resume+0x4e/0xa4
 ? serial8250_rpm_get+0x2e/0x44
 serial8250_console_write+0x44/0x301
 ? lock_acquire+0x1b8/0x1fa
 console_unlock+0x577/0x60f
 vprintk_emit+0x1f0/0x217
 printk+0x52/0x6e
 register_console+0x43b/0x524
 uart_add_one_port+0x672/0x8b0
 ? set_io_from_upio+0x150/0x162
 serial8250_register_8250_port+0x825/0x8bb
 dw8250_probe+0x80c/0x8b0
 ? dw8250_serial_inq+0x8e/0x8e
 ? dw8250_check_lcr+0x108/0x108
 ? dw8250_runtime_resume+0x5b/0x5b
 ? dw8250_serial_outq+0xa1/0xa1
 ? dw8250_remove+0x115/0x115
 platform_drv_probe+0x76/0xc5
 really_probe+0x1f1/0x3ee
 ? driver_allows_async_probing+0x5d/0x5d
 driver_probe_device+0xd6/0x112
 ? driver_allows_async_probing+0x5d/0x5d
 bus_for_each_drv+0xbe/0xe5
 __device_attach+0xdd/0x15b
 bus_probe_device+0x5a/0x10b
 device_add+0x501/0x894
 ? _raw_write_unlock+0x27/0x3a
 platform_device_add+0x224/0x2b7
 mfd_add_device+0x718/0x75b
 ? __kmalloc+0x144/0x16a
 ? mfd_add_devices+0x38/0xdb
 mfd_add_devices+0x9b/0xdb
 intel_lpss_probe+0x7d4/0x8ee
 intel_lpss_pci_probe+0xac/0xd4
 pci_device_probe+0x101/0x18e
...

Revert the offending patch until a more comprehensive solution
is available.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Fixes: d76c74387e1c ("serial: 8250_dw: Fix runtime PM handling")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_dw.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index af842000188c..a25f6ea5c784 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -576,10 +576,6 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (!data->skip_autocfg)
 		dw8250_setup_port(p);
 
-#ifdef CONFIG_PM
-	uart.capabilities |= UART_CAP_RPM;
-#endif
-
 	/* If we have a valid fifosize, try hooking up DMA */
 	if (p->fifosize) {
 		data->dma.rxconf.src_maxburst = p->fifosize / 4;
-- 
2.17.1

