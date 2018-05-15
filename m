Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbeEOV3S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:29:18 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:54610 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752601AbeEOV0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:26:13 -0400
From: Nadav Amit <namit@vmware.com>
To: <linux-kernel@vger.kernel.org>
CC: <nadav.amit@gmail.com>, Nadav Amit <namit@vmware.com>,
        Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [RFC 7/8] ilog2: preventing compiler distortion due to big condition
Date: Tue, 15 May 2018 07:11:14 -0700
Message-ID: <20180515141124.84254-8-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515141124.84254-1-namit@vmware.com>
References: <20180515141124.84254-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several places in the kernel in which there is a condition
that is based on whether the input is known to be constant in
compilation time. If it is, there are complex computations, which only
take place during compilation time.

Although this scheme works correctly, when GCC computes the expected
cost of this code in time and size, it disregards the fact that the
computations of the "constant" case will not take place during runtime
for the non-constant case. The cost of these functions is considered to
be much higher.  As a result, inline and branching decisions of the
compiler are distorted. Specifically, functions are less likely to be
inlined due to their preserved big size and execution time.

One of this cases is ilog2() which performs a complicated condition for
constant inputs.

The solution is to use __builtin_choose_expr() to detect whether the
input is constant instead of a C condition. GCC evaluates the builtin
earlier, which allows it to improve code-generation decisions.

This patch allows to inline functions such as tbl_size().

   text	   data	    bss	    dec	    hex	filename
18148888 10064016 2936832 31149736 1db4ea8 ./vmlinux before
18149165 10064176 2936832 31150173 1db505d ./vmlinux after (+437)

Static text symbols:
Before:	39650
After:	39643	(-7)

Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/log2.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/log2.h b/include/linux/log2.h
index 41a1ae010993..aa4dac874339 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -83,7 +83,8 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
  */
 #define ilog2(n)				\
 (						\
-	__builtin_constant_p(n) ? (		\
+	__builtin_choose_expr(			\
+		__builtin_constant_p(n), (	\
 		(n) < 2 ? 0 :			\
 		(n) & (1ULL << 63) ? 63 :	\
 		(n) & (1ULL << 62) ? 62 :	\
@@ -147,10 +148,10 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
 		(n) & (1ULL <<  4) ?  4 :	\
 		(n) & (1ULL <<  3) ?  3 :	\
 		(n) & (1ULL <<  2) ?  2 :	\
-		1 ) :				\
-	(sizeof(n) <= 4) ?			\
-	__ilog2_u32(n) :			\
-	__ilog2_u64(n)				\
+		1),				\
+		(sizeof(n) <= 4) ?		\
+		__ilog2_u32(n) :		\
+		__ilog2_u64(n))			\
  )
 
 /**
-- 
2.17.0
