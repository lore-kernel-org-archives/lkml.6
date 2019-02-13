Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1077C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B086222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404072AbfBMMZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:25:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727981AbfBMMZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:25:03 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 82A97577AD98EE5C5761;
        Wed, 13 Feb 2019 20:24:57 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Wed, 13 Feb 2019
 20:24:50 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <miaoxie@huawei.com>
Subject: [PATCH] tracing: fix incorrect tracer freeing when opening tracing pipe
Date:   Wed, 13 Feb 2019 20:29:06 +0800
Message-ID: <1550060946-45984-1-git-send-email-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d716ff71dd12 ("tracing: Remove taking of trace_types_lock in
pipe files") use the current tracer instead of the copy in
tracing_open_pipe(), but it forget to remove the freeing sentence in
the error path.

Fixes: d716ff71dd12 ("tracing: Remove taking of trace_types_lock in pipe files")
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 kernel/trace/trace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c521b73..b583ff7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5624,7 +5624,6 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 	return ret;
 
 fail:
-	kfree(iter->trace);
 	kfree(iter);
 	__trace_array_put(tr);
 	mutex_unlock(&trace_types_lock);
-- 
2.7.4

