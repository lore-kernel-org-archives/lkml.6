Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658A9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B5B21773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbeLTIPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:15:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:4390 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbeLTIPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:15:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2018 00:15:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,376,1539673200"; 
   d="scan'208";a="119794170"
Received: from shclpe02.sh.intel.com (HELO clrdev-22780.sh.intel.com) ([10.239.144.225])
  by orsmga002.jf.intel.com with ESMTP; 20 Dec 2018 00:15:12 -0800
From:   Bin Yang <bin.yang@intel.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        chris@chris-wilson.co.uk, jani.saarinen@intel.com,
        alek.du@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        bin.yang@intel.com
Subject: [PATCH] drm/i915: Fix i915_gem_wait_for_idle oops due to active_requests check
Date:   Thu, 20 Dec 2018 08:01:35 +0000
Message-Id: <20181220080135.9059-1-bin.yang@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i915_gem_wait_for_idle() waits for all requests being completed and
calls i915_retire_requests() to retire them. It assumes the
active_requests should be zero finally.

In i915_retire_requests(), it will retire all requests on the active
rings. Unfortunately, active_requests is increased in
i915_request_alloc() and reduced in i915_request_retire(), but the
request is added into active rings in i915_request_add().

If i915_gem_wait_for_idle() is called between i915_request_alloc()
and i915_request_add(), this request will not be retired. Then, the
active_requests will not be zero in the end.

Normally, i915_request_alloc() and i915_request_add() will be called
in sequence with drm.struct_mutex locked. But in
intel_vgpu_create_workload(), it will pre-allocate the request and
call i915_request_add() in the workload thread for performance
optimization. The above issue will be triggered.

This patch introduced a new counter named reserved_requests for
request allocation. The active_requests will be increased when
the request is really added into the active rings.

8<----- below is the oops when above issue is hitted.

