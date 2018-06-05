Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeFEOoE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:44:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35378 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752067AbeFEOoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:44:03 -0400
Date: Tue, 5 Jun 2018 16:44:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000010da43f
 last fence id 0x00000000010da52d on ring 0)
Message-ID: <20180605144404.GA7389@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

X just froze here ontop of 4.17-rc7+ tip/master (kernel is from last
week) with the splat at the end.

Box is a x470 chipset with Ryzen 2700X.

GPU gets detected as

[    7.440971] [drm] radeon kernel modesetting enabled.
[    7.441220] [drm] initializing kernel modesetting (RV635 0x1002:0x9598 0x1043:0x01DA 0x00).
[    7.441328] ATOM BIOS: 9598.10.88.0.3.AS05
[    7.441395] radeon 0000:1d:00.0: VRAM: 512M 0x0000000000000000 - 0x000000001FFFFFFF (512M used)
[    7.441464] radeon 0000:1d:00.0: GTT: 512M 0x0000000020000000 - 0x000000003FFFFFFF
[    7.441531] [drm] Detected VRAM RAM=512M, BAR=256M
[    7.441588] [drm] RAM width 128bits DDR
[    7.441690] [TTM] Zone  kernel: Available graphics memory: 16462214 kiB
[    7.441751] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    7.441811] [TTM] Initializing pool allocator
[    7.441868] [TTM] Initializing DMA pool allocator
[    7.441934] [drm] radeon: 512M of VRAM memory ready
[    7.441990] [drm] radeon: 512M of GTT memory ready.
[    7.442050] [drm] Loading RV635 Microcode
[    7.442865] [drm] Internal thermal controller without fan control
[    7.442940] [drm] radeon: power management initialized
[    7.443222] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    7.443487] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
[    7.477319] [drm] PCIE GART of 512M enabled (table at 0x0000000000142000).
[    7.477400] radeon 0000:1d:00.0: WB enabled
[    7.477455] radeon 0000:1d:00.0: fence driver on ring 0 use gpu addr 0x0000000020000c00 and cpu addr 0x        (ptrval)
[    7.477708] radeon 0000:1d:00.0: fence driver on ring 5 use gpu addr 0x00000000000521d0 and cpu addr 0x        (ptrval)
[    7.477778] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    7.477836] [drm] Driver supports precise vblank timestamp query.
[    7.477896] radeon 0000:1d:00.0: radeon: MSI limited to 32-bit
[    7.477990] radeon 0000:1d:00.0: radeon: using MSI.
[    7.478062] [drm] radeon: irq initialized.
[    7.509056] [drm] ring test on 0 succeeded in 0 usecs
[    7.683793] [drm] ring test on 5 succeeded in 1 usecs
[    7.683853] [drm] UVD initialized successfully.
[    7.684009] [drm] ib test on ring 0 succeeded in 0 usecs
[    8.348466] [drm] ib test on ring 5 succeeded
[    8.348921] [drm] Radeon Display Connectors
[    8.348978] [drm] Connector 0:
[    8.349031] [drm]   DVI-I-1
[    8.349082] [drm]   HPD1
[    8.349135] [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
[    8.349200] [drm]   Encoders:
[    8.349252] [drm]     DFP1: INTERNAL_UNIPHY
[    8.349308] [drm]     CRT2: INTERNAL_KLDSCP_DAC2
[    8.349364] [drm] Connector 1:
[    8.349416] [drm]   DIN-1
[    8.349467] [drm]   Encoders:
[    8.349520] [drm]     TV1: INTERNAL_KLDSCP_DAC2
[    8.349576] [drm] Connector 2:
[    8.349628] [drm]   DVI-I-2
[    8.349680] [drm]   HPD2
[    8.349732] [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
[    8.349797] [drm]   Encoders:
[    8.349849] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    8.349905] [drm]     DFP2: INTERNAL_KLDSCP_LVTMA
[    8.430521] [drm] fb mappable at 0xE0243000
[    8.430575] [drm] vram apper at 0xE0000000
[    8.431194] [drm] size 9216000
[    8.431245] [drm] fb depth is 24
[    8.431295] [drm]    pitch is 7680
[    8.431406] fbcon: radeondrmfb (fb0) is primary device
[    8.496928] Console: switching to colour frame buffer device 240x75
[    8.501851] radeon 0000:1d:00.0: fb0: radeondrmfb frame buffer device
[    8.520179] [drm] Initialized radeon 2.50.0 20080528 for 0000:1d:00.0 on minor 0

in the PCIe slot with two monitors connected to it. radeon firmware is

Version: 20170823-1

What practically happened is X froze and got restarted after the GPU
reset. It seems to be ok now, as I'm typing in it.

Thoughts?

[197439.022249] Restarting tasks ... done.
[197439.024043] PM: hibernation exit
[197439.058296] r8169 0000:18:00.0 eth0: link up
[200941.240184] perf: interrupt took too long (2507 > 2500), lowering kernel.perf_event_max_sample_rate to 79750
[221973.686894] radeon 0000:1d:00.0: ring 0 stalled for more than 10176msec
[221973.686900] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000010da43f last fence id 0x00000000010da52d on ring 0)
[221973.686929] radeon 0000:1d:00.0: failed to get a new IB (-35)
[221973.686950] [drm:radeon_cs_ioctl [radeon]] *ERROR* Failed to get ib !
[221973.693971] radeon 0000:1d:00.0: Saved 7609 dwords of commands on ring 0.
[221973.693985] radeon 0000:1d:00.0: GPU softreset: 0x00000008
[221973.693988] radeon 0000:1d:00.0:   R_008010_GRBM_STATUS      = 0xA0001030
[221973.693990] radeon 0000:1d:00.0:   R_008014_GRBM_STATUS2     = 0x00000003
[221973.693992] radeon 0000:1d:00.0:   R_000E50_SRBM_STATUS      = 0x200010C0
[221973.693994] radeon 0000:1d:00.0:   R_008674_CP_STALLED_STAT1 = 0x00000000
[221973.693996] radeon 0000:1d:00.0:   R_008678_CP_STALLED_STAT2 = 0x00000000
[221973.693998] radeon 0000:1d:00.0:   R_00867C_CP_BUSY_STAT     = 0x00000006
[221973.694000] radeon 0000:1d:00.0:   R_008680_CP_STAT          = 0x80000645
[221973.694002] radeon 0000:1d:00.0:   R_00D034_DMA_STATUS_REG   = 0x44C83D57
[221973.768483] radeon 0000:1d:00.0: R_008020_GRBM_SOFT_RESET=0x00004001
[221973.768541] radeon 0000:1d:00.0: SRBM_SOFT_RESET=0x00000100
[221973.770637] radeon 0000:1d:00.0:   R_008010_GRBM_STATUS      = 0xA0003030
[221973.770643] radeon 0000:1d:00.0:   R_008014_GRBM_STATUS2     = 0x00000003
[221973.770646] radeon 0000:1d:00.0:   R_000E50_SRBM_STATUS      = 0x200080C0
[221973.770648] radeon 0000:1d:00.0:   R_008674_CP_STALLED_STAT1 = 0x00000000
[221973.770650] radeon 0000:1d:00.0:   R_008678_CP_STALLED_STAT2 = 0x00000000
[221973.770652] radeon 0000:1d:00.0:   R_00867C_CP_BUSY_STAT     = 0x00000000
[221973.770654] radeon 0000:1d:00.0:   R_008680_CP_STAT          = 0x80100000
[221973.770656] radeon 0000:1d:00.0:   R_00D034_DMA_STATUS_REG   = 0x44C83D57
[221973.770664] radeon 0000:1d:00.0: GPU reset succeeded, trying to resume
[221973.786437] [drm] PCIE gen 2 link speeds already enabled
[221973.788725] [drm] PCIE GART of 512M enabled (table at 0x0000000000142000).
[221973.788745] radeon 0000:1d:00.0: WB enabled
[221973.788749] radeon 0000:1d:00.0: fence driver on ring 0 use gpu addr 0x0000000020000c00 and cpu addr 0x0000000063adc4ad
[221973.788936] radeon 0000:1d:00.0: fence driver on ring 5 use gpu addr 0x00000000000521d0 and cpu addr 0x0000000088b51197
[221973.819814] [drm] ring test on 0 succeeded in 0 usecs
[221973.994512] [drm] ring test on 5 succeeded in 1 usecs
[221973.994522] [drm] UVD initialized successfully.
[221984.438892] radeon 0000:1d:00.0: ring 0 stalled for more than 10448msec
[221984.438898] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000010da440 last fence id 0x00000000010da52d on ring 0)
[221984.450978] [drm:r600_ib_test [radeon]] *ERROR* radeon: fence wait failed (-35).
[221984.451011] [drm:radeon_ib_ring_tests [radeon]] *ERROR* radeon: failed testing IB on GFX ring (-35).

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
