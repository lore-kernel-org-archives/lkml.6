Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCD5ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DE820671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DE820671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeINUZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:25:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12139 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbeINUZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:25:34 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F24A0AA3C414C;
        Fri, 14 Sep 2018 23:10:31 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Fri, 14 Sep 2018 23:10:32 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>
CC:     <seanpaul@chromium.org>, <daniel.vetter@ffwll.ch>,
        <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: nouveau: use match_string() helper to simplify the code
Date:   Fri, 14 Sep 2018 22:58:16 +0800
Message-ID: <1536937096-31093-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded implementation.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
index 6a4ca13..053d794 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
@@ -641,17 +641,13 @@ static int nv17_tv_create_resources(struct drm_encoder *encoder,
 	struct dcb_output *dcb = nouveau_encoder(encoder)->dcb;
 	int num_tv_norms = dcb->tvconf.has_component_output ? NUM_TV_NORMS :
 							NUM_LD_TV_NORMS;
-	int i;
+	int index;
 
 	if (nouveau_tv_norm) {
-		for (i = 0; i < num_tv_norms; i++) {
-			if (!strcmp(nv17_tv_norm_names[i], nouveau_tv_norm)) {
-				tv_enc->tv_norm = i;
-				break;
-			}
-		}
-
-		if (i == num_tv_norms)
+		index = match_string(nv17_tv_norm_names, num_tv_norms, nouveau_tv_norm);
+		if (index >= 0)
+			tv_enc->tv_norm = index;
+		else
 			NV_WARN(drm, "Invalid TV norm setting \"%s\"\n",
 				nouveau_tv_norm);
 	}
-- 
1.7.12.4