[2018-11-28 23:17:54] [12278.310417] kernel BUG at drivers/gpu/drm/i915/i915_gem.c:4702!
[2018-11-28 23:17:54] [12278.310802] invalid opcode: 0000 [#1] PREEMPT SMP
[2018-11-28 23:17:54] [12278.311012] CPU: 0 PID: 61 Comm: kswapd0 Tainted: G     U  WC        4.19.0-26.iot-lts2018-sos #1
[2018-11-28 23:17:54] [12278.311393] RIP: 0010:i915_gem_wait_for_idle.part.78.cold.114+0x45/0x47
[2018-11-28 23:17:54] [12278.311675] Code: 7b 8b ae ff 48 8b 35 e6 92 3c 01 49 c7 c0 af 48 55 a9 b9 5e 12 00 00 48 c7 c2 50 7a 0b a9 48 c7 c7 f4 e6 60 a8 e8 37 38 b6 ff <0f> 0b 48 c7 c1 a8 59 55 a9 ba b8 12 00 00 48 c7 c6 20 7a 0b a9 48
[2018-11-28 23:17:55] [12278.312447] RSP: 0018:ffff8e31acd8bbb8 EFLAGS: 00010246
[2018-11-28 23:17:55] [12278.312673] RAX: 000000000000000e RBX: 000000000000000a RCX: 0000000000000000
[2018-11-28 23:17:55] [12278.312971] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff8e31ae841400
[2018-11-28 23:17:55] [12278.313268] RBP: ffff8e31acea8340 R08: 0000000001416578 R09: ffff8e31aea15000
[2018-11-28 23:17:55] [12278.313566] R10: ffff8e31ae807100 R11: ffff8e31ae841400 R12: ffff8e31acea0000
[2018-11-28 23:17:55] [12278.313863] R13: 00000b2ab1d38ed0 R14: 0000000000000000 R15: ffff8e31acd8bd70
[2018-11-28 23:17:55] [12278.314162] FS:  0000000000000000(0000) GS:ffff8e31afa00000(0000) knlGS:0000000000000000
[2018-11-28 23:17:55] [12278.314499] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[2018-11-28 23:17:55] [12278.314741] CR2: 00007ff94948f000 CR3: 0000000226813000 CR4: 00000000003406f0
[2018-11-28 23:17:55] [12278.315039] Call Trace:
[2018-11-28 23:17:55] [12278.315162]  i915_gem_shrink+0x3b7/0x4b0
[2018-11-28 23:17:55] [12278.315340]  i915_gem_shrinker_scan+0x104/0x130
[2018-11-28 23:17:55] [12278.315537]  do_shrink_slab+0x12c/0x2c0
[2018-11-28 23:17:55] [12278.315706]  shrink_slab+0x225/0x2c0
[2018-11-28 23:17:55] [12278.315864]  shrink_node+0xe4/0x430
[2018-11-28 23:17:55] [12278.316018]  kswapd+0x3ce/0x730
[2018-11-28 23:17:55] [12278.316161]  ? mem_cgroup_shrink_node+0x1a0/0x1a0
[2018-11-28 23:17:55] [12278.316365]  kthread+0x11e/0x140
[2018-11-28 23:17:55] [12278.316508]  ? kthread_create_worker_on_cpu+0x70/0x70
[2018-11-28 23:17:55] [12278.316727]  ret_from_fork+0x3a/0x50
[2018-11-28 23:17:55] [12278.316884] Modules linked in: igb_avb(C) xhci_pci xhci_hcd dca ici_isys_mod ipu4_acpi intel_ipu4_isys_csslib intel_ipu4_psys intel_ipu4_psys_csslib intel_ipu4_mmu intel_ipu4 iova crlmodule_lite

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=109005
Signed-off-by: Bin Yang <bin.yang@intel.com>
---
 drivers/gpu/drm/i915/i915_drv.h     |  1 +
 drivers/gpu/drm/i915/i915_gem.c     |  2 +-
 drivers/gpu/drm/i915/i915_request.c | 10 +++++++---
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 815db160b966..7a757f0f504f 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1948,6 +1948,7 @@ struct drm_i915_private {
 		struct list_head active_rings;
 		struct list_head closed_vma;
 		u32 active_requests;
+		u32 reserved_requests;
 		u32 request_serial;
 
 		/**
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index d92147ab4489..1873e21c84c1 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -200,7 +200,7 @@ void i915_gem_unpark(struct drm_i915_private *i915)
 	GEM_TRACE("\n");
 
 	lockdep_assert_held(&i915->drm.struct_mutex);
-	GEM_BUG_ON(!i915->gt.active_requests);
+	GEM_BUG_ON(!i915->gt.reserved_requests);
 
 	if (i915->gt.awake)
 		return;
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 637909c59f1f..394283799ee9 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -200,7 +200,7 @@ static int reserve_gt(struct drm_i915_private *i915)
 		}
 	}
 
-	if (!i915->gt.active_requests++)
+	if (!i915->gt.reserved_requests++)
 		i915_gem_unpark(i915);
 
 	return 0;
@@ -208,8 +208,8 @@ static int reserve_gt(struct drm_i915_private *i915)
 
 static void unreserve_gt(struct drm_i915_private *i915)
 {
-	GEM_BUG_ON(!i915->gt.active_requests);
-	if (!--i915->gt.active_requests)
+	GEM_BUG_ON(!i915->gt.reserved_requests);
+	if (!--i915->gt.reserved_requests)
 		i915_gem_park(i915);
 }
 
@@ -384,6 +384,8 @@ static void i915_request_retire(struct i915_request *request)
 
 	__retire_engine_upto(request->engine, request);
 
+	GEM_BUG_ON(!request->i915->gt.active_requests);
+	request->i915->gt.active_requests--;
 	unreserve_gt(request->i915);
 
 	i915_sched_node_fini(request->i915, &request->sched);
@@ -1006,6 +1008,8 @@ void i915_request_add(struct i915_request *request)
 							 0);
 	}
 
+	++request->i915->gt.active_requests;
+
 	spin_lock_irq(&timeline->lock);
 	list_add_tail(&request->link, &timeline->requests);
 	spin_unlock_irq(&timeline->lock);
-- 
2.19.1

