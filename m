Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD76AC43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AD92083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REbhczB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AD92083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeIBBBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 21:01:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46360 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeIBBBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 21:01:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id b129-v6so6907228pga.13;
        Sat, 01 Sep 2018 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xV6QtS4XkBxEqLngu8Sevec3OBS/0hrQoTPUaJeOSLI=;
        b=REbhczB+flYJl6aC/7Bn8ZEpz5Ia3LVvNXPCY17omR1DG1WpeDeBibQ2SrTcOztIcw
         BL6u4et6Ri262RkU3E1d0jTqQO2tzXla4ye1t/aG/16xgTr9ZjLNh5qkVwdMwg7B13zY
         Nl+K1Xrq4ntTUB1YeCFtnLm4xdg/50mSUuT8WsmXCfe5HEAaZJiEpwz8gxDa671ZV629
         HxqRoddwmza7aD+QsUZ+APEtB5wv51e0u5sywHT41GE+YMTQUxx4NLGL9RlRgtbFgYvN
         G8C7CR7V4WXf1K4auVfOiSioyfgwj61afdEO3Irtm8V5Czlyq4NBPL4566xhWzw8QwmV
         jkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xV6QtS4XkBxEqLngu8Sevec3OBS/0hrQoTPUaJeOSLI=;
        b=eTZMwSoag+MrzTxuvPs5TaqY+D4N8xE6UoYHJrg8DWWtHnH2RNS0tXtA8TdpnO0cIK
         RDUlwxJgwmp1pUdktQwvYRc7ZUNPSPgipWg8T1cVDzxcAnMjq1wuknAHMfum9d0wnOfw
         lLUT+Y4inZqKjR8Zd4+mfy/K3qhpjBrJMTxY1EnMj3eMiS9/bIfyBKk95T/o5Oo4zl9t
         GXvgKgLGbWxOslbbs7Wf7BZXF3yMv8cwauax8ZiM1ZQc8OQkUupcMFO+ZH8cz7tWi690
         f7MBUNfpdugd4qAiawh+kBzZTzPTrhrkTszeceWIqv2/bDxXapjbiAX+8H6jCERN9gp6
         KscQ==
X-Gm-Message-State: APzg51BpetP31TY/OMq5lvTKdE7jrUk7GWjoadmY5dMDgPUjcXrxkDlM
        sxKdzG2kVlGsE5mQMQV1HyQ=
X-Google-Smtp-Source: ANB0VdYoXuEz+ms/+4XorGwGrT5lhrSTiYsNKj3Y/shg8EkjGnG5VLX8ArnFRgK/DL/ejBVD+iZDww==
X-Received: by 2002:a62:5302:: with SMTP id h2-v6mr22505393pfb.183.1535834890492;
        Sat, 01 Sep 2018 13:48:10 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id u17-v6sm24512265pfa.176.2018.09.01.13.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 13:48:10 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-aio@kvack.org
Subject: [PATCH 2/5] signal: Add restore_user_sigmask()
Date:   Sat,  1 Sep 2018 13:47:18 -0700
Message-Id: <20180901204721.13117-3-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180901204721.13117-1-deepa.kernel@gmail.com>
References: <20180901204721.13117-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the logic to restore the sigmask before the syscall
returns into an api.
This is useful for versions of syscalls that pass in the
sigmask and expect the current->sigmask to be changed during
the execution and restored after the execution of the syscall.

With the advent of new y2038 syscalls in the subsequent patches,
we add 2 more new versions of the syscalls(for pselect, ppoll
and io_pgetevents) in addition to the existing native and compat
versions. Adding such an api reduces the logic that would need to
be replicated otherwise.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/aio.c               | 29 +++++---------------
 fs/eventpoll.c         | 30 ++-------------------
 fs/select.c            | 60 ++++++------------------------------------
 include/linux/signal.h |  2 ++
 kernel/signal.c        | 33 +++++++++++++++++++++++
 5 files changed, 51 insertions(+), 103 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 67e5b1f6fb0f..b81c216534d6 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2111,18 +2111,9 @@ SYSCALL_DEFINE6(io_pgetevents,
 		return ret;
 
 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
-	if (signal_pending(current)) {
-		if (ksig.sigmask) {
-			current->saved_sigmask = sigsaved;
-			set_restore_sigmask();
-		}
-
-		if (!ret)
-			ret = -ERESTARTNOHAND;
-	} else {
-		if (ksig.sigmask)
-			sigprocmask(SIG_SETMASK, &sigsaved, NULL);
-	}
+	restore_user_sigmask(ksig.sigmask, &sigsaved);
+	if (signal_pending(current) && !ret)
+		ret = -ERESTARTNOHAND;
 
 	return ret;
 }
