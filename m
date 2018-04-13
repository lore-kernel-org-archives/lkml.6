Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754410AbeDMOBf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753859AbeDMOBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:01:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F9D217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/17] tools headers: Restore READ_ONCE() C++ compatibility
Date: Fri, 13 Apr 2018 11:00:56 -0300
Message-Id: <20180413140111.25313-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180413140111.25313-1-acme@kernel.org>
References: <20180413140111.25313-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

Our userspace <linux/compiler.h> defines READ_ONCE() in a way that clang
doesn't like, as we have an anonymous union in which neither field is
initialized.

WRITE_ONCE() is fine since it initializes the __val field. For
READ_ONCE() we can keep clang and GCC happy with a dummy initialization
of the __c field, so let's do that.

At the same time, let's split READ_ONCE() and WRITE_ONCE() over several
lines for legibility, as we do in the in-kernel <linux/compiler.h>.

Reported-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reported-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Tested-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 6aa7de059173a986 ("locking/atomics: COCCINELLE/treewide: Convert trivial ACCESS_ONCE() patterns to READ_ONCE()/WRITE_ONCE()")
Link: http://lkml.kernel.org/r/20180404163445.16492-1-mark.rutland@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/compiler.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

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
2.14.3
