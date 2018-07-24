Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D448EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B61320852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B61320852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbeGXEbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:31:53 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41954 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388085AbeGXEbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:31:52 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnz2-00032V-Qv; Mon, 23 Jul 2018 21:27:32 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnxP-0008AK-61; Mon, 23 Jul 2018 21:25:51 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 23 Jul 2018 22:24:10 -0500
Message-Id: <20180724032419.20231-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87efft5ncd.fsf_-_@xmission.com>
References: <87efft5ncd.fsf_-_@xmission.com>
X-XM-SPF: eid=1fhnxP-0008AK-61;;;mid=<20180724032419.20231-11-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18BXOQMa+i1cW0T8v+ZhKxJgZ510kwuq/c=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 11/20] signal: Pass pid type into send_sigio_to_task & send_sigurg_to_task
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This information is already present and using it directly simplifies the logic
of the code.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/fcntl.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 1523588fd759..5d596a00f40b 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -723,7 +723,7 @@ static inline int sigio_perm(struct task_struct *p,
 
 static void send_sigio_to_task(struct task_struct *p,
 			       struct fown_struct *fown,
-			       int fd, int reason, int group)
+			       int fd, int reason, enum pid_type type)
 {
 	/*
 	 * F_SETSIG can change ->signum lockless in parallel, make
@@ -767,11 +767,11 @@ static void send_sigio_to_task(struct task_struct *p,
 			else
 				si.si_band = mangle_poll(band_table[reason - POLL_IN]);
 			si.si_fd    = fd;
-			if (!do_send_sig_info(signum, &si, p, group))
+			if (!do_send_sig_info(signum, &si, p, type != PIDTYPE_PID))
 				break;
 		/* fall-through: fall back on the old plain SIGIO signal */
 		case 0:
-			do_send_sig_info(SIGIO, SEND_SIG_PRIV, p, group);
+			do_send_sig_info(SIGIO, SEND_SIG_PRIV, p, type != PIDTYPE_PID);
 	}
 }
 
@@ -780,14 +780,10 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
 	struct task_struct *p;
 	enum pid_type type;
 	struct pid *pid;
-	int group = 1;
 	
 	read_lock(&fown->lock);
 
 	type = fown->pid_type;
-	if (type == PIDTYPE_PID)
-		group = 0;
-
 	pid = fown->pid;
 	if (!pid)
 		goto out_unlock_fown;
@@ -795,12 +791,12 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
 	if (type <= PIDTYPE_TGID) {
 		rcu_read_lock();
 		p = pid_task(pid, PIDTYPE_PID);
-		send_sigio_to_task(p, fown, fd, band, group);
+		send_sigio_to_task(p, fown, fd, band, type);
 		rcu_read_unlock();
 	} else {
 		read_lock(&tasklist_lock);
 		do_each_pid_task(pid, type, p) {
-			send_sigio_to_task(p, fown, fd, band, group);
+			send_sigio_to_task(p, fown, fd, band, type);
 		} while_each_pid_task(pid, type, p);
 		read_unlock(&tasklist_lock);
 	}
@@ -809,10 +805,10 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
 }
 
 static void send_sigurg_to_task(struct task_struct *p,
-				struct fown_struct *fown, int group)
+				struct fown_struct *fown, enum pid_type type)
 {
 	if (sigio_perm(p, fown, SIGURG))
-		do_send_sig_info(SIGURG, SEND_SIG_PRIV, p, group);
+		do_send_sig_info(SIGURG, SEND_SIG_PRIV, p, type != PIDTYPE_PID);
 }
 
 int send_sigurg(struct fown_struct *fown)
@@ -820,15 +816,11 @@ int send_sigurg(struct fown_struct *fown)
 	struct task_struct *p;
 	enum pid_type type;
 	struct pid *pid;
-	int group = 1;
 	int ret = 0;
 	
 	read_lock(&fown->lock);
 
 	type = fown->pid_type;
-	if (type == PIDTYPE_PID)
-		group = 0;
-
 	pid = fown->pid;
 	if (!pid)
 		goto out_unlock_fown;
@@ -838,12 +830,12 @@ int send_sigurg(struct fown_struct *fown)
 	if (type <= PIDTYPE_TGID) {
 		rcu_read_lock();
 		p = pid_task(pid, PIDTYPE_PID);
-		send_sigurg_to_task(p, fown, group);
+		send_sigurg_to_task(p, fown, type);
 		rcu_read_unlock();
 	} else {
 		read_lock(&tasklist_lock);
 		do_each_pid_task(pid, type, p) {
-			send_sigurg_to_task(p, fown, group);
+			send_sigurg_to_task(p, fown, type);
 		} while_each_pid_task(pid, type, p);
 		read_unlock(&tasklist_lock);
 	}
-- 
2.17.1

