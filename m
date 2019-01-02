Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA64C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 08:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E0E2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 08:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfABIi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 03:38:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:32810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbfABIi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 03:38:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A292AC55;
        Wed,  2 Jan 2019 08:38:54 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 235D2E00B3; Wed,  2 Jan 2019 09:38:54 +0100 (CET)
Date:   Wed, 2 Jan 2019 09:38:54 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
Subject: crash in gart_unmap_page() with master snapshot (commit e1ef035d272e)
Message-ID: <20190102083854.GA28932@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

today I encountered a crash with kernel built from master branch
snapshot (commit e1ef035d272e):

CPU: 1 PID: 0 Comm: swapper/1 Kdump: loaded Tainted: G            E     4.21.0-rc0-1.gd3c9245-default #1 openSUSE Tumbleweed (unreleased)
Hardware name: MICRO-STAR INTERANTIONAL CO.,LTD MS-7376/MS-7376, BIOS V1.2 12/21/2007
RIP: 0010:gart_unmap_page+0x69/0xc0
Code: 29 c5 48 c1 eb 0c 48 c1 ed 0c 85 db 7e 27 48 8b 35 dc 9b 8b 01 8d 53 ff 8b 0d bb 9b 8b 01 48 01 ea 48 8d 04 ae 48 8d 54 96 04 <89> 08 48 83 c0 04 48 39 c2 75 f5 48 c7 c7 88 b2 92 89 e8 00 23 81
RSP: 0018:ffff98a4e7a83dd8 EFLAGS: 00010002
RAX: 003f98a4e750a438 RBX: 0000000000000001 RCX: 0000000027788023
RDX: 003f98a4e750a43c RSI: ffff98a4e7750000 RDI: ffff98a4e74020b0
RBP: 000ffffffff6e90e R08: 0000000000000000 R09: ffffffff88071720
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff98a4e74020b0 R14: 0000000000000001 R15: ffff98a4e2aea418
FS:  0000000000000000(0000) GS:ffff98a4e7a80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002743b1f4f890 CR3: 00000001f5a70000 CR4: 00000000000006e0
Call Trace:
 <IRQ>
 gart_unmap_sg+0x52/0x70
 __ata_qc_complete+0xfb/0x160
 ata_qc_complete_multiple+0xbd/0xe0
 ahci_handle_port_interrupt+0xcd/0x5a0
 ? blk_mq_run_hw_queue+0x38/0xc0
 ahci_handle_port_intr+0x54/0xb0
 ahci_single_level_irq_intr+0x3b/0x60
 __handle_irq_event_percpu+0x46/0x1c0
 handle_irq_event_percpu+0x20/0x60
 handle_irq_event+0x3a/0x5a
 handle_fasteoi_irq+0x9c/0x160
 handle_irq+0x1f/0x30
 do_IRQ+0x49/0xd0
 common_interrupt+0xf/0xf
 </IRQ>

This is the code of gart_unmap_page():

254     in ../arch/x86/kernel/amd_gart_64.c
   0xffffffff81071660 <+0>:     callq  0xffffffff81a01990 <__fentry__>

255     in ../arch/x86/kernel/amd_gart_64.c
256     in ../arch/x86/kernel/amd_gart_64.c
257     in ../arch/x86/kernel/amd_gart_64.c
258     in ../arch/x86/kernel/amd_gart_64.c
259     in ../arch/x86/kernel/amd_gart_64.c
   0xffffffff81071665 <+5>:     cmp    $0xffffffffffffffff,%rsi
   0xffffffff81071669 <+9>:     je     0xffffffff8107171c <gart_unmap_page+188>
   0xffffffff8107166f <+15>:    mov    0x18b9c32(%rip),%rax        # 0xffffffff8292b2a8 <iommu_bus_base>
   0xffffffff81071676 <+22>:    mov    0x18b9c23(%rip),%rcx        # 0xffffffff8292b2a0 <iommu_size>
   0xffffffff8107167d <+29>:    add    %rax,%rcx
   0xffffffff81071680 <+32>:    cmp    %rsi,%rcx
   0xffffffff81071683 <+35>:    jbe    0xffffffff8107171c <gart_unmap_page+188>

260     in ../arch/x86/kernel/amd_gart_64.c
261     in ../arch/x86/kernel/amd_gart_64.c
262     in ../arch/x86/kernel/amd_gart_64.c
263     in ../arch/x86/kernel/amd_gart_64.c
   0xffffffff81071689 <+41>:    push   %r12
   0xffffffff8107168b <+43>:    push   %rbp
   0xffffffff8107168c <+44>:    mov    %rsi,%rbp
   0xffffffff8107168f <+47>:    and    $0xfff,%esi
   0xffffffff81071695 <+53>:    push   %rbx
   0xffffffff81071696 <+54>:    lea    0xfff(%rdx,%rsi,1),%rbx
   0xffffffff8107169e <+62>:    sub    %rax,%rbp
   0xffffffff810716a1 <+65>:    shr    $0xc,%rbx
   0xffffffff810716a5 <+69>:    shr    $0xc,%rbp

264     in ../arch/x86/kernel/amd_gart_64.c
265     in ../arch/x86/kernel/amd_gart_64.c
   0xffffffff810716a9 <+73>:    test   %ebx,%ebx
   0xffffffff810716ab <+75>:    jle    0xffffffff810716d4 <gart_unmap_page+116>
   0xffffffff810716ad <+77>:    mov    0x18b9bdc(%rip),%rsi        # 0xffffffff8292b290 <iommu_gatt_base>
   0xffffffff810716b4 <+84>:    lea    -0x1(%rbx),%edx
   0xffffffff810716b7 <+87>:    mov    0x18b9bbb(%rip),%ecx        # 0xffffffff8292b278 <gart_unmapped_entry>
   0xffffffff810716bd <+93>:    add    %rbp,%rdx
   0xffffffff810716c0 <+96>:    lea    (%rsi,%rbp,4),%rax
   0xffffffff810716c4 <+100>:   lea    0x4(%rsi,%rdx,4),%rdx

266     in ../arch/x86/kernel/amd_gart_64.c
   0xffffffff810716c9 <+105>:   mov    %ecx,(%rax)	<-------- crashed here
   0xffffffff810716cb <+107>:   add    $0x4,%rax
   0xffffffff810716cf <+111>:   cmp    %rax,%rdx
   0xffffffff810716d2 <+114>:   jne    0xffffffff810716c9 <gart_unmap_page+105>
...

According to the register values, i = 0 and npages = 1 but the problem
is iommu_page in %rbp which is 0x000ffffffff6e90e. The way it is
calculated it looks as if a kernel pointer was passed as dma_addr rather
than a DMA address.

There is a recent change in gart_unmap_page() from commit 9e8aa6b5461b
("x86/amd_gart: remove the mapping_error dma_map_ops method"):

------------------------------------------------------------------------
@@ -271,7 +259,7 @@ static void gart_unmap_page(struct device *dev, dma_addr_t dma_addr,
        int npages;
        int i;
 
-       if (dma_addr < iommu_bus_base + EMERGENCY_PAGES*PAGE_SIZE ||
+       if (dma_addr == DMA_MAPPING_ERROR ||
            dma_addr >= iommu_bus_base + iommu_size)
                return;
 
------------------------------------------------------------------------

It seems the condition removed by this commit would catch such invalid
value of dma_addr so that it's possible this is an older problem which
was masked before and commit 9e8aa6b5461b uncovered it.

Michal Kubecek
