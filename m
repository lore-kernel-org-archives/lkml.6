Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967076AbeCAJkQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:40:16 -0500
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:39819 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966871AbeCAJkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:40:13 -0500
Date: Thu, 1 Mar 2018 11:40:08 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: UBSAN warning in nouveau_bios.c:1528:8
Message-ID: <alpine.LRH.2.21.1803011136510.6139@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first time I have tried UBSAN on this specific machine 
(onboard nforce 420 with HP BIOS on Nance mainboard). nouveau seems to 
be working fine but gives this UBSAN warning:

[    7.953957] nouveau 0000:00:0d.0: NVIDIA C61 (04c000a2)
[    7.965101] nouveau 0000:00:0d.0: bios: version 05.61.32.25.02
[    7.966141] nouveau 0000:00:0d.0: fb: 128 MiB of unknown memory type
[    8.015336] [TTM] Zone  kernel: Available graphics memory: 952564 kiB
[    8.015339] [TTM] Initializing pool allocator
[    8.015344] [TTM] Initializing DMA pool allocator
[    8.015370] nouveau 0000:00:0d.0: DRM: VRAM: 125 MiB
[    8.015372] nouveau 0000:00:0d.0: DRM: GART: 512 MiB
[    8.015377] nouveau 0000:00:0d.0: DRM: TMDS table version 1.1
[    8.015379] nouveau 0000:00:0d.0: DRM: DCB version 3.0
[    8.015382] nouveau 0000:00:0d.0: DRM: DCB outp 00: 01000310 00000023
[    8.015385] nouveau 0000:00:0d.0: DRM: DCB outp 01: 00110204 98830003
[    8.015386] ================================================================================
[    8.015423] UBSAN: Undefined behaviour in drivers/gpu/drm/nouveau/nouveau_bios.c:1528:8
[    8.015455] shift exponent -1 is negative
[    8.015482] CPU: 1 PID: 148 Comm: systemd-udevd Not tainted 4.16.0-rc3-00167-g97ace515f014 #1
[    8.015483] Hardware name: HP-Pavilion RT589AA-ABU t3709.uk/Nance, BIOS 5.02 11/26/2006
[    8.015485] Call Trace:
[    8.015496]  dump_stack+0x5a/0x99
[    8.015500]  ubsan_epilogue+0x9/0x40
[    8.015503]  __ubsan_handle_shift_out_of_bounds+0x124/0x160
[    8.015506]  ? _dev_info+0x67/0x90
[    8.015509]  ? dev_printk_emit+0x49/0x70
[    8.015632]  parse_dcb_entry+0x91e/0xd90 [nouveau]
[    8.015712]  ? parse_bit_M_tbl_entry+0x150/0x150 [nouveau]
[    8.015791]  olddcb_outp_foreach+0x66/0xa0 [nouveau]
[    8.015870]  nouveau_bios_init+0x23a/0x2250 [nouveau]
[    8.015950]  ? nouveau_ttm_init+0x3a4/0x710 [nouveau]
[    8.016029]  nouveau_drm_load+0x229/0xf10 [nouveau]
[    8.016033]  ? sysfs_do_create_link_sd+0xa6/0x170
[    8.016067]  drm_dev_register+0x1b7/0x330 [drm]
[    8.016070]  ? pci_enable_device_flags+0x160/0x1f0
[    8.016091]  drm_get_pci_dev+0xee/0x2e0 [drm]
[    8.016172]  nouveau_drm_probe+0x1dd/0x270 [nouveau]
[    8.016175]  pci_device_probe+0x113/0x1d0
[    8.016178]  driver_probe_device+0x375/0x720
[    8.016180]  __driver_attach+0xeb/0x150
[    8.016181]  ? driver_probe_device+0x720/0x720
[    8.016183]  bus_for_each_dev+0x84/0xe0
[    8.016186]  bus_add_driver+0x19f/0x340
[    8.016188]  driver_register+0x67/0x110
[    8.016190]  ? 0xffffffffc0cfb000
[    8.016193]  do_one_initcall+0x66/0x210
[    8.016197]  do_init_module+0xa7/0x2a9
[    8.016199]  load_module+0x2548/0x3d30
[    8.016202]  ? __symbol_put+0x60/0x60
[    8.016205]  ? kernel_read_file+0x21b/0x390
[    8.016208]  ? kernel_read_file_from_fd+0x52/0x90
[    8.016210]  SYSC_finit_module+0x124/0x150
[    8.016212]  do_syscall_64+0x7a/0x1f0
[    8.016214]  ? page_fault+0x2f/0x50
[    8.016217]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[    8.016219] RIP: 0033:0x7f2e47b82e19
[    8.016220] RSP: 002b:00007ffdcdc157b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    8.016223] RAX: ffffffffffffffda RBX: 00005638b23c7250 RCX: 00007f2e47b82e19
[    8.016224] RDX: 0000000000000000 RSI: 00007f2e4788d0ed RDI: 0000000000000019
[    8.016225] RBP: 00007f2e4788d0ed R08: 0000000000000000 R09: 0000000000000000
[    8.016226] R10: 0000000000000019 R11: 0000000000000246 R12: 0000000000000000
[    8.016227] R13: 00005638b23c2ce0 R14: 0000000000020000 R15: 00005638b23c7250
[    8.016228] ================================================================================
[    8.016299] nouveau 0000:00:0d.0: DRM: DCB conn 00: 0000
[    8.016301] nouveau 0000:00:0d.0: DRM: DCB conn 01: 1131
[    8.016302] nouveau 0000:00:0d.0: DRM: DCB conn 02: 0110
[    8.016304] nouveau 0000:00:0d.0: DRM: DCB conn 03: 0111
[    8.016305] nouveau 0000:00:0d.0: DRM: DCB conn 04: 0113
[    8.016626] nouveau 0000:00:0d.0: DRM: Saving VGA fonts
[    8.052781] nouveau 0000:00:0d.0: DRM: DCB type 4 not known
[    8.052784] nouveau 0000:00:0d.0: DRM: Unknown-1 has no encoders, removing
[    8.053728] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    8.053729] [drm] Driver supports precise vblank timestamp query.
[    8.055836] nouveau 0000:00:0d.0: DRM: MM: using M2MF for buffer copies
[    8.084488] nouveau 0000:00:0d.0: DRM: allocated 1280x1024 fb: 0x9000, bo 0000000050f4b5d0
[    8.084678] fbcon: nouveaufb (fb0) is primary device
[    8.193959] Console: switching to colour frame buffer device 160x64
[    8.195378] nouveau 0000:00:0d.0: fb0: nouveaufb frame buffer device
[    8.212083] [drm] Initialized nouveau 1.3.1 20120801 for 0000:00:0d.0 on minor 0

-- 
Meelis Roos (mroos@linux.ee)
