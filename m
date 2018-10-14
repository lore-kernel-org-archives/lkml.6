Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6CEC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004DC20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004DC20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeJNXSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:18:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36721 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728404AbeJNXSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:18:24 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMD-0004cU-5D; Sun, 14 Oct 2018 16:31:05 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLP-0000Du-F1; Sun, 14 Oct 2018 16:30:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.978979959@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 066/366] ipc/util: Helpers for making the sysvipc
 operations pid namespace aware
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

commit 03f1fc09180b345582889a344b012d069b3a6dbe upstream.

Capture the pid namespace when /proc/sysvipc/msg /proc/sysvipc/shm
and /proc/sysvipc/sem are opened, and make it available through
the new helper ipc_seq_pid_ns.

This makes it possible to report the pids in these files in the
pid namespace of the opener of the files.

Implement ipc_update_pid.  A simple impline helper that will only update
a struct pid pointer if the new value does not equal the old value.  This
removes the need for wordy code sequences like:

	old = object->pid;
	object->pid = new;
	put_pid(old);

and

	old = object->pid;
	if (old != new) {
		object->pid = new;
		put_pid(old);
	}

Allowing the following to be written instead:

	ipc_update_pid(&object->pid, new);

Which is easier to read and ensures that the pid reference count is
not touched the old and the new values are the same.  Not touching
the reference count in this case is important to help avoid issues
like af_unix experienced, where multiple threads of the same
process managed to bounce the struct pid between cpu cache lines,
but updating the pids reference count.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 ipc/util.c |  9 +++++++++
 ipc/util.h | 11 +++++++++++
 2 files changed, 20 insertions(+)

--- a/ipc/util.c
+++ b/ipc/util.c
@@ -777,9 +777,16 @@ int ipc_parse_version(int *cmd)
 #ifdef CONFIG_PROC_FS
 struct ipc_proc_iter {
 	struct ipc_namespace *ns;
+	struct pid_namespace *pid_ns;
 	struct ipc_proc_iface *iface;
 };
 
+struct pid_namespace *ipc_seq_pid_ns(struct seq_file *s)
+{
+	struct ipc_proc_iter *iter = s->private;
+	return iter->pid_ns;
+}
+
 /*
  * This routine locks the ipc structure found at least at position pos.
  */
@@ -914,6 +921,7 @@ static int sysvipc_proc_open(struct inod
 
 	iter->iface = PDE_DATA(inode);
 	iter->ns    = get_ipc_ns(current->nsproxy->ipc_ns);
+	iter->pid_ns = get_pid_ns(task_active_pid_ns(current));
 out:
 	return ret;
 }
@@ -923,6 +931,7 @@ static int sysvipc_proc_release(struct i
 	struct seq_file *seq = file->private_data;
 	struct ipc_proc_iter *iter = seq->private;
 	put_ipc_ns(iter->ns);
+	put_pid_ns(iter->pid_ns);
 	return seq_release_private(inode, file);
 }
 
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -20,6 +20,7 @@ void msg_init(void);
 void shm_init(void);
 
 struct ipc_namespace;
+struct pid_namespace;
 
 #ifdef CONFIG_POSIX_MQUEUE
 extern void mq_clear_sbinfo(struct ipc_namespace *ns);
@@ -90,6 +91,7 @@ void ipc_init_ids(struct ipc_ids *);
 #ifdef CONFIG_PROC_FS
 void __init ipc_init_proc_interface(const char *path, const char *header,
 		int ids, int (*show)(struct seq_file *, void *));
+struct pid_namespace *ipc_seq_pid_ns(struct seq_file *);
 #else
 #define ipc_init_proc_interface(path, header, ids, show) do {} while (0)
 #endif
@@ -141,6 +143,15 @@ struct kern_ipc_perm *ipcctl_pre_down_no
 					     struct ipc_ids *ids, int id, int cmd,
 					     struct ipc64_perm *perm, int extra_perm);
 
+static inline void ipc_update_pid(struct pid **pos, struct pid *pid)
+{
+	struct pid *old = *pos;
+	if (old != pid) {
+		*pos = get_pid(pid);
+		put_pid(old);
+	}
+}
+
 #ifndef CONFIG_ARCH_WANT_IPC_PARSE_VERSION
 /* On IA-64, we always use the "64-bit version" of the IPC structures.  */
 # define ipc_parse_version(cmd)	IPC_64

