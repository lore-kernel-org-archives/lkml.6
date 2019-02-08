Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D091C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B1A20869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfBHCfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:35:13 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:42842 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfBHCfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:35:12 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1grw0R-00079h-GG; Thu, 07 Feb 2019 19:35:10 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1grw0P-0007Q1-Vr; Thu, 07 Feb 2019 19:35:07 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 07 Feb 2019 20:34:55 -0600
Message-ID: <87ftszqa7k.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1grw0P-0007Q1-Vr;;;mid=<87ftszqa7k.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ejdJgo6mkuAmxhp6VQjK9zgcY5f+Zclc=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [CFT][PATCH] signal/usb: Replace kill_pid_info_as_cred with kill_pid_usb_asyncio
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The usb support for asyncio encoded one of it's values in the wrong
field.  It should have used si_value but instead used si_addr which is
not present in the _rt union member of struct siginfo.

The result is a POSIX and glibc incompatible encoding of fields in
struct siginfo with si_code of SI_ASYNCIO.  This makes it impossible
to look at a struct siginfo with si_code set to SI_ASYNCIO and without
context properly decode it.  Which unfortunately means that
copy_siginfo_to_user32 can't handle the compat issues this unfortunate
choice in encodings brings up.

Therefore replace kill_pid_info_as_cred with kill_pid_usb_asyncio a
dedicated function for this one specific case.  There are no other
users of kill_pid_info_as_cred so this specialization should have no
impact on the amont of code in the kernel.  Have kill_pid_usb_asyncio
take instead of a siginfo_t which is difficult error prone 3
arguments, a signal number, an errno value, and an address enconded as
a sigval_t.  The encoding as a sigval_t allows the caller to deal with
the compat issues before calling kill_pid_info_as_cred.

Add BUILD_BUG_ONs in kernel/signal.c to ensure that we can now place
the pointer value at the in si_pid (instead of si_addr) and get
the same binary result when the structure is copied to user space
and when the structure is copied field by field.

The usb code is updated to track if the values it passes into
kill_pid_usb_asyncio were passed to it from a native userspace
or from at compat user space.  To allow a proper conversion
of the addresses.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.com>
Fixes: v2.3.39
Cc: stable@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Can I get someone to test this code?  I just discovered that the
usb code is filling in struct siginfo wrong and copy_siginfo_to_user32
can't possibly get this correct without some help.

I think I have coded up a working fix.  But I don't have a setup
where I can test this.

 drivers/usb/core/devio.c     | 45 +++++++++++------------
 include/linux/sched/signal.h |  2 +-
 kernel/signal.c              | 69 +++++++++++++++++++++++++++++++-----
 3 files changed, 83 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index d65566341dd1..d1a53f760f00 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -63,7 +63,7 @@ struct usb_dev_state {
 	unsigned int discsignr;
 	struct pid *disc_pid;
 	const struct cred *cred;
-	void __user *disccontext;
+	sigval_t disccontext;
 	unsigned long ifclaimed;
 	u32 disabled_bulk_eps;
 	bool privileges_dropped;
@@ -94,6 +94,7 @@ struct async {
 	struct usb_memory *usbm;
 	unsigned int mem_usage;
 	int status;
+	u8 compat_userurb;
 	u8 bulk_addr;
 	u8 bulk_status;
 };
@@ -582,22 +583,24 @@ static void async_completed(struct urb *urb)
 {
 	struct async *as = urb->context;
 	struct usb_dev_state *ps = as->ps;
-	struct kernel_siginfo sinfo;
 	struct pid *pid = NULL;
 	const struct cred *cred = NULL;
 	unsigned long flags;
-	int signr;
+	sigval_t addr;
+	int signr, errno;
 
 	spin_lock_irqsave(&ps->lock, flags);
 	list_move_tail(&as->asynclist, &ps->async_completed);
 	as->status = urb->status;
 	signr = as->signr;
 	if (signr) {
-		clear_siginfo(&sinfo);
-		sinfo.si_signo = as->signr;
-		sinfo.si_errno = as->status;
-		sinfo.si_code = SI_ASYNCIO;
-		sinfo.si_addr = as->userurb;
+		errno = as->status;
+#ifdef CONFIG_COMPAT
+		if (as->compat_userurb)
+			addr.sival_int = ptr_to_compat(as->userurb);
+		else
+#endif
+			addr.sival_ptr = as->userurb;
 		pid = get_pid(as->pid);
 		cred = get_cred(as->cred);
 	}
@@ -615,7 +618,7 @@ static void async_completed(struct urb *urb)
 	spin_unlock_irqrestore(&ps->lock, flags);
 
 	if (signr) {
-		kill_pid_info_as_cred(sinfo.si_signo, &sinfo, pid, cred);
+		kill_pid_usb_asyncio(signr, errno, addr, pid, cred);
 		put_pid(pid);
 		put_cred(cred);
 	}
@@ -1427,7 +1430,7 @@ find_memory_area(struct usb_dev_state *ps, const struct usbdevfs_urb *uurb)
 
 static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb,
 			struct usbdevfs_iso_packet_desc __user *iso_frame_desc,
-			void __user *arg)
+			void __user *arg, bool compat)
 {
 	struct usbdevfs_iso_packet_desc *isopkt = NULL;
 	struct usb_host_endpoint *ep;
@@ -1729,6 +1732,7 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
 	isopkt = NULL;
 	as->ps = ps;
 	as->userurb = arg;
+	as->compat_userurb = compat;
 	if (as->usbm) {
 		unsigned long uurb_start = (unsigned long)uurb->buffer;
 
@@ -1809,7 +1813,7 @@ static int proc_submiturb(struct usb_dev_state *ps, void __user *arg)
 
 	return proc_do_submiturb(ps, &uurb,
 			(((struct usbdevfs_urb __user *)arg)->iso_frame_desc),
-			arg);
+			arg, false);
 }
 
 static int proc_unlinkurb(struct usb_dev_state *ps, void __user *arg)
