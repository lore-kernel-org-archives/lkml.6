Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA34C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41466206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977274;
	bh=P8M6wB4WlKleFhzT9IrG46sydlMNmSd+4GYcpIwkz88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wn4swNsShgFN3gKUA3GrPp9N7ixbB8/f2/AFyHcXX7SXoAA9uMMx32SVu0APR+yxG
	 uy/MpIGGsaKJCmplcyFJf4EEBrC0Rj+SZ5LkpTSzi1bhGXh9uO3b/cSKpEywo67fQg
	 dUjNqe4YxqqE2WRFEN0EzZbEXki6hbHQS984FUpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732971AbfAHTyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:54:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730134AbfAHTam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6637D20645;
        Tue,  8 Jan 2019 19:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975841;
        bh=P8M6wB4WlKleFhzT9IrG46sydlMNmSd+4GYcpIwkz88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BfrkeY9XHWWTh4S4EuWYzqFMd0/Didl4VPjSShTjZ50dESGm7LsCezxDDGEm3V4eK
         XiowP34Ijfc72Or29cHFouRB2TC/SCQ4/VfT7CK+OI5uj7n833Pucu6c9incgk9034
         mTZNU08gQEU0/GwE+qkGNxVLIbulge+5VhFkL9io=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Alex Deucher <alexdeucher@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 30/97] drm/amdgpu: Reorder uvd ring init before uvd resume
Date:   Tue,  8 Jan 2019 14:28:39 -0500
Message-Id: <20190108192949.122407-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

[ Upstream commit 3b34c14fd50c302db091f020f26dd00ede902c80 ]

As amd_uvd_resume() accesses the uvd ring, it must be initialised first
or else we trigger errors like:

[    5.595963] [drm] Found UVD firmware Version: 1.87 Family ID: 17
[    5.595969] [drm] PSP loading UVD firmware
[    5.596266] ------------[ cut here ]------------
[    5.596268] ODEBUG: assert_init not available (active state 0) object type: timer_list hint:           (null)
[    5.596285] WARNING: CPU: 0 PID: 507 at lib/debugobjects.c:329 debug_print_object+0x6a/0x80
[    5.596286] Modules linked in: amdgpu(+) hid_logitech_hidpp(+) chash gpu_sched amd_iommu_v2 ttm drm_kms_helper crc32c_intel drm hid_sony ff_memless igb hid_logitech_dj nvme dca i2c_algo_bit nvme_core wmi pinctrl_amd uas usb_storage
[    5.596299] CPU: 0 PID: 507 Comm: systemd-udevd Tainted: G        W         4.20.0-0.rc1.git4.1.fc30.x86_64 #1
[    5.596301] Hardware name: System manufacturer System Product Name/ROG STRIX X470-I GAMING, BIOS 0901 07/23/2018
[    5.596303] RIP: 0010:debug_print_object+0x6a/0x80
[    5.596305] Code: 8b 43 10 83 c2 01 8b 4b 14 4c 89 e6 89 15 e6 82 b0 02 4c 8b 45 00 48 c7 c7 60 fd 34 a6 48 8b 14 c5 a0 da 08 a6 e8 6a 6a b8 ff <0f> 0b 5b 83 05 d0 45 3e 01 01 5d 41 5c c3 83 05 c5 45 3e 01 01 c3
[    5.596306] RSP: 0018:ffffa02ac863f8c0 EFLAGS: 00010282
[    5.596307] RAX: 0000000000000000 RBX: ffffa02ac863f8e0 RCX: 0000000000000006
[    5.596308] RDX: 0000000000000007 RSI: ffff9160e9a7bfe8 RDI: ffff9160f91d6c60
[    5.596310] RBP: ffffffffa6742740 R08: 0000000000000002 R09: 0000000000000000
[    5.596311] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffa634ff69
[    5.596312] R13: 00000000000b79d0 R14: ffffffffa80f76d8 R15: 0000000000266000
[    5.596313] FS:  00007f762abf7940(0000) GS:ffff9160f9000000(0000) knlGS:0000000000000000
[    5.596314] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.596315] CR2: 000055fdc593f000 CR3: 00000007e999c000 CR4: 00000000003406f0
[    5.596317] Call Trace:
[    5.596321]  debug_object_assert_init+0x14a/0x180
[    5.596327]  del_timer+0x2e/0x90
[    5.596383]  amdgpu_fence_process+0x47/0x100 [amdgpu]
[    5.596430]  amdgpu_uvd_resume+0xf6/0x120 [amdgpu]
[    5.596475]  uvd_v7_0_sw_init+0xe0/0x280 [amdgpu]
[    5.596523]  amdgpu_device_init.cold.30+0xf97/0x14b6 [amdgpu]
[    5.596563]  ? amdgpu_driver_load_kms+0x53/0x330 [amdgpu]
[    5.596604]  amdgpu_driver_load_kms+0x86/0x330 [amdgpu]
[    5.596614]  drm_dev_register+0x115/0x150 [drm]
[    5.596654]  amdgpu_pci_probe+0xbd/0x120 [amdgpu]
[    5.596658]  local_pci_probe+0x41/0x90
[    5.596661]  pci_device_probe+0x188/0x1a0
[    5.596666]  really_probe+0xf8/0x3b0
[    5.596669]  driver_probe_device+0xb3/0xf0
[    5.596672]  __driver_attach+0xe1/0x110
[    5.596674]  ? driver_probe_device+0xf0/0xf0
[    5.596676]  bus_for_each_dev+0x79/0xc0
[    5.596679]  bus_add_driver+0x155/0x230
[    5.596681]  ? 0xffffffffc07d9000
[    5.596683]  driver_register+0x6b/0xb0
[    5.596685]  ? 0xffffffffc07d9000
[    5.596688]  do_one_initcall+0x5d/0x2be
[    5.596691]  ? rcu_read_lock_sched_held+0x79/0x80
[    5.596693]  ? kmem_cache_alloc_trace+0x264/0x290
[    5.596695]  ? do_init_module+0x22/0x210
[    5.596698]  do_init_module+0x5a/0x210
[    5.596701]  load_module+0x2137/0x2430
[    5.596703]  ? lockdep_hardirqs_on+0xed/0x180
[    5.596714]  ? __do_sys_init_module+0x150/0x1a0
[    5.596715]  __do_sys_init_module+0x150/0x1a0
[    5.596722]  do_syscall_64+0x60/0x1f0
[    5.596725]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[    5.596726] RIP: 0033:0x7f762b877dee
[    5.596728] Code: 48 8b 0d 9d 20 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6a 20 0c 00 f7 d8 64 89 01 48
[    5.596729] RSP: 002b:00007ffc777b8558 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
[    5.596730] RAX: ffffffffffffffda RBX: 000055fdc48da320 RCX: 00007f762b877dee
[    5.596731] RDX: 00007f762b9f284d RSI: 00000000006c5fc6 RDI: 000055fdc527a060
[    5.596732] RBP: 00007f762b9f284d R08: 0000000000000003 R09: 0000000000000002
[    5.596733] R10: 000055fdc48ad010 R11: 0000000000000246 R12: 000055fdc527a060
[    5.596734] R13: 000055fdc48dca20 R14: 0000000000020000 R15: 0000000000000000
[    5.596740] irq event stamp: 134618
[    5.596743] hardirqs last  enabled at (134617): [<ffffffffa513d52e>] console_unlock+0x45e/0x610
[    5.596744] hardirqs last disabled at (134618): [<ffffffffa50037e8>] trace_hardirqs_off_thunk+0x1a/0x1c
[    5.596746] softirqs last  enabled at (133146): [<ffffffffa5e00365>] __do_softirq+0x365/0x47c
[    5.596748] softirqs last disabled at (133139): [<ffffffffa50c64f9>] irq_exit+0x119/0x120
[    5.596749] ---[ end trace eaee508abfebccdc ]---

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=108709
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Alex Deucher <alexdeucher@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 8 ++++----
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 8a926d1df939..2b4199adcd94 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -116,16 +116,16 @@ static int uvd_v4_2_sw_init(void *handle)
 	if (r)
 		return r;
 
