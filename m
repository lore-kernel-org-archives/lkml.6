Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0222ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9640820880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9640820880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeIYX2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:28:49 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60823 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeIYX2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:28:48 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4r0V-0000Zr-Jn; Tue, 25 Sep 2018 11:20:19 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4r0U-0001uD-C1; Tue, 25 Sep 2018 11:20:19 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 25 Sep 2018 19:19:04 +0200
Message-Id: <20180925171906.19683-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87h8idv6nw.fsf@xmission.com>
References: <87h8idv6nw.fsf@xmission.com>
X-XM-SPF: eid=1g4r0U-0001uD-C1;;;mid=<20180925171906.19683-4-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ERpqjCZhmsFTJC92C1QflMzMLeh7SunY=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 4/6] signal: Introduce copy_siginfo_from_user and use it's return value
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for using a smaller version of siginfo in the kernel
introduce copy_siginfo_from_user and use it when siginfo is copied from
userspace.

Make the pattern for using copy_siginfo_from_user and
copy_siginfo_from_user32 to capture the return value and return that
value on error.

This is a necessary prerequisite for using a smaller siginfo
in the kernel than the kernel exports to userspace.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/signal.h |  1 +
 kernel/ptrace.c        | 12 +++++-------
 kernel/signal.c        | 25 ++++++++++++++++---------
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index 3d4cd5db30a9..de94c159bfb0 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -22,6 +22,7 @@ static inline void clear_siginfo(struct siginfo *info)
 }
 
 int copy_siginfo_to_user(struct siginfo __user *to, const struct siginfo *from);
+int copy_siginfo_from_user(struct siginfo *to, const struct siginfo __user *from);
 
 enum siginfo_layout {
 	SIL_KILL,
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 45f77a1b9c97..a807ff5cc1a9 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -919,9 +919,8 @@ int ptrace_request(struct task_struct *child, long request,
 		break;
 
 	case PTRACE_SETSIGINFO:
-		if (copy_from_user(&siginfo, datavp, sizeof siginfo))
-			ret = -EFAULT;
-		else
+		ret = copy_siginfo_from_user(&siginfo, datavp);
+		if (!ret)
 			ret = ptrace_setsiginfo(child, &siginfo);
 		break;
 
@@ -1215,10 +1214,9 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
 		break;
 
 	case PTRACE_SETSIGINFO:
-		if (copy_siginfo_from_user32(
-			    &siginfo, (struct compat_siginfo __user *) datap))
-			ret = -EFAULT;
-		else
+		ret = copy_siginfo_from_user32(
+			&siginfo, (struct compat_siginfo __user *) datap);
+		if (!ret)
 			ret = ptrace_setsiginfo(child, &siginfo);
 		break;
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
diff --git a/kernel/signal.c b/kernel/signal.c
index debb485a76db..c0e289e62d77 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2896,6 +2896,13 @@ int copy_siginfo_to_user(siginfo_t __user *to, const siginfo_t *from)
 	return 0;
 }
 
+int copy_siginfo_from_user(siginfo_t *to, const siginfo_t __user *from)
+{
+	if (copy_from_user(to, from, sizeof(struct siginfo)))
+		return -EFAULT;
+	return 0;
+}
+
 #ifdef CONFIG_COMPAT
 int copy_siginfo_to_user32(struct compat_siginfo __user *to,
 			   const struct siginfo *from)
@@ -3323,8 +3330,9 @@ SYSCALL_DEFINE3(rt_sigqueueinfo, pid_t, pid, int, sig,
 		siginfo_t __user *, uinfo)
 {
 	siginfo_t info;
-	if (copy_from_user(&info, uinfo, sizeof(siginfo_t)))
-		return -EFAULT;
+	int ret = copy_siginfo_from_user(&info, uinfo);
+	if (unlikely(ret))
+		return ret;
 	return do_rt_sigqueueinfo(pid, sig, &info);
 }
 
@@ -3365,10 +3373,9 @@ SYSCALL_DEFINE4(rt_tgsigqueueinfo, pid_t, tgid, pid_t, pid, int, sig,
 		siginfo_t __user *, uinfo)
 {
 	siginfo_t info;
-
-	if (copy_from_user(&info, uinfo, sizeof(siginfo_t)))
-		return -EFAULT;
-
+	int ret = copy_siginfo_from_user(&info, uinfo);
+	if (unlikely(ret))
+		return ret;
 	return do_rt_tgsigqueueinfo(tgid, pid, sig, &info);
 }
 
@@ -3380,9 +3387,9 @@ COMPAT_SYSCALL_DEFINE4(rt_tgsigqueueinfo,
 			struct compat_siginfo __user *, uinfo)
 {
 	siginfo_t info;
-
-	if (copy_siginfo_from_user32(&info, uinfo))
-		return -EFAULT;
+	int ret = copy_siginfo_from_user32(&info, uinfo);
+	if (unlikely(ret))
+		return ret;
 	return do_rt_tgsigqueueinfo(tgid, pid, sig, &info);
 }
 #endif
-- 
2.17.1

