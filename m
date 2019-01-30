Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C26C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D514020989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfA3KQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:16:41 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbfA3KQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:16:40 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 674FB13114401F63A0B9;
        Wed, 30 Jan 2019 18:16:37 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 18:16:29 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <b.zolnierkie@samsung.com>, <keescook@chromium.org>,
        <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] video: fbdev: Fix potential NULL pointer dereference
Date:   Wed, 30 Jan 2019 18:16:25 +0800
Message-ID: <20190130101625.20048-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential NULL pointer dereference in case
fb_create_modedb() fails and returns NULL.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/video/fbdev/core/fbmon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index dd31289..3558a70 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -978,6 +978,8 @@ void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 	get_monspecs(edid, specs);
 
 	specs->modedb = fb_create_modedb(edid, &specs->modedb_len, specs);
+	if (!specs->modedb)
+		return;
 
 	/*
 	 * Workaround for buggy EDIDs that sets that the first
-- 
2.7.0