@@ -1979,7 +1983,7 @@ static int proc_disconnectsignal_compat(struct usb_dev_state *ps, void __user *a
 	if (copy_from_user(&ds, arg, sizeof(ds)))
 		return -EFAULT;
 	ps->discsignr = ds.signr;
-	ps->disccontext = compat_ptr(ds.context);
+	ps->disccontext.sival_int = ds.context;
 	return 0;
 }
 
@@ -2013,7 +2017,7 @@ static int proc_submiturb_compat(struct usb_dev_state *ps, void __user *arg)
 
 	return proc_do_submiturb(ps, &uurb,
 			((struct usbdevfs_urb32 __user *)arg)->iso_frame_desc,
-			arg);
+			arg, true);
 }
 
 static int processcompl_compat(struct async *as, void __user * __user *arg)
@@ -2094,7 +2098,7 @@ static int proc_disconnectsignal(struct usb_dev_state *ps, void __user *arg)
 	if (copy_from_user(&ds, arg, sizeof(ds)))
 		return -EFAULT;
 	ps->discsignr = ds.signr;
-	ps->disccontext = ds.context;
+	ps->disccontext.sival_ptr = ds.context;
 	return 0;
 }
 
@@ -2616,22 +2620,15 @@ const struct file_operations usbdev_file_operations = {
 static void usbdev_remove(struct usb_device *udev)
 {
 	struct usb_dev_state *ps;
-	struct kernel_siginfo sinfo;
 
 	while (!list_empty(&udev->filelist)) {
 		ps = list_entry(udev->filelist.next, struct usb_dev_state, list);
 		destroy_all_async(ps);
 		wake_up_all(&ps->wait);
 		list_del_init(&ps->list);
-		if (ps->discsignr) {
-			clear_siginfo(&sinfo);
-			sinfo.si_signo = ps->discsignr;
-			sinfo.si_errno = EPIPE;
-			sinfo.si_code = SI_ASYNCIO;
-			sinfo.si_addr = ps->disccontext;
-			kill_pid_info_as_cred(ps->discsignr, &sinfo,
-					ps->disc_pid, ps->cred);
-		}
+		if (ps->discsignr)
+			kill_pid_usb_asyncio(ps->discsignr, EPIPE, ps->disccontext,
+					     ps->disc_pid, ps->cred);
 	}
 }
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index e31d68204b23..80a51555a7e1 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -330,7 +330,7 @@ extern void force_sigsegv(int sig);
 extern int force_sig_info(struct kernel_siginfo *);
 extern int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp);
 extern int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid);
