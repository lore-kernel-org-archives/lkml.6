Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD094C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A5620C0A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A5620C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeILXze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:55:34 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:41581 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbeILXze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:55:34 -0400
Received: from tarshish (unknown [10.0.8.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 6C75B44028C;
        Wed, 12 Sep 2018 21:49:24 +0300 (IDT)
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
User-agent: mu4e 1.0; emacs 25.2.2
From:   Baruch Siach <baruch@tkos.co.il>
To:     Jan =?utf-8?Q?Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since "PCI: mvebu: Only remap I/O space if configured"
In-reply-to: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
Date:   Wed, 12 Sep 2018 21:49:41 +0300
Message-ID: <87zhwm4kl6.fsf@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

Jan Kundrát writes:
> since commit ee1604381a371b3ea6aec7d5e43b6e3f5e153854 ("PCI: mvebu: Only
> remap I/O space if configured"), my board (Solidrun Clearfog Base) won't
> finish booting with 4.18-rc3 won't boot:

You mean '4.19-rc3', right?

>> [    1.741458] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
>> [    1.748182] CPU: 1 PID: 72 Comm: kworker/1:2 Tainted: G        W         4.19.0-rc3 #1

The 'W' taint means that there was a kernel warning before. Which
warning was that?

I reproduced the same Oops on Clearfog Base without any taint:

[    1.476401] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
[    1.483124] CPU: 1 PID: 1241 Comm: kworker/1:2 Not tainted 4.19.0-rc3 #145
[    1.490013] Hardware name: Marvell Armada 380/385 (Device Tree)
[    1.495953] Workqueue: events deferred_probe_work_func
[    1.501108] PC is at ioremap_page_range+0x114/0x1a4
[    1.505999] LR is at mvebu_pcie_probe+0x138/0x7d8
[    1.510711] pc : [<c083552c>]    lr : [<c043980c>]    psr: a0000013
[    1.516990] sp : ef257d80  ip : 000f0000  fp : c0a6d0bc
[    1.522225] r10: 00000243  r9 : e9200000  r8 : 00000103
[    1.527460] r7 : ee87f000  r6 : fee10000  r5 : fee00000  r4 : ee87f004
[    1.534001] r3 : ee87f000  r2 : e8000243  r1 : fee0ffff  r0 : c0004000
[    1.540543] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    1.547693] Control: 10c5387d  Table: 0000404a  DAC: 00000051
[    1.553450] Process kworker/1:2 (pid: 1241, stack limit = 0x(ptrval))
[    1.559903] Stack: (0xef257d80 to 0xef258000)
[    1.564269] 7d80: fee10000 e9200000 fee0ffff ffe00000 c0007fb8 00000000 00000000 ee743010
[    1.572466] 7da0: ef200410 ee743264 00000000 00000000 c0e39474 00000001 00000000 c043980c
[    1.580662] 7dc0: ef257e00 c0e03c08 ef7f7574 c0a26120 ef7f7574 ee743210 ee74321c f2a8b0d2
[    1.588858] 7de0: c0e03c08 c0e03c08 c0e39474 ef200410 00000000 c063ce84 00000000 c0296ad4
[    1.597054] 7e00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 f2a8b0d2
[    1.605250] 7e20: 00000000 ef200410 00000000 c0e39474 00000000 00000000 c0e39474 00000001
[    1.613446] 7e40: ef7e52c0 c048c4c0 c0e9461c ef200410 c0e94628 c048a8fc ef200410 c0e39474
[    1.621642] 7e60: c048af44 c0e03c08 00000001 c0e73c30 00000000 c048ad70 ef200410 c0e39474
[    1.629838] 7e80: ef200410 00000000 ef257ed4 c048af44 c0e03c08 00000001 c0e73c30 00000000
[    1.638034] 7ea0: ef7e52c0 c0489354 c0e73c30 ef088d6c ef3116b8 f2a8b0d2 ef200410 ef200410
[    1.646230] 7ec0: c0e03c08 ef200444 c0e3fae8 c048abd8 c0e03c08 ef200410 00000001 f2a8b0d2
[    1.654426] 7ee0: ef200410 ef200410 c0e3fd30 c0e3fae8 00000000 c0489538 ef200410 c0e3facc
[    1.662622] 7f00: c0e3facc c048a1d0 c0e3fb04 ee4b7f00 ef7e52c0 ef7e6400 00000000 c0139974
[    1.670818] 7f20: ef7e52c0 ef7e52c0 c0e02d00 ee4b7f00 ef7e52c0 ee4b7f14 c0e02d00 ef7e52d8
[    1.679014] 7f40: ffffe000 00000008 ef7e52c0 c0139f0c 00000000 c0e73696 c09efbe0 ee952d40
[    1.687209] 7f60: 00000000 ee75f680 ef256000 ee952d40 00000000 ee4b7f00 c0139c64 ef0d9ea4
[    1.695405] 7f80: ee75f69c c013f75c 0000004e ee952d40 c013f62c 00000000 00000000 00000000
[    1.703601] 7fa0: 00000000 00000000 00000000 c01010e8 00000000 00000000 00000000 00000000
[    1.711796] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.719992] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    1.728195] [<c083552c>] (ioremap_page_range) from [<c043980c>] (mvebu_pcie_probe+0x138/0x7d8)
[    1.736830] [<c043980c>] (mvebu_pcie_probe) from [<c048c4c0>] (platform_drv_probe+0x48/0x98)
[    1.745290] [<c048c4c0>] (platform_drv_probe) from [<c048a8fc>] (really_probe+0x1d0/0x2bc)
[    1.753575] [<c048a8fc>] (really_probe) from [<c048ad70>] (driver_probe_device+0x60/0x160)
[    1.761860] [<c048ad70>] (driver_probe_device) from [<c0489354>] (bus_for_each_drv+0x58/0xb8)
[    1.770404] [<c0489354>] (bus_for_each_drv) from [<c048abd8>] (__device_attach+0xd0/0x138)
[    1.778688] [<c048abd8>] (__device_attach) from [<c0489538>] (bus_probe_device+0x84/0x8c)
[    1.786884] [<c0489538>] (bus_probe_device) from [<c048a1d0>] (deferred_probe_work_func+0x60/0x8c)
[    1.795868] [<c048a1d0>] (deferred_probe_work_func) from [<c0139974>] (process_one_work+0x218/0x508)
[    1.805023] [<c0139974>] (process_one_work) from [<c0139f0c>] (worker_thread+0x2a8/0x5c0)
[    1.813221] [<c0139f0c>] (worker_thread) from [<c013f75c>] (kthread+0x130/0x138)
[    1.820635] [<c013f75c>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[    1.827872] Exception stack(0xef257fb0 to 0xef257ff8)
[    1.832933] 7fa0:                                     00000000 00000000 00000000 00000000
[    1.841129] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.849324] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.855954] Code: e2844004 e5972000 e3520000 0affffee (e7f001f2)
[    1.862059] ---[ end trace 4067cdcfd86589a5 ]---

