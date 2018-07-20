Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB1FECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6369D20854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6369D20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbeGTNRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:17:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37710 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbeGTNRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:17:49 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DF79BBD4;
        Fri, 20 Jul 2018 12:29:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Sodagudi Prasad <psodagud@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 04/66] compiler, clang: always inline when CONFIG_OPTIMIZE_INLINING is disabled
Date:   Fri, 20 Jul 2018 14:13:21 +0200
Message-Id: <20180720121407.493796538@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121407.228772286@linuxfoundation.org>
References: <20180720121407.228772286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Rientjes <rientjes@google.com>

commit 9a04dbcfb33b4012d0ce8c0282f1e3ca694675b1 upstream.

The motivation for commit abb2ea7dfd82 ("compiler, clang: suppress
warning for unused static inline functions") was to suppress clang's
warnings about unused static inline functions.

For configs without CONFIG_OPTIMIZE_INLINING enabled, such as any non-x86
architecture, `inline' in the kernel implies that
__attribute__((always_inline)) is used.

Some code depends on that behavior, see
  https://lkml.org/lkml/2017/6/13/918:

  net/built-in.o: In function `__xchg_mb':
  arch/arm64/include/asm/cmpxchg.h:99: undefined reference to `__compiletime_assert_99'
  arch/arm64/include/asm/cmpxchg.h:99: undefined reference to `__compiletime_assert_99

The full fix would be to identify these breakages and annotate the
functions with __always_inline instead of `inline'.  But since we are
late in the 4.12-rc cycle, simply carry forward the forced inlining
behavior and work toward moving arm64, and other architectures, toward
CONFIG_OPTIMIZE_INLINING behavior.

Link: http://lkml.kernel.org/r/alpine.DEB.2.10.1706261552200.1075@chino.kir.corp.google.com
Signed-off-by: David Rientjes <rientjes@google.com>
Reported-by: Sodagudi Prasad <psodagud@codeaurora.org>
Tested-by: Sodagudi Prasad <psodagud@codeaurora.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/compiler-clang.h |    8 --------
 include/linux/compiler-gcc.h   |   18 +++++++++++-------
 2 files changed, 11 insertions(+), 15 deletions(-)

--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -16,14 +16,6 @@
  */
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
-/*
- * GCC does not warn about unused static inline functions for
- * -Wunused-function.  This turns out to avoid the need for complex #ifdef
- * directives.  Suppress the warning in clang as well.
- */
-#undef inline
-#define inline inline __attribute__((unused)) notrace
-
 /* Clang doesn't have a way to turn it off per-function, yet. */
 #ifdef __noretpoline
 #undef __noretpoline
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -66,18 +66,22 @@
 
 /*
  * Force always-inline if the user requests it so via the .config,
- * or if gcc is too old:
+ * or if gcc is too old.
+ * GCC does not warn about unused static inline functions for
+ * -Wunused-function.  This turns out to avoid the need for complex #ifdef
+ * directives.  Suppress the warning in clang as well by using "unused"
+ * function attribute, which is redundant but not harmful for gcc.
  */
 #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) ||		\
     !defined(CONFIG_OPTIMIZE_INLINING) || (__GNUC__ < 4)
-#define inline		inline		__attribute__((always_inline)) notrace
-#define __inline__	__inline__	__attribute__((always_inline)) notrace
-#define __inline	__inline	__attribute__((always_inline)) notrace
+#define inline inline		__attribute__((always_inline,unused)) notrace
+#define __inline__ __inline__	__attribute__((always_inline,unused)) notrace
+#define __inline __inline	__attribute__((always_inline,unused)) notrace
 #else
 /* A lot of inline functions can cause havoc with function tracing */
-#define inline		inline		notrace
-#define __inline__	__inline__	notrace
-#define __inline	__inline	notrace
+#define inline inline		__attribute__((unused)) notrace
+#define __inline__ __inline__	__attribute__((unused)) notrace
+#define __inline __inline	__attribute__((unused)) notrace
 #endif
 
 #define __always_inline	inline __attribute__((always_inline))


