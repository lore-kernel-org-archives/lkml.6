Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B37C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F58A20856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfA2Sjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:39:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16103 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfA2Sjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:39:39 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 268EF51EF3;
        Tue, 29 Jan 2019 18:39:39 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 067F51713D;
        Tue, 29 Jan 2019 18:39:32 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/dp_mst: Fix unbalanced malloc ref in drm_dp_mst_deallocate_vcpi()
Date:   Tue, 29 Jan 2019 13:39:25 -0500
Message-Id: <20190129183928.26779-2-lyude@redhat.com>
In-Reply-To: <20190129183928.26779-1-lyude@redhat.com>
References: <20190129183928.26779-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 29 Jan 2019 18:39:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drm_dp_mst_deallocate_vcpi(), we currently unconditionally call
drm_dp_mst_put_port_malloc() on the port that's passed to us, even if we
never successfully allocated VCPI to it. This is contrary to what we do
in drm_dp_mst_allocate_vcpi(), where we only call
drm_dp_mst_get_port_malloc() on the passed port if we successfully
allocated VCPI to it.

As a result, if drm_dp_mst_allocate_vcpi() fails during a modeset and
another successive modeset calls drm_dp_mst_deallocate_vcpi() we will
end up dropping someone else's malloc reference to the port. Example:

[  962.309260] ==================================================================
[  962.309290] BUG: KASAN: use-after-free in drm_dp_mst_put_port_malloc+0x72/0x180 [drm_kms_helper]
[  962.309296] Read of size 4 at addr ffff888416c30004 by task kworker/0:1H/500

[  962.309308] CPU: 0 PID: 500 Comm: kworker/0:1H Tainted: G        W  O      5.0.0-rc2Lyude-Test+ #1
[  962.309313] Hardware name: LENOVO 20L8S2N800/20L8S2N800, BIOS N22ET35W (1.12 ) 04/09/2018
[  962.309428] Workqueue: events_highpri intel_atomic_cleanup_work [i915]
[  962.309434] Call Trace:
[  962.309452]  dump_stack+0xad/0x150
[  962.309462]  ? dump_stack_print_info.cold.0+0x1b/0x1b
[  962.309472]  ? kmsg_dump_rewind_nolock+0xd9/0xd9
[  962.309504]  ? drm_dp_mst_put_port_malloc+0x72/0x180 [drm_kms_helper]
[  962.309515]  print_address_description+0x6c/0x23c
[  962.309542]  ? drm_dp_mst_put_port_malloc+0x72/0x180 [drm_kms_helper]
[  962.309568]  ? drm_dp_mst_put_port_malloc+0x72/0x180 [drm_kms_helper]
[  962.309577]  kasan_report.cold.3+0x1a/0x32
[  962.309605]  ? drm_dp_mst_put_port_malloc+0x72/0x180 [drm_kms_helper]
[  962.309631]  drm_dp_mst_put_port_malloc+0x72/0x180 [drm_kms_helper]
[  962.309658]  ? drm_dp_mst_put_mstb_malloc+0x180/0x180 [drm_kms_helper]
[  962.309687]  drm_dp_mst_destroy_state+0xcd/0x120 [drm_kms_helper]
[  962.309745]  drm_atomic_state_default_clear+0x6ee/0xcc0 [drm]
[  962.309864]  intel_atomic_state_clear+0xe/0x80 [i915]
[  962.309928]  __drm_atomic_state_free+0x35/0xd0 [drm]
[  962.310044]  intel_atomic_cleanup_work+0x56/0x70 [i915]
[  962.310057]  process_one_work+0x884/0x1400
[  962.310067]  ? drain_workqueue+0x5a0/0x5a0
[  962.310075]  ? __schedule+0x87f/0x1e80
[  962.310086]  ? __sched_text_start+0x8/0x8
[  962.310095]  ? run_rebalance_domains+0x400/0x400
[  962.310110]  ? deref_stack_reg+0xb4/0x120
[  962.310117]  ? __read_once_size_nocheck.constprop.7+0x10/0x10
[  962.310124]  ? worker_enter_idle+0x47f/0x6a0
[  962.310134]  ? schedule+0xd7/0x2e0
[  962.310141]  ? __schedule+0x1e80/0x1e80
[  962.310148]  ? _raw_spin_lock_irq+0x9f/0x130
[  962.310155]  ? _raw_write_unlock_irqrestore+0x110/0x110
[  962.310164]  worker_thread+0x196/0x11e0
[  962.310175]  ? set_load_weight+0x2e0/0x2e0
[  962.310181]  ? __switch_to_asm+0x34/0x70
[  962.310187]  ? __switch_to_asm+0x40/0x70
[  962.310194]  ? process_one_work+0x1400/0x1400
[  962.310199]  ? __switch_to_asm+0x40/0x70
[  962.310205]  ? __switch_to_asm+0x34/0x70
[  962.310211]  ? __switch_to_asm+0x34/0x70
[  962.310216]  ? __switch_to_asm+0x40/0x70
[  962.310221]  ? __switch_to_asm+0x34/0x70
[  962.310226]  ? __switch_to_asm+0x40/0x70
[  962.310231]  ? __switch_to_asm+0x34/0x70
[  962.310236]  ? __switch_to_asm+0x40/0x70
[  962.310242]  ? syscall_return_via_sysret+0xf/0x7f
[  962.310248]  ? __switch_to_asm+0x34/0x70
[  962.310253]  ? __switch_to_asm+0x40/0x70
[  962.310258]  ? __switch_to_asm+0x34/0x70
[  962.310263]  ? __switch_to_asm+0x40/0x70
[  962.310268]  ? __switch_to_asm+0x34/0x70
[  962.310273]  ? __switch_to_asm+0x40/0x70
[  962.310281]  ? __schedule+0x87f/0x1e80
[  962.310292]  ? __sched_text_start+0x8/0x8
[  962.310300]  ? save_stack+0x8c/0xb0
[  962.310308]  ? __kasan_kmalloc.constprop.6+0xc6/0xd0
[  962.310313]  ? kthread+0x98/0x3a0
[  962.310318]  ? ret_from_fork+0x35/0x40
[  962.310334]  ? __wake_up_common+0x178/0x6f0
[  962.310343]  ? _raw_spin_lock_irqsave+0xa4/0x140
[  962.310349]  ? __lock_text_start+0x8/0x8
[  962.310355]  ? _raw_write_lock_irqsave+0x70/0x130
[  962.310360]  ? __lock_text_start+0x8/0x8
[  962.310371]  ? process_one_work+0x1400/0x1400
[  962.310376]  kthread+0x2e2/0x3a0
[  962.310383]  ? kthread_create_on_node+0xc0/0xc0
[  962.310389]  ret_from_fork+0x35/0x40

