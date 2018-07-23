Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6925ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC0920685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC0920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388219AbeGWOnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:43:33 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:18153 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387989AbeGWOnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:43:32 -0400
From:   Snild Dolkow <snild@sony.com>
To:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Peter Enderborg <peter.enderborg@sony.com>,
        Yoshitaka Seto <yoshitaka.seto@sony.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        John Stultz <john.stultz@linaro.org>,
        Snild Dolkow <snild@sony.com>
Subject: [PATCH RESEND] kthread, tracing: Don't expose half-written comm when creating kthreads
Date:   Mon, 23 Jul 2018 15:42:10 +0200
Message-ID: <20180723134210.54013-1-snild@sony.com>
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

