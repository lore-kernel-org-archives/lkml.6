Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B5FC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14BA2086D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uY33KcZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14BA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbeKDXHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:07:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:45080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730164AbeKDXHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC54220862;
        Sun,  4 Nov 2018 13:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339539;
        bh=xZXo0NyrnN9ENqHCMkPUPa3ZpIa13R7fzVlMeDCtsmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uY33KcZY5qGKQMVJe2nyHuqHlPaYoaXkWEhWwyaR0rHpRMCJxOX2QSDzTK1egTw3p
         hMLvHkbia+JRj95gMn5z/fACmZ9Ee8p7OgY/NCVaYEBOJU3ukpesWtRcrwiMoc3RjV
         izZebbfoOJNE8clAXK3jzQscqMgY6jFf8yisuDqY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 34/57] drm/hisilicon: hibmc: Do not carry error code in HiBMC framebuffer pointer
Date:   Sun,  4 Nov 2018 08:51:21 -0500
Message-Id: <20181104135144.88324-34-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

[ Upstream commit 331d880b35a76b5de0eec8cbcecbf615d758a5f9 ]

In hibmc_drm_fb_create(), when the call to hibmc_framebuffer_init() fails
with error, do not store the error code in the HiBMC device frame-buffer
pointer, as this will be later checked for non-zero value in
hibmc_fbdev_destroy() when our intention is to check for a valid function
pointer.

This fixes the following crash:
[    9.699791] Unable to handle kernel NULL pointer dereference at virtual address 000000000000001a
[    9.708672] Mem abort info:
[    9.711489]   ESR = 0x96000004
[    9.714570]   Exception class = DABT (current EL), IL = 32 bits
[    9.720551]   SET = 0, FnV = 0
[    9.723631]   EA = 0, S1PTW = 0
[    9.726799] Data abort info:
[    9.729702]   ISV = 0, ISS = 0x00000004
[    9.733573]   CM = 0, WnR = 0
[    9.736566] [000000000000001a] user address but active_mm is swapper
[    9.742987] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    9.748614] Modules linked in:
[    9.751694] CPU: 16 PID: 293 Comm: kworker/16:1 Tainted: G        W         4.19.0-rc4-next-20180920-00001-g9b0012c #322
[    9.762681] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21 Nemo 2.0 RC0 04/18/2018
[    9.771915] Workqueue: events work_for_cpu_fn
[    9.776312] pstate: 60000005 (nZCv daif -PAN -UAO)
[    9.781150] pc : drm_mode_object_put+0x0/0x20
[    9.785547] lr : hibmc_fbdev_fini+0x40/0x58
[    9.789767] sp : ffff00000af1bcf0
[    9.793108] x29: ffff00000af1bcf0 x28: 0000000000000000
[    9.798473] x27: 0000000000000000 x26: ffff000008f66630
[    9.803838] x25: 0000000000000000 x24: ffff0000095abb98
[    9.809203] x23: ffff8017db92fe00 x22: ffff8017d2b13000
[    9.814568] x21: ffffffffffffffea x20: ffff8017d2f80018
[    9.819933] x19: ffff8017d28a0018 x18: ffffffffffffffff
[    9.825297] x17: 0000000000000000 x16: 0000000000000000
[    9.830662] x15: ffff0000092296c8 x14: ffff00008939970f
[    9.836026] x13: ffff00000939971d x12: ffff000009229940
[    9.841391] x11: ffff0000085f8fc0 x10: ffff00000af1b9a0
[    9.846756] x9 : 000000000000000d x8 : 6620657a696c6169
[    9.852121] x7 : ffff8017d3340580 x6 : ffff8017d4168000
[    9.857486] x5 : 0000000000000000 x4 : ffff8017db92fb20
[    9.862850] x3 : 0000000000002690 x2 : ffff8017d3340480
[    9.868214] x1 : 0000000000000028 x0 : 0000000000000002
[    9.873580] Process kworker/16:1 (pid: 293, stack limit = 0x(____ptrval____))
[    9.880788] Call trace:
[    9.883252]  drm_mode_object_put+0x0/0x20
[    9.887297]  hibmc_unload+0x1c/0x80
[    9.890815]  hibmc_pci_probe+0x170/0x3c8
[    9.894773]  local_pci_probe+0x3c/0xb0
[    9.898555]  work_for_cpu_fn+0x18/0x28
[    9.902337]  process_one_work+0x1e0/0x318
[    9.906382]  worker_thread+0x228/0x450
[    9.910164]  kthread+0x128/0x130
[    9.913418]  ret_from_fork+0x10/0x18
[    9.917024] Code: a94153f3 a8c27bfd d65f03c0 d503201f (f9400c01)
[    9.923180] ---[ end trace 2695ffa0af5be375 ]---

Fixes: d1667b86795a ("drm/hisilicon/hibmc: Add support for frame buffer")
Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Signed-off-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
index b92595c477ef..8bd29075ae4e 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
@@ -122,6 +122,7 @@ static int hibmc_drm_fb_create(struct drm_fb_helper *helper,
 	hi_fbdev->fb = hibmc_framebuffer_init(priv->dev, &mode_cmd, gobj);
 	if (IS_ERR(hi_fbdev->fb)) {
 		ret = PTR_ERR(hi_fbdev->fb);
+		hi_fbdev->fb = NULL;
 		DRM_ERROR("failed to initialize framebuffer: %d\n", ret);
 		goto out_release_fbi;
 	}
-- 
2.17.1

