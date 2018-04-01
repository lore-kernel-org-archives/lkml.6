Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeDAUlb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:41:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753951AbeDAUl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:41:29 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/45] C++: x86: Turn cmpxchg_double() & co. into inline
 template functions
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:41:27 +0100
Message-ID: <152261528761.30503.4314337036821536020.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn cmpxchg_double() and similar functions into inline C++ template
functions.  This produces more robust source as the all the casting the C
macros require is then unnecessary.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/cmpxchg.h |   93 +++++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index 4bbf947c88a2..2ffe1c621eb1 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -180,27 +180,76 @@ static inline P sync_cmpxchg(P *ptr, P old, N rep)
 # include <asm/cmpxchg_64.h>
 #endif
 
-#define __cmpxchg_double(pfx, p1, p2, o1, o2, n1, n2)			\
-({									\
-	bool __ret;							\
-	__typeof__(*(p1)) __old1 = (o1), __new1 = (n1);			\
-	__typeof__(*(p2)) __old2 = (o2), __new2 = (n2);			\
-	BUILD_BUG_ON(sizeof(*(p1)) != sizeof(long));			\
-	BUILD_BUG_ON(sizeof(*(p2)) != sizeof(long));			\
-	VM_BUG_ON((unsigned long)(p1) % (2 * sizeof(long)));		\
-	VM_BUG_ON((unsigned long)((p1) + 1) != (unsigned long)(p2));	\
-	asm volatile(pfx "cmpxchg%c4b %2; sete %0"			\
-		     : "=a" (__ret), "+d" (__old2),			\
-		       "+m" (*(p1)), "+m" (*(p2))			\
-		     : "i" (2 * sizeof(long)), "a" (__old1),		\
-		       "b" (__new1), "c" (__new2));			\
-	__ret;								\
-})
-
-#define cmpxchg_double(p1, p2, o1, o2, n1, n2) \
-	__cmpxchg_double(LOCK_PREFIX, p1, p2, o1, o2, n1, n2)
-
-#define cmpxchg_double_local(p1, p2, o1, o2, n1, n2) \
-	__cmpxchg_double(, p1, p2, o1, o2, n1, n2)
+template <typename P1, typename P2, typename N1, typename N2>
+static inline bool __cmpxchg_double(P1 *p1,  P2 *p2,
+				    P1 old1, P2 old2,
+				    N1 rep1, N2 rep2,
+				    enum cmpxchg_lock lock = __lock_always)
+{
+	bool ret;
+
+	if (sizeof(P1) != sizeof(long)) __cmpxchg_wrong_size();
+	if (sizeof(P2) != sizeof(long))	__cmpxchg_wrong_size();
+
+	//VM_BUG_ON((unsigned long)(p1) % (2 * sizeof(long)));
+	//VM_BUG_ON((unsigned long)((p1) + 1) != (unsigned long)(p2));
+
+	switch (lock) {
+	case __lock_local:
+		asm volatile("cmpxchg%c4b %[ptr1]"
+			     CC_SET(z)
+			     : CC_OUT(z) (ret),
+			       [old2]"+d" (old2),
+			       [ptr1] "+m" (*p1),
+			       [ptr2] "+m" (*p2)
+			     : "i" (2 * sizeof(long)),
+			       [old1] "a" (old1),
+			       [rep1] "b" (rep1),
+			       [rep2] "c" (rep2));
+		break;
+	case __lock_smp:
+		asm volatile(LOCK_PREFIX "cmpxchg%c4b %[ptr1]"
+			     CC_SET(z)
+			     : CC_OUT(z) (ret),
+			       [old2]"+d" (old2),
+			       [ptr1] "+m" (*p1),
+			       [ptr2] "+m" (*p2)
+			     : "i" (2 * sizeof(long)),
+			       [old1] "a" (old1),
+			       [rep1] "b" (rep1),
+			       [rep2] "c" (rep2));
+		break;
+	case __lock_always:
+		asm volatile("lock; cmpxchg%c4b %[ptr1]"
+			     CC_SET(z)
+			     : CC_OUT(z) (ret),
+			       [old2]"+d" (old2),
+			       [ptr1] "+m" (*p1),
+			       [ptr2] "+m" (*p2)
+			     : "i" (2 * sizeof(long)),
+			       [old1] "a" (old1),
+			       [rep1] "b" (rep1),
+			       [rep2] "c" (rep2));
+		break;
+	}
+
+	return ret;
+}
+
+template <typename P1, typename P2, typename N1, typename N2>
+static inline bool cmpxchg_double(P1 *p1,  P2 *p2,
+				  P1 old1, P2 old2,
+				  N1 rep1, N2 rep2)
+{
+	return __cmpxchg_double(p1, p2, old1, old2, rep1, rep2, __lock_always);
+}
+
+template <typename P1, typename P2, typename N1, typename N2>
+static inline bool cmpxchg_double_local(P1 *p1,  P2 *p2,
+					P1 old1, P2 old2,
+					N1 rep1, N2 rep2)
+{
+	return __cmpxchg_double(p1, p2, old1, old2, rep1, rep2, __lock_local);
+}
 
 #endif	/* ASM_X86_CMPXCHG_H */
