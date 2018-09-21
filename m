Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C51ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937E320673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937E320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390994AbeIUXSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:18:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46772 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390365AbeIUXSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:18:04 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6EB3983C25ECD;
        Sat, 22 Sep 2018 01:28:09 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Sat, 22 Sep 2018 01:28:03 +0800
From:   John Garry <john.garry@huawei.com>
To:     <z.liuxinliang@hisilicon.com>, <kong.kongxinwei@hisilicon.com>,
        <puck.chen@hisilicon.com>, <airlied@linux.ie>
CC:     <linuxarm@huawei.com>, <chris@chris-wilson.co.uk>,
        <dri-devel@lists.freedesktop.org>, <baowenyi@huawei.com>,
        <linux-kernel@vger.kernel.org>, <zourongrong@gmail.com>,
        <daniel.vetter@ffwll.ch>, John Garry <john.garry@huawei.com>
Subject: [PATCH 1/3] drm/hisilicon: hibmc: Do not carry error code in HiBMC framebuffer pointer
Date:   Sat, 22 Sep 2018 01:25:25 +0800
Message-ID: <1537550727-21257-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537550727-21257-1-git-send-email-john.garry@huawei.com>
References: <1537550727-21257-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
index b92595c..8bd2907 100644
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
1.9.1

