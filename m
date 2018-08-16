Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B5CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0822147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0822147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeHPXN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:13:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbeHPXN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:13:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9EA777721E;
        Thu, 16 Aug 2018 20:13:27 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81E351049469;
        Thu, 16 Aug 2018 20:13:25 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Prevent handling ACPI HPD events too early
Date:   Thu, 16 Aug 2018 16:13:13 -0400
Message-Id: <20180816201313.6370-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 16 Aug 2018 20:13:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 16 Aug 2018 20:13:27 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On most systems with ACPI hotplugging support, it seems that we always
receive a hotplug event once we re-enable EC interrupts even if the GPU
hasn't even been resumed yet.

This can cause problems since even though we schedule hpd_work to handle
connector reprobing for us, hpd_work synchronizes on
pm_runtime_get_sync() to wait until the device is ready to perform
reprobing. Since runtime suspend/resume callbacks are disabled before
the PM core calls ->suspend(), any calls to pm_runtime_get_sync() during
this period will grab a runtime PM ref and return immediately with
-EACCES. Because we schedule hpd_work from our ACPI HPD handler, and
hpd_work synchronizes on pm_runtime_get_sync(), this causes us to launch
a connector reprobe immediately even if the GPU isn't actually resumed
just yet. This causes various warnings in dmesg and occasionally, also
prevents some displays connected to the dedicated GPU from coming back
up after suspend. Example:

usb 1-4: USB disconnect, device number 14
usb 1-4.1: USB disconnect, device number 15
WARNING: CPU: 0 PID: 838 at drivers/gpu/drm/nouveau/include/nvkm/subdev/i2c.h:170 nouveau_dp_detect+0x17e/0x370 [nouveau]
CPU: 0 PID: 838 Comm: kworker/0:6 Not tainted 4.17.14-201.Lyude.bz1477182.V3.fc28.x86_64 #1
Hardware name: LENOVO 20EQS64N00/20EQS64N00, BIOS N1EET77W (1.50 ) 03/28/2018
Workqueue: events nouveau_display_hpd_work [nouveau]
RIP: 0010:nouveau_dp_detect+0x17e/0x370 [nouveau]
RSP: 0018:ffffa15143933cf0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8cb4f656c400 RCX: 0000000000000000
RDX: ffffa1514500e4e4 RSI: ffffa1514500e4e4 RDI: 0000000001009002
RBP: ffff8cb4f4a8a800 R08: ffffa15143933cfd R09: ffffa15143933cfc
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8cb4fb57a000
R13: ffff8cb4fb57a000 R14: ffff8cb4f4a8f800 R15: ffff8cb4f656c418
FS:  0000000000000000(0000) GS:ffff8cb51f400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f78ec938000 CR3: 000000073720a003 CR4: 00000000003606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ? _cond_resched+0x15/0x30
 nouveau_connector_detect+0x2ce/0x520 [nouveau]
 ? _cond_resched+0x15/0x30
 ? ww_mutex_lock+0x12/0x40
 drm_helper_probe_detect_ctx+0x8b/0xe0 [drm_kms_helper]
 drm_helper_hpd_irq_event+0xa8/0x120 [drm_kms_helper]
 nouveau_display_hpd_work+0x2a/0x60 [nouveau]
 process_one_work+0x187/0x340
 worker_thread+0x2e/0x380
 ? pwq_unbound_release_workfn+0xd0/0xd0
 kthread+0x112/0x130
 ? kthread_create_worker_on_cpu+0x70/0x70
 ret_from_fork+0x35/0x40
Code: 4c 8d 44 24 0d b9 00 05 00 00 48 89 ef ba 09 00 00 00 be 01 00 00 00 e8 e1 09 f8 ff 85 c0 0f 85 b2 01 00 00 80 7c 24 0c 03 74 02 <0f> 0b 48 89 ef e8 b8 07 f8 ff f6 05 51 1b c8 ff 02 0f 84 72 ff
---[ end trace 55d811b38fc8e71a ]---

So, to fix this we attempt to grab a runtime PM reference in the ACPI
handler itself asynchronously. If the GPU is already awake (it will have
normal hotplugging at this point) or runtime PM callbacks are currently
disabled on the device, we drop our reference without updating the
autosuspend delay. We only schedule connector reprobes when we
successfully managed to queue up a resume request with our asynchronous
PM ref.

This also has the added benefit of preventing redundant connector
reprobes from ACPI while the GPU is runtime resumed!

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Cc: Karol Herbst <kherbst@redhat.com>
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1477182#c41

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 26 +++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index 4b873e668b26..2e3226ff9f95 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -377,15 +377,29 @@ nouveau_display_acpi_ntfy(struct notifier_block *nb, unsigned long val,
 {
 	struct nouveau_drm *drm = container_of(nb, typeof(*drm), acpi_nb);
 	struct acpi_bus_event *info = data;
+	int ret;
 
 	if (!strcmp(info->device_class, ACPI_VIDEO_CLASS)) {
 		if (info->type == ACPI_VIDEO_NOTIFY_PROBE) {
-			/*
-			 * This may be the only indication we receive of a
-			 * connector hotplug on a runtime suspended GPU,
-			 * schedule hpd_work to check.
-			 */
-			schedule_work(&drm->hpd_work);
+			ret = pm_runtime_get(drm->dev->dev);
+			if (ret == 1 || ret == -EACCES) {
+				/* If the GPU is already awake, or in a state
+				 * where we can't wake it up, it can handle
+				 * it's own hotplug events.
+				 */
+				pm_runtime_put_autosuspend(drm->dev->dev);
+			} else if (ret == 0) {
+				/* This may be the only indication we receive
+				 * of a connector hotplug on a runtime
+				 * suspended GPU, schedule hpd_work to check.
+				 */
+				NV_DEBUG(drm, "ACPI requested connector reprobe\n");
+				schedule_work(&drm->hpd_work);
+				pm_runtime_put_noidle(drm->dev->dev);
+			} else {
+				NV_WARN(drm, "Dropped ACPI reprobe event due to RPM error: %d\n",
+					ret);
+			}
 
 			/* acpi-video should not generate keypresses for this */
 			return NOTIFY_BAD;
-- 
2.17.1

