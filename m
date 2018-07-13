Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A447AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5434520840
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5434520840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbeGMQkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:40:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731428AbeGMQkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:40:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39271407048D;
        Fri, 13 Jul 2018 16:25:00 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-125-176.rdu2.redhat.com [10.10.125.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C53001C67B;
        Fri, 13 Jul 2018 16:24:59 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/nouveau: Avoid looping through fake MST connectors
Date:   Fri, 13 Jul 2018 12:24:41 -0400
Message-Id: <20180713162442.22522-3-lyude@redhat.com>
In-Reply-To: <20180713162442.22522-1-lyude@redhat.com>
References: <20180713162442.22522-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 13 Jul 2018 16:25:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 13 Jul 2018 16:25:00 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When MST and atomic were introduced to nouveau, another structure that
could contain a drm_connector embedded within it was introduced; struct
nv50_mstc. This meant that we no longer would be able to simply loop
through our connector list and assume that nouveau_connector() would
return a proper pointer for each connector, since the assertion that
all connectors coming from nouveau have a full nouveau_connector struct
became invalid.

Unfortunately, none of the actual code that looped through connectors
ever got updated, which means that we've been causing invalid memory
accesses for quite a while now.

An example that was caught by KASAN:

[  201.038698] ==================================================================
[  201.038792] BUG: KASAN: slab-out-of-bounds in nvif_notify_get+0x190/0x1a0 [nouveau]
[  201.038797] Read of size 4 at addr ffff88076738c650 by task kworker/0:3/718
[  201.038800]
[  201.038822] CPU: 0 PID: 718 Comm: kworker/0:3 Tainted: G           O      4.18.0-rc4Lyude-Test+ #1
[  201.038825] Hardware name: LENOVO 20EQS64N0B/20EQS64N0B, BIOS N1EET78W (1.51 ) 05/18/2018
[  201.038882] Workqueue: events nouveau_display_hpd_work [nouveau]
[  201.038887] Call Trace:
[  201.038894]  dump_stack+0xa4/0xfd
[  201.038900]  print_address_description+0x71/0x239
[  201.038929]  ? nvif_notify_get+0x190/0x1a0 [nouveau]
[  201.038935]  kasan_report.cold.6+0x242/0x2fe
[  201.038942]  __asan_report_load4_noabort+0x19/0x20
[  201.038970]  nvif_notify_get+0x190/0x1a0 [nouveau]
[  201.038998]  ? nvif_notify_put+0x1f0/0x1f0 [nouveau]
[  201.039003]  ? kmsg_dump_rewind_nolock+0xe4/0xe4
[  201.039049]  nouveau_display_init.cold.12+0x34/0x39 [nouveau]
[  201.039089]  ? nouveau_user_framebuffer_create+0x120/0x120 [nouveau]
[  201.039133]  nouveau_display_resume+0x5c0/0x810 [nouveau]
[  201.039173]  ? nvkm_client_ioctl+0x20/0x20 [nouveau]
[  201.039215]  nouveau_do_resume+0x19f/0x570 [nouveau]
[  201.039256]  nouveau_pmops_runtime_resume+0xd8/0x2a0 [nouveau]
[  201.039264]  pci_pm_runtime_resume+0x130/0x250
[  201.039269]  ? pci_restore_standard_config+0x70/0x70
[  201.039275]  __rpm_callback+0x1f2/0x5d0
[  201.039279]  ? rpm_resume+0x560/0x18a0
[  201.039283]  ? pci_restore_standard_config+0x70/0x70
[  201.039287]  ? pci_restore_standard_config+0x70/0x70
[  201.039291]  ? pci_restore_standard_config+0x70/0x70
[  201.039296]  rpm_callback+0x175/0x210
[  201.039300]  ? pci_restore_standard_config+0x70/0x70
[  201.039305]  rpm_resume+0xcc3/0x18a0
[  201.039312]  ? rpm_callback+0x210/0x210
[  201.039317]  ? __pm_runtime_resume+0x9e/0x100
[  201.039322]  ? kasan_check_write+0x14/0x20
[  201.039326]  ? do_raw_spin_lock+0xc2/0x1c0
[  201.039333]  __pm_runtime_resume+0xac/0x100
[  201.039374]  nouveau_display_hpd_work+0x67/0x1f0 [nouveau]
[  201.039380]  process_one_work+0x7a0/0x14d0
[  201.039388]  ? cancel_delayed_work_sync+0x20/0x20
[  201.039392]  ? lock_acquire+0x113/0x310
[  201.039398]  ? kasan_check_write+0x14/0x20
[  201.039402]  ? do_raw_spin_lock+0xc2/0x1c0
[  201.039409]  worker_thread+0x86/0xb50
[  201.039418]  kthread+0x2e9/0x3a0
[  201.039422]  ? process_one_work+0x14d0/0x14d0
[  201.039426]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[  201.039431]  ret_from_fork+0x3a/0x50
[  201.039441]
[  201.039444] Allocated by task 79:
[  201.039449]  save_stack+0x43/0xd0
[  201.039452]  kasan_kmalloc+0xc4/0xe0
[  201.039456]  kmem_cache_alloc_trace+0x10a/0x260
[  201.039494]  nv50_mstm_add_connector+0x9a/0x340 [nouveau]
[  201.039504]  drm_dp_add_port+0xff5/0x1fc0 [drm_kms_helper]
[  201.039511]  drm_dp_send_link_address+0x4a7/0x740 [drm_kms_helper]
[  201.039518]  drm_dp_check_and_send_link_address+0x1a7/0x210 [drm_kms_helper]
[  201.039525]  drm_dp_mst_link_probe_work+0x71/0xb0 [drm_kms_helper]
[  201.039529]  process_one_work+0x7a0/0x14d0
[  201.039533]  worker_thread+0x86/0xb50
[  201.039537]  kthread+0x2e9/0x3a0
[  201.039541]  ret_from_fork+0x3a/0x50
[  201.039543]
[  201.039546] Freed by task 0:
[  201.039549] (stack is not available)
[  201.039551]
[  201.039555] The buggy address belongs to the object at ffff88076738c1a8
                                 which belongs to the cache kmalloc-2048 of size 2048
[  201.039559] The buggy address is located 1192 bytes inside of
                                 2048-byte region [ffff88076738c1a8, ffff88076738c9a8)
[  201.039563] The buggy address belongs to the page:
[  201.039567] page:ffffea001d9ce200 count:1 mapcount:0 mapping:ffff88084000d0c0 index:0x0 compound_mapcount: 0
[  201.039573] flags: 0x8000000000008100(slab|head)
[  201.039578] raw: 8000000000008100 ffffea001da3be08 ffffea001da25a08 ffff88084000d0c0
[  201.039582] raw: 0000000000000000 00000000000d000d 00000001ffffffff 0000000000000000
[  201.039585] page dumped because: kasan: bad access detected
[  201.039588]
[  201.039591] Memory state around the buggy address:
[  201.039594]  ffff88076738c500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  201.039598]  ffff88076738c580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  201.039601] >ffff88076738c600: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
[  201.039604]                                                  ^
[  201.039607]  ffff88076738c680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  201.039611]  ffff88076738c700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  201.039613] ==================================================================

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Cc: Karol Herbst <karolherbst@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c |  2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.h | 24 ++++++++++++++++++++-
 drivers/gpu/drm/nouveau/nouveau_display.c   |  4 ++--
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 7dc380449232..af68eae4c626 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1213,7 +1213,7 @@ nouveau_connector_create(struct drm_device *dev, int index)
 	bool dummy;
 
 	drm_connector_list_iter_begin(dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter) {
+	nouveau_for_each_non_mst_connector_iter(connector, &conn_iter) {
 		nv_connector = nouveau_connector(connector);
 		if (nv_connector->index == index) {
 			drm_connector_list_iter_end(&conn_iter);
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index a8cbb4b56fc7..aaf3a213c685 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -33,6 +33,7 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_dp_helper.h>
 #include "nouveau_crtc.h"
+#include "nouveau_encoder.h"
 
 struct nvkm_i2c_port;
 
@@ -60,6 +61,27 @@ static inline struct nouveau_connector *nouveau_connector(
 	return container_of(con, struct nouveau_connector, base);
 }
 
+static inline bool
+nouveau_connector_is_mst(struct drm_connector *connector)
+{
+	const struct nouveau_encoder *nv_encoder;
+	const struct drm_encoder *encoder;
+
+	if (connector->connector_type != DRM_MODE_CONNECTOR_DisplayPort)
+		return false;
+
+	nv_encoder = find_encoder(connector, DCB_OUTPUT_ANY);
+	if (!nv_encoder)
+		return false;
+
+	encoder = &nv_encoder->base.base;
+	return encoder->encoder_type == DRM_MODE_ENCODER_DPMST;
+}
+
+#define nouveau_for_each_non_mst_connector_iter(connector, iter) \
+	drm_for_each_connector_iter(connector, iter) \
+		if (!nouveau_connector_is_mst(connector))
+
 static inline struct nouveau_connector *
 nouveau_crtc_connector_get(struct nouveau_crtc *nv_crtc)
 {
@@ -70,7 +92,7 @@ nouveau_crtc_connector_get(struct nouveau_crtc *nv_crtc)
 	struct drm_crtc *crtc = to_drm_crtc(nv_crtc);
 
 	drm_connector_list_iter_begin(dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter) {
+	nouveau_for_each_non_mst_connector_iter(connector, &conn_iter) {
 		if (connector->encoder && connector->encoder->crtc == crtc) {
 			nv_connector = nouveau_connector(connector);
 			break;
diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index 46b8430ef4aa..ec7861457b84 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -413,7 +413,7 @@ nouveau_display_init(struct drm_device *dev)
 
 	/* enable hotplug interrupts */
 	drm_connector_list_iter_begin(dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter) {
+	nouveau_for_each_non_mst_connector_iter(connector, &conn_iter) {
 		struct nouveau_connector *conn = nouveau_connector(connector);
 		nvif_notify_get(&conn->hpd);
 	}
@@ -444,7 +444,7 @@ nouveau_display_fini(struct drm_device *dev, bool suspend)
 
 	/* disable hotplug interrupts */
 	drm_connector_list_iter_begin(dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter) {
+	nouveau_for_each_non_mst_connector_iter(connector, &conn_iter) {
 		struct nouveau_connector *conn = nouveau_connector(connector);
 		nvif_notify_put(&conn->hpd);
 	}
-- 
2.17.1

