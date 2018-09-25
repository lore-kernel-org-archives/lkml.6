Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8D7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C6220880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="deH9h/cb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C6220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeIZFnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:43:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56554 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbeIZFne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:43:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8PNSosp137767;
        Tue, 25 Sep 2018 23:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=sCU1xfICRMpZDIIeqCRuSYxheBxLLg9BkmfpJddM0+Y=;
 b=deH9h/cb1huLCGN8em0cWJtmYYYEfcASV/Pl9Irvln6/X9b3JAcHWeQIkFTD1YTACTxQ
 AGZV+m90E0CZ/gktmipxE8r+0kVacskXUE0y/qgH4l/YwBWGj6Ycd8xwopYfpsL+7/Vw
 /sxj862bWfJRWv5FwbaBh0nbTYulrFdfE5QWV24XrBIzEgSI1BBAwu3+4gwwL/pqvJbs
 rv+WOi8y4Fe3+JGZFocrfE6WQUzKNd11+D8rp/WQNLCYRHbJh4bw1jsIK8KgfZSzrEFl
 LjzqliovPfvjzxnFA0xSKu8wibjlijW2gQS9vYNdH7MOBixoKL0F04NkgsGZ/CLnjZzP +w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2mnvtup083-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Sep 2018 23:32:55 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8PNWoO8010437
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Sep 2018 23:32:50 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8PNWodQ016180;
        Tue, 25 Sep 2018 23:32:50 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Sep 2018 16:32:49 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, tglx@linutronix.de, dhaval.giani@oracle.com,
        steven.sistare@oracle.com
Subject: [RFC PATCH v2 1/1] pipe: busy wait for pipe
Date:   Tue, 25 Sep 2018 16:32:40 -0700
Message-Id: <20180925233240.24451-2-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180925233240.24451-1-subhra.mazumdar@oracle.com>
References: <20180925233240.24451-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9027 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=523
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809250229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce pipe_ll_usec field for pipes that indicates the amount of micro
seconds a thread should spin if pipe is empty or full before sleeping. This
is similar to network sockets. Workloads like hackbench in pipe mode
benefits significantly from this by avoiding the sleep and wakeup overhead.
Other similar usecases can benefit. A tunable pipe_busy_poll is introduced
to enable or disable busy waiting via /proc. The value of it specifies the
amount of spin in microseconds. Default value is 0 indicating no spin.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 fs/pipe.c                 | 12 ++++++++++++
 include/linux/pipe_fs_i.h |  2 ++
 kernel/sysctl.c           |  7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index bdc5d3c..35d805b 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -26,6 +26,7 @@
 
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
+#include <linux/sched/clock.h>
 
 #include "internal.h"
 
@@ -40,6 +41,7 @@ unsigned int pipe_max_size = 1048576;
  */
 unsigned long pipe_user_pages_hard;
 unsigned long pipe_user_pages_soft = PIPE_DEF_BUFFERS * INR_OPEN_CUR;
+unsigned int pipe_busy_poll;
 
 /*
  * We use a start+len construction, which provides full use of the 
@@ -106,6 +108,7 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
 void pipe_wait(struct pipe_inode_info *pipe)
 {
 	DEFINE_WAIT(wait);
+	u64 start;
 
 	/*
 	 * Pipes are system-local resources, so sleeping on them
@@ -113,6 +116,10 @@ void pipe_wait(struct pipe_inode_info *pipe)
 	 */
 	prepare_to_wait(&pipe->wait, &wait, TASK_INTERRUPTIBLE);
 	pipe_unlock(pipe);
+	start = local_clock();
+	while (current->state != TASK_RUNNING &&
+	       ((local_clock() - start) >> 10) < pipe->pipe_ll_usec)
+		cpu_relax();
 	schedule();
 	finish_wait(&pipe->wait, &wait);
 	pipe_lock(pipe);
@@ -825,6 +832,7 @@ static int do_pipe2(int __user *fildes, int flags)
 	struct file *files[2];
 	int fd[2];
 	int error;
+	struct pipe_inode_info *pipe;
 
 	error = __do_pipe_flags(fd, files, flags);
 	if (!error) {
@@ -838,6 +846,10 @@ static int do_pipe2(int __user *fildes, int flags)
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
index 5a3bb3b..73267d2 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -55,6 +55,7 @@ struct pipe_inode_info {
 	unsigned int waiting_writers;
 	unsigned int r_counter;
 	unsigned int w_counter;
+	unsigned int pipe_ll_usec;
 	struct page *tmp_page;
 	struct fasync_struct *fasync_readers;
 	struct fasync_struct *fasync_writers;
@@ -170,6 +171,7 @@ void pipe_double_lock(struct pipe_inode_info *, struct pipe_inode_info *);
 extern unsigned int pipe_max_size;
 extern unsigned long pipe_user_pages_hard;
 extern unsigned long pipe_user_pages_soft;
+extern unsigned int pipe_busy_poll;
 
 /* Drop the inode semaphore and wait for a pipe event, atomically */
 void pipe_wait(struct pipe_inode_info *pipe);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cc02050..0e9ce0c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1863,6 +1863,13 @@ static struct ctl_table fs_table[] = {
 		.proc_handler	= proc_doulongvec_minmax,
 	},
 	{
+		.procname       = "pipe-busy-poll",
+		.data           = &pipe_busy_poll,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+	},
+	{
 		.procname	= "mount-max",
 		.data		= &sysctl_mount_max,
 		.maxlen		= sizeof(unsigned int),
-- 
2.9.3

