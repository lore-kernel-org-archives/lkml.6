Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9FFC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 01:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0F2219A2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 01:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0F2219A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeHFD1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 23:27:33 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:49574 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbeHFD1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 23:27:33 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id CAC46D6F7818A062A773;
        Mon,  6 Aug 2018 09:20:53 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w761KiuS026262;
        Mon, 6 Aug 2018 09:20:44 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018080609204539-3234299 ;
          Mon, 6 Aug 2018 09:20:45 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     tj@kernel.org
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, wang.yi59@zte.com.cn,
        zhong.weidong@zte.com.cn
Subject: [PATCH] workqueue: fix memory leak in wq_numa_init()
Date:   Mon, 6 Aug 2018 09:20:39 +0800
Message-Id: <1533518439-3982-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-06 09:20:45,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-06 09:20:44,
        Serialize complete at 2018-08-06 09:20:44
X-MAIL: mse01.zte.com.cn w761KiuS026262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'tbl' variable may leak when return in function
wq_numa_init(), and this patch fixes this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 kernel/workqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 78b1920..9321a05 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5649,6 +5649,7 @@ static void __init wq_numa_init(void)
 		node = cpu_to_node(cpu);
 		if (WARN_ON(node == NUMA_NO_NODE)) {
 			pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
+			kfree(tbl);
 			/* happens iff arch is bonkers, let's just proceed */
 			return;
 		}
-- 
1.8.3.1

