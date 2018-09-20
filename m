Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F0EECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7208921522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uM5EYgRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7208921522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbeITKek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 06:34:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34459 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731390AbeITKei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 06:34:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id d19-v6so3824165pgv.1;
        Wed, 19 Sep 2018 21:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fasTCoAPZVwjqwOQBf+Or2gIUaryX3r7wiRDzuaEyJQ=;
        b=uM5EYgRb9+QdZBc1aRs//mOiVAgT8aGgQubk3cKAIrSUgDVbBgGITco7nHA697i7XY
         g2rqpGvYslKUoX09TQhFh3zs5Wyhve4sUdU4Q6Or5sLS7r1v3GBmEWTG3MmBhvnUUPdT
         5jr/Jz4ggjzFcD8xQsqNn8SxrkM/4a2+k8sDoXrlmZOQJ4yrK/tpLtbgA7sk1CUROE47
         gXlVZyL+lJ/JXKm9JA0Ut2B8nxRfWur0CbVZ4+8mdGUw8f3kIpp2ubIcLWbd1QoClZ6e
         YgmeEJAt8sp2rt5tMU8SYDIUZ5Kw0Ga2l6Ljz/9mSvhlQEzgfT0o4X0ThDmsxd3a3G2n
         K/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fasTCoAPZVwjqwOQBf+Or2gIUaryX3r7wiRDzuaEyJQ=;
        b=Afvq8XMuHbnu4OEbz0DcwB7eSuhQRHGL6AKERDxjmwob4A5ZL6cZwXYVFgPSzv0M7H
         rHhdswdySU3zEb51BM1G3AY3qwvhebTeByykO2uiEB/fZNAwuAmIH5fO1tmhqsoY2CBP
         iDKdXZ9j+39g8bhflzF7zkAA+l/W6Cm4syeCbnowKQnclMf0yRbUdb5G4Kwwe+ZA47Vi
         QiPIgmcGWi5agGr2aeW6QpbQ8wgCrzXUPBfICvOTcsof0gFKnjl73xc+dLHX5Boqjkb6
         ahYOrgmac0jDYNyDgO/kwp2EJxn7cybM77OnMZNnr/t4M5UEwE2haDMsBAoaQo6kx+Et
         c89Q==
X-Gm-Message-State: APzg51AtqLjx+6ZKacITh7jU+h06BrH//W8aCHycm3brIL94JBE6TdyD
        aEeJYCDDwqUgi76jkYLU6+yGLb5e
X-Google-Smtp-Source: ANB0VdbSgsFJaLsF7PL7PlqHEN9TkggjGf81zqQuN5M3Ie43RQ8Fxmei0npHS21SDIg7TBwwaGo+/Q==
X-Received: by 2002:a62:2b50:: with SMTP id r77-v6mr39080709pfr.51.1537419190032;
        Wed, 19 Sep 2018 21:53:10 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id d66-v6sm39209705pfd.121.2018.09.19.21.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 21:53:09 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-aio@kvack.org
Subject: [PATCH v4 5/5] io_pgetevents: use __kernel_timespec
Date:   Wed, 19 Sep 2018 21:41:08 -0700
Message-Id: <20180920044108.6606-6-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920044108.6606-1-deepa.kernel@gmail.com>
References: <20180920044108.6606-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct timespec is not y2038 safe.
struct __kernel_timespec is the new y2038 safe structure for all
syscalls that are using struct timespec.
Update io_pgetevents interfaces to use struct __kernel_timespec.

sigset_t also has different representations on 32 bit and 64 bit
architectures. Hence, we need to support the following different
syscalls:

New y2038 safe syscalls:
(Controlled by CONFIG_64BIT_TIME for 32 bit ABIs)

Native 64 bit(unchanged) and native 32 bit : sys_io_pgetevents
Compat : compat_sys_io_pgetevents_time64

Older y2038 unsafe syscalls:
(Controlled by CONFIG_32BIT_COMPAT_TIME for 32 bit ABIs)

Native 32 bit : sys_io_pgetevents_time32
Compat : compat_sys_io_pgetevents

