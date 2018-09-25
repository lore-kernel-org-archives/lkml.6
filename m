Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39149ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AC520657
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AC520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeIYX3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:29:02 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:44390 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeIYX3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:29:01 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4r0h-00056w-FS; Tue, 25 Sep 2018 11:20:31 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4r0g-0001uD-9t; Tue, 25 Sep 2018 11:20:31 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 25 Sep 2018 19:19:06 +0200
Message-Id: <20180925171906.19683-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87h8idv6nw.fsf@xmission.com>
References: <87h8idv6nw.fsf@xmission.com>
X-XM-SPF: eid=1g4r0g-0001uD-9t;;;mid=<20180925171906.19683-6-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19oS2s1r2kIS992IYEvLew8EoEdANCMKPg=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 6/6] signal: Use a smaller struct siginfo in the kernel
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We reserve 128 bytes for struct siginfo but only use about 48 bytes on
64bit and 32 bytes on 32bit.  Someday we might use more but it is unlikely
to be anytime soon.

Userspace seems content with just enough bytes of siginfo to implement
sigqueue.  Or in the case of checkpoint/restart reinjecting signals
the kernel has sent.

Reducing the stack footprint and the work to copy siginfo around from
2 cachelines to 1 cachelines seems worth doing even if I don't have
benchmarks to show a performance difference.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/signal.h       |  2 +
 include/linux/signal_types.h |  5 +--
 kernel/signal.c              | 82 ++++++++++++++++++++++++++++--------
 3 files changed, 67 insertions(+), 22 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index 70031b10b918..706a499d1eb1 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -22,6 +22,8 @@ static inline void clear_siginfo(kernel_siginfo_t *info)
 	memset(info, 0, sizeof(*info));
 }
 
+#define SI_EXPANSION_SIZE (sizeof(struct siginfo) - sizeof(struct kernel_siginfo))
+
 int copy_siginfo_to_user(siginfo_t __user *to, const kernel_siginfo_t *from);
 int copy_siginfo_from_user(kernel_siginfo_t *to, const siginfo_t __user *from);
 
