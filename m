Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E79C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E4D2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bf39QKyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E4D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbeJYWtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728155AbeJYWtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:06 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD9CB2085B;
        Thu, 25 Oct 2018 14:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476968;
        bh=blCUGrSUQMSdWdwcP4PLiaA7yejzPVeaogooTANOBWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bf39QKyf9H8XuWevvimKft0YNn1Jzr4HZoy/zXNq9oUWiApMuDQAHPN9y6efzOP0s
         ngGAxGtBY219IR43vgeIA/YYyKwT7GNEdNTyraOTwW90Ig22++DWc8f+faPjylatYs
         H1/T6yqry3DIM4lWCfSi2VOFMVNMd1zD/Z9tLP7M=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 71/98] drm: bochs: Don't remove uninitialized fbdev framebuffer
Date:   Thu, 25 Oct 2018 10:13:56 -0400
Message-Id: <20181025141423.213774-71-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>

[ Upstream commit 4fa13dbe8c86382a846584e65c47bce09297f75b ]

In the same spirit of the fix for QXL in commit 861078381ba5 ("drm: qxl:
Don't alloc fbdev if emulation is not supported"), prevent the Oops in
the unbind path of Bochs if fbdev emulation is disabled.

[  112.176009] Oops: 0002 [#1] SMP
[  112.176009] Modules linked in: bochs_drm
[  112.176009] CPU: 0 PID: 3002 Comm: bash Not tainted 4.11.0-rc1+ #111
[  112.176009] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-20161025_171302-gandalf 04/01/2014
[  112.176009] task: ffff8800743bbac0 task.stack: ffffc90000b5c000
[  112.176009] RIP: 0010:mutex_lock+0x18/0x30
[  112.176009] RSP: 0018:ffffc90000b5fc78 EFLAGS: 00010246
[  112.176009] RAX: 0000000000000000 RBX: 0000000000000260 RCX: 0000000000000000
[  112.176009] RDX: ffff8800743bbac0 RSI: ffff8800787176e0 RDI: 0000000000000260
[  112.176009] RBP: ffffc90000b5fc80 R08: ffffffff00000000 R09: 00000000ffffffff
[  112.176009] R10: ffff88007b463650 R11: 0000000000000000 R12: 0000000000000260
[  112.176009] R13: ffff8800787176e0 R14: ffffffffa0003068 R15: 0000000000000060
[  112.176009] FS:  00007f20564c7b40(0000) GS:ffff88007ce00000(0000) knlGS:0000000000000000
[  112.176009] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  112.176009] CR2: 0000000000000260 CR3: 000000006b89c000 CR4: 00000000000006f0
[  112.176009] Call Trace:
[  112.176009]  drm_mode_object_unregister+0x1e/0x50
[  112.176009]  drm_framebuffer_unregister_private+0x15/0x20
[  112.176009]  bochs_fbdev_fini+0x57/0x70 [bochs_drm]
[  112.176009]  bochs_unload+0x16/0x50 [bochs_drm]
[  112.176009]  drm_dev_unregister+0x37/0xd0
[  112.176009]  drm_put_dev+0x31/0x60
[  112.176009]  bochs_pci_remove+0x10/0x20 [bochs_drm]
[  112.176009]  pci_device_remove+0x34/0xb0
[  112.176009]  device_release_driver_internal+0x150/0x200
[  112.176009]  device_release_driver+0xd/0x10
[  112.176009]  unbind_store+0x108/0x150
[  112.176009]  drv_attr_store+0x20/0x30
[  112.176009]  sysfs_kf_write+0x32/0x40
[  112.176009]  kernfs_fop_write+0x10b/0x190
[  112.176009]  __vfs_write+0x23/0x120
[  112.176009]  ? security_file_permission+0x36/0xb0
[  112.176009]  ? rw_verify_area+0x49/0xb0
[  112.176009]  vfs_write+0xb0/0x190
[  112.176009]  SyS_write+0x41/0xa0
[  112.176009]  entry_SYSCALL_64_fastpath+0x1a/0xa9
[  112.176009] RIP: 0033:0x7f2055bd5620
[  112.176009] RSP: 002b:00007ffed2f487d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  112.176009] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2055bd5620
[  112.176009] RDX: 000000000000000d RSI: 0000000000ee0008 RDI: 0000000000000001
[  112.176009] RBP: 0000000000000001 R08: 00007f2055e94760 R09: 00007f20564c7b40
[  112.176009] R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000000
[  112.176009] R13: 00007ffed2f48d70 R14: 0000000000000000 R15: 0000000000000000
[  112.176009] Code: 00 00 00 55 be 02 00 00 00 48 89 e5 e8 62 fb ff ff 5d c3 55 48 89 e5 53 48 89 fb e8 53 e9 ff ff 65 48 8b 14 25 40 c4 00 00 31 c0 <f0> 48 0f b1 13 48 85 c0 74 08 48 89 df e8c6 ff ff ff 5b 5d c3
[  112.176009] RIP: mutex_lock+0x18/0x30 RSP: ffffc90000b5fc78
[  112.176009] CR2: 0000000000000260
[  112.205622] ---[ end trace 76189cd7a9bdd155 ]---

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Link: http://patchwork.freedesktop.org/patch/msgid/20170317181409.4183-1-krisman@collabora.co.uk
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bochs/bochs_fbdev.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
index e1ec498a6b6e..35f40255644d 100644
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
@@ -138,6 +138,7 @@ static int bochsfb_create(struct drm_fb_helper *helper,
 	info->fix.smem_start = 0;
 	info->fix.smem_len = size;
 
+	bochs->fb.initialized = true;
 	return 0;
 }
 
@@ -155,7 +156,6 @@ static int bochs_fbdev_destroy(struct bochs_device *bochs)
 		gfb->obj = NULL;
 	}
 
-	drm_fb_helper_fini(&bochs->fb.helper);
 	drm_framebuffer_unregister_private(&gfb->base);
 	drm_framebuffer_cleanup(&gfb->base);
 
@@ -188,7 +188,6 @@ int bochs_fbdev_init(struct bochs_device *bochs)
 	if (ret)
 		goto fini;
 
-	bochs->fb.initialized = true;
 	return 0;
 
 fini:
@@ -198,9 +197,9 @@ int bochs_fbdev_init(struct bochs_device *bochs)
 
 void bochs_fbdev_fini(struct bochs_device *bochs)
 {
-	if (!bochs->fb.initialized)
-		return;
+	if (bochs->fb.initialized)
+		bochs_fbdev_destroy(bochs);
 
-	bochs_fbdev_destroy(bochs);
+	drm_fb_helper_fini(&bochs->fb.helper);
 	bochs->fb.initialized = false;
 }
-- 
2.17.1