Note that io_getevents syscalls do not have a y2038 safe solution.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/aio.c                 | 84 ++++++++++++++++++++++++++++++++++++++--
 include/linux/compat.h   |  6 +++
 include/linux/syscalls.h | 10 ++++-
 3 files changed, 95 insertions(+), 5 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index b81c216534d6..5caf31455f90 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2063,11 +2063,13 @@ static long do_io_getevents(aio_context_t ctx_id,
  *	specifies an infinite timeout. Note that the timeout pointed to by
  *	timeout is relative.  Will fail with -ENOSYS if not implemented.
  */
+#if !defined(CONFIG_64BIT_TIME) || defined(CONFIG_64BIT)
+
 SYSCALL_DEFINE5(io_getevents, aio_context_t, ctx_id,
 		long, min_nr,
 		long, nr,
 		struct io_event __user *, events,
-		struct timespec __user *, timeout)
+		struct __kernel_timespec __user *, timeout)
 {
 	struct timespec64	ts;
 	int			ret;
@@ -2081,6 +2083,8 @@ SYSCALL_DEFINE5(io_getevents, aio_context_t, ctx_id,
 	return ret;
 }
 
+#endif
+
 struct __aio_sigset {
 	const sigset_t __user	*sigmask;
 	size_t		sigsetsize;
@@ -2091,7 +2095,7 @@ SYSCALL_DEFINE6(io_pgetevents,
 		long, min_nr,
 		long, nr,
 		struct io_event __user *, events,
-		struct timespec __user *, timeout,
+		struct __kernel_timespec __user *, timeout,
 		const struct __aio_sigset __user *, usig)
 {
 	struct __aio_sigset	ksig = { NULL, };
@@ -2105,6 +2109,39 @@ SYSCALL_DEFINE6(io_pgetevents,
 	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
 		return -EFAULT;
 
+	ret = set_user_sigmask(ksig.sigmask, &ksigmask, &sigsaved, ksig.sigsetsize);
+	if (ret)
+		return ret;
+
+	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
+	restore_user_sigmask(ksig.sigmask, &sigsaved);
+	if (signal_pending(current) && !ret)
+		ret = -ERESTARTNOHAND;
+
+	return ret;
+}
+
+#if defined(CONFIG_COMPAT_32BIT_TIME) && !defined(CONFIG_64BIT)
+
+SYSCALL_DEFINE6(io_pgetevents_time32,
+		aio_context_t, ctx_id,
+		long, min_nr,
+		long, nr,
+		struct io_event __user *, events,
+		struct old_timespec32 __user *, timeout,
+		const struct __aio_sigset __user *, usig)
+{
+	struct __aio_sigset	ksig = { NULL, };
+	sigset_t		ksigmask, sigsaved;
+	struct timespec64	ts;
+	int ret;
+
+	if (timeout && unlikely(get_old_timespec32(&ts, timeout)))
+		return -EFAULT;
+
+	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
+		return -EFAULT;
+
 
 	ret = set_user_sigmask(ksig.sigmask, &ksigmask, &sigsaved, ksig.sigsetsize);
 	if (ret)
@@ -2118,7 +2155,10 @@ SYSCALL_DEFINE6(io_pgetevents,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
+#endif
+
+#if defined(CONFIG_COMPAT_32BIT_TIME)
+
 COMPAT_SYSCALL_DEFINE5(io_getevents, compat_aio_context_t, ctx_id,
 		       compat_long_t, min_nr,
 		       compat_long_t, nr,
@@ -2137,12 +2177,17 @@ COMPAT_SYSCALL_DEFINE5(io_getevents, compat_aio_context_t, ctx_id,
 	return ret;
 }
 
+#endif
+
+#ifdef CONFIG_COMPAT
 
 struct __compat_aio_sigset {
 	compat_sigset_t __user	*sigmask;
 	compat_size_t		sigsetsize;
 };
 
+#if defined(CONFIG_COMPAT_32BIT_TIME)
+
 COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 		compat_aio_context_t, ctx_id,
 		compat_long_t, min_nr,
@@ -2173,4 +2218,37 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 
 	return ret;
 }
+
+#endif
+
+COMPAT_SYSCALL_DEFINE6(io_pgetevents_time64,
+		compat_aio_context_t, ctx_id,
+		compat_long_t, min_nr,
+		compat_long_t, nr,
+		struct io_event __user *, events,
+		struct __kernel_timespec __user *, timeout,
+		const struct __compat_aio_sigset __user *, usig)
+{
+	struct __compat_aio_sigset ksig = { NULL, };
+	sigset_t ksigmask, sigsaved;
+	struct timespec64 t;
+	int ret;
+
+	if (timeout && get_timespec64(&t, timeout))
+		return -EFAULT;
+
+	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
+		return -EFAULT;
+
+	ret = set_compat_user_sigmask(ksig.sigmask, &ksigmask, &sigsaved, ksig.sigsetsize);
+	if (ret)
+		return ret;
+
+	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
+	restore_user_sigmask(ksig.sigmask, &sigsaved);
+	if (signal_pending(current) && !ret)
+		ret = -ERESTARTNOHAND;
+
+	return ret;
+}
 #endif
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 6896e6e51c00..50cd0329c8bf 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -556,6 +556,12 @@ asmlinkage long compat_sys_io_pgetevents(compat_aio_context_t ctx_id,
 					struct io_event __user *events,
 					struct old_timespec32 __user *timeout,
 					const struct __compat_aio_sigset __user *usig);
+asmlinkage long compat_sys_io_pgetevents_time64(compat_aio_context_t ctx_id,
+					compat_long_t min_nr,
+					compat_long_t nr,
+					struct io_event __user *events,
+					struct __kernel_timespec __user *timeout,
+					const struct __compat_aio_sigset __user *usig);
 
 /* fs/cookies.c */
 asmlinkage long compat_sys_lookup_dcookie(u32, u32, char __user *, compat_size_t);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e9cd0409c3fe..3ff0e29c082c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -297,12 +297,18 @@ asmlinkage long sys_io_getevents(aio_context_t ctx_id,
 				long min_nr,
 				long nr,
 				struct io_event __user *events,
-				struct timespec __user *timeout);
+				struct __kernel_timespec __user *timeout);
 asmlinkage long sys_io_pgetevents(aio_context_t ctx_id,
 				long min_nr,
 				long nr,
 				struct io_event __user *events,
-				struct timespec __user *timeout,
+				struct __kernel_timespec __user *timeout,
+				const struct __aio_sigset *sig);
+asmlinkage long sys_io_pgetevents_time32(aio_context_t ctx_id,
+				long min_nr,
+				long nr,
+				struct io_event __user *events,
+				struct old_timespec32 __user *timeout,
 				const struct __aio_sigset *sig);
 
 /* fs/xattr.c */
-- 
2.17.1

