Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB95C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C7B20989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C7B20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbeK0Tid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:38:33 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15165 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728985AbeK0Tic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:38:32 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 753D22EF3CED7;
        Tue, 27 Nov 2018 16:41:21 +0800 (CST)
Received: from HGHY1y003799431.china.huawei.com (10.177.245.162) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Tue, 27 Nov 2018 16:41:17 +0800
From:   <yezengruan@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-fbdev@vger.kernel.org>
CC:     <wanghaibin@huawei.com>, <yezengruan@huawei.com>
Subject: [PATCH] [BUG REPORT] Panic with sys_imageblit on arm64
Date:   Tue, 27 Nov 2018 16:41:00 +0800
Message-ID: <1543308060-13932-1-git-send-email-yezengruan@huawei.com>
X-Mailer: git-send-email 2.7.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.245.162]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yezengruan <yezengruan@huawei.com>

Hi all,

When I run linux-4.19.2 on arm64, I got panic in sys_imageblit. My test steps are as fllows:
1) Remote login using BMC;
2) Enter a bunch of 'Enter' keys;
3) Execute the 'top' command and continuously press shift + page up several times.

This gives the following panic on the serial console:

[47229.923256] Unable to handle kernel paging request at virtual address ffff00002f0bc010
[47229.923258] Mem abort info:
[47229.923259]   ESR = 0x96000047
[47229.923261]   Exception class = DABT (current EL), IL = 32 bits
[47229.923262]   SET = 0, FnV = 0
[47229.923263]   EA = 0, S1PTW = 0
[47229.923263] Data abort info:
[47229.923265]   ISV = 0, ISS = 0x00000047
[47229.923265]   CM = 0, WnR = 1
[47229.923269] swapper pgtable: 4k pages, 48-bit VAs, pgdp = 00000000ea9a862f
[47229.923270] [ffff00002f0bc010] pgd=000000dffbffe803, pud=000000dffbffd803, pmd=000000bf758ee003, pte=0000000000000000
[47229.923279] Internal error: Oops: 96000047 [#1] SMP
[47229.923285] CPU: 45 PID: 16061 Comm: top Kdump: loaded Tainted: G           OE     4.19.2-1.1.23.aarch64 #1
[47229.923286] Hardware name: Huawei Taishan 2280 /BC11SPCD, BIOS 1.46 03/29/2018
[47229.923288] pstate: 80000005 (Nzcv daif -PAN -UAO)
[47229.923295] pc : sys_imageblit+0x414/0x1000 [sysimgblt]
[47229.923317] lr : drm_fb_helper_sys_imageblit+0x28/0x50 [drm_kms_helper]
[47229.923318] sp : ffff00002f6d3820
[47229.923319] x29: ffff00002f6d3820 x28: 00000000000000ff
[47229.923322] x27: 0000000000000010 x26: 0000000000000001
[47229.923325] x25: 0000000000000118 x24: 0000000000000008
[47229.923327] x23: ffff805f771db800 x22: 0000000000000000
[47229.923330] x21: ffff00002f6d3958 x20: ffff00002f0bc010
[47229.923332] x19: 0000000000000000 x18: 0000000000000000
[47229.923335] x17: 0000000000000000 x16: 0000000000000000
[47229.923337] x15: 0000000000000000 x14: 2020202020202020
[47229.923339] x13: 2020202064686374 x12: ffff805f77927360
[47229.923342] x11: ffff000000f54078 x10: 0000000000000023
[47229.923344] x9 : 000000000000000f x8 : 0000000000000003
[47229.923346] x7 : 000000000000008c x6 : 0000000000000002
[47229.923349] x5 : 0000000000000000 x4 : 00000000ad55ad55
[47229.923352] x3 : ffff805f77927360 x2 : 0000000000000000
[47229.923354] x1 : 0000000000000006 x0 : 0000000000000000
[47229.923357] Process top (pid: 16061, stack limit = 0x00000000d490d156)
[47229.923359] Call trace:
[47229.923363]  sys_imageblit+0x414/0x1000 [sysimgblt]
[47229.923373]  drm_fb_helper_sys_imageblit+0x28/0x50 [drm_kms_helper]
[47229.923387]  bit_putcs+0x29c/0x4a0
[47229.923391]  fbcon_putcs+0x110/0x148
[47229.923397]  do_update_region+0x138/0x1d8
[47229.923399]  do_con_trol+0xb44/0x13e0
[47229.923400]  do_con_write.part.29+0x1d0/0x8f0
[47229.923402]  con_write+0x70/0x78
[47229.923405]  n_tty_write+0x1a8/0x428
[47229.923407]  tty_write+0x1bc/0x2f0
[47229.923412]  __vfs_write+0x60/0x1a8
[47229.923414]  vfs_write+0xb0/0x1a8
[47229.923416]  ksys_write+0x6c/0xd8
[47229.923418]  __arm64_sys_write+0x28/0x38
[47229.923424]  el0_svc_common+0xb8/0x118
[47229.923426]  el0_svc_handler+0x38/0x88
[47229.923429]  el0_svc+0x8/0xc
[47229.923431] Code: 0a080000 b8605960 0a000080 4a050000 (b8227a80)
[47229.923436] [kbox] die event detected

I followed the same test steps and found the same problem in the linux-4.20.0-rc3.
In the test I found that if the variable bitstart in function sys_imageblit is greater than variable p->screen_size - 1, the kernel will panic.
The following patch seems to work fine in my test:
---
 drivers/video/fbdev/core/sysimgblt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/core/sysimgblt.c b/drivers/video/fbdev/core/sysimgblt.c
index a4d05b1..b316404 100644
--- a/drivers/video/fbdev/core/sysimgblt.c
+++ b/drivers/video/fbdev/core/sysimgblt.c
@@ -254,6 +254,9 @@ void sys_imageblit(struct fb_info *p, const struct fb_image *image)
 
 	bitstart /= 8;
 	bitstart &= ~(bpl - 1);
+	if (p->screen_size - 1 < bitstart)
+		return;
+
 	dst1 = (void __force *)p->screen_base + bitstart;
 
 	if (p->fbops->fb_sync)
-- 
1.8.3.1


