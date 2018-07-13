Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0FDECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AB2208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AB2208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbeGMIKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:10:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9235 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729284AbeGMIKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:10:52 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 138709596BA09;
        Fri, 13 Jul 2018 15:57:08 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 15:57:00 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <FlorianSchandinat@gmx.de>, <b.zolnierkie@samsung.com>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-fbdev@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] video: fbdev: via: hide unused procfs helpers
Date:   Fri, 13 Jul 2018 15:56:25 +0800
Message-ID: <20180713075625.11252-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PROC_FS isn't set, gcc warning this:

drivers/video/fbdev/via/viafbdev.c:1471:12: warning: ‘viafb_sup_odev_proc_show’ defined but not used [-Wunused-function]
 static int viafb_sup_odev_proc_show(struct seq_file *m, void *v)
            ^
fix this by adding #ifdef around it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/video/fbdev/via/viafbdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index d2f7850..edca3e0 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -1468,12 +1468,14 @@ static const struct file_operations viafb_vt1636_proc_fops = {
 
 #endif /* CONFIG_FB_VIA_DIRECT_PROCFS */
 
+#ifdef CONFIG_PROC_FS
 static int viafb_sup_odev_proc_show(struct seq_file *m, void *v)
 {
 	via_odev_to_seq(m, supported_odev_map[
 		viaparinfo->shared->chip_info.gfx_chip_name]);
 	return 0;
 }
+#endif
 
 static ssize_t odev_update(const char __user *buffer, size_t count, u32 *odev)
 {
-- 
2.7.0


