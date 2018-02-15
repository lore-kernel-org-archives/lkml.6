Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032309AbeBOA3v (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:29:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56889 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032219AbeBOA3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:29:49 -0500
Date: Wed, 14 Feb 2018 16:29:24 -0800
From: tip-bot for Rui Wang <tipbot@zytor.com>
Message-ID: <tip-961888b1d76d84efc66a8f5604b06ac12ac2f978@git.kernel.org>
Cc: hpa@zytor.com, torvalds@linux-foundation.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rui.y.wang@intel.com
Reply-To: peterz@infradead.org, mingo@kernel.org, rui.y.wang@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        torvalds@linux-foundation.org
In-Reply-To: <1513586050-1641-1-git-send-email-rui.y.wang@intel.com>
References: <1513586050-1641-1-git-send-email-rui.y.wang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] selftests/x86/mpx: Fix incorrect bounds with old
 _sigfault
Git-Commit-ID: 961888b1d76d84efc66a8f5604b06ac12ac2f978
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  961888b1d76d84efc66a8f5604b06ac12ac2f978
Gitweb:     https://git.kernel.org/tip/961888b1d76d84efc66a8f5604b06ac12ac2f978
Author:     Rui Wang <rui.y.wang@intel.com>
AuthorDate: Mon, 18 Dec 2017 16:34:10 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 15 Feb 2018 01:15:52 +0100

selftests/x86/mpx: Fix incorrect bounds with old _sigfault

For distributions with old userspace header files, the _sigfault
structure is different. mpx-mini-test fails with the following
error:

  [root@Purley]# mpx-mini-test_64 tabletest
  XSAVE is supported by HW & OS
  XSAVE processor supported state mask: 0x2ff
  XSAVE OS supported state mask: 0x2ff
   BNDREGS: size: 64 user: 1 supervisor: 0 aligned: 0
    BNDCSR: size: 64 user: 1 supervisor: 0 aligned: 0
  starting mpx bounds table test
  ERROR: siginfo bounds do not match shadow bounds for register 0

Fix it by using the correct offset of _lower/_upper in _sigfault.
RHEL needs this patch to work.

Signed-off-by: Rui Wang <rui.y.wang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@linux.intel.com
Fixes: e754aedc26ef ("x86/mpx, selftests: Add MPX self test")
Link: http://lkml.kernel.org/r/1513586050-1641-1-git-send-email-rui.y.wang@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/mpx-mini-test.c | 32 +++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/mpx-mini-test.c b/tools/testing/selftests/x86/mpx-mini-test.c
index ec0f6b4..9c0325e 100644
--- a/tools/testing/selftests/x86/mpx-mini-test.c
+++ b/tools/testing/selftests/x86/mpx-mini-test.c
@@ -315,11 +315,39 @@ static inline void *__si_bounds_upper(siginfo_t *si)
 	return si->si_upper;
 }
 #else
+
+/*
+ * This deals with old version of _sigfault in some distros:
+ *
+
+old _sigfault:
+        struct {
+            void *si_addr;
+	} _sigfault;
+
+new _sigfault:
+	struct {
+		void __user *_addr;
+		int _trapno;
+		short _addr_lsb;
+		union {
+			struct {
+				void __user *_lower;
+				void __user *_upper;
+			} _addr_bnd;
+			__u32 _pkey;
+		};
+	} _sigfault;
+ *
+ */
+
 static inline void **__si_bounds_hack(siginfo_t *si)
 {
 	void *sigfault = &si->_sifields._sigfault;
 	void *end_sigfault = sigfault + sizeof(si->_sifields._sigfault);
-	void **__si_lower = end_sigfault;
+	int *trapno = (int*)end_sigfault;
+	/* skip _trapno and _addr_lsb */
+	void **__si_lower = (void**)(trapno + 2);
 
 	return __si_lower;
 }
@@ -331,7 +359,7 @@ static inline void *__si_bounds_lower(siginfo_t *si)
 
 static inline void *__si_bounds_upper(siginfo_t *si)
 {
-	return (*__si_bounds_hack(si)) + sizeof(void *);
+	return *(__si_bounds_hack(si) + 1);
 }
 #endif
 
