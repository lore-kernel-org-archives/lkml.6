Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E05C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A9D20989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GWqr4FEU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ddt341OD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A9D20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbeKUUHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:07:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37874 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbeKUUHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:07:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 60ED460B12; Wed, 21 Nov 2018 09:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542792827;
        bh=XUKaYDR/t6sKVg5zxPi9jY85x462ISIHa/Ib9RRhS6I=;
        h=Date:From:To:Subject:From;
        b=GWqr4FEUIOsL82iQUIa4cV9OrB5O3b2HbGa7zvvDbyyQJmro3gyYAE+C+dY3wnkDz
         NuIpkb1EfyV+JQS1f5ZnzMRwTmokWfmwvTe1vjea++AN4BcBbKMVRF0tG5Omv0xkee
         lbI1vH7A9PaRhxYWtQLf6csUvcF3Mb9P/FtF6TAo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A42756047C;
        Wed, 21 Nov 2018 09:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542792826;
        bh=XUKaYDR/t6sKVg5zxPi9jY85x462ISIHa/Ib9RRhS6I=;
        h=Date:From:To:Subject:From;
        b=Ddt341ODjJcljgc0YVDk5YJEGhgsqnn76uVliEz325vp4EjTchNNYT4QanchzV4AQ
         7iRlB9kKw2rawLupn0BaK8M5LzQ9ehyCkqoA6GBoDVN0EG1plXkHitPcpwWkvT14Zv
         x5vWvHRJdPlFdJvGCl3kdWRmTTOpo3R50il5ySxc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Nov 2018 15:03:46 +0530
From:   poza@codeaurora.org
To:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: ASPEED graphics card: ast_pci_probe causes RCU stalls
Message-ID: <146595c1e1c6753cca92cf70a7b79f47@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


we have on-board ASPEED Graphics card on PCIe.

kernel version: 4.16

I select following drive to enable ast graphics support.
Symbol: DRM_AST [=y]                                                     
                                                                          
                                                           \u2502
   AST server chips                                                       
                                                                          
                                                     \u2502
   Location:                                                              
                                                                          
                                                           \u2502
   -> Device Drivers                                                      
                                                                          
                                                         \u2502
     -> Graphics support                                                  
                                                                          
                                                         \u2502
   Defined at drivers/gpu/drm/ast/Kconfig:1                               
                                                                          
                                                           \u2502
   Depends on: HAS_IOMEM [=y] && DRM [=y] && PCI [=y] && MMU [=y]         
                                                                          
                                                           \u2502
   Selects: DRM_TTM [=y] && DRM_KMS_HELPER [=y] && DRM_TTM [=y]

lspci -vvv output.
-----------------------------

0007:02:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED 
Graphics Family (rev 41) (prog-if 00 [VGA controller])
         Subsystem: ASPEED Technology, Inc. ASPEED Graphics Family
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 255
         Region 0: Memory at e70101000000 (32-bit, non-prefetchable) 
[size=16M]
         Region 1: Memory at e70100800000 (32-bit, non-prefetchable) 
[size=128K]
         Region 2: I/O ports at 60000 [size=128]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable- Count=1/2 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000


it seems to me that; ast_pci_probe seems to stuck in set_clock

[   38.293239] INFO: rcu_sched self-detected stall on CPU
[   38.300808]  0-....: (35 ticks this GP) 
idle=256/1/4611686018427387906 softirq=183/183 fqs=187
[   38.313653]   (t=421 jiffies g=-232 c=-233 q=322)
[   38.320592] Task dump for CPU 0:
[   38.325566] kworker/0:0     R  running task        0     3      2 
0x00000002
[   38.335989] Workqueue: events work_for_cpu_fn
[   38.342409] Call trace:
[   38.346025]  dump_backtrace+0x0/0x170
[   38.351413]  show_stack+0x14/0x20
[   38.356297]  sched_show_task+0x104/0x128
[   38.362173]  dump_cpu_task+0x40/0x50
[   38.367441]  rcu_dump_cpu_stacks+0x94/0xd4
[   38.373480]  rcu_check_callbacks+0x574/0x7b0
[   38.379785]  update_process_times+0x2c/0x58
[   38.385946]  tick_sched_handle.isra.5+0x30/0x50
[   38.393830]  tick_sched_timer+0x40/0x90
[   38.399480]  __hrtimer_run_queues+0x120/0x1b8
[   38.405895]  hrtimer_interrupt+0xd4/0x250
[   38.411815]  arch_timer_handler_phys+0x28/0x40
[   38.418361]  handle_percpu_devid_irq+0x80/0x138
[   38.425152]  generic_handle_irq+0x24/0x38
[   38.431057]  __handle_domain_irq+0x5c/0xb0
[   38.437104]  gic_handle_irq+0x7c/0x184
[   38.442639]  el1_irq+0xb0/0x140
[   38.447265]  ast_get_index_reg_mask+0x4/0x38
[   38.453553]  __i2c_bit_add_bus+0x54/0x3e0
[   38.459532]  i2c_bit_add_bus+0x14/0x20
[   38.465057]  ast_mode_init+0x230/0x358
[   38.470584]  ast_driver_load+0x5a4/0x968
[   38.476368]  drm_dev_register+0x154/0x1d8
[   38.482283]  drm_get_pci_dev+0x94/0x160
[   38.488047]  ast_pci_probe+0x18/0x20
[   38.493318]  local_pci_probe+0x28/0x80
[   38.498830]  work_for_cpu_fn+0x18/0x28
[   38.504367]  process_one_work+0x1d4/0x310
[   38.510271]  worker_thread+0x230/0x470
[   38.515804]  kthread+0x128/0x130
[   38.520777]  ret_from_fork+0x10/0x18

Regards,
Oza.

