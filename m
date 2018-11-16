Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6A9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B57A2089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B57A2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389642AbeKPVPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:15:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15111 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727534AbeKPVPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:15:02 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8C18AE62B7327;
        Fri, 16 Nov 2018 19:03:07 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Fri, 16 Nov 2018
 19:03:01 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <b.zolnierkie@samsung.com>, <daniel@zonque.org>,
        <robert.jarzmik@free.fr>
CC:     <linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] video: fbdev: pxafb: Fix "WARNING: invalid free of devm_ allocated data"
Date:   Fri, 16 Nov 2018 19:02:55 +0800
Message-ID: <20181116110255.19736-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'info->modes' got allocated with devm_kcalloc in of_get_pxafb_display.

This gives this error message:
  ./drivers/video/fbdev/pxafb.c:2238:2-7: WARNING: invalid free of devm_ allocated data

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/video/fbdev/pxafb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index bbed039..d59c8a5 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2234,10 +2234,8 @@ static struct pxafb_mach_info *of_pxafb_of_mach_info(struct device *dev)
 	if (!info)
 		return ERR_PTR(-ENOMEM);
 	ret = of_get_pxafb_mode_info(dev, info);
-	if (ret) {
-		kfree(info->modes);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	/*
 	 * On purpose, neither lccrX registers nor video memory size can be
-- 
2.7.0


