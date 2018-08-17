Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D868C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 02:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3C620C0A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 02:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3C620C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeHQFhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 01:37:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11125 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725833AbeHQFhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 01:37:32 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 06D796F6248E3;
        Fri, 17 Aug 2018 10:35:58 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.399.0; Fri, 17 Aug 2018 10:35:56 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <shawnguo@kernel.org>, <airlied@linux.ie>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] gpu: do not double put device node in zx_drm_probe
Date:   Fri, 17 Aug 2018 10:24:06 +0800
Message-ID: <1534472646-10368-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for_each_available_child_of_node will get and put the node properly,
the following of_node_put will lead to the double put. So just
remove it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/gpu/drm/zte/zx_drm_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/zte/zx_drm_drv.c b/drivers/gpu/drm/zte/zx_drm_drv.c
index 6f4205e8..d7b9870 100644
--- a/drivers/gpu/drm/zte/zx_drm_drv.c
+++ b/drivers/gpu/drm/zte/zx_drm_drv.c
@@ -161,10 +161,8 @@ static int zx_drm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	for_each_available_child_of_node(parent, child) {
+	for_each_available_child_of_node(parent, child)
 		component_match_add(dev, &match, compare_of, child);
-		of_node_put(child);
-	}
 
 	return component_master_add_with_match(dev, &zx_drm_master_ops, match);
 }
-- 
1.7.12.4