>> [    1.756120] Hardware name: Marvell Armada 380/385 (Device Tree)
>> [    1.762063] Workqueue: events deferred_probe_work_func
>> [    1.767222] PC is at ioremap_page_range+0x114/0x1a4
>> [    1.772117] LR is at mvebu_pcie_probe+0x134/0xa60
>> [    1.776832] pc : [<c06e643c>]    lr : [<c03e9d5c>]    psr: a0000013
>> [    1.783115] sp : ee30dd88  ip : 000f0000  fp : c0837b38
>> [    1.788352] r10: 00000243  r9 : e9200000  r8 : 00000103
>> [    1.793590] r7 : ef6f8000  r6 : fee10000  r5 : fee00000  r4 : ef6f8004
>> [    1.800133] r3 : ef6f8000  r2 : e8000243  r1 : fee0ffff  r0 : c0004000
>> [    1.806678] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> [    1.813832] Control: 10c5387d  Table: 0000404a  DAC: 00000051
>> [    1.819592] Process kworker/1:2 (pid: 72, stack limit = 0x(ptrval))
>> [    1.825874] Stack: (0xee30dd88 to 0xee30e000)
>> [    1.830244] dd80:                   fee10000 e9200000 fee0ffff ffe00000 c0007fb8 ee33e224
>> [    1.838445] dda0: 00000000 ee33e010 00000000 ef575610 ee33e224 00000000 c0a30ac4 00000002
>> [    1.846646] ddc0: ef9f827c c03e9d5c c0ab6d30 ef9ed434 ee342898 ee342898 ee33e1d0 ee33e1dc
>> [    1.854848] dde0: ee342898 00000000 c0a03bc8 c07fcabc 00000001 ef575610 ef577000 c02a72b4
>> [    1.863050] de00: 00000000 ee342898 ef6744d0 ef6744d0 ee342898 ef577000 c07fcabc 5d6fd1e4
>> [    1.871252] de20: c0a30ac4 ef575610 00000000 c0a30ac4 00000000 00000000 c0a30ac4 00000002
>> [    1.879454] de40: ef9e40c0 c043dba4 c0ab3144 ef575610 c0ab3150 c043c4e4 ef575610 c0a30ac4
>> [    1.887656] de60: c043cb2c c0a03bc8 00000001 c0a5cf50 00000000 c043c958 ef575610 c0a30ac4
>> [    1.895858] de80: ef575610 00000000 ee30ded4 c043cb2c c0a03bc8 00000001 c0a5cf50 00000000
>> [    1.904059] dea0: ef9e40c0 c043af7c c0a5cf50 ef484d6c ef66d8b8 5d6fd1e4 ef575610 ef575610
>> [    1.912261] dec0: c0a03bc8 ef575644 c0a371c4 c043c7c0 00000003 ef575610 00000001 5d6fd1e4
>> [    1.920462] dee0: ef575610 ef575610 c0a373f0 c0a371c4 00000000 c043b160 ef575610 c0a371a8
>> [    1.928663] df00: c0a371a8 c043bdf8 c0a371e0 ee2f9880 ef9e40c0 ef9e5300 00000000 c01388b4
>> [    1.936864] df20: ef9e40c0 ef9e40c0 ee30c000 ee2f9880 ef9e40c0 ee2f9894 c0a02d00 ef9e40d8
>> [    1.945064] df40: ffffe000 00000008 ef9e40c0 c0138e4c ffffe000 c0a5ca32 c07d2f68 00000000
>> [    1.953265] df60: ffffe000 eee5e0c0 ee2fa4c0 00000000 ee30c000 ee2f9880 c0138ba4 ef4d5ea4
>> [    1.961466] df80: eee5e0dc c013e448 00000001 ee2fa4c0 c013e2fc 00000000 00000000 00000000
>> [    1.969668] dfa0: 00000000 00000000 00000000 c01010e8 00000000 00000000 00000000 00000000
>> [    1.977869] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> [    1.986069] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
>> [    1.994277] [<c06e643c>] (ioremap_page_range) from [<c03e9d5c>] (mvebu_pcie_probe+0x134/0xa60)
>> [    2.002917] [<c03e9d5c>] (mvebu_pcie_probe) from [<c043dba4>] (platform_drv_probe+0x48/0x98)
>> [    2.011382] [<c043dba4>] (platform_drv_probe) from [<c043c4e4>] (really_probe+0x1d0/0x2bc)
>> [    2.019671] [<c043c4e4>] (really_probe) from [<c043c958>] (driver_probe_device+0x60/0x160)
>> [    2.027961] [<c043c958>] (driver_probe_device) from [<c043af7c>] (bus_for_each_drv+0x58/0xb8)
>> [    2.036511] [<c043af7c>] (bus_for_each_drv) from [<c043c7c0>] (__device_attach+0xd0/0x138)
>> [    2.044800] [<c043c7c0>] (__device_attach) from [<c043b160>] (bus_probe_device+0x84/0x8c)
>> [    2.053002] [<c043b160>] (bus_probe_device) from [<c043bdf8>] (deferred_probe_work_func+0x60/0x8c)
>> [    2.061991] [<c043bdf8>] (deferred_probe_work_func) from [<c01388b4>] (process_one_work+0x218/0x508)
>> [    2.071152] [<c01388b4>] (process_one_work) from [<c0138e4c>] (worker_thread+0x2a8/0x5c0)
>> [    2.079355] [<c0138e4c>] (worker_thread) from [<c013e448>] (kthread+0x14c/0x154)
>> [    2.086774] [<c013e448>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
>> [    2.094015] Exception stack(0xee30dfb0 to 0xee30dff8)
>> [    2.099079] dfa0:                                     00000000 00000000 00000000 00000000
>> [    2.107280] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> [    2.115481] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> [    2.122115] Code: e2844004 e5972000 e3520000 0affffee (e7f001f2)
>> [    2.128225] ---[ end trace 7a77412d00a47123 ]---
>> [    2.132853] Kernel panic - not syncing: Fatal exception
>> [    2.138094] CPU0: stopping
>> [    2.140811] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D W         4.19.0-rc3 #1
>> [    2.148489] Hardware name: Marvell Armada 380/385 (Device Tree)
>> [    2.154430] [<c01109fc>] (unwind_backtrace) from [<c010c894>] (show_stack+0x10/0x14)
>> [    2.162198] [<c010c894>] (show_stack) from [<c06e29c4>] (dump_stack+0x88/0x9c)
>> [    2.169443] [<c06e29c4>] (dump_stack) from [<c010f71c>] (handle_IPI+0x38c/0x3ac)
>> [    2.176863] [<c010f71c>] (handle_IPI) from [<c03b4af4>] (gic_handle_irq+0x8c/0x90)
>> [    2.184457] [<c03b4af4>] (gic_handle_irq) from [<c0101a0c>] (__irq_svc+0x6c/0x90)
>> [    2.191960] Exception stack(0xc0a01f18 to 0xc0a01f60)
>> [    2.197024] 1f00:                                                       00000000 00001db4
>> [    2.205226] 1f20: ef9d1398 c0119260 ffffe000 c0a03bf0 c0a03c30 00000001 00000000 c0a03bc8
>> [    2.213426] 1f40: c0968980 00000000 00000000 c0a01f68 c0108e68 c0108e6c 60000013 ffffffff
>> [    2.221631] [<c0101a0c>] (__irq_svc) from [<c0108e6c>] (arch_cpu_idle+0x38/0x3c)
>> [    2.229051] [<c0108e6c>] (arch_cpu_idle) from [<c014cf4c>] (do_idle+0x1e0/0x210)
>> [    2.236469] [<c014cf4c>] (do_idle) from [<c014d218>] (cpu_startup_entry+0x18/0x20)
>> [    2.244065] [<c014d218>] (cpu_startup_entry) from [<c0900f48>] (start_kernel+0x42c/0x454)
>> [    2.252268] [<c0900f48>] (start_kernel) from [<00000000>] (  (null))
>> [    2.258642] Rebooting in 10 seconds..
>
> I cannot easily revert that commit now due to some followup changes. I'll
> be happy to test patches which attempt to fix this.
>
> The DTS file in use on this board is armada-388-clearfog-base.dts in case
> it matters (we have some DT add-on patches on top of that, but nothing PCI-
> or MBUS-related).

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
