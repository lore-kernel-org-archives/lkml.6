Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024A8C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC42921877
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC42921877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeHROQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:16:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40382 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbeHROQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:16:24 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ED44AF9F3030A;
        Sat, 18 Aug 2018 19:09:05 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Sat, 18 Aug 2018 19:09:03 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <tomi.valkeinen@ti.com>, <airlied@linux.ie>
CC:     <sre@kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <afd@ti.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] gpu: Use ERR_CAST to replace ERR_PTR(PTR_ERR())
Date:   Sat, 18 Aug 2018 18:57:12 +0800
Message-ID: <1534589832-65325-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We prefer to ERR_CAST rather than ERR_PTR(PTR_ERR()), So just
replace it.

The issue is detected with the help of Coccinelle

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/gpu/drm/omapdrm/dss/dss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dss.c b/drivers/gpu/drm/omapdrm/dss/dss.c
index cb80dda..1fc46b2 100644
--- a/drivers/gpu/drm/omapdrm/dss/dss.c
+++ b/drivers/gpu/drm/omapdrm/dss/dss.c
@@ -956,7 +956,7 @@ struct dss_debugfs_entry *
 				&dss_debug_fops);
 	if (IS_ERR(d)) {
 		kfree(entry);
-		return ERR_PTR(PTR_ERR(d));
+		return ERR_CAST(d);
 	}
 
 	entry->dentry = d;
-- 
1.7.12.4

