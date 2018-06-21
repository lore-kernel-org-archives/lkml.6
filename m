Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5635CC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD0921C3B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD0921C3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933382AbeFUUsh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:48:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933134AbeFUUsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:48:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB7C681A4EA6;
        Thu, 21 Jun 2018 20:48:35 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62D7F21AF0D6;
        Thu, 21 Jun 2018 20:48:34 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        Shirish S <shirish.s@amd.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Count disabled CRTCs in commit tail earlier
Date:   Thu, 21 Jun 2018 16:48:26 -0400
Message-Id: <20180621204832.22448-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 21 Jun 2018 20:48:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 21 Jun 2018 20:48:35 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a regression I accidentally reduced that was picked up by
kasan, where we were checking the CRTC atomic states after DRM's helpers
had already freed them. Example:

==================================================================
BUG: KASAN: use-after-free in amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
Read of size 1 at addr ffff8803a697b071 by task kworker/u16:0/7

CPU: 7 PID: 7 Comm: kworker/u16:0 Tainted: G           O      4.18.0-rc1Lyude-Upstream+ #1
Hardware name: HP HP ZBook 15 G4/8275, BIOS P70 Ver. 01.21 05/02/2018
Workqueue: events_unbound commit_work [drm_kms_helper]
Call Trace:
 dump_stack+0xc1/0x169
 ? dump_stack_print_info.cold.1+0x42/0x42
 ? kmsg_dump_rewind_nolock+0xd9/0xd9
 ? printk+0x9f/0xc5
 ? amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
 print_address_description+0x6c/0x23c
 ? amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
 kasan_report.cold.6+0x241/0x2fd
 amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
 ? commit_planes_to_stream.constprop.45+0x13b0/0x13b0 [amdgpu]
 ? cpu_load_update_active+0x290/0x290
 ? finish_task_switch+0x2bd/0x840
 ? __switch_to_asm+0x34/0x70
 ? read_word_at_a_time+0xe/0x20
 ? strscpy+0x14b/0x460
 ? drm_atomic_helper_wait_for_dependencies+0x47d/0x7e0 [drm_kms_helper]
 commit_tail+0x96/0xe0 [drm_kms_helper]
 process_one_work+0x88a/0x1360
 ? create_worker+0x540/0x540
 ? __sched_text_start+0x8/0x8
 ? move_queued_task+0x760/0x760
 ? call_rcu_sched+0x20/0x20
 ? vsnprintf+0xcda/0x1350
 ? wait_woken+0x1c0/0x1c0
 ? mutex_unlock+0x1d/0x40
 ? init_timer_key+0x190/0x230
 ? schedule+0xea/0x390
 ? __schedule+0x1ea0/0x1ea0
 ? need_to_create_worker+0xe4/0x210
 ? init_worker_pool+0x700/0x700
 ? try_to_del_timer_sync+0xbf/0x110
 ? del_timer+0x120/0x120
 ? __mutex_lock_slowpath+0x10/0x10
 worker_thread+0x196/0x11f0
 ? flush_rcu_work+0x50/0x50
 ? __switch_to_asm+0x34/0x70
 ? __switch_to_asm+0x34/0x70
 ? __switch_to_asm+0x40/0x70
 ? __switch_to_asm+0x34/0x70
 ? __switch_to_asm+0x40/0x70
 ? __switch_to_asm+0x34/0x70
 ? __switch_to_asm+0x40/0x70
 ? __schedule+0x7d6/0x1ea0
 ? migrate_swap_stop+0x850/0x880
 ? __sched_text_start+0x8/0x8
 ? save_stack+0x8c/0xb0
 ? kasan_kmalloc+0xbf/0xe0
 ? kmem_cache_alloc_trace+0xe4/0x190
 ? kthread+0x98/0x390
 ? ret_from_fork+0x35/0x40
 ? ret_from_fork+0x35/0x40
 ? deactivate_slab.isra.67+0x3c4/0x5c0
 ? kthread+0x98/0x390
 ? kthread+0x98/0x390
 ? set_track+0x76/0x120
 ? schedule+0xea/0x390
 ? __schedule+0x1ea0/0x1ea0
 ? wait_woken+0x1c0/0x1c0
 ? kasan_unpoison_shadow+0x30/0x40
 ? parse_args.cold.15+0x17a/0x17a
 ? flush_rcu_work+0x50/0x50
 kthread+0x2d4/0x390
 ? kthread_create_worker_on_cpu+0xc0/0xc0
 ret_from_fork+0x35/0x40

