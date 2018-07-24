Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31752ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D0920852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D0920852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbeGXEaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:30:03 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51282 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388088AbeGXEaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:30:01 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnxG-0007VO-GF; Mon, 23 Jul 2018 21:25:42 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnxF-0008AK-Mi; Mon, 23 Jul 2018 21:25:42 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 23 Jul 2018 22:24:06 -0500
Message-Id: <20180724032419.20231-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87efft5ncd.fsf_-_@xmission.com>
References: <87efft5ncd.fsf_-_@xmission.com>
X-XM-SPF: eid=1fhnxF-0008AK-Mi;;;mid=<20180724032419.20231-7-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19wPxXgc0sXt6HV97mdgDtEtCalTatAYZ8=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 07/20] signal: Use PIDTYPE_TGID to clearly store where file signals will be sent
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
PIDTYPE_PID.

For now the code continues to capture task_pid (when task_tgid would
really be appropriate), and iterate on PIDTYPE_PID (even when type ==
PIDTYPE_TGID) out of an abundance of caution to preserve existing
behavior.

Oleg Nesterov suggested using the test to ensure we use PIDTYPE_PID
for tgid lookup also be used to avoid taking the tasklist lock.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/net/tun.c           |  2 +-
 drivers/tty/tty_io.c        |  2 +-
 fs/fcntl.c                  | 54 ++++++++++++++++++++++---------------
 fs/locks.c                  |  2 +-
 fs/notify/dnotify/dnotify.c |  3 ++-
 5 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index a192a017cc68..9958b70ac1b0 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3216,7 +3216,7 @@ static int tun_chr_fasync(int fd, struct file *file, int on)
 		goto out;
 
 	if (on) {
-		__f_setown(file, task_pid(current), PIDTYPE_PID, 0);
+		__f_setown(file, task_pid(current), PIDTYPE_TGID, 0);
 		tfile->flags |= TUN_FASYNC;
 	} else
 		tfile->flags &= ~TUN_FASYNC;
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index aba59521ad48..090fb7e78eea 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2122,7 +2122,7 @@ static int __tty_fasync(int fd, struct file *filp, int on)
 			type = PIDTYPE_PGID;
 		} else {
 			pid = task_pid(current);
-			type = PIDTYPE_PID;
+			type = PIDTYPE_TGID;
 		}
 		get_pid(pid);
 		spin_unlock_irqrestore(&tty->ctrl_lock, flags);
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 12273b6ea56d..1523588fd759 100644
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
 
@@ -785,20 +785,25 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
 	read_lock(&fown->lock);
 
 	type = fown->pid_type;
-	if (type == PIDTYPE_MAX) {
+	if (type == PIDTYPE_PID)
 		group = 0;
-		type = PIDTYPE_PID;
-	}
 
 	pid = fown->pid;
 	if (!pid)
 		goto out_unlock_fown;
-	
-	read_lock(&tasklist_lock);
-	do_each_pid_task(pid, type, p) {
+
+	if (type <= PIDTYPE_TGID) {
+		rcu_read_lock();
+		p = pid_task(pid, PIDTYPE_PID);
 		send_sigio_to_task(p, fown, fd, band, group);
-	} while_each_pid_task(pid, type, p);
-	read_unlock(&tasklist_lock);
+		rcu_read_unlock();
+	} else {
+		read_lock(&tasklist_lock);
+		do_each_pid_task(pid, type, p) {
+			send_sigio_to_task(p, fown, fd, band, group);
+		} while_each_pid_task(pid, type, p);
+		read_unlock(&tasklist_lock);
+	}
  out_unlock_fown:
 	read_unlock(&fown->lock);
 }
@@ -821,22 +826,27 @@ int send_sigurg(struct fown_struct *fown)
 	read_lock(&fown->lock);
 
 	type = fown->pid_type;
-	if (type == PIDTYPE_MAX) {
+	if (type == PIDTYPE_PID)
 		group = 0;
-		type = PIDTYPE_PID;
-	}
 
 	pid = fown->pid;
 	if (!pid)
 		goto out_unlock_fown;
 
 	ret = 1;
-	
-	read_lock(&tasklist_lock);
-	do_each_pid_task(pid, type, p) {
+
+	if (type <= PIDTYPE_TGID) {
+		rcu_read_lock();
+		p = pid_task(pid, PIDTYPE_PID);
 		send_sigurg_to_task(p, fown, group);
-	} while_each_pid_task(pid, type, p);
-	read_unlock(&tasklist_lock);
+		rcu_read_unlock();
+	} else {
+		read_lock(&tasklist_lock);
+		do_each_pid_task(pid, type, p) {
+			send_sigurg_to_task(p, fown, group);
+		} while_each_pid_task(pid, type, p);
+		read_unlock(&tasklist_lock);
+	}
  out_unlock_fown:
 	read_unlock(&fown->lock);
 	return ret;
diff --git a/fs/locks.c b/fs/locks.c
index db7b6917d9c5..cfc059bda8ea 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -546,7 +546,7 @@ lease_setup(struct file_lock *fl, void **priv)
 	if (!fasync_insert_entry(fa->fa_fd, filp, &fl->fl_fasync, fa))
 		*priv = NULL;
 
-	__f_setown(filp, task_pid(current), PIDTYPE_PID, 0);
+	__f_setown(filp, task_pid(current), PIDTYPE_TGID, 0);
 }
 
 static const struct lock_manager_operations lease_manager_ops = {
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index e2bea2ac5dfb..484f2c3a33bb 100644
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
+	__f_setown(filp, task_pid(current), PIDTYPE_TGID, 0);
 
 	error = attach_dn(dn, dn_mark, id, fd, filp, mask);
 	/* !error means that we attached the dn to the dn_mark, so don't free it */
-- 
2.17.1