-extern int kill_pid_info_as_cred(int, struct kernel_siginfo *, struct pid *,
+extern int kill_pid_usb_asyncio(int sig, int errno, sigval_t addr, struct pid *,
 				const struct cred *);
 extern int kill_pgrp(struct pid *pid, int sig, int priv);
 extern int kill_pid(struct pid *pid, int sig, int priv);
diff --git a/kernel/signal.c b/kernel/signal.c
index 3d522dd2858b..acc43c9a5fd3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1437,13 +1437,44 @@ static inline bool kill_as_cred_perm(const struct cred *cred,
 	       uid_eq(cred->uid, pcred->uid);
 }
 
-/* like kill_pid_info(), but doesn't use uid/euid of "current" */
-int kill_pid_info_as_cred(int sig, struct kernel_siginfo *info, struct pid *pid,
-			 const struct cred *cred)
+/*
+ * The usb asyncio usage of siginfo is wrong.  The glibc support
+ * for asyncio which uses SI_ASYNCIO assumes the layout is SIL_RT.
+ * AKA after the generic fields:
+ *	kernel_pid_t	si_pid;
+ *	kernel_uid32_t	si_uid;
+ *	sigval_t	si_value;
+ *
+ * Unfortunately when usb generates SI_ASYNCIO it assumes the layout
+ * after the generic fields is:
+ *	void __user 	*si_addr;
+ *
+ * This is a practical problem when there is a 64bit big endian kernel
+ * and a 32bit userspace.  As the 32bit address will encoded in the low
+ * 32bits of the pointer.  Those low 32bits will be stored at higher
+ * address than appear in a 32 bit pointer.  So userspace will not
+ * see the address it was expecting for it's completions.
+ *
+ * There is nothing in the encoding that can allow
+ * copy_siginfo_to_user32 to detect this confusion of formats, so
+ * handle this by requiring the caller of kill_pid_usb_asyncio to
+ * notice when this situration takes place and to store the 32bit
+ * pointer in sival_int, instead of sival_addr of the sigval_t addr
+ * parameter.
+ */
+int kill_pid_usb_asyncio(int sig, int errno, sigval_t addr,
+			 struct pid *pid, const struct cred *cred)
 {
-	int ret = -EINVAL;
+	struct kernel_siginfo info;
 	struct task_struct *p;
 	unsigned long flags;
+	int ret = -EINVAL;
+
+	clear_siginfo(&info);
+	info.si_signo = sig;
+	info.si_errno = errno;
+	info.si_code = SI_ASYNCIO;
+	*((sigval_t *)&info.si_pid) = addr;
 
 	if (!valid_signal(sig))
 		return ret;
@@ -1454,17 +1485,17 @@ int kill_pid_info_as_cred(int sig, struct kernel_siginfo *info, struct pid *pid,
 		ret = -ESRCH;
 		goto out_unlock;
 	}
-	if (si_fromuser(info) && !kill_as_cred_perm(cred, p)) {
+	if (!kill_as_cred_perm(cred, p)) {
 		ret = -EPERM;
 		goto out_unlock;
 	}
-	ret = security_task_kill(p, info, sig, cred);
+	ret = security_task_kill(p, &info, sig, cred);
 	if (ret)
 		goto out_unlock;
 
 	if (sig) {
 		if (lock_task_sighand(p, &flags)) {
-			ret = __send_signal(sig, info, p, PIDTYPE_TGID, 0);
+			ret = __send_signal(sig, &info, p, PIDTYPE_TGID, 0);
 			unlock_task_sighand(p, &flags);
 		} else
 			ret = -ESRCH;
@@ -1473,7 +1504,7 @@ int kill_pid_info_as_cred(int sig, struct kernel_siginfo *info, struct pid *pid,
 	rcu_read_unlock();
 	return ret;
 }
-EXPORT_SYMBOL_GPL(kill_pid_info_as_cred);
+EXPORT_SYMBOL_GPL(kill_pid_usb_asyncio);
 
 /*
  * kill_something_info() interprets pid in interesting ways just like kill(2).
@@ -4318,6 +4349,28 @@ static inline void siginfo_buildtime_checks(void)
 	CHECK_OFFSET(si_syscall);
 	CHECK_OFFSET(si_arch);
 #undef CHECK_OFFSET
+
+	/* usb asyncio */
+	BUILD_BUG_ON(offsetof(struct siginfo, si_pid) !=
+		     offsetof(struct siginfo, si_addr));
+	if (sizeof(int) == sizeof(void __user *)) {
+		BUILD_BUG_ON(sizeof_field(struct siginfo, si_pid) !=
+			     sizeof(void __user *));
+	} else {
+		BUILD_BUG_ON((sizeof_field(struct siginfo, si_pid) +
+			      sizeof_field(struct siginfo, si_uid)) !=
+			     sizeof(void __user *));
+		BUILD_BUG_ON(offsetofend(struct siginfo, si_pid) !=
+			     offsetof(struct siginfo, si_uid));
+	}
+#ifdef CONFIG_COMPAT
+	BUILD_BUG_ON(offsetof(struct compat_siginfo, si_pid) !=
+		     offsetof(struct compat_siginfo, si_addr));
+	BUILD_BUG_ON(sizeof_field(struct compat_siginfo, si_pid) !=
+		     sizeof(compat_uptr_t));
+	BUILD_BUG_ON(sizeof_field(struct compat_siginfo, si_pid) !=
+		     sizeof_field(struct siginfo, si_pid));
+#endif
 }
 
 void __init signals_init(void)
-- 
2.17.1