Allocated by task 1124:
 kasan_kmalloc+0xbf/0xe0
 kmem_cache_alloc_trace+0xe4/0x190
 dm_crtc_duplicate_state+0x78/0x130 [amdgpu]
 drm_atomic_get_crtc_state+0x147/0x410 [drm]
 page_flip_common+0x57/0x230 [drm_kms_helper]
 drm_atomic_helper_page_flip+0xa6/0x110 [drm_kms_helper]
 drm_mode_page_flip_ioctl+0xc4b/0x10a0 [drm]
 drm_ioctl_kernel+0x1d4/0x260 [drm]
 drm_ioctl+0x433/0x920 [drm]
 amdgpu_drm_ioctl+0x11d/0x290 [amdgpu]
 do_vfs_ioctl+0x1a1/0x13d0
 ksys_ioctl+0x60/0x90
 __x64_sys_ioctl+0x6f/0xb0
 do_syscall_64+0x147/0x440
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 1124:
 __kasan_slab_free+0x12e/0x180
 kfree+0x92/0x1a0
 drm_atomic_state_default_clear+0x315/0xc40 [drm]
 __drm_atomic_state_free+0x35/0xd0 [drm]
 drm_atomic_helper_update_plane+0xac/0x350 [drm_kms_helper]
 __setplane_internal+0x2d6/0x840 [drm]
 drm_mode_cursor_universal+0x41e/0xbe0 [drm]
 drm_mode_cursor_common+0x49f/0x880 [drm]
 drm_mode_cursor_ioctl+0xd8/0x130 [drm]
 drm_ioctl_kernel+0x1d4/0x260 [drm]
 drm_ioctl+0x433/0x920 [drm]
 amdgpu_drm_ioctl+0x11d/0x290 [amdgpu]
 do_vfs_ioctl+0x1a1/0x13d0
 ksys_ioctl+0x60/0x90
 __x64_sys_ioctl+0x6f/0xb0
 do_syscall_64+0x147/0x440
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8803a697b068
 which belongs to the cache kmalloc-1024 of size 1024
The buggy address is located 9 bytes inside of
 1024-byte region [ffff8803a697b068, ffff8803a697b468)
The buggy address belongs to the page:
page:ffffea000e9a5e00 count:1 mapcount:0 mapping:ffff88041e00efc0 index:0x0 compound_mapcount: 0
flags: 0x8000000000008100(slab|head)
raw: 8000000000008100 ffffea000ecbc208 ffff88041e000c70 ffff88041e00efc0
raw: 0000000000000000 0000000000170017 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8803a697af00: fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8803a697af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8803a697b000: fc fc fc fc fc fc fc fc fc fc fc fc fc fb fb fb
                                                             ^
 ffff8803a697b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8803a697b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

So, we fix this by counting the number of CRTCs this atomic commit disabled
early on in the function before their atomic states have been freed, then use
that count later to do the appropriate number of RPM puts at the end of the
function.

Fixes: 97028037a38ae ("drm/amdgpu: Grab/put runtime PM references in atomic_commit_tail()")
Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Michel Dänzer <michel@daenzer.net>
Reported-by: Michel Dänzer <michel@daenzer.net>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f9add85157e7..689dbdf44bbf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4206,6 +4206,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	struct drm_connector *connector;
 	struct drm_connector_state *old_con_state, *new_con_state;
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
+	int crtc_disable_count = 0;
 
 	drm_atomic_helper_update_legacy_modeset_state(dev, state);
 
@@ -4410,6 +4411,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 		bool modeset_needed;
 
+		if (old_crtc_state->active && !new_crtc_state->active)
+			crtc_disable_count++;
+
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 		modeset_needed = modeset_required(
@@ -4463,11 +4467,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	 * so we can put the GPU into runtime suspend if we're not driving any
 	 * displays anymore
 	 */
+	for (i = 0; i < crtc_disable_count; i++)
+		pm_runtime_put_autosuspend(dev->dev);
 	pm_runtime_mark_last_busy(dev->dev);
-	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
-		if (old_crtc_state->active && !new_crtc_state->active)
-			pm_runtime_put_autosuspend(dev->dev);
-	}
 }
 
 
-- 
2.17.1

