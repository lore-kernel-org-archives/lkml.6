Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C200FC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EAC20835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EAC20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeJNXSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:18:00 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36706 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727252AbeJNXSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:18:00 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMD-0004cI-5P; Sun, 14 Oct 2018 16:31:05 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLP-0000Dz-GD; Sun, 14 Oct 2018 16:30:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Nagarathnam Muthusamy" <nagarathnam.muthusamy@oracle.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.291673417@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 067/366] ipc/shm: Fix shmctl(..., IPC_STAT, ...)
 between pid namespaces.
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Eric W. Biederman" <ebiederm@xmission.com>

commit 98f929b1bd4d0b7c7a77d0d9776d1b924db2e454 upstream.

Today shm_cpid and shm_lpid are remembered in the pid namespace of the
creator and the processes that last touched a sysvipc shared memory
segment.   If you have processes in multiple pid namespaces that
is just wrong, and I don't know how this has been over-looked for
so long.

As only creation and shared memory attach and shared memory detach
update the pids I do not expect there to be a repeat of the issues
when struct pid was attached to each af_unix skb, which in some
notable cases cut the performance in half.  The problem was threads of
the same process updating same struct pid from different cpus causing
the cache line to be highly contended and bounce between cpus.

As creation, attach, and detach are expected to be rare operations for
sysvipc shared memory segments I do not expect that kind of cache line
ping pong to cause probems.  In addition because the pid is at a fixed
location in the structure instead of being dynamic on a skb, the
reference count of the pid does not need to be updated on each
operation if the pid is the same.  This ability to simply skip the pid
reference count changes if the pid is unchanging further reduces the
likelihood of the a cache line holding a pid reference count
ping-ponging between cpus.

Fixes: b488893a390e ("pid namespaces: changes to show virtual ids to user")
Reviewed-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/include/linux/shm.h
+++ b/include/linux/shm.h
@@ -14,8 +14,8 @@ struct shmid_kernel /* private to the ke
 	time_t			shm_atim;
 	time_t			shm_dtim;
 	time_t			shm_ctim;
-	pid_t			shm_cprid;
-	pid_t			shm_lprid;
+	struct pid		*shm_cprid;
+	struct pid		*shm_lprid;
 	struct user_struct	*mlock_user;
 
 	/* The task created the shm object.  NULL if the task is dead. */
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -198,7 +198,7 @@ static int __shm_open(struct vm_area_str
 		return PTR_ERR(shp);
 
 	shp->shm_atim = get_seconds();
-	shp->shm_lprid = task_tgid_vnr(current);
+	ipc_update_pid(&shp->shm_lprid, task_tgid(current));
 	shp->shm_nattch++;
 	shm_unlock(shp);
 	return 0;
@@ -238,6 +238,8 @@ static void shm_destroy(struct ipc_names
 	else if (shp->mlock_user)
 		user_shm_unlock(file_inode(shm_file)->i_size, shp->mlock_user);
 	fput(shm_file);
+	ipc_update_pid(&shp->shm_cprid, NULL);
+	ipc_update_pid(&shp->shm_lprid, NULL);
 	ipc_rcu_putref(shp, shm_rcu_free);
 }
 
@@ -282,7 +284,7 @@ static void shm_close(struct vm_area_str
 	if (WARN_ON_ONCE(IS_ERR(shp)))
 		goto done; /* no-op */
 
-	shp->shm_lprid = task_tgid_vnr(current);
+	ipc_update_pid(&shp->shm_lprid, task_tgid(current));
 	shp->shm_dtim = get_seconds();
 	shp->shm_nattch--;
 	if (shm_may_destroy(ns, shp))
@@ -581,8 +583,8 @@ static int newseg(struct ipc_namespace *
 	if (IS_ERR(file))
 		goto no_file;
 
-	shp->shm_cprid = task_tgid_vnr(current);
-	shp->shm_lprid = 0;
+	shp->shm_cprid = get_pid(task_tgid(current));
+	shp->shm_lprid = NULL;
 	shp->shm_atim = shp->shm_dtim = 0;
 	shp->shm_ctim = get_seconds();
 	shp->shm_segsz = size;
@@ -614,6 +616,8 @@ no_id:
 		user_shm_unlock(size, shp->mlock_user);
 	fput(file);
 no_file:
+	ipc_update_pid(&shp->shm_cprid, NULL);
+	ipc_update_pid(&shp->shm_lprid, NULL);
 	ipc_rcu_putref(shp, shm_rcu_free);
 	return error;
 }
@@ -952,8 +956,8 @@ static int shmctl_nolock(struct ipc_name
 		tbuf.shm_atime	= shp->shm_atim;
 		tbuf.shm_dtime	= shp->shm_dtim;
 		tbuf.shm_ctime	= shp->shm_ctim;
-		tbuf.shm_cpid	= shp->shm_cprid;
-		tbuf.shm_lpid	= shp->shm_lprid;
+		tbuf.shm_cpid	= pid_vnr(shp->shm_cprid);
+		tbuf.shm_lpid	= pid_vnr(shp->shm_lprid);
 		tbuf.shm_nattch	= shp->shm_nattch;
 		rcu_read_unlock();
 
@@ -1363,6 +1367,7 @@ SYSCALL_DEFINE1(shmdt, char __user *, sh
 #ifdef CONFIG_PROC_FS
 static int sysvipc_shm_proc_show(struct seq_file *s, void *it)
 {
+	struct pid_namespace *pid_ns = ipc_seq_pid_ns(s);
 	struct user_namespace *user_ns = seq_user_ns(s);
 	struct shmid_kernel *shp = it;
 	unsigned long rss = 0, swp = 0;
@@ -1383,8 +1388,8 @@ static int sysvipc_shm_proc_show(struct
 		   shp->shm_perm.id,
 		   shp->shm_perm.mode,
 		   shp->shm_segsz,
-		   shp->shm_cprid,
-		   shp->shm_lprid,
+		   pid_nr_ns(shp->shm_cprid, pid_ns),
+		   pid_nr_ns(shp->shm_lprid, pid_ns),
 		   shp->shm_nattch,
 		   from_kuid_munged(user_ns, shp->shm_perm.uid),
 		   from_kgid_munged(user_ns, shp->shm_perm.gid),

