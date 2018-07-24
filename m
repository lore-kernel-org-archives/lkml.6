Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C44AECDFBB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB6C20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB6C20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388324AbeGXEaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:30:05 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41877 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388244AbeGXEaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:30:03 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnxJ-0002pj-3g; Mon, 23 Jul 2018 21:25:45 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnxI-0008AK-1e; Mon, 23 Jul 2018 21:25:44 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 23 Jul 2018 22:24:07 -0500
Message-Id: <20180724032419.20231-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87efft5ncd.fsf_-_@xmission.com>
References: <87efft5ncd.fsf_-_@xmission.com>
X-XM-SPF: eid=1fhnxI-0008AK-1e;;;mid=<20180724032419.20231-8-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+1JkB6lJppQ4R50rte1YkCol4ZlHtp4x0=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 08/20] posix-timers: Noralize good_sigevent
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In good_sigevent directly compute the default return value as
"task_tgid(current)".  This is exactly the same as
"task_pid(current->group_leader)" but written more clearly.

In the thread case first compute the thread's pid.  Then veify that
attached to that pid is a thread of the current thread group.

This has the net effect of making the code a little clearer, and
making it obvious that posix timers never look up a process by a the
pid of a thread.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/time/posix-timers.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index e08ce3f27447..2bdf08a2bae9 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -433,11 +433,13 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 
 static struct pid *good_sigevent(sigevent_t * event)
 {
-	struct task_struct *rtn = current->group_leader;
+	struct pid *pid = task_tgid(current);
+	struct task_struct *rtn;
 
 	switch (event->sigev_notify) {
 	case SIGEV_SIGNAL | SIGEV_THREAD_ID:
-		rtn = find_task_by_vpid(event->sigev_notify_thread_id);
+		pid = find_vpid(event->sigev_notify_thread_id);
+		rtn = pid_task(pid, PIDTYPE_PID);
 		if (!rtn || !same_thread_group(rtn, current))
 			return NULL;
 		/* FALLTHRU */
@@ -447,7 +449,7 @@ static struct pid *good_sigevent(sigevent_t * event)
 			return NULL;
 		/* FALLTHRU */
 	case SIGEV_NONE:
-		return task_pid(rtn);
+		return pid;
 	default:
 		return NULL;
 	}
-- 
2.17.1