[  962.310401] Allocated by task 1462:
[  962.310410]  __kasan_kmalloc.constprop.6+0xc6/0xd0
[  962.310437]  drm_dp_add_port+0xd60/0x1960 [drm_kms_helper]
[  962.310464]  drm_dp_send_link_address+0x4b0/0x770 [drm_kms_helper]
[  962.310491]  drm_dp_check_and_send_link_address+0x197/0x1f0 [drm_kms_helper]
[  962.310515]  drm_dp_mst_link_probe_work+0x2b6/0x330 [drm_kms_helper]
[  962.310522]  process_one_work+0x884/0x1400
[  962.310529]  worker_thread+0x196/0x11e0
[  962.310533]  kthread+0x2e2/0x3a0
[  962.310538]  ret_from_fork+0x35/0x40

[  962.310543] Freed by task 500:
[  962.310550]  __kasan_slab_free+0x133/0x180
[  962.310555]  kfree+0x92/0x1a0
[  962.310581]  drm_dp_mst_put_port_malloc+0x14d/0x180 [drm_kms_helper]
[  962.310693]  intel_connector_destroy+0xb2/0xe0 [i915]
[  962.310747]  drm_mode_object_put.part.0+0x12b/0x1a0 [drm]
[  962.310802]  drm_atomic_state_default_clear+0x1f2/0xcc0 [drm]
[  962.310916]  intel_atomic_state_clear+0xe/0x80 [i915]
[  962.310972]  __drm_atomic_state_free+0x35/0xd0 [drm]
[  962.311083]  intel_atomic_cleanup_work+0x56/0x70 [i915]
[  962.311092]  process_one_work+0x884/0x1400
[  962.311098]  worker_thread+0x196/0x11e0
[  962.311103]  kthread+0x2e2/0x3a0
[  962.311108]  ret_from_fork+0x35/0x40

[  962.311116] The buggy address belongs to the object at ffff888416c30000
                which belongs to the cache kmalloc-2k of size 2048
[  962.311122] The buggy address is located 4 bytes inside of
                2048-byte region [ffff888416c30000, ffff888416c30800)
[  962.311124] The buggy address belongs to the page:
[  962.311132] page:ffffea00105b0c00 count:1 mapcount:0 mapping:ffff88841d003040 index:0x0 compound_mapcount: 0
[  962.311142] flags: 0x8000000000010200(slab|head)
[  962.311152] raw: 8000000000010200 dead000000000100 dead000000000200 ffff88841d003040
[  962.311159] raw: 0000000000000000 00000000000f000f 00000001ffffffff 0000000000000000
[  962.311162] page dumped because: kasan: bad access detected

So, bail early if drm_dp_mst_deallocate_vcpi() is called on a port with
no VCPI allocation. Additionally, clean up the surrounding kerneldoc
while we're at it since the port is assumed to be kept around because
the DRM driver is expected to hold a malloc reference to it, not just
us.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: eceae1472467 ("drm/dp_mst: Start tracking per-port VCPI allocations")
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 2552a27362a0..8ba0e5b368da 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3246,15 +3246,13 @@ EXPORT_SYMBOL(drm_dp_mst_reset_vcpi_slots);
 /**
  * drm_dp_mst_deallocate_vcpi() - deallocate a VCPI
  * @mgr: manager for this port
- * @port: unverified port to deallocate vcpi for
+ * @port: port to deallocate vcpi for
  */
 void drm_dp_mst_deallocate_vcpi(struct drm_dp_mst_topology_mgr *mgr,
 				struct drm_dp_mst_port *port)
 {
-	/*
-	 * A port with VCPI will remain allocated until it's VCPI is
-	 * released, no verified ref needed
-	 */
+	if (!port->vcpi.vcpi)
+		return;
 
 	drm_dp_mst_put_payload_id(mgr, port->vcpi.vcpi);
 	port->vcpi.num_slots = 0;
-- 
2.20.1

