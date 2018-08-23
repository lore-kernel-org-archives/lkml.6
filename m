Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9FBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691932086D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691932086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeHWFHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 01:07:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbeHWFHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 01:07:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B0A3940216EA;
        Thu, 23 Aug 2018 01:40:20 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-124-163.rdu2.redhat.com [10.10.124.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 518A610D18CB;
        Thu, 23 Aug 2018 01:40:20 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/nouveau: Shut down GPU on kernel shutdown
Date:   Wed, 22 Aug 2018 21:40:08 -0400
Message-Id: <20180823014009.21532-4-lyude@redhat.com>
In-Reply-To: <20180823014009.21532-1-lyude@redhat.com>
References: <20180823014009.21532-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 23 Aug 2018 01:40:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 23 Aug 2018 01:40:20 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A little while ago I sent some patches to try to fix issues with
initializing the GM107 GPU with nouveau on the ThinkPad P50. The issues
I was witnessing were rather bizarre: seemingly at random, initializing
the GPU would fail with failed mthds from disp that nouveau had not
actually kicked through the evo channel yet. Example:

    [    1.603467] nouveau 0000:01:00.0: disp: outp 02:0006:0f48: aux power -> demand
    [    1.603931] nouveau 0000:01:00.0: disp: outp 03:0002:0f48: no heads (0 3 2)
    [    1.604375] nouveau 0000:01:00.0: disp: outp 04:0006:0f81: no heads (0 3 4)
    [    1.604858] nouveau 0000:01:00.0: disp: outp 04:0006:0f81: aux power -> always
    [    1.605354] nouveau 0000:01:00.0: disp: outp 04:0006:0f81: aux power -> demand
    [    1.605815] nouveau 0000:01:00.0: disp: outp 05:0002:0f81: no heads (0 3 2)
--->[    1.607289] nouveau 0000:01:00.0: disp: chid 0 mthd 0000 data 00000400 00001000 00000002
--->[    1.608818] nouveau 0000:01:00.0: disp: chid 1 mthd 0000 data 00000400 00001000 00000002
--->[    1.609500] nouveau 0000:01:00.0: disp: chid 2 mthd 0000 data 00000400 00001000 00000002
    [    1.612392] [drm:drm_dp_dpcd_read [drm_kms_helper]] sor-0006-0f42: 0x00000 AUX -> (ret=  1) 12
    [    1.612774] [drm:drm_dp_dpcd_write [drm_kms_helper]] sor-0006-0f42: 0x00111 AUX <- (ret=  1) 00
    [    1.635748] [drm:drm_dp_dpcd_access [drm_kms_helper]] Too many retries, giving up. First error: -6
    [    1.635752] [drm:drm_dp_dpcd_read [drm_kms_helper]] sor-0006-0f48: 0x00000 AUX -> (ret= -6)
    [    1.658128] [drm:drm_dp_dpcd_access [drm_kms_helper]] Too many retries, giving up. First error: -6
    [    1.658131] [drm:drm_dp_dpcd_read [drm_kms_helper]] sor-0006-0f81: 0x00000 AUX -> (ret= -6)

These failures would also occur /before/ nouveau had actually pushed
anything to the evo channel. Then, later the rest of the GPU would start
failing like so:

[    3.851956] ------------[ cut here ]------------
[    3.851958] nouveau 0000:01:00.0: timeout
[    3.851995] WARNING: CPU: 0 PID: 62 at drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.c:1560 gf100_grctx_generate+0x89d/0x8b0 [nouveau]
[    3.851997] Modules linked in: serio_raw crc32c_intel xhci_pci i915(O+) xhci_hcd nouveau(O) video mxm_wmi wmi i2c_algo_bit drm_kms_helper(O) syscopyarea sysfillrect sysimgblt fb_sys_fops ttm(O) drm(O) i2c_core
[    3.852010] CPU: 0 PID: 62 Comm: kworker/0:2 Tainted: G           O      4.18.0-rc8Lyude-Test+ #7
[    3.852011] Hardware name: LENOVO 20EQS64N0B/20EQS64N0B, BIOS N1EET78W (1.51 ) 05/18/2018
[    3.852018] Workqueue: events output_poll_execute [drm_kms_helper]
[    3.852105] RIP: 0010:gf100_grctx_generate+0x89d/0x8b0 [nouveau]
[    3.852107] Code: ff 49 8b 7c 24 10 48 8b 5f 50 48 85 db 75 04 48 8b 5f 10 e8 25 5d 30 e1 48 89 da 48 c7 c7 4e e7 2a a0 48 89 c6 e8 65 c1 e9 e0 <0f> 0b bb f0 ff ff ff e9 68 f9 ff ff 0f 1f 80 00 00 00 00 0f 1f 44
[    3.852127] RSP: 0018:ffffc9000027b898 EFLAGS: 00010282
[    3.852128] RAX: 0000000000000000 RBX: ffff880876c20bd0 RCX: 0000000000000006
[    3.852130] RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff88089b415570
[    3.852132] RBP: ffffc9000027b958 R08: 0000000000000000 R09: 0000000000000000
[    3.852133] R10: ffff880876685f00 R11: ffffffff8140cc60 R12: ffff8808716d2000
[    3.852135] R13: ffffc9000027b8d0 R14: ffffc9000027b8c8 R15: ffff88087165c000
[    3.852137] FS:  0000000000000000(0000) GS:ffff88089b400000(0000) knlGS:0000000000000000
[    3.852139] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.852140] CR2: 00005621d2c180b8 CR3: 000000000200a005 CR4: 00000000003606f0
[    3.852142] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    3.852144] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    3.852145] Call Trace:
[    3.852168]  ? nv04_timer_read+0x48/0x60 [nouveau]
[    3.852191]  gf100_gr_init_ctxctl+0x536/0xa40 [nouveau]
[    3.852212]  gf100_gr_init+0x563/0x590 [nouveau]
[    3.852234]  gf100_gr_init_+0x5b/0x60 [nouveau]
[    3.852255]  nvkm_gr_init+0x1d/0x20 [nouveau]
[    3.852267]  nvkm_engine_init+0xb9/0x1f0 [nouveau]
[    3.852280]  nvkm_subdev_init+0xbc/0x210 [nouveau]
[    3.852292]  nvkm_engine_ref.part.0+0x4a/0x70 [nouveau]
[    3.852304]  nvkm_engine_ref+0x13/0x20 [nouveau]
[    3.852316]  nvkm_ioctl_new+0x12c/0x260 [nouveau]
[    3.852337]  ? nvkm_fifo_chan_dtor+0x100/0x100 [nouveau]
[    3.852358]  ? gf100_fermi_mthd+0x100/0x100 [nouveau]
[    3.852371]  nvkm_ioctl+0xe2/0x180 [nouveau]
[    3.852392]  nvkm_client_ioctl+0x12/0x20 [nouveau]
[    3.852403]  nvif_object_ioctl+0x47/0x50 [nouveau]
[    3.852415]  nvif_object_init+0xc8/0x120 [nouveau]
[    3.852435]  nvc0_fbcon_accel_init+0x5b/0x950 [nouveau]
[    3.852455]  nouveau_fbcon_create+0x5bb/0x5e0 [nouveau]
[    3.852460]  ? drm_setup_crtcs+0x247/0xa60 [drm_kms_helper]
[    3.852464]  __drm_fb_helper_initial_config_and_unlock+0x1c0/0x410 [drm_kms_helper]
[    3.852468]  drm_fb_helper_hotplug_event.part.33+0xa9/0xb0 [drm_kms_helper]
[    3.852472]  drm_fb_helper_hotplug_event+0x1c/0x30 [drm_kms_helper]
[    3.852492]  nouveau_fbcon_output_poll_changed+0xb6/0x110 [nouveau]
[    3.852496]  drm_kms_helper_hotplug_event+0x2a/0x30 [drm_kms_helper]
[    3.852500]  output_poll_execute+0x198/0x1c0 [drm_kms_helper]
[    3.852504]  process_one_work+0x1b2/0x370
[    3.852506]  worker_thread+0x37/0x3a0
[    3.852508]  kthread+0x120/0x140
[    3.852510]  ? wq_update_unbound_numa+0x10/0x10
[    3.852511]  ? kthread_create_worker_on_cpu+0x70/0x70
[    3.852514]  ret_from_fork+0x35/0x40
[    3.852516] ---[ end trace 583fe2d8feb59e4a ]---
[    3.852733] nouveau 0000:01:00.0: gr: failed to construct context
[    3.852737] nouveau 0000:01:00.0: gr: init failed, -16