@@ -2176,17 +2167,9 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 		return ret;
 
 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
-	if (signal_pending(current)) {
-		if (ksig.sigmask) {
-			current->saved_sigmask = sigsaved;
-			set_restore_sigmask();
-		}
-		if (!ret)
-			ret = -ERESTARTNOHAND;
-	} else {
-		if (ksig.sigmask)
-			sigprocmask(SIG_SETMASK, &sigsaved, NULL);
-	}
+	restore_user_sigmask(ksig.sigmask, &sigsaved);
+	if (signal_pending(current) && !ret)
+		ret = -ERESTARTNOHAND;
 
 	return ret;
 }
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 2d86eeba837b..8a5a1010886b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2229,20 +2229,7 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
 
 	error = do_epoll_wait(epfd, events, maxevents, timeout);
 
-	/*
-	 * If we changed the signal mask, we need to restore the original one.
-	 * In case we've got a signal while waiting, we do not restore the
-	 * signal mask yet, and we allow do_signal() to deliver the signal on
-	 * the way back to userspace, before the signal mask is restored.
-	 */
-	if (sigmask) {
-		if (error == -EINTR) {
-			memcpy(&current->saved_sigmask, &sigsaved,
-			       sizeof(sigsaved));
-			set_restore_sigmask();
-		} else
-			set_current_blocked(&sigsaved);
-	}
+	restore_user_sigmask(sigmask, &sigsaved);
 
 	return error;
 }
@@ -2267,20 +2254,7 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
 
 	err = do_epoll_wait(epfd, events, maxevents, timeout);
 
-	/*
-	 * If we changed the signal mask, we need to restore the original one.
-	 * In case we've got a signal while waiting, we do not restore the
-	 * signal mask yet, and we allow do_signal() to deliver the signal on
-	 * the way back to userspace, before the signal mask is restored.
-	 */
-	if (sigmask) {
-		if (err == -EINTR) {
-			memcpy(&current->saved_sigmask, &sigsaved,
-			       sizeof(sigsaved));
-			set_restore_sigmask();
-		} else
-			set_current_blocked(&sigsaved);
-	}
+	restore_user_sigmask(sigmask, &sigsaved);
 
 	return err;
 }
diff --git a/fs/select.c b/fs/select.c
index 65c78b4147a2..eb9132520197 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -724,19 +724,7 @@ static long do_pselect(int n, fd_set __user *inp, fd_set __user *outp,
 	ret = core_sys_select(n, inp, outp, exp, to);
 	ret = poll_select_copy_remaining(&end_time, tsp, 0, ret);
 
-	if (ret == -ERESTARTNOHAND) {
-		/*
-		 * Don't restore the signal mask yet. Let do_signal() deliver
-		 * the signal on the way back to userspace, before the signal
-		 * mask is restored.
-		 */
-		if (sigmask) {
-			memcpy(&current->saved_sigmask, &sigsaved,
-					sizeof(sigsaved));
-			set_restore_sigmask();
-		}
-	} else if (sigmask)
-		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+	restore_user_sigmask(sigmask, &sigsaved);
 
 	return ret;
 }
@@ -1060,21 +1048,11 @@ SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds, unsigned int, nfds,
 
 	ret = do_sys_poll(ufds, nfds, to);
 
+	restore_user_sigmask(sigmask, &sigsaved);
+
 	/* We can restart this syscall, usually */
-	if (ret == -EINTR) {
-		/*
-		 * Don't restore the signal mask yet. Let do_signal() deliver
-		 * the signal on the way back to userspace, before the signal
-		 * mask is restored.
-		 */
-		if (sigmask) {
-			memcpy(&current->saved_sigmask, &sigsaved,
-					sizeof(sigsaved));
-			set_restore_sigmask();
-		}
+	if (ret == -EINTR)
 		ret = -ERESTARTNOHAND;
-	} else if (sigmask)
-		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
 	ret = poll_select_copy_remaining(&end_time, tsp, 0, ret);
 
