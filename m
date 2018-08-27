Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84A4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA6D208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA6D208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeH0XeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:34:07 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:45163 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeH0XeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:34:00 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MJl3M-1ftGzY3Mma-001A9X; Mon, 27 Aug 2018 21:45:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     tglx@linutronix.de
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, deepa.kernel@gmail.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 14/14] y2038: signal: Change rt_sigtimedwait to use __kernel_timespec
Date:   Mon, 27 Aug 2018 21:45:31 +0200
Message-Id: <20180827194531.3796559-15-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827194531.3796559-1-arnd@arndb.de>
References: <20180827194531.3796559-1-arnd@arndb.de>
X-Provags-ID: V03:K1:xZZzmnDdydRGcaU8fik9x2VJnlUAaSwLpHGEywejpKwdgWLBeBW
 eswYtn8eitwySsa56Ef/BEG5HyDIIRMQXFal8PYAal0mV1EUWrxhh1VyI8CIAhrv/jF5p2c
 AypyvLA+xi9RWo4/Nu++do2SBb12GWabT5PNb/vLDLuPN6GLFJr8x8SWGok+xvBdVJqYjgS
 Gyt+wFOr80nFMEb+D6DDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CTs3t11d81Y=:Pgf9rbF7prThlp5nRAnHEy
 m4wrSp8CVIyco5oALh2KIFccStH6/j53hCTLKCRYLwvsTsYi6m73TTYT3Nj5yzTEqB+sSvrUg
 +i8bgWcAS6ldVlNYSmVYSa1Q33xBWKUGXivNHxwPaYAttnrk8Ohz8ld8LKcmkjxh5CDTwYk51
 evI46jRar2ctnT1BwG2SVx7jnUvrwn9U/T04/7oaiyaTHc/LsntWJ3SginQpfBUDFTFAQnkk0
 T7CK5CtkbnP3F2N5EgGmjcDjFlxST4gIGfpWJmoMH/gJh1gV4w0tNfVGWJvDJZZowpitL6lIp
 cT220azwWN8w74KUHTKfFbQIngfy4GYN9CRUFj6YxmDyiBUe9+nwJAfSVTZiE5HGQaPD7UnSa
 MdOy70B0QQT5SNt3xjDjUWadd7A3XT0VOcZMQtoIfyR4dZwVM0BDZHOsFy9g1LZ8aXPib4Snz
 lYNqV4bFW1pc+gR6027BABzy8/8Th+0iP3H64UWKIxey9jlfg08qLOaeTw9tRCNyoY9MlwoDg
 zbxwJj22ltkBtf9hkRoFXrNiVrcpvV0HzTCeKzWyOS3p1gA7uv/vaA2JEnNbmUSaUIjAwEOQd
 OeKjShCcI77q2QjE07aNBL4Nr3bczN9WUCXrRqd95dWDF9wVg2dAxMDlnyjhYk0/6YQ7/IReu
 E5k4646UFTvTmly0jnjwiMFQ7lSbk9v27SCW1nPgWc3l/zDYQZNudfnPCwHcL7wWObvg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes sys_rt_sigtimedwait() to use get_timespec64(), changing
the timeout type to __kernel_timespec, which will be changed to use
a 64-bit time_t in the future. Since the do_sigtimedwait() core
function changes, we also have to modify the compat version of this
system call in the same way.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h |  2 +-
 kernel/signal.c          | 17 +++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index fb3a05fab8aa..2ac3d13a915b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -635,7 +635,7 @@ asmlinkage long sys_rt_sigprocmask(int how, sigset_t __user *set,
 asmlinkage long sys_rt_sigpending(sigset_t __user *set, size_t sigsetsize);
 asmlinkage long sys_rt_sigtimedwait(const sigset_t __user *uthese,
 				siginfo_t __user *uinfo,
-				const struct timespec __user *uts,
+				const struct __kernel_timespec __user *uts,
 				size_t sigsetsize);
 asmlinkage long sys_rt_sigqueueinfo(pid_t pid, int sig, siginfo_t __user *uinfo);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index a4db724e14c1..0831d56a731a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3082,7 +3082,7 @@ int copy_siginfo_from_user32(struct siginfo *to,
  *  @ts: upper bound on process time suspension
  */
 static int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
-		    const struct timespec *ts)
+		    const struct timespec64 *ts)
 {
 	ktime_t *to = NULL, timeout = KTIME_MAX;
 	struct task_struct *tsk = current;
@@ -3090,9 +3090,9 @@ static int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
 	int sig, ret = 0;
 
 	if (ts) {
-		if (!timespec_valid(ts))
+		if (!timespec64_valid(ts))
 			return -EINVAL;
-		timeout = timespec_to_ktime(*ts);
+		timeout = timespec64_to_ktime(*ts);
 		to = &timeout;
 	}
 
@@ -3140,11 +3140,12 @@ static int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
  *  @sigsetsize: size of sigset_t type
  */
 SYSCALL_DEFINE4(rt_sigtimedwait, const sigset_t __user *, uthese,
-		siginfo_t __user *, uinfo, const struct timespec __user *, uts,
+		siginfo_t __user *, uinfo,
+		const struct __kernel_timespec __user *, uts,
 		size_t, sigsetsize)
 {
 	sigset_t these;
-	struct timespec ts;
+	struct timespec64 ts;
 	siginfo_t info;
 	int ret;
 
@@ -3156,7 +3157,7 @@ SYSCALL_DEFINE4(rt_sigtimedwait, const sigset_t __user *, uthese,
 		return -EFAULT;
 
 	if (uts) {
-		if (copy_from_user(&ts, uts, sizeof(ts)))
+		if (get_timespec64(&ts, uts))
 			return -EFAULT;
 	}
 
@@ -3176,7 +3177,7 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait, compat_sigset_t __user *, uthese,
 		struct old_timespec32 __user *, uts, compat_size_t, sigsetsize)
 {
 	sigset_t s;
-	struct timespec t;
+	struct timespec64 t;
 	siginfo_t info;
 	long ret;
 
@@ -3187,7 +3188,7 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait, compat_sigset_t __user *, uthese,
 		return -EFAULT;
 
 	if (uts) {
-		if (compat_get_timespec(&t, uts))
+		if (get_old_timespec32(&t, uts))
 			return -EFAULT;
 	}
 
-- 
2.18.0

