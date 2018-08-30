Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A275CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF2820834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FwAeDfGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF2820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeHaA3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:29:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58710 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeHaA3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:29:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UKOA4X032167;
        Thu, 30 Aug 2018 20:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=VpVdmdU76rt3SerFVK34lF/ARdQa/i/ZyGByq309Kpc=;
 b=FwAeDfGRioLKDULrB3fFLRZA7ZgfWfAycVCq74217CaVFS2o9kkc6se7t2yuRTUFfrK1
 xkngagPXeaKP8HRxk1BwlJv4P/+CuGYFqAJb3K2CYnKeuPGSX+eB05D2jBT2FTaXFgG5
 8DaX2DnyWTHM5lEY97ZJtSoHYAL5n8AIN97wdJ77UiEPH/9e9JoohVzeg1ef2GIGKk83
 2N/6JtnCrzZ2x9ifZ/ndvpkqVsEw5e/esLawzDivY2W/K+3oEpA0diuaCXTwYumiGDd9
 0m52Pbbi7HfvyNLGLY8rZtSMTYvZzMFxtRZsqRVRudNcG0pY1gc/vRg9+2mVeRKuoR4i 1w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2m2yrqptss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 20:24:45 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7UKOiBf008901
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 20:24:44 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7UKOhlo028458;
        Thu, 30 Aug 2018 20:24:44 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 13:24:43 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, dhaval.giani@oracle.com,
        steven.sistare@oracle.com, subhra.mazumdar@oracle.com
Subject: [RFC PATCH 2/2] pipe: use pipe busy wait
Date:   Thu, 30 Aug 2018 13:24:58 -0700
Message-Id: <20180830202458.32579-3-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180830202458.32579-1-subhra.mazumdar@oracle.com>
References: <20180830202458.32579-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9001 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=627
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable busy waiting for pipes. pipe_busy_wait is called if pipe is empty or
full which spins for specified micro seconds. wake_up_busy_poll is called
when data is written or read to signal any busy waiting threads. A tunable
pipe_busy_poll is introduced to enable or disable busy waiting via /proc.
The value of it specifies the amount of spin in microseconds.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 fs/pipe.c                 | 58 +++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/pipe_fs_i.h |  1 +
 kernel/sysctl.c           |  7 ++++++
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 97e5be8..03ce76a 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -44,6 +44,7 @@ unsigned int pipe_min_size = PAGE_SIZE;
  */
 unsigned long pipe_user_pages_hard;
 unsigned long pipe_user_pages_soft = PIPE_DEF_BUFFERS * INR_OPEN_CUR;
+unsigned int pipe_busy_poll;
 
 /*
  * We use a start+len construction, which provides full use of the 
@@ -122,6 +123,35 @@ void pipe_wait(struct pipe_inode_info *pipe)
 	pipe_lock(pipe);
 }
 
+void pipe_busy_wait(struct pipe_inode_info *pipe)
+{
+	unsigned long wait_flag = pipe->pipe_wait_flag;
+	unsigned long start_time = pipe_busy_loop_current_time();
+
+	pipe_unlock(pipe);
+	preempt_disable();
+	for (;;) {
+		if (pipe->pipe_wait_flag > wait_flag) {
+			preempt_enable();
+			pipe_lock(pipe);
+			return;
+		}
+		if (pipe_busy_loop_timeout(pipe, start_time))
+			break;
+		cpu_relax();
+	}
+	preempt_enable();
+	pipe_lock(pipe);
+	if (pipe->pipe_wait_flag > wait_flag)
+		return;
+	pipe_wait(pipe);
+}
+
+void wake_up_busy_poll(struct pipe_inode_info *pipe)
+{
+	pipe->pipe_wait_flag++;
+}
+
 static void anon_pipe_buf_release(struct pipe_inode_info *pipe,
 				  struct pipe_buffer *buf)
 {
@@ -254,6 +284,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	struct pipe_inode_info *pipe = filp->private_data;
 	int do_wakeup;
 	ssize_t ret;
+	unsigned int poll = pipe->pipe_ll_usec;
 
 	/* Null read succeeds. */
 	if (unlikely(total_len == 0))
