Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ACBC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1D720880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tom.com header.i=@tom.com header.b="OnuxfMgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1D720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeILT3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:29:05 -0400
Received: from smtprz15.163.net ([106.3.154.248]:27933 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726672AbeILT3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:29:05 -0400
Received: from antispam2.tom.com (unknown [172.25.16.56])
        by freemail02.tom.com (Postfix) with ESMTP id 14D58B00D40
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 21:58:38 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1536760718; bh=FYQpOGlwRE+h+7nqiGEOlqMW9cEEo1eWUN50qNhF0sU=;
        h=From:To:Cc:Subject:Date:From;
        b=OnuxfMgy8X6PH8Lb+X3VMdtPtxuuIPxHFt7GNI2NXR78YzcHI8Nh1LSdSGvpDfyJt
         2ZWqeclpmnNj1kuH4wYdjtudkSK5Mfl5AfjljC0H7T0gnpSOnVboKDcB75atBK/kd8
         mqWmorW+AZBVxNvzxtnnvSjsI/v+KetIiVVUf68k=
Received: from antispam2.tom.com (antispam2.tom.com [127.0.0.1])
        by antispam2.tom.com (Postfix) with ESMTP id 0EE588137D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 21:58:38 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam2.tom.com
Received: from antispam2.tom.com ([127.0.0.1])
        by antispam2.tom.com (antispam2.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QOEEjtNREcbV for <linux-kernel@vger.kernel.org>;
        Wed, 12 Sep 2018 21:58:37 +0800 (CST)
Received: from localhost.localdomain (unknown [171.216.70.25])
        by antispam2.tom.com (Postfix) with ESMTPA id A1CE981277;
        Wed, 12 Sep 2018 21:58:36 +0800 (CST)
From:   liusong@tom.com
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     liu.song11@zte.com.cn, linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: combine judgments in the loop of maybe_create_worker
Date:   Wed, 12 Sep 2018 21:58:29 +0800
Message-Id: <20180912135829.3832-1-liusong@tom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liu.song11@zte.com.cn>

Although the 'need_to_create_worker' has been determined to be
true before entering the function. However, adjusting the order
of judgment can combine two judgments in the loop. Also improve
the matching between logical operations and function naming.

Signed-off-by: Liu Song <liu.song11@zte.com.cn>
---
 kernel/workqueue.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 78b192071ef7..3c7c90d70dcf 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1969,13 +1969,10 @@ __acquires(&pool->lock)
 	mod_timer(&pool->mayday_timer, jiffies + MAYDAY_INITIAL_TIMEOUT);
 
 	while (true) {
-		if (create_worker(pool) || !need_to_create_worker(pool))
+		if (!need_to_create_worker(pool) || create_worker(pool))
 			break;
 
 		schedule_timeout_interruptible(CREATE_COOLDOWN);
-
-		if (!need_to_create_worker(pool))
-			break;
 	}
 
 	del_timer_sync(&pool->mayday_timer);
-- 
2.17.1

