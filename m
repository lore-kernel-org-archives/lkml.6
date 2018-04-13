Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeDMQQI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:16:08 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:39957 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbeDMQQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:16:07 -0400
X-Google-Smtp-Source: AIpwx4+Rn87vYqgevEUX4uoEb4t6+zLGS5Vy0/bCwVCCrv7hoNZUTePlHvFb8/T/hC7kf0pthob2DA==
From: Daniel Kurtz <djkurtz@chromium.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Jason Clinton <jclinton@chromium.org>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/amdgpu/acp: Fix slab-out-of-bounds in mfd_add_device in acp_hw_init
Date: Fri, 13 Apr 2018 10:15:59 -0600
Message-Id: <20180413161601.109431-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 51f7415039d4 ("drm/amd/amdgpu: creating two I2S instances for
stoney/cz") added support for the "BT_I2S" ACP i2s channel.  As part of
this change, one additional acp resource was added, but the "num_resource"
count was accidentally incremented by 2.

This incorrect count eventually causes mfd_add_device() to try to access
an invalid memory address (the location of non-existent resource 5.

This fault was detected by running a KASAN enabled kernel, which produced
the following splat at boot:

[    6.612987] ==================================================================
[    6.613509] BUG: KASAN: slab-out-of-bounds in mfd_add_device+0x4bc/0x7a7
[    6.613509] Read of size 8 at addr ffff880107d4dc58 by task swapper/0/1
[    6.613509]
[    6.613509] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.33 #349
[    6.613509] Hardware name: Google Grunt/Grunt, BIOS Google_Grunt.10543.0.2018_04_03_1812 04/02/2018
[    6.613509] Call Trace:
[    6.613509]  dump_stack+0x4d/0x63
[    6.613509]  print_address_description+0x80/0x2d6
[    6.613509]  ? mfd_add_device+0x4bc/0x7a7
[    6.613509]  kasan_report+0x255/0x295
[    6.613509]  mfd_add_device+0x4bc/0x7a7
[    6.613509]  ? kasan_kmalloc+0x99/0xa8
[    6.613509]  ? mfd_add_devices+0x58/0xe4
[    6.613509]  ? __kmalloc+0x154/0x178
[    6.613509]  mfd_add_devices+0xa5/0xe4
[    6.613509]  acp_hw_init+0x92e/0xc4a
[    6.613509]  amdgpu_device_init+0x1dfb/0x22a2
[    6.613509]  ? kmalloc_order+0x53/0x5d
[    6.613509]  ? kmalloc_order_trace+0x23/0xb3
[    6.613509]  amdgpu_driver_load_kms+0xce/0x267
[    6.613509]  drm_dev_register+0x169/0x2fb
[    6.613509]  amdgpu_pci_probe+0x217/0x242
[    6.613509]  pci_device_probe+0x101/0x18e
[    6.613509]  driver_probe_device+0x1dd/0x419
[    6.613509]  ? ___might_sleep+0x80/0x1b6
[    6.613509]  __driver_attach+0x9f/0xc9
[    6.613509]  ? driver_probe_device+0x419/0x419
[    6.613509]  bus_for_each_dev+0xbc/0xe1
[    6.613509]  bus_add_driver+0x189/0x2c0
[    6.613509]  driver_register+0x108/0x156
[    6.613509]  ? ttm_init+0x67/0x67
[    6.613509]  do_one_initcall+0xb2/0x161
[    6.613509]  kernel_init_freeable+0x25a/0x308
[    6.613509]  ? rest_init+0xcc/0xcc
[    6.613509]  kernel_init+0x11/0x10d
[    6.613509]  ? rest_init+0xcc/0xcc
[    6.613509]  ret_from_fork+0x22/0x40
[    6.613509]
[    6.613509] Allocated by task 1:
[    6.613509]  save_stack+0x46/0xce
[    6.613509]  kasan_kmalloc+0x99/0xa8
[    6.613509]  kmem_cache_alloc_trace+0x11a/0x13e
[    6.613509]  acp_hw_init+0x210/0xc4a
[    6.613509]  amdgpu_device_init+0x1dfb/0x22a2
[    6.613509]  amdgpu_driver_load_kms+0xce/0x267
[    6.613509]  drm_dev_register+0x169/0x2fb
[    6.613509]  amdgpu_pci_probe+0x217/0x242
[    6.613509]  pci_device_probe+0x101/0x18e
[    6.613509]  driver_probe_device+0x1dd/0x419
[    6.613509]  __driver_attach+0x9f/0xc9
[    6.613509]  bus_for_each_dev+0xbc/0xe1
[    6.613509]  bus_add_driver+0x189/0x2c0
[    6.613509]  driver_register+0x108/0x156
[    6.613509]  do_one_initcall+0xb2/0x161
[    6.613509]  kernel_init_freeable+0x25a/0x308
[    6.613509]  kernel_init+0x11/0x10d
[    6.613509]  ret_from_fork+0x22/0x40
[    6.613509]
[    6.613509] Freed by task 0:
[    6.613509] (stack is not available)
[    6.613509]
[    6.613509] The buggy address belongs to the object at ffff880107d4db08
[    6.613509]  which belongs to the cache kmalloc-512 of size 512
[    6.613509] The buggy address is located 336 bytes inside of
[    6.613509]  512-byte region [ffff880107d4db08, ffff880107d4dd08)
[    6.613509] The buggy address belongs to the page:
[    6.613509] page:ffffea00041f5300 count:1 mapcount:0 mapping:          (null) index:0x0 compound_mapcount: 0
[    6.613509] flags: 0x8000000000008100(slab|head)
[    6.613509] raw: 8000000000008100 0000000000000000 0000000000000000 0000000100120012
[    6.613509] raw: ffffea0004208520 ffff88010b001680 ffff88010b002cc0 0000000000000000
[    6.613509] page dumped because: kasan: bad access detected
[    6.613509]
[    6.613509] Memory state around the buggy address:
[    6.613509]  ffff880107d4db00: fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    6.613509]  ffff880107d4db80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    6.613509] >ffff880107d4dc00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
[    6.613509]                                                     ^
[    6.613509]  ffff880107d4dc80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    6.613509]  ffff880107d4dd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    6.613509] ==================================================================

Fixes: 51f7415039d4 ("drm/amd/amdgpu: creating two I2S instances for stoney/cz")
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 20f20079935b..42f0d60cf3f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -402,7 +402,7 @@ static int acp_hw_init(void *handle)
 	adev->acp.acp_res[4].end = adev->acp.acp_res[4].start;
 
 	adev->acp.acp_cell[0].name = "acp_audio_dma";
-	adev->acp.acp_cell[0].num_resources = 6;
+	adev->acp.acp_cell[0].num_resources = 5;
 	adev->acp.acp_cell[0].resources = &adev->acp.acp_res[0];
 	adev->acp.acp_cell[0].platform_data = &adev->asic_type;
 	adev->acp.acp_cell[0].pdata_size = sizeof(adev->asic_type);
-- 
2.17.0.484.g0c8726318c-goog