@@ -331,11 +362,18 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			break;
 		}
 		if (do_wakeup) {
+			if (poll)
+				wake_up_busy_poll(pipe);
 			wake_up_interruptible_sync_poll(&pipe->wait, POLLOUT | POLLWRNORM);
  			kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 		}
-		pipe_wait(pipe);
+		if (poll)
+			pipe_busy_wait(pipe);
+		else
+			pipe_wait(pipe);
 	}
+	if (poll && do_wakeup)
+		wake_up_busy_poll(pipe);
 	__pipe_unlock(pipe);
 
 	/* Signal writers asynchronously that there is more room. */
@@ -362,6 +400,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	int do_wakeup = 0;
 	size_t total_len = iov_iter_count(from);
 	ssize_t chars;
+	unsigned int poll = pipe->pipe_ll_usec;
 
 	/* Null write succeeds. */
 	if (unlikely(total_len == 0))
@@ -467,15 +506,22 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			break;
 		}
 		if (do_wakeup) {
+			if (poll)
+				wake_up_busy_poll(pipe);
 			wake_up_interruptible_sync_poll(&pipe->wait, POLLIN | POLLRDNORM);
 			kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 			do_wakeup = 0;
 		}
 		pipe->waiting_writers++;
-		pipe_wait(pipe);
+		if (poll)
+			pipe_busy_wait(pipe);
+		else
+			pipe_wait(pipe);
 		pipe->waiting_writers--;
 	}
 out:
+	if (poll && do_wakeup)
+		wake_up_busy_poll(pipe);
 	__pipe_unlock(pipe);
 	if (do_wakeup) {
 		wake_up_interruptible_sync_poll(&pipe->wait, POLLIN | POLLRDNORM);
@@ -564,6 +610,7 @@ static int
 pipe_release(struct inode *inode, struct file *file)
 {
 	struct pipe_inode_info *pipe = file->private_data;
+	unsigned int poll = pipe->pipe_ll_usec;
 
 	__pipe_lock(pipe);
 	if (file->f_mode & FMODE_READ)
@@ -572,6 +619,8 @@ pipe_release(struct inode *inode, struct file *file)
 		pipe->writers--;
 
 	if (pipe->readers || pipe->writers) {
+		if (poll)
+			wake_up_busy_poll(pipe);
 		wake_up_interruptible_sync_poll(&pipe->wait, POLLIN | POLLOUT | POLLRDNORM | POLLWRNORM | POLLERR | POLLHUP);
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
@@ -840,6 +889,7 @@ SYSCALL_DEFINE2(pipe2, int __user *, fildes, int, flags)
 	struct file *files[2];
 	int fd[2];
 	int error;
+	struct pipe_inode_info *pipe;
 
 	error = __do_pipe_flags(fd, files, flags);
 	if (!error) {
@@ -853,6 +903,10 @@ SYSCALL_DEFINE2(pipe2, int __user *, fildes, int, flags)
 			fd_install(fd[0], files[0]);
 			fd_install(fd[1], files[1]);
 		}
+		pipe = files[0]->private_data;
+		pipe->pipe_ll_usec = pipe_busy_poll;
+		pipe = files[1]->private_data;
+		pipe->pipe_ll_usec = pipe_busy_poll;
 	}
 	return error;
 }
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index fdfd2a2..3b96b05 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -188,6 +188,7 @@ void pipe_double_lock(struct pipe_inode_info *, struct pipe_inode_info *);
 extern unsigned int pipe_max_size, pipe_min_size;
 extern unsigned long pipe_user_pages_hard;
 extern unsigned long pipe_user_pages_soft;
+extern unsigned int pipe_busy_poll;
 int pipe_proc_fn(struct ctl_table *, int, void __user *, size_t *, loff_t *);
 
 /* Drop the inode semaphore and wait for a pipe event, atomically */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d9c31bc..823bde1 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1842,6 +1842,13 @@ static struct ctl_table fs_table[] = {
 		.proc_handler	= proc_doulongvec_minmax,
 	},
 	{
+		.procname	= "pipe-busy-poll",
+		.data		= &pipe_busy_poll,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+	},
+	{
 		.procname	= "mount-max",
 		.data		= &sysctl_mount_max,
 		.maxlen		= sizeof(unsigned int),
-- 
2.9.3