@@ -1316,19 +1294,7 @@ static long do_compat_pselect(int n, compat_ulong_t __user *inp,
 	ret = compat_core_sys_select(n, inp, outp, exp, to);
 	ret = compat_poll_select_copy_remaining(&end_time, tsp, 0, ret);
 
-	if (ret == -ERESTARTNOHAND) {
-		/*
-		 * Don't restore the signal mask yet. Let do_signal() deliver
-		 * the signal on the way back to userspace, before the signal
-		 * mask is restored.
-		 */
-		if (sigmask) {
-			memcpy(&current->saved_sigmask, &sigsaved,
-					sizeof(sigsaved));
-			set_restore_sigmask();
-		}
-	} else if (sigmask)
-		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+	restore_user_sigmask(sigmask, &sigsaved);
 
 	return ret;
 }
@@ -1375,21 +1341,11 @@ COMPAT_SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds,
 
 	ret = do_sys_poll(ufds, nfds, to);
 
+	restore_user_sigmask(sigmask, &sigsaved);
+
 	/* We can restart this syscall, usually */
-	if (ret == -EINTR) {
-		/*
-		 * Don't restore the signal mask yet. Let do_signal() deliver
-		 * the signal on the way back to userspace, before the signal
-		 * mask is restored.
-		 */
-		if (sigmask) {
-			memcpy(&current->saved_sigmask, &sigsaved,
-				sizeof(sigsaved));
-			set_restore_sigmask();
-		}
+	if (ret == -EINTR)
 		ret = -ERESTARTNOHAND;
-	} else if (sigmask)
-		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
 	ret = compat_poll_select_copy_remaining(&end_time, tsp, 0, ret);
 
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 403e63d01bcf..ed8be17afe89 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -265,6 +265,8 @@ extern int __group_send_sig_info(int, struct siginfo *, struct task_struct *);
 extern int sigprocmask(int, sigset_t *, sigset_t *);
 extern int set_user_sigmask(const sigset_t __user *usigmask, sigset_t *set,
 	sigset_t *oldset, size_t sigsetsize);
+extern void restore_user_sigmask(const void __user *usigmask,
+				 sigset_t *sigsaved);
 extern void set_current_blocked(sigset_t *);
 extern void __set_current_blocked(const sigset_t *);
 extern int show_unhandled_signals;
diff --git a/kernel/signal.c b/kernel/signal.c
index 1d72dcddcaaf..457d1abe62a4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2783,6 +2783,39 @@ int set_compat_user_sigmask(const compat_sigset_t __user *usigmask,
 EXPORT_SYMBOL(set_compat_user_sigmask);
 #endif
 
+/*
+ * restore_user_sigmask:
+ * usigmask: sigmask passed in from userland.
+ * sigsaved: saved sigmask when the syscall started and changed the sigmask to
+ *           usigmask.
+ *
+ * This is useful for syscalls such as ppoll, pselect, io_pgetevents and
+ * epoll_pwait where a new sigmask is passed in from userland for the syscalls.
+ */
+void restore_user_sigmask(const void __user *usigmask, sigset_t *sigsaved)
+{
+
+	if (!usigmask)
+		return;
+	/*
+	 * When signals are pending, do not restore them here.
+	 * Restoring sigmask here can lead to delivering signals that the above
+	 * syscalls are intended to block because of the sigmask passed in.
+	 */
+	if (signal_pending(current)) {
+		current->saved_sigmask = *sigsaved;
+		set_restore_sigmask();
+		return;
+	}
+
+	/*
+	 * This is needed because the fast syscall return path does not restore
+	 * saved_sigmask when signals are not pending.
+	 */
+	set_current_blocked(sigsaved);
+}
+EXPORT_SYMBOL(restore_user_sigmask);
+
 /**
  *  sys_rt_sigprocmask - change the list of currently blocked signals
  *  @how: whether to add, remove, or set signals
-- 
2.17.1

