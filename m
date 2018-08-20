Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5123CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D7A213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D7A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeHTUq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:46:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbeHTUq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:46:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD57187A73;
        Mon, 20 Aug 2018 17:20:38 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-120-60.rdu2.redhat.com [10.10.120.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D4AC2166BA1;
        Mon, 20 Aug 2018 17:20:38 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/nouveau: Fix GM107 disp core chan init on ThinkPad P50
Date:   Mon, 20 Aug 2018 13:20:26 -0400
Message-Id: <20180820172030.10963-2-lyude@redhat.com>
In-Reply-To: <20180820172030.10963-1-lyude@redhat.com>
References: <20180820172030.10963-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 20 Aug 2018 17:20:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 20 Aug 2018 17:20:38 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been experiencing a rather strange looking bug on the P50 I've got
for work. After a number of reboots, nouveau will fail to initialize the
dedicated GPU on the system at boot properly. Things start off with
this disp mthd failure:

...
[    2.088505] nouveau 0000:01:00.0: disp: outp 04:0006:0f81: aux power -> demand
[    2.088516] nouveau 0000:01:00.0: disp: outp 05:0002:0f81: no heads (0 3 2)
[    2.088620] nouveau 0000:01:00.0: disp: init completed in 329us
[    2.088957] nouveau 0000:01:00.0: disp: chid 0 mthd 0000 data 00000400 00001000 00000002
                               the failure ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[    2.151517] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.151517] [drm] Driver supports precise vblank timestamp query.
[    2.151521] 0088 1 core507d_init
[    2.151522] 	f0000000

After the error happens, parts of the card start timing out and
eventually the GR fails to hold it's golden context and starts timing
out:

[   10.163137] ------------[ cut here ]------------
[   10.163169] nouveau 0000:01:00.0: timeout
[   10.163218] WARNING: CPU: 4 PID: 98 at drivers/gpu/drm/nouveau/nvkm/engine/disp/coregf119.c:181 gf119_disp_core_fini+0xe6/0x140 [nouveau]
[   10.163246] Modules linked in: joydev vfat fat intel_rapl iTCO_wdt x86_pkg_temp_thermal coretemp crc32_pclmul psmouse wmi_bmof i2c_i801 mei_me tpm_tis mei tpm_tis_core tpm thinkpad_acpi pcc_cpufreq ax88179_178a usbnet mii nouveau mxm_wmi i915 ttm i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops crc32c_intel serio_raw xhci_pci drm xhci_hcd i2c_core wmi video
[   10.163330] CPU: 4 PID: 98 Comm: kworker/4:1 Kdump: loaded Not tainted 4.18.0-rc8Lyude-Test+ #7
[   10.163349] Hardware name: LENOVO 20EQS64N0B/20EQS64N0B, BIOS N1EET78W (1.51 ) 05/18/2018
[   10.163370] Workqueue: pm pm_runtime_work
[   10.163404] RIP: 0010:gf119_disp_core_fini+0xe6/0x140 [nouveau]
[   10.163418] Code: 5e 41 5f 5d c3 49 8b 7c 24 10 48 8b 5f 50 48 85 db 74 5f e8 1c 5b 0f e1 48 89 da 48 c7 c7 b3 b2 4e a0 48 89 c6 e8 5c bf c8 e0 <0f> 0b 41 8b 47 50 85 c0 74 c6 49 8b 7c 24 78 48 81 c7 90 04 61 00
[   10.163476] RSP: 0018:ffffc90000a83b00 EFLAGS: 00010286
[   10.163489] RAX: 0000000000000000 RBX: ffff8808773c6bd0 RCX: 0000000000000006
[   10.163506] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff88089b515570
[   10.163523] RBP: ffffc90000a83b28 R08: 0000000000000000 R09: 0000000000aaaaaa
[   10.163539] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8808715b2c00
[   10.163556] R13: ffff88087779d780 R14: 00000001e68f0200 R15: ffff88086f91b000
[   10.163573] FS:  0000000000000000(0000) GS:ffff88089b500000(0000) knlGS:0000000000000000
[   10.163591] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.163605] CR2: 00007f3d7953d180 CR3: 000000000200a003 CR4: 00000000003606e0
[   10.163622] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   10.163639] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   10.163655] Call Trace:
[   10.163686]  nv50_disp_chan_fini+0x23/0x40 [nouveau]
[   10.163711]  nvkm_object_fini+0xbf/0x150 [nouveau]
[   10.163735]  nvkm_object_fini+0x76/0x150 [nouveau]
[   10.163759]  nvkm_object_fini+0x76/0x150 [nouveau]
[   10.163783]  nvkm_object_fini+0x76/0x150 [nouveau]
[   10.163807]  nvkm_object_fini+0x76/0x150 [nouveau]
[   10.163840]  nvkm_client_suspend+0x13/0x20 [nouveau]
[   10.163864]  nvif_client_suspend+0x1d/0x20 [nouveau]
[   10.163898]  nouveau_do_suspend+0x113/0x310 [nouveau]
[   10.163931]  nouveau_pmops_runtime_suspend+0x57/0xe0 [nouveau]
[   10.163947]  ? pci_has_legacy_pm_support+0x70/0x70
[   10.163960]  pci_pm_runtime_suspend+0x6b/0x180
[   10.163972]  ? pci_has_legacy_pm_support+0x70/0x70
[   10.163985]  ? pci_has_legacy_pm_support+0x70/0x70
[   10.163997]  __rpm_callback+0xcc/0x1e0
[   10.164009]  ? __switch_to_asm+0x40/0x70
[   10.164020]  ? pci_has_legacy_pm_support+0x70/0x70
[   10.164033]  rpm_callback+0x24/0x80
[   10.164043]  ? pci_has_legacy_pm_support+0x70/0x70
[   10.164055]  rpm_suspend+0x142/0x600
[   10.164066]  ? __switch_to_asm+0x40/0x70
[   10.164100]  pm_runtime_work+0x79/0x90
[   10.164112]  process_one_work+0x1b2/0x370
[   10.164140]  worker_thread+0x37/0x3a0
[   10.164150]  kthread+0x120/0x140
[   10.164160]  ? wq_update_unbound_numa+0x10/0x10
[   10.164172]  ? kthread_create_worker_on_cpu+0x70/0x70
[   10.164186]  ret_from_fork+0x35/0x40
[   10.164196] ---[ end trace d5c556c207f0c26b ]---

