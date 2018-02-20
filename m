Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932506AbeBTDve (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 22:51:34 -0500
Received: from simcoe209srvr.owm.bell.net ([184.150.200.209]:50745 "EHLO
        torfep10.bell.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932391AbeBTDvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 22:51:32 -0500
Message-ID: <1519098356.2973.7.camel@sympatico.ca>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
From: "David H. Gutteridge" <dhgutteridge@sympatico.ca>
To: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Feb 2018 22:45:56 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cloudmark-Analysis: v=2.2 cv=T8Zjd7CQ c=1 sm=0 tr=0 a=L8/W01PiBGW18o/lVCsRRA==:17 a=IkcTkHD0fZMA:10 a=Op4juWPpsa0A:10 a=lViJMyulAAAA:8 a=n96pIJ16R4xGhL1GV5oA:9 a=m4bISJQEKB-rVmCD:21 a=5DH2w0gy6Ro587V6:21 a=QEXdDO2ut3YA:10 a=IKcPO0ljxDkA:10 a=gb9IC-u5QvZuJU0a8fSk:22
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/18 10:25, Joerg Roedel wrote:
> Hi,
> 
> here is the second version of my PTI implementation for
> x86_32, based on tip/x86-pti-for-linus. It took a lot longer
> than I had hoped, but there have been a number of obstacles
> on the way. It also isn't the small patch-set anymore that v1
> was, but compared to it this one actually works :)
[...]
>I do not claim that I've found the best solution for every
>problem I encountered, so please review and give me feedback
>on what I should change or solve differently. Of course I am
>also interested in all bugs that may still be in there.
>
>Thanks a lot,
>
>       Joerg

Hello,

I thought I'd try my hand at testing this patch set from an end user's
perspective. I built a test kernel based on Fedora's
config-4.15.2-300.fc27.i686+PAE, the only change obviously being the
addition of CONFIG_PAGE_TABLE_ISOLATION=y. I ran this kernel in two
test environments: an LG X110 netbook, which has an Atom N270 with 1GB
of RAM (booted with "pti=on"), and a QEMU VM emulating a quad Core i7
Nehalem setup. (The X110 is the only i686 hardware I had on hand I
could practically use. I figured it'd be a suitable low-end hardware
spec to work with, even though no one realistically would force-enable
PTI on it.)

Testing consisted in part of using the laptop's Mate session to
remotely render the VM's Xfce session, while both had PTI enabled on
their test kernels. The VM also successfully ran the basic kernel
tests and the performance test suite that Fedora provides for
community testing (https://pagure.io/kernel-tests.git). (Well, it had
a hiccup with the performance testing, but that's apparently unrelated
to the PTI patches.) The laptop was also used for various everyday
activities, like web browsing using Firefox, and document editing
using LibreOffice Writer. (It obviously isn't a star at this, but it
was usable.)

General results:

X110: no issues whatsoever. (I was actually expecting more of a
noticable performance hit in some aspects.)

QEMU VM: I encountered two similar issues:

(1) There is a regression when the QXL display driver is enabled; the
VM hangs during boot. (QXL has been a source of similar trouble in the
past.) I don't have an example trace for it at present.

(2) There is a regression when the VGA display driver is enabled; it
intermittently (but reproducibly) faults, which makes it impossible
to boot to the graphical login manager.

[   25.430588] [drm] Found bochs VGA, ID 0xb0c0.
[   25.431212] [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @
0xfebd4000.
[   25.432586] [TTM] Zone  kernel: Available graphics memory: 426476 kiB
[   25.433099] [TTM] Zone highmem: Available graphics memory: 1549744
kiB
[   25.433890] [TTM] Initializing pool allocator
[   25.434863] [TTM] Initializing DMA pool allocator
[   25.436767] ------------[ cut here ]------------
[   25.439213] kernel BUG at arch/x86/mm/fault.c:268!
[   25.439218] invalid opcode: 0000 [#1] SMP PTI
[   25.439218] Modules linked in: bochs_drm(+) ttm snd_hda_core
drm_kms_helper snd_hwdep drm snd_seq snd_seq_device snd_pcm snd_timer
snd pcspkr virtio_balloon i2c_piix4 soundcore virtio_console 8139too
crc32c_intel virtio_pci virtio_ring serio_raw virtio 8139cp ata_generic
mii pata_acpi floppy qemu_fw_cfg
[   25.439236] CPU: 1 PID: 545 Comm: systemd-udevd Tainted:
G        W        4.15.0+ #1
[   25.439237] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[   25.439241] EIP: vmalloc_fault+0x1e7/0x210
[   25.439242] EFLAGS: 00010083 CPU: 1
[   25.439243] EAX: 02788000 EBX: d78ecdf8 ECX: 00000080 EDX: 00000000
[   25.439244] ESI: 000fd000 EDI: fd0000f3 EBP: f3f639a0 ESP: f3f63988
[   25.439245]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   25.439246] CR0: 80050033 CR2: f7e00000 CR3: 33e3a000 CR4: 000006f0
[   25.439249] Call Trace:
[   25.439254]  ? kvm_async_pf_task_wake+0x100/0x100
[   25.439256]  __do_page_fault+0x34d/0x4d0
[   25.439257]  ? __ioremap_caller+0x23a/0x3d0
[   25.439259]  ? kvm_async_pf_task_wake+0x100/0x100
[   25.439260]  do_page_fault+0x27/0xe0
[   25.439261]  ? kvm_async_pf_task_wake+0x100/0x100
[   25.439263]  do_async_page_fault+0x55/0x80
[   25.439265]  common_exception+0xef/0xf6
[   25.439268] EIP: memset+0xb/0x20
[   25.439268] EFLAGS: 00010206 CPU: 1
[   25.439269] EAX: 00000000 EBX: f7e00000 ECX: 00300000 EDX: 00000000
[   25.439270] ESI: f3f63b5c EDI: f7e00000 EBP: f3f63a58 ESP: f3f63a50
[   25.439271]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   25.439278]  ttm_bo_move_memcpy+0x47c/0x4a0 [ttm]
[   25.439283]  ttm_bo_handle_move_mem+0x55a/0x580 [ttm]
[   25.439286]  ? ttm_bo_mem_space+0x394/0x460 [ttm]
[   25.439290]  ttm_bo_validate+0x116/0x130 [ttm]
[   25.439294]  bochs_bo_pin+0xa1/0x170 [bochs_drm]
[   25.439297]  bochsfb_create+0xce/0x310 [bochs_drm]
[   25.439308]  __drm_fb_helper_initial_config_and_unlock+0x1cc/0x460
[drm_kms_helper]
[   25.439314]  drm_fb_helper_initial_config+0x35/0x40 [drm_kms_helper]
[   25.439317]  bochs_fbdev_init+0x74/0x80 [bochs_drm]
[   25.439319]  bochs_load+0x7a/0x90 [bochs_drm]
[   25.439333]  drm_dev_register+0x133/0x1b0 [drm]
[   25.439343]  drm_get_pci_dev+0x86/0x160 [drm]
[   25.439346]  bochs_pci_probe+0xcb/0x110 [bochs_drm]
[   25.439348]  ? bochs_load+0x90/0x90 [bochs_drm]
[   25.439351]  pci_device_probe+0xc7/0x160
[   25.439353]  driver_probe_device+0x2dc/0x460
[   25.439354]  __driver_attach+0x99/0xe0
[   25.439356]  ? driver_probe_device+0x460/0x460
[   25.439357]  bus_for_each_dev+0x5a/0xa0
[   25.439359]  driver_attach+0x19/0x20
[   25.439360]  ? driver_probe_device+0x460/0x460
[   25.439362]  bus_add_driver+0x187/0x230
[   25.439363]  ? 0xf7afa000
[   25.439364]  driver_register+0x56/0xd0
[   25.439365]  ? 0xf7afa000
[   25.439367]  __pci_register_driver+0x3a/0x40
[   25.439369]  bochs_init+0x41/0x1000 [bochs_drm]
[   25.439371]  do_one_initcall+0x49/0x170
[   25.439373]  ? _cond_resched+0x2a/0x40
[   25.439375]  ? kmem_cache_alloc_trace+0x175/0x1e0
[   25.439376]  ? do_init_module+0x21/0x1dc
[   25.439378]  ? do_init_module+0x21/0x1dc
[   25.439379]  do_init_module+0x50/0x1dc
[   25.439380]  load_module+0x1fce/0x28e0
[   25.439383]  SyS_finit_module+0x8a/0xe0
[   25.439385]  do_fast_syscall_32+0x81/0x1b0
[   25.439518]  entry_SYSENTER_32+0x5f/0xb9
[   25.439519] EIP: 0xb7f21cf9
[   25.439520] EFLAGS: 00000246 CPU: 1
[   25.439521] EAX: ffffffda EBX: 00000011 ECX: b7afae75 EDX: 00000000
[   25.439522] ESI: 019d5740 EDI: 019acc00 EBP: 019ade00 ESP: bff9bb4c
[   25.439524]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[   25.439525] Code: e2 00 f0 1f 00 81 ea 00 00 20 00 21 d0 8b 55 e8 89
c6 81 e2 ff 0f 00 00 0f ac d6 0c 8d 04 b6 c1 e0 03 39 45 ec 0f 84 27 ff
ff ff <0f> 0b 8d b4 26 00 00 00 00 83 c4 0c ba ff ff ff ff 5b 89 d0 5e
[   25.439547] EIP: vmalloc_fault+0x1e7/0x210 SS:ESP: 0068:f3f63988
[   25.439548] ---[ end trace 18f2d11043a28ec0 ]---

The Virtio and VMVGA display drivers both worked consistently for me.

I haven't tested a non-PAE kernel, but can do so if it's of interest.
Or I can provide further details or testing if need be. If so, please
CC me. I hope this is of some use.

Regards,

Dave