Originally I had a good bit of trouble even reproducing this issue
whatsoever. I've since then managed to figure out a reproducer that
seems to work about 70% of the time:

- Boot the machine while docked, load nouveau
- Undock the machine, wait for nouveau to go into runtime suspend
- Reboot the machine. If done correctly, you should be able to see
  nouveau briefly resume itself before the shutdown finishes
- On the next boot, the following should happen (if it doesn't, go back
  to step one):
  - If nouveau isn't loaded within 10-20 seconds of booting, you will
    probably see an unclaimed interrupt warning.
  - Once nouveau is loaded, you'll see the symptoms I've described here

At first I assumed that the BIOS was probably trying to probe for
displays before loading the OS, leaving us with a GPU in a funky
sort-of-on state. I tried some solutions that involved shutting down the
various display channels that were left on, but eventually discovered
that we were starting off with more then just disp channels left on: the
entire gr was left on as well. Additionally; it was pointed out to me by
Ben Skeggs that the BIOS doesn't make any use of evo channels anyway.

After some investigation we found the real cause of the problem, and
unfortunately it's far worse than leaving a few channels on: the version
of the BIOS on this P50 appears to have a bug which makes it so that on
full system reboots, the dedicated GPU somehow does not always get power
cycled. In fact, it's even left in nearly the same state it was in
before we finished rebooting! How awful.

While it's quite clear there's one rather impressive BIOS bug going on
here that needs to get fixed, we can at least solve most of the symptoms
of this issue by making nouveau a little better about cleaning up after
itself on kernel shutdowns/reboots. This is something nouveau is going
to need to be able to do if it's ever going to be used for things like
PCI passthrough anyway, since we want to avoid passing the GPU around
from VM guest to VM host if it's still half-way initialized.

Luckily I have some contacts at Lenovo, so I will be bringing this up
and referencing this patch to make sure that this gets fixed properly in
the P50 BIOS as well, especially since not having this fixed in the BIOS
means it's possible for us to fail to reboot if we put both the card and
the kernel into a bad state and require a full reboot. But until then,
this patch should make the problem significantly less noticeable.

For reference, the BIOS version on this P50 is version 1.52.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
[omitting Cc to stable. I'd /love/ to get this into a stable kernel, but
unfortunately there's too many large changes this depends on to do that]

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index b88b338dc79c..c37641496324 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1151,6 +1151,7 @@ nouveau_drm_pci_driver = {
 	.id_table = nouveau_drm_pci_table,
 	.probe = nouveau_drm_probe,
 	.remove = nouveau_drm_remove,
+	.shutdown = nouveau_drm_remove,
 	.driver.pm = &nouveau_pm_ops,
 };
 
-- 
2.17.1