You'll notice from those traces that the very first evo kick happens
/after/ the mthd failure on the display channel, not before.
Additionally, there is no point at this part of the initialization
process where we actually call mthd 0000 from nouveau.

Upon closer inspection, I discovered that this mysterious phantom disp
failure seems to be the result of someone else (probably the VBIOS or
the BIOS of the P50) leaving the disp core channel enabled by the time
nouveau begins to start initializing it. This was confirmed by observing
that the 0x610490 register holds a value of 0x490a009b when the card is
in this broken state, as opposed to the usual 0x48070088 or 0x48000088
observed on most cards pre-init.

It appears we can fix this by checking for the unknown mask 0x000a0000,
and simply shutting down the channel like we normally would on suspend
or driver unload before we start trying to initialize it. This appears
to be close to what nouveau does for older cards, as a similar
workaround can be seen in nv50_disp_core_init().

Unfortunately, I'm still not entirely clear on what conditions actually
cause this problem to be reproduced. Everyone else I've talked to so far
with a P50 doesn't report ever having hit this issue. As well, I haven't
managed to find a clear reproducer for this besides rebooting the
machine until the bug happens, while alternating between booting while
docked and while on battery every so often.

This fixes most random initialization errors on my ThinkPad P50 with a
GM107 GPU.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: stable@vger.kernel.org
---
 .../drm/nouveau/nvkm/engine/disp/coregf119.c  | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/coregf119.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/coregf119.c
index d162b9cf4eac..7534b5e9246f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/coregf119.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/coregf119.c
@@ -166,8 +166,8 @@ gf119_disp_core_mthd = {
 	}
 };
 
-void
-gf119_disp_core_fini(struct nv50_disp_chan *chan)
+static bool
+gf119_disp_core_deactivate(struct nv50_disp_chan *chan)
 {
 	struct nvkm_subdev *subdev = &chan->disp->base.engine.subdev;
 	struct nvkm_device *device = subdev->device;
@@ -181,7 +181,16 @@ gf119_disp_core_fini(struct nv50_disp_chan *chan)
 	) < 0) {
 		nvkm_error(subdev, "core fini: %08x\n",
 			   nvkm_rd32(device, 0x610490));
+		return false;
 	}
+
+	return true;
+}
+
+void
+gf119_disp_core_fini(struct nv50_disp_chan *chan)
+{
+	gf119_disp_core_deactivate(chan);
 }
 
 static int
@@ -190,6 +199,14 @@ gf119_disp_core_init(struct nv50_disp_chan *chan)
 	struct nvkm_subdev *subdev = &chan->disp->base.engine.subdev;
 	struct nvkm_device *device = subdev->device;
 
+	/* attempt to unstick the channel from some unknown state */
+	if ((nvkm_rd32(device, 0x610490) & 0x000a0000) == 0x000a0000 &&
+	    WARN_ON(!gf119_disp_core_deactivate(chan))) {
+
+		nvkm_error(subdev, "core won't shut down, aborting\n");
+		return -EBUSY;
+	}
+
 	/* initialise channel for dma command submission */
 	nvkm_wr32(device, 0x610494, chan->push);
 	nvkm_wr32(device, 0x610498, 0x00010000);
-- 
2.17.1