-	r = amdgpu_uvd_resume(adev);
-	if (r)
-		return r;
-
 	ring = &adev->uvd.inst->ring;
 	sprintf(ring->name, "uvd");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0);
 	if (r)
 		return r;
 
+	r = amdgpu_uvd_resume(adev);
+	if (r)
+		return r;
+
 	r = amdgpu_uvd_entity_init(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 50248059412e..88c006c5ee2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -113,16 +113,16 @@ static int uvd_v5_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	r = amdgpu_uvd_resume(adev);
-	if (r)
-		return r;
-
 	ring = &adev->uvd.inst->ring;
 	sprintf(ring->name, "uvd");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0);
 	if (r)
 		return r;
 
+	r = amdgpu_uvd_resume(adev);
+	if (r)
+		return r;
+
 	r = amdgpu_uvd_entity_init(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 6ae82cc2e55e..d4070839ac80 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -420,16 +420,16 @@ static int uvd_v6_0_sw_init(void *handle)
 		DRM_INFO("UVD ENC is disabled\n");
 	}
 
-	r = amdgpu_uvd_resume(adev);
-	if (r)
-		return r;
-
 	ring = &adev->uvd.inst->ring;
 	sprintf(ring->name, "uvd");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0);
 	if (r)
 		return r;
 
+	r = amdgpu_uvd_resume(adev);
+	if (r)
+		return r;
+
 	if (uvd_v6_0_enc_support(adev)) {
 		for (i = 0; i < adev->uvd.num_enc_rings; ++i) {
 			ring = &adev->uvd.inst->ring_enc[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 9b7f8469bc5c..057151b17b45 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -444,10 +444,6 @@ static int uvd_v7_0_sw_init(void *handle)
 		DRM_INFO("PSP loading UVD firmware\n");
 	}
 
-	r = amdgpu_uvd_resume(adev);
-	if (r)
-		return r;
-
 	for (j = 0; j < adev->uvd.num_uvd_inst; j++) {
 		if (adev->uvd.harvest_config & (1 << j))
 			continue;
@@ -479,6 +475,10 @@ static int uvd_v7_0_sw_init(void *handle)
 		}
 	}
 
+	r = amdgpu_uvd_resume(adev);
+	if (r)
+		return r;
+
 	r = amdgpu_uvd_entity_init(adev);
 	if (r)
 		return r;
-- 
2.19.1

