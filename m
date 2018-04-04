Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeDDQev (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:34:51 -0400
Received: from foss.arm.com ([217.140.101.70]:46440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751896AbeDDQeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:34:50 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: lizhijian@cn.fujitsu.com, sandipan@linux.vnet.ibm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH] tools: restore READ_ONCE() C++ compatibility
Date: Wed,  4 Apr 2018 17:34:45 +0100
Message-Id: <20180404163445.16492-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our userspace <linux/compiler.h> defines READ_ONCE() in a way that clang
doesn't like, as we have an anonymous union in which neither field is
initialized.

WRITE_ONCE() is fine since it initializes the __val field. For
READ_ONCE() we can keep clang and GCC happy with a dummy initialization
of the __c field, so let's do that.

At the same time, let's split READ_ONCE() and WRITE_ONCE() over several
lines for legibility, as we do in the in-kernel <linux/compiler.h>.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 6aa7de059173a986 ("locking/atomics: COCCINELLE/treewide: Convert trivial ACCESS_ONCE() patterns to READ_ONCE()/WRITE_ONCE()")
Reported-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reported-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/compiler.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

Hi,

This is fallout from my automated ACCESS_ONCE() removal, and I'm not that
familiar with using clang for perf.

In local testing, this fixes READ_ONCE() when compiling with clang, but I
subsequently hit some other issues which I believe are down to LLVM API
changes.

Zhijian, Sandipan, does this patch work for you?

Thanks,
Mark.

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 04e32f965ad7..1827c2f973f9 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -151,11 +151,21 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
  * required ordering.
  */
 
-#define READ_ONCE(x) \
-	({ union { typeof(x) __val; char __c[1]; } __u; __read_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
-
-#define WRITE_ONCE(x, val) \
-	({ union { typeof(x) __val; char __c[1]; } __u = { .__val = (val) }; __write_once_size(&(x), __u.__c, sizeof(x)); __u.__val; })
+#define READ_ONCE(x)					\
+({							\
+	union { typeof(x) __val; char __c[1]; } __u =	\
+		{ .__c = { 0 } };			\
+	__read_once_size(&(x), __u.__c, sizeof(x));	\
+	__u.__val;					\
+})
+
+#define WRITE_ONCE(x, val)				\
+({							\
+	union { typeof(x) __val; char __c[1]; } __u =	\
+		{ .__val = (val) }; 			\
+	__write_once_size(&(x), __u.__c, sizeof(x));	\
+	__u.__val;					\
+})
 
 
 #ifndef __fallthrough
-- 
2.11.0
