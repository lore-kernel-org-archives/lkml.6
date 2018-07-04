Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EF5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F362089D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F362089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbeGDOY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:24:29 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:14456 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751075AbeGDOY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:24:28 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jul 2018 10:24:28 EDT
From:   Snild Dolkow <snild@sony.com>
To:     Ingo Molnar <mingo@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Peter Enderborg <peter.enderborg@sony.com>,
        Yoshitaka Seto <yoshitaka.seto@sony.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Snild Dolkow <snild@sony.com>
Subject: [PATCH] kthread, tracing: Don't expose half-written comm when creating kthreads
Date:   Wed, 4 Jul 2018 16:10:53 +0200
Message-ID: <20180704141053.131811-1-snild@sony.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a window for racing when task->comm was being written. The
vsnprintf function writes 16 bytes, then counts the rest, then null
terminates. In the meantime, other threads could see the non-terminated
comm value. In our case, it got into the trace system's saved cmdlines
and could cause stack corruption when strcpy'd out of there.

The workaround in e09e28671 (use strlcpy in __trace_find_cmdline) was
likely needed because of this bug.

Solved by vsnprintf:ing to a local buffer, then using set_task_comm().

Signed-off-by: Snild Dolkow <snild@sony.com>
---
 kernel/kthread.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 481951bf091d..28874afbf747 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -319,8 +319,10 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 	task = create->result;
 	if (!IS_ERR(task)) {
 		static const struct sched_param param = { .sched_priority = 0 };
+		char name[TASK_COMM_LEN];
 
-		vsnprintf(task->comm, sizeof(task->comm), namefmt, args);
+		vsnprintf(name, sizeof(name), namefmt, args);
+		set_task_comm(task, name);
 		/*
 		 * root may have changed our (kthreadd's) priority or CPU mask.
 		 * The kernel thread should not inherit these properties.
-- 
2.15.1

