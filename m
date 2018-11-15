Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD53C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD6521582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD6521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388418AbeKPAyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:54:21 -0500
Received: from 8bytes.org ([81.169.241.247]:44016 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387839AbeKPAyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:54:21 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 63A054A7; Thu, 15 Nov 2018 15:46:13 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, David1.Zhou@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] drm/amdgpu: Fix Kernel Oops triggered by kfdtest
Date:   Thu, 15 Nov 2018 15:46:12 +0100
Message-Id: <20181115144612.30301-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Running kfdtest on Kaveri triggers a kernel NULL-ptr dereference:

	BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
	PGD 42c017067 P4D 42c017067 PUD 40f071067 PMD 0
	Oops: 0010 [#1] SMP NOPTI
	CPU: 0 PID: 13107 Comm: kfdtest Not tainted 4.20.0-rc2+ #11
	Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./F2A88XM-HD3, BIOS F6 05/28/2014
	RIP: 0010:          (null)
	Code: Bad RIP value.
	RSP: 0018:ffffc90001adbbf0 EFLAGS: 00010202
	RAX: ffffffffa0806240 RBX: ffff88842a0fbc00 RCX: 0000000000000002
	RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffff888429690000
	RBP: ffffc90001adbbf8 R08: 0000000000002000 R09: ffff88842e542ec0
	R10: 00007feff778f008 R11: 00007feff778f010 R12: 0000000000000000
	R13: ffff88840f063a20 R14: ffff88842a0fbd20 R15: 000000000f43ff60
	FS:  00007feff7769740(0000) GS:ffff88842fa00000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: ffffffffffffffd6 CR3: 000000040f122000 CR4: 00000000000406f0
	Call Trace:
	 ? amdgpu_amdkfd_set_compute_idle+0x29/0x30 [amdgpu]
	 register_process+0x140/0x150 [amdgpu]
	 pqm_create_queue+0x395/0x560 [amdgpu]
	 kfd_ioctl_create_queue+0x285/0x680 [amdgpu]
	 kfd_ioctl+0x27f/0x450 [amdgpu]
	 ? kfd_ioctl_destroy_queue+0x80/0x80 [amdgpu]
	 do_vfs_ioctl+0x96/0x6a0
	 ? __audit_syscall_entry+0xdd/0x130
	 ? handle_mm_fault+0x11b/0x240
	 ksys_ioctl+0x67/0x90
	 __x64_sys_ioctl+0x1a/0x20
	 do_syscall_64+0x61/0x190
	 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The reason is that the pp_funcs->switch_power_profile
function pointer is not set for a Kaveri ASIC and thus the
kernel calls a NULL pointer.

Add a check before calling the function to avoid that.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
index f972cd156795..0ecedd30f2aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
@@ -337,8 +337,9 @@ enum amdgpu_pcie_gen {
 			(adev)->powerplay.pp_handle, request))
 
 #define amdgpu_dpm_switch_power_profile(adev, type, en) \
-		((adev)->powerplay.pp_funcs->switch_power_profile(\
-			(adev)->powerplay.pp_handle, type, en))
+		if ((adev)->powerplay.pp_funcs->switch_power_profile != NULL) \
+			((adev)->powerplay.pp_funcs->switch_power_profile(\
+				(adev)->powerplay.pp_handle, type, en))
 
 #define amdgpu_dpm_set_clockgating_by_smu(adev, msg_id) \
 		((adev)->powerplay.pp_funcs->set_clockgating_by_smu(\
-- 
2.13.7

