Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190BCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 07:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD0720872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 07:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD0720872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeKKQ6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 11:58:32 -0500
Received: from asrmicro.com ([210.13.118.86]:47090 "EHLO mail2012.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbeKKQ6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 11:58:32 -0500
Received: from localhost (10.38.17.127) by mail2012.asrmicro.com (10.1.24.123)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Sun, 11 Nov 2018 15:10:26
 +0800
From:   Zhizhou Zhang <zhizhouzhang@asrmicro.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <zhizhouzhang@asrmicro.com>,
        <zhizhouzh@gmail.com>
Subject: [PATCH] ftrace: remove KASAN poison in ftrace_ops_test()
Date:   Sun, 11 Nov 2018 23:10:17 +0800
Message-ID: <1541949017-3001-1-git-send-email-zhizhouzhang@asrmicro.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.38.17.127]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrace_ops_test() passed local varible parameter to hash_contains_ip(),
which could result KASAN stack-out-of-bounds warning.

Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
---
 kernel/trace/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f536f60..6e11f90 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1522,6 +1522,8 @@ ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
 	rcu_assign_pointer(hash.filter_hash, ops->func_hash->filter_hash);
 	rcu_assign_pointer(hash.notrace_hash, ops->func_hash->notrace_hash);
 
+	kasan_unpoison_task_stack(current);
+
 	if (hash_contains_ip(ip, &hash))
 		ret = 1;
 	else
-- 
2.7.4

