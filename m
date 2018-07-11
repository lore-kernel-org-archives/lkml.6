Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB11AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFC5208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFC5208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbeGKCst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:48:49 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40194 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732316AbeGKCsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:48:35 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd59F-0001AX-Ap; Tue, 10 Jul 2018 20:46:33 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd59D-00063R-1t; Tue, 10 Jul 2018 20:46:33 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 10 Jul 2018 21:44:56 -0500
Message-Id: <20180711024459.10654-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <877em2jxyr.fsf_-_@xmission.com>
References: <877em2jxyr.fsf_-_@xmission.com>
X-XM-SPF: eid=1fd59D-00063R-1t;;;mid=<20180711024459.10654-8-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/WnnXwhn54/Lx0RIHXRHL92OSpQD4qNmo=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH 08/11] signal: Use PIDTYPE_TGID to clearly store where file signals will be sent
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When f_setown is called a pid and a pid type are stored.  Replace the use
of PIDTYPE_PID with PIDTYPE_TGID as PIDTYPE_TGID goes to the entire thread
group.  Replace the use of PIDTYPE_MAX with PIDTYPE_PID as PIDTYPE_PID now
is only for a thread.

Update the users of __f_setown to use PIDTYPE_TGID instead of
PIDTYPE_PID, and gather the pid with task_tgid.  As the intent of
PIDTYPE_PID was a thread group level owner.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/net/tun.c           |  2 +-
 drivers/tty/tty_io.c        |  4 ++--
 fs/fcntl.c                  | 20 ++++++++------------
 fs/locks.c                  |  2 +-
 fs/notify/dnotify/dnotify.c |  3 ++-
 5 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index a192a017cc68..4219735a5418 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3216,7 +3216,7 @@ static int tun_chr_fasync(int fd, struct file *file, int on)
 		goto out;
 
 	if (on) {
-		__f_setown(file, task_pid(current), PIDTYPE_PID, 0);
+		__f_setown(file, task_tgid(current), PIDTYPE_TGID, 0);
 		tfile->flags |= TUN_FASYNC;
 	} else
 		tfile->flags &= ~TUN_FASYNC;
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index aba59521ad48..cec58c53b0c4 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2121,8 +2121,8 @@ static int __tty_fasync(int fd, struct file *filp, int on)
 			pid = tty->pgrp;
 			type = PIDTYPE_PGID;
 		} else {
-			pid = task_pid(current);
-			type = PIDTYPE_PID;
+			pid = task_tgid(current);
+			type = PIDTYPE_TGID;
 		}
 		get_pid(pid);
 		spin_unlock_irqrestore(&tty->ctrl_lock, flags);
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 12273b6ea56d..cf10909cfa0a 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -116,7 +116,7 @@ int f_setown(struct file *filp, unsigned long arg, int force)
 	struct pid *pid = NULL;
 	int who = arg, ret = 0;
 
-	type = PIDTYPE_PID;
+	type = PIDTYPE_TGID;
 	if (who < 0) {
 		/* avoid overflow below */
 		if (who == INT_MIN)
@@ -143,7 +143,7 @@ EXPORT_SYMBOL(f_setown);
 
 void f_delown(struct file *filp)
 {
-	f_modown(filp, NULL, PIDTYPE_PID, 1);
+	f_modown(filp, NULL, PIDTYPE_TGID, 1);
 }
 
 pid_t f_getown(struct file *filp)
@@ -171,11 +171,11 @@ static int f_setown_ex(struct file *filp, unsigned long arg)
 
 	switch (owner.type) {
 	case F_OWNER_TID:
-		type = PIDTYPE_MAX;
+		type = PIDTYPE_PID;
 		break;
 
 	case F_OWNER_PID:
-		type = PIDTYPE_PID;
+		type = PIDTYPE_TGID;
 		break;
 
 	case F_OWNER_PGRP:
@@ -206,11 +206,11 @@ static int f_getown_ex(struct file *filp, unsigned long arg)
 	read_lock(&filp->f_owner.lock);
 	owner.pid = pid_vnr(filp->f_owner.pid);
 	switch (filp->f_owner.pid_type) {
-	case PIDTYPE_MAX:
+	case PIDTYPE_PID:
 		owner.type = F_OWNER_TID;
 		break;
 
-	case PIDTYPE_PID:
+	case PIDTYPE_TGID:
 		owner.type = F_OWNER_PID;
 		break;
 
@@ -785,10 +785,8 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
 	read_lock(&fown->lock);
 
 	type = fown->pid_type;
-	if (type == PIDTYPE_MAX) {
+	if (type == PIDTYPE_PID)
 		group = 0;
-		type = PIDTYPE_PID;
-	}
 
 	pid = fown->pid;
 	if (!pid)
@@ -821,10 +819,8 @@ int send_sigurg(struct fown_struct *fown)
 	read_lock(&fown->lock);
 
 	type = fown->pid_type;
-	if (type == PIDTYPE_MAX) {
+	if (type == PIDTYPE_PID)
 		group = 0;
-		type = PIDTYPE_PID;
-	}
 
 	pid = fown->pid;
 	if (!pid)
diff --git a/fs/locks.c b/fs/locks.c
index db7b6917d9c5..dd5f012887ca 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -546,7 +546,7 @@ lease_setup(struct file_lock *fl, void **priv)
 	if (!fasync_insert_entry(fa->fa_fd, filp, &fl->fl_fasync, fa))
 		*priv = NULL;
 
-	__f_setown(filp, task_pid(current), PIDTYPE_PID, 0);
+	__f_setown(filp, task_tgid(current), PIDTYPE_TGID, 0);
 }
 
 static const struct lock_manager_operations lease_manager_ops = {
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index e2bea2ac5dfb..47b650b81b07 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -19,6 +19,7 @@
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/sched/signal.h>
 #include <linux/dnotify.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
@@ -353,7 +354,7 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	__f_setown(filp, task_pid(current), PIDTYPE_PID, 0);
+	__f_setown(filp, task_tgid(current), PIDTYPE_TGID, 0);
 
 	error = attach_dn(dn, dn_mark, id, fd, filp, mask);
 	/* !error means that we attached the dn to the dn_mark, so don't free it */
-- 
2.17.1

