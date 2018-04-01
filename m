Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754399AbeDAUm0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:42:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754382AbeDAUmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:42:23 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 21/45] C++: Set the type of atomic64_t to s64
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:42:21 +0100
Message-ID: <152261534183.30503.13961922233693133727.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always declare the type of atomic64_t to be s64 rather than conditionally
defining it as long in generic code.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/atomic64_64.h |   12 ++++++------
 include/linux/types.h              |    4 +---
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 738495caf05f..895292a50c77 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -172,20 +172,20 @@ static inline long atomic64_fetch_sub(long i, atomic64_t *v)
 #define atomic64_inc_return(v)  (atomic64_add_return(1, (v)))
 #define atomic64_dec_return(v)  (atomic64_sub_return(1, (v)))
 
-static inline long atomic64_cmpxchg(atomic64_t *v, long old, long new)
+static inline long atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new_val)
 {
-	return cmpxchg(&v->counter, old, new);
+	return cmpxchg(&v->counter, old, new_val);
 }
 
 #define atomic64_try_cmpxchg atomic64_try_cmpxchg
-static __always_inline bool atomic64_try_cmpxchg(atomic64_t *v, s64 *old, long new)
+static __always_inline bool atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new_val)
 {
-	return try_cmpxchg(&v->counter, old, new);
+	return try_cmpxchg(&v->counter, *old, new_val);
 }
 
-static inline long atomic64_xchg(atomic64_t *v, long new)
+static inline long atomic64_xchg(atomic64_t *v, long new_val)
 {
-	return xchg(&v->counter, new);
+	return xchg(&v->counter, new_val);
 }
 
 /**
diff --git a/include/linux/types.h b/include/linux/types.h
index 68323cb03910..d233b12c7ebe 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -179,11 +179,9 @@ typedef struct {
 	int counter;
 } atomic_t;
 
-#ifdef CONFIG_64BIT
 typedef struct {
-	long counter;
+	s64 counter;
 } atomic64_t;
-#endif
 
 struct list_head {
 	struct list_head *next, *prev;