diff --git a/include/linux/signal_types.h b/include/linux/signal_types.h
index 2a40a9c5e4ad..f8a90ae9c6ec 100644
--- a/include/linux/signal_types.h
+++ b/include/linux/signal_types.h
@@ -10,10 +10,7 @@
 #include <uapi/linux/signal.h>
 
 typedef struct kernel_siginfo {
-	union {
-		__SIGINFO;
-		int _si_pad[SI_MAX_SIZE/sizeof(int)];
-	};
+	__SIGINFO;
 } kernel_siginfo_t;
 
 /*
diff --git a/kernel/signal.c b/kernel/signal.c
index 161cad4e448c..1c2dd117fee0 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2844,27 +2844,48 @@ COMPAT_SYSCALL_DEFINE2(rt_sigpending, compat_sigset_t __user *, uset,
 }
 #endif
 
+static const struct {
+	unsigned char limit, layout;
+} sig_sicodes[] = {
+	[SIGILL]  = { NSIGILL,  SIL_FAULT },
+	[SIGFPE]  = { NSIGFPE,  SIL_FAULT },
+	[SIGSEGV] = { NSIGSEGV, SIL_FAULT },
+	[SIGBUS]  = { NSIGBUS,  SIL_FAULT },
+	[SIGTRAP] = { NSIGTRAP, SIL_FAULT },
+#if defined(SIGEMT)
+	[SIGEMT]  = { NSIGEMT,  SIL_FAULT },
+#endif
+	[SIGCHLD] = { NSIGCHLD, SIL_CHLD },
+	[SIGPOLL] = { NSIGPOLL, SIL_POLL },
+	[SIGSYS]  = { NSIGSYS,  SIL_SYS },
+};
+
+static bool known_siginfo_layout(int sig, int si_code)
+{
+	if (si_code == SI_KERNEL)
+		return true;
+	else if ((si_code > SI_USER)) {
+		if (sig_specific_sicodes(sig)) {
+			if (si_code <= sig_sicodes[sig].limit)
+				return true;
+		}
+		else if (si_code <= NSIGPOLL)
+			return true;
+	}
+	else if (si_code >= SI_DETHREAD)
+		return true;
+	else if (si_code == SI_ASYNCNL)
+		return true;
+	return false;
+}
+
 enum siginfo_layout siginfo_layout(int sig, int si_code)
 {
 	enum siginfo_layout layout = SIL_KILL;
 	if ((si_code > SI_USER) && (si_code < SI_KERNEL)) {
-		static const struct {
-			unsigned char limit, layout;
-		} filter[] = {
-			[SIGILL]  = { NSIGILL,  SIL_FAULT },
-			[SIGFPE]  = { NSIGFPE,  SIL_FAULT },
-			[SIGSEGV] = { NSIGSEGV, SIL_FAULT },
-			[SIGBUS]  = { NSIGBUS,  SIL_FAULT },
-			[SIGTRAP] = { NSIGTRAP, SIL_FAULT },
-#if defined(SIGEMT)
-			[SIGEMT]  = { NSIGEMT,  SIL_FAULT },
-#endif
-			[SIGCHLD] = { NSIGCHLD, SIL_CHLD },
-			[SIGPOLL] = { NSIGPOLL, SIL_POLL },
-			[SIGSYS]  = { NSIGSYS,  SIL_SYS },
-		};
-		if ((sig < ARRAY_SIZE(filter)) && (si_code <= filter[sig].limit)) {
-			layout = filter[sig].layout;
+		if ((sig < ARRAY_SIZE(sig_sicodes)) &&
+		    (si_code <= sig_sicodes[sig].limit)) {
+			layout = sig_sicodes[sig].layout;
 			/* Handle the exceptions */
 			if ((sig == SIGBUS) &&
 			    (si_code >= BUS_MCEERR_AR) && (si_code <= BUS_MCEERR_AO))
@@ -2889,17 +2910,42 @@ enum siginfo_layout siginfo_layout(int sig, int si_code)
 	return layout;
 }
 
+static inline char __user *si_expansion(const siginfo_t __user *info)
+{
+	return ((char __user *)info) + sizeof(struct kernel_siginfo);
+}
+
 int copy_siginfo_to_user(siginfo_t __user *to, const kernel_siginfo_t *from)
 {
+	char __user *expansion = si_expansion(to);
 	if (copy_to_user(to, from , sizeof(struct kernel_siginfo)))
 		return -EFAULT;
+	if (clear_user(expansion, SI_EXPANSION_SIZE))
+		return -EFAULT;
 	return 0;
 }
 
 int copy_siginfo_from_user(kernel_siginfo_t *to, const siginfo_t __user *from)
 {
-	if (copy_from_user(to, from, sizeof(struct siginfo)))
+	if (copy_from_user(to, from, sizeof(struct kernel_siginfo)))
 		return -EFAULT;
+	if (unlikely(!known_siginfo_layout(to->si_signo, to->si_code))) {
+		char __user *expansion = si_expansion(from);
+		char buf[SI_EXPANSION_SIZE];
+		int i;
+		/*
+		 * An unknown si_code might need more than
+		 * sizeof(struct kernel_siginfo) bytes.  Verify all of the
+		 * extra bytes are 0.  This guarantees copy_siginfo_to_user
+		 * will return this data to userspace exactly.
+		 */
+		if (copy_from_user(&buf, expansion, SI_EXPANSION_SIZE))
+			return -EFAULT;
+		for (i = 0; i < SI_EXPANSION_SIZE; i++) {
+			if (buf[i] != 0)
+				return -E2BIG;
+		}
+	}
 	return 0;
 }
 
-- 
2.17.1

