Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B932C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ED420852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3ED420852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeGXE3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:29:21 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51230 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeGXE3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:29:19 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnwb-0007Rq-1u; Mon, 23 Jul 2018 21:25:01 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnwa-0008AK-Eb; Mon, 23 Jul 2018 21:25:00 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 23 Jul 2018 22:24:01 -0500
Message-Id: <20180724032419.20231-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87efft5ncd.fsf_-_@xmission.com>
References: <87efft5ncd.fsf_-_@xmission.com>
X-XM-SPF: eid=1fhnwa-0008AK-Eb;;;mid=<20180724032419.20231-2-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/OE8+23Pb3kzcjL4iQJKQplTeZuYX1/NE=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 02/20] pids: Move task_pid_type into sched/signal.h
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is general and inline so there is no need
to hide it inside of exit.c

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h | 8 ++++++++
 kernel/exit.c                | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 113d1ad1ced7..d8ef0a3d2e7e 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -556,6 +556,14 @@ extern bool current_is_single_threaded(void);
 typedef int (*proc_visitor)(struct task_struct *p, void *data);
 void walk_process_tree(struct task_struct *top, proc_visitor, void *);
 
+static inline
+struct pid *task_pid_type(struct task_struct *task, enum pid_type type)
+{
+	if (type != PIDTYPE_PID)
+		task = task->group_leader;
+	return task->pids[type].pid;
+}
+
 static inline int get_nr_threads(struct task_struct *tsk)
 {
 	return tsk->signal->nr_threads;
diff --git a/kernel/exit.c b/kernel/exit.c
index c3c7ac560114..16432428fc6c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1001,14 +1001,6 @@ struct wait_opts {
 	int			notask_error;
 };
 
-static inline
-struct pid *task_pid_type(struct task_struct *task, enum pid_type type)
-{
-	if (type != PIDTYPE_PID)
-		task = task->group_leader;
-	return task->pids[type].pid;
-}
-
 static int eligible_pid(struct wait_opts *wo, struct task_struct *p)
 {
 	return	wo->wo_type == PIDTYPE_MAX ||
-- 
2.17.1

