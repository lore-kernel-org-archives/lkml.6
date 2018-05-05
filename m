Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbeEELz0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 07:55:26 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36779 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeEELzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 07:55:24 -0400
X-Google-Smtp-Source: AB8JxZrEjZNki9+XPWWZocQFvvs0sU/9vRacM3JMFvSt7JMp3FCj8vrLGo7LkaImKPgsK/wv3JokpQPpx1j0Pcx90Ng=
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
From: tedheadster <tedheadster@gmail.com>
Date: Sat, 5 May 2018 07:55:03 -0400
Message-ID: <CAP8WD_YRPFSwqqUPy7AtmPs-0x4u+7V0rxWU75VnMh5HdLCA8w@mail.gmail.com>
Subject: PCI: Regression in remove NULL device handling from PCI DMA API
To: Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,
  I bisected the following kernel panic to the patch "PCI: Remove NULL
device handling from PCI DMA API". It seems we
still need NULL checking for some older drivers, in my case the 3c59x
driver for PCI/EISA cards.

I am pretty sure the panic arises in the driver here
(drivers/net/ethernet/3com/3c59x.c: vortex_probe1() ):

        /* Makes sure rings are at least 16 byte aligned. */
        vp->rx_ring = pci_alloc_consistent(pdev, sizeof(struct
boom_rx_desc) * RX_RING_SIZE
                                           + sizeof(struct
boom_tx_desc) * TX_RING_SIZE,
                                           &vp->rx_ring_dma);

Here is the panic backtrace:

eisa 00:08: EISA: slot 8: TCM5970 detected
3c59x: Donald Becker and others.
00:08: 3Com EISA 3c597 EISA Fast Demon/Vortex at 4d2ccbd3.
BUG: unable to handle kernel NULL pointer dereference at 000000e8
IP: get_dma_ops+0x7/0x18
*pde = 00000000
Oops: 0000 [#1]
CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc4.i486-netinstall-14+ #47
EIP: get_dma_ops+0x7/0x18
EFLAGS: 00010202 CPU: 0
EAX: 00000064 EBX: c01844a0 ECX: 00000000 EDX: 00000020
ESI: c0182708 EDI: ffffffff EBP: c0015cc8 ESP: c0015cc8
 DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
CR0: 80050033 CR2: 000000e8 CR3: 01348000 CR4: 00000000
Call Trace:
 vortex_probe1+0x31b/0xc6f
 ? node_tag_clear+0x2f/0x71
 ? radix_tree_iter_tag_clear+0x14/0x1a
 ? idr_alloc_cmn+0x77/0x8d
 ? slob_page_alloc+0x12b/0x172
 ? __kmalloc+0x2e/0x56
 ? __request_region+0x82/0xdf
 ? do_task_dead+0x21/0x21
 vortex_eisa_probe+0x6a/0xa1
 driver_probe_device+0x18c/0x316
 __device_attach_driver+0xa7/0xb6
 bus_for_each_drv+0x57/0x63
 __device_attach+0x68/0xbb
 ? driver_allows_async_probing+0xc/0xc
 device_initial_probe+0xd/0xf
 bus_probe_device+0x1f/0x5f
 device_add+0x387/0x442
 device_register+0x12/0x15
 eisa_register_device+0x12/0x7c
 eisa_root_register+0x1e8/0x25c
 ? eisa_root_register+0x25c/0x25c
 virtual_eisa_root_init+0x2f/0x42
 do_one_initcall+0x7c/0x106
 ? parse_args+0x1ac/0x2a0
 ? kernel_init_freeable+0xba/0x156
 kernel_init_freeable+0xda/0x156
 ? rest_init+0x70/0x70
 kernel_init+0x8/0xc6
 ret_from_fork+0x19/0x30
Code: 04 74 17 68 8b b7 2c c1 68 b8 a4 2b c1 68 b8 52 30 c1 e8 a4 4f
fa ff 83 c4 0c 89 d8 8d 65 f4 5b 5e 5f 5d c3 55 89 e5 85 c0 74 0a <8b>
80 84 00 00 00 85 c0 75 05 a1 a8 69 2e c1 5d c3 55 89 e5 53
EIP: get_dma_ops+0x7/0x18 SS:ESP: 0068:c0015cc8
CR2: 00000000000000e8
---[ end trace 8d36496943468a6f ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

Kernel Offset: disabled

- Matthew Whitehead
