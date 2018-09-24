Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249F3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B2820877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=odi.ch header.i=@odi.ch header.b="CJt46tDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B2820877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=odi.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbeIXSCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:02:04 -0400
Received: from vie01a-dmta-ch02-3.mx.upcmail.net ([84.116.36.96]:61002 "EHLO
        vie01a-dmta-ch02-3.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728131AbeIXSCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:02:03 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-ch02.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <odi@odi.ch>)
        id 1g4PXD-0003Ri-A0
        for linux-kernel@vger.kernel.org; Mon, 24 Sep 2018 14:00:15 +0200
Received: from gandalf.odi.ch ([84.74.184.48])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id fQ051y01o134B7001Q075Z; Mon, 24 Sep 2018 14:00:07 +0200
X-SourceIP: 84.74.184.48
X-Authenticated-Sender: odi.ch@hispeed.ch
Received: from [10.11.1.254] (unknown [81.7.230.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gandalf.odi.ch (Postfix) with ESMTPSA id 9436C460512;
        Mon, 24 Sep 2018 14:00:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=odi.ch; s=mail;
        t=1537790405; bh=yyg0Meuo538ckQbZtOkklKfr1yANKUss4Vhj2KFJtFQ=;
        h=From:To:Subject:Date;
        b=CJt46tDsb2DRO0ixA8Y4LsLyS0mnNueSXQdyQD4w2V3tKnVqt6yZ+pao8xWLefa0k
         eKBRa0dPUaMBN4SkTuGPeIZpmBf7GZSV9RS/NOF/CdUxboJTCmD91U4sz5EIEJEorw
         /75p7+eZE6QxAGku5Yqv9CuCuhWmBybLj8bX8cHM=
From:   =?UTF-8?Q?Ortwin_Gl=c3=bcck?= <odi@odi.ch>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Subject: r8169 hang on 4.18
Message-ID: <332fecce-3fab-1c92-1558-67a1d90d6372@odi.ch>
Date:   Mon, 24 Sep 2018 14:00:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Stable kernel has stability problems on r8169 that were not present in 4.17.3:

[    0.000000] Linux version 4.18.8 (kbuild@lofw) (gcc version 7.3.0 (Gentoo 7.3.0-r3 p1.4)) #70 SMP 
PREEMPT Mon Sep 17 17:56:57 CEST 2018
[    0.000000] Command line: BOOT_IMAGE=/boot/linux-4.18.8 root=LABEL=ROOT ro rootfstype=ext4 
net.ifnames=0 pci=nomsi

[    1.772849] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    1.772852] r8169 0000:07:00.0: can't disable ASPM; OS doesn't have ASPM control
[    1.784948] r8169 0000:07:00.0 eth4: RTL8168h/8111h, 50:9a:4c:2e:92:be, XID 54100800, IRQ 16
[    1.784949] r8169 0000:07:00.0 eth4: jumbo features [frames: 9200 bytes, tx checksumming: ko]

We saw the interface unresponsive twice during the last 3 days with:

[Mon Sep 24 11:35:56 2018] ------------[ cut here ]------------
[Mon Sep 24 11:35:56 2018] NETDEV WATCHDOG: wan (r8169): transmit queue 0 timed out
[Mon Sep 24 11:35:56 2018] WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:461 
dev_watchdog+0x215/0x220
[Mon Sep 24 11:35:56 2018] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.18.8 #70
[Mon Sep 24 11:35:56 2018] Hardware name: Dell Inc. OptiPlex 3050/0W0CHX, BIOS 1.6.5 09/09/2017
[Mon Sep 24 11:35:56 2018] RIP: 0010:dev_watchdog+0x215/0x220
[Mon Sep 24 11:35:56 2018] Code: 49 63 4c 24 e8 eb 8c 4c 89 ef c6 05 1a 19 ca 00 01 e8 5f 52 fd ff 
89 d9 4c 89 ee 48 c7 c7 78 ab 67 89 48 89 c2 e8 1b 2b 49 ff <0f> 0b eb be 0f 1f 80 00 00 00 00 41 57 
45 89 cf 41 56 49 89 d6 41
[Mon Sep 24 11:35:56 2018] RSP: 0018:ffff96f05dd03e98 EFLAGS: 00010282
[Mon Sep 24 11:35:56 2018] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000006
[Mon Sep 24 11:35:56 2018] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff96f05dd15350
[Mon Sep 24 11:35:56 2018] RBP: ffff96f0462ee41c R08: 0000000000000001 R09: 000000000000133d
[Mon Sep 24 11:35:56 2018] R10: 0000000000000202 R11: 0000000000000000 R12: ffff96f0462ee438
[Mon Sep 24 11:35:56 2018] R13: ffff96f0462ee000 R14: 0000000000000001 R15: ffff96f0455eaa80
[Mon Sep 24 11:35:56 2018] FS:  0000000000000000(0000) GS:ffff96f05dd00000(0000) knlGS:0000000000000000
[Mon Sep 24 11:35:56 2018] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Mon Sep 24 11:35:56 2018] CR2: 000055c9498766e0 CR3: 00000000bb80a006 CR4: 00000000003606e0
[Mon Sep 24 11:35:56 2018] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[Mon Sep 24 11:35:56 2018] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[Mon Sep 24 11:35:56 2018] Call Trace:
[Mon Sep 24 11:35:56 2018]  <IRQ>
[Mon Sep 24 11:35:56 2018]  ? pfifo_fast_reset+0x130/0x130
[Mon Sep 24 11:35:56 2018]  ? pfifo_fast_reset+0x130/0x130
[Mon Sep 24 11:35:56 2018]  call_timer_fn+0x11/0x70
[Mon Sep 24 11:35:56 2018]  expire_timers+0x8e/0xa0
[Mon Sep 24 11:35:56 2018]  run_timer_softirq+0xb9/0x160
[Mon Sep 24 11:35:56 2018]  ? __hrtimer_run_queues+0x135/0x1a0
[Mon Sep 24 11:35:56 2018]  ? hw_breakpoint_pmu_read+0x10/0x10
[Mon Sep 24 11:35:56 2018]  ? ktime_get+0x39/0x90
[Mon Sep 24 11:35:56 2018]  ? lapic_next_event+0x20/0x20
[Mon Sep 24 11:35:56 2018]  __do_softirq+0xcb/0x1f8
[Mon Sep 24 11:35:56 2018]  irq_exit+0xa9/0xb0
[Mon Sep 24 11:35:56 2018]  smp_apic_timer_interrupt+0x59/0x90
[Mon Sep 24 11:35:56 2018]  apic_timer_interrupt+0xf/0x20
[Mon Sep 24 11:35:56 2018]  </IRQ>
[Mon Sep 24 11:35:56 2018] RIP: 0010:cpuidle_enter_state+0x129/0x200
[Mon Sep 24 11:35:56 2018] Code: 45 00 89 c3 e8 d8 3b 55 ff 65 8b 3d b1 eb 45 77 e8 8c 3a 55 ff 31 
ff 49 89 c4 e8 72 43 55 ff fb 48 ba cf f7 53 e3 a5 9b c4 20 <4c> 89 e1 4c 29 e9 48 89 c8 48 c1 f9 3f 
48 f7 ea b8 ff ff ff 7f 48
[Mon Sep 24 11:35:56 2018] RSP: 0018:ffff9a93c06e7ea8 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
[Mon Sep 24 11:35:56 2018] RAX: ffff96f05dd1f800 RBX: 0000000000000003 RCX: 000000000000001f
[Mon Sep 24 11:35:56 2018] RDX: 20c49ba5e353f7cf RSI: 00000000258f0602 RDI: 0000000000000000
[Mon Sep 24 11:35:56 2018] RBP: ffff96f05dd25ee0 R08: 00000000000002b4 R09: 00000000ffffffff
[Mon Sep 24 11:35:56 2018] R10: ffff9a93c06e7e90 R11: 0000000000000142 R12: 00012ec849a182b9
[Mon Sep 24 11:35:56 2018] R13: 00012ec8499ddf88 R14: 0000000000000003 R15: 0000000000000000
[Mon Sep 24 11:35:56 2018]  ? cpuidle_enter_state+0x11e/0x200
[Mon Sep 24 11:35:56 2018]  do_idle+0x1c0/0x200
[Mon Sep 24 11:35:56 2018]  cpu_startup_entry+0x6a/0x70
[Mon Sep 24 11:35:56 2018]  start_secondary+0x18a/0x1c0
[Mon Sep 24 11:35:56 2018]  secondary_startup_64+0xa5/0xb0
[Mon Sep 24 11:35:56 2018] ---[ end trace 327bd9c035abe307 ]---

This is the built-in ethernet port on a Dell main board:
07:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express 
Gigabit Ethernet Controller [10ec:8168] (rev 15)
         Subsystem: Dell RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [1028:07a3]
         Flags: bus master, fast devsel, latency 0, IRQ 16
         I/O ports at e000 [size=256]
         Memory at f7404000 (64-bit, non-prefetchable) [size=4K]
         Memory at f7400000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [40] Power Management version 3
         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
         Capabilities: [70] Express Endpoint, MSI 01
         Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
         Capabilities: [100] Advanced Error Reporting
         Capabilities: [140] Virtual Channel
         Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
         Capabilities: [170] Latency Tolerance Reporting
         Capabilities: [178] L1 PM Substates
         Kernel driver in use: r8169

The box has an extra 4-way ethernet card that uses the same driver. We had to set pci=nomsi because 
the card frequently behaved erratic with msi on.

Thanks,

Ortwin
