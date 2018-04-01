Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754222AbeDAUlh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:41:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753951AbeDAUlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:41:35 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/45] C++: x86: Turn cmpxchg64() & co. into inline template
 functions
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:41:33 +0100
Message-ID: <152261529364.30503.14203436620412946271.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn cmpxchg64() and similar functions into inline C++ template functions.
This produces more robust source as the all the casting the C macros
require is then unnecessary.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/cmpxchg_64.h |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index 03cad196a301..55beb7fc036d 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 -*- c++ -*- */
 #ifndef _ASM_X86_CMPXCHG_64_H
 #define _ASM_X86_CMPXCHG_64_H
 
@@ -7,17 +7,23 @@ static inline void set_64bit(volatile u64 *ptr, u64 val)
 	*ptr = val;
 }
 
-#define cmpxchg64(ptr, o, n)						\
-({									\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg((ptr), (o), (n));					\
-})
+template <typename P, typename N>
+static inline P cmpxchg64(P *ptr, P old, N rep)
+{
+	P ret = old;
+	if (sizeof(P) != 8)
+		__cmpxchg_wrong_size();
+	return cmpxchg(ptr, ret, rep);
+}
 
-#define cmpxchg64_local(ptr, o, n)					\
-({									\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg_local((ptr), (o), (n));					\
-})
+template <typename P, typename N>
+static inline P cmpxchg64_local(P *ptr, P old, N rep)
+{
+	P ret = old;
+	if (sizeof(P) != 8)
+		__cmpxchg_wrong_size();
+	return cmpxchg_local(ptr, ret, rep);
+}
 
 #define system_has_cmpxchg_double() boot_cpu_has(X86_FEATURE_CX16)
 
