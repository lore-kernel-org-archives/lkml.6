Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754338AbeDAUmH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:42:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754295AbeDAUmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:42:05 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 18/45] C++: Turn RCU accessors into inline template functions
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:42:03 +0100
Message-ID: <152261532385.30503.14346830829867907595.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the RCU accessor functions by turning them into inline template
functions.  There's then no need for the use of casts built around typeof.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/rcupdate.h |  124 +++++++++++++++++++++++++++++-----------------
 1 file changed, 78 insertions(+), 46 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 043d04784675..328b312f09f0 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1,4 +1,4 @@
-/*
+/* -*- c++ -*-
  * Read-Copy Update mechanism for mutual exclusion
  *
  * This program is free software; you can redistribute it and/or modify
@@ -337,32 +337,50 @@ static inline void rcu_preempt_sleep_check(void) { }
 #define rcu_dereference_sparse(p, space)
 #endif /* #else #ifdef __CHECKER__ */
 
-#define __rcu_access_pointer(p, space) \
-({ \
-	typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
-	rcu_dereference_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(_________p1)); \
-})
-#define __rcu_dereference_check(p, c, space) \
-({ \
-	/* Dependency order vs. p above. */ \
-	typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
-	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
-	rcu_dereference_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(________p1)); \
-})
-#define __rcu_dereference_protected(p, c, space) \
-({ \
-	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
-	rcu_dereference_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(p)); \
-})
-#define rcu_dereference_raw(p) \
-({ \
-	/* Dependency order vs. p above. */ \
-	typeof(p) ________p1 = READ_ONCE(p); \
-	((typeof(*p) __force __kernel *)(________p1)); \
-})
+template <typename T>
+T *__rcu_access_pointer(T *&p)
+{
+	/* Dependency order vs. p above. */
+	T *p1 = (T *__force)READ_ONCE(p);
+	rcu_dereference_sparse(p, __rcu);
+	return (T __force __kernel *)p1;
+}
+
+template <typename T>
+T *__rcu_dereference_check(T *&p, bool c)
+{
+	/* Dependency order vs. p above. */
+	T *p1 = (T *__force)READ_ONCE(p);
+	RCU_LOCKDEP_WARN(!c, "suspicious rcu_dereference_check() usage");
+	rcu_dereference_sparse(p, __rcu);
+	return (T __force __kernel *)p1;
+}
+
+template <typename T>
+T *__rcu_dereference_check(T *const &p, bool c)
+{
+	/* Dependency order vs. p above. */
+	T *p1 = (T *__force)READ_ONCE(p);
+	RCU_LOCKDEP_WARN(!c, "suspicious rcu_dereference_check() usage");
+	rcu_dereference_sparse(p, __rcu);
+	return (T __force __kernel *)p1;
+}
+
+template <typename T>
+T *__rcu_dereference_protected(T *&p, bool c)
+{
+	RCU_LOCKDEP_WARN(!c, "suspicious rcu_dereference_protected() usage");
+	rcu_dereference_sparse(p, __rcu);
+	return (T __force __kernel *)p;
+}
+
+template <typename T>
+T *rcu_dereference_raw(T *&p)
+{
+	/* Dependency order vs. p above. */
+	T *p1 = READ_ONCE(p);
+	return (T __force __kernel *)p1;
+}
 
 /**
  * RCU_INITIALIZER() - statically initialize an RCU-protected global variable
@@ -401,16 +419,14 @@ static inline void rcu_preempt_sleep_check(void) { }
  * please be careful when making changes to rcu_assign_pointer() and the
  * other macros that it invokes.
  */
-#define rcu_assign_pointer(p, v)					      \
-({									      \
-	uintptr_t _r_a_p__v = (uintptr_t)(v);				      \
-									      \
-	if (__builtin_constant_p(v) && (_r_a_p__v) == (uintptr_t)NULL)	      \
-		WRITE_ONCE((p), (typeof(p))(_r_a_p__v));		      \
-	else								      \
-		smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
-	_r_a_p__v;							      \
-})
+template <typename T>
+static inline void rcu_assign_pointer(T *&p, T *v)
+{
+	if (__builtin_constant_p(v) && !v)
+		WRITE_ONCE((p), v);
+	else
+		smp_store_release(&p, (T __force __rcu *)v);
+}
 
 /**
  * rcu_swap_protected() - swap an RCU and a regular pointer
@@ -482,8 +498,17 @@ static inline void rcu_preempt_sleep_check(void) { }
  * which pointers are protected by RCU and checks that the pointer is
  * annotated as __rcu.
  */
-#define rcu_dereference_check(p, c) \
-	__rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
+template <typename T>
+T *rcu_dereference_check(T *&p, bool c)
+{
+	return __rcu_dereference_check(p, c || rcu_read_lock_held());
+}
+
+template <typename T>
+T *rcu_dereference_check(T *const &p, bool c)
+{
+	return __rcu_dereference_check(p, c || rcu_read_lock_held());
+}
 
 /**
  * rcu_dereference_bh_check() - rcu_dereference_bh with debug checking
@@ -493,7 +518,7 @@ static inline void rcu_preempt_sleep_check(void) { }
  * This is the RCU-bh counterpart to rcu_dereference_check().
  */
 #define rcu_dereference_bh_check(p, c) \
-	__rcu_dereference_check((p), (c) || rcu_read_lock_bh_held(), __rcu)
+	__rcu_dereference_check((p), (c) || rcu_read_lock_bh_held())
 
 /**
  * rcu_dereference_sched_check() - rcu_dereference_sched with debug checking
@@ -532,7 +557,7 @@ static inline void rcu_preempt_sleep_check(void) { }
  * but very ugly failures.
  */
 #define rcu_dereference_protected(p, c) \
-	__rcu_dereference_protected((p), (c), __rcu)
+	__rcu_dereference_protected((p), (c))
 
 
 /**
@@ -814,11 +839,18 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * Note that unlike rcu_assign_pointer(), RCU_INIT_POINTER() provides no
  * ordering guarantees for either the CPU or the compiler.
  */
-#define RCU_INIT_POINTER(p, v) \
-	do { \
-		rcu_dereference_sparse(p, __rcu); \
-		WRITE_ONCE(p, RCU_INITIALIZER(v)); \
-	} while (0)
+template <typename T>
+static inline void RCU_INIT_POINTER(T *&p, T *v)
+{
+	rcu_dereference_sparse(p, __rcu);
+	WRITE_ONCE(p, (T __force __rcu *)v);
+}
+
+template <typename T>
+static inline void RCU_INIT_POINTER(T *&p, nullptr_t v)
+{
+	WRITE_ONCE(p, (T __force __rcu *)v);
+}
 
 /**
  * RCU_POINTER_INITIALIZER() - statically initialize an RCU protected pointer
