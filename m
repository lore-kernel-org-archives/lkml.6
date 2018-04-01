Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbeDAUlA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:41:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753896AbeDAUk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:40:58 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/45] C++: Define a header with some C++ type traits for
 type checking
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:40:57 +0100
Message-ID: <152261525734.30503.803101607707002603.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header that provides the following facilities:

 (1) A construction to determine whether two types are the same.

 (2) A construction to determine whether a pointer can be determined to be
     NULL at compile time.

 (3) A construction to determine whether a type is an array as compile
     time.

Note that these are implemented as C++ type traits, for example:

	char *p;
	if (__is_array(p))
		this_is_not_executed();
	else
		this_is_executed();

See http://en.cppreference.com/w/cpp/types

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/compiler-c++.h |   54 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/compiler-gcc.h |    5 ++--
 include/linux/kernel.h       |    3 ++
 3 files changed, 59 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/compiler-c++.h

diff --git a/include/linux/compiler-c++.h b/include/linux/compiler-c++.h
new file mode 100644
index 000000000000..84f7607d6ccc
--- /dev/null
+++ b/include/linux/compiler-c++.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 -*- c++ -*- */
+/*
+ * C++ type traits.  See http://en.cppreference.com/w/cpp/types
+ */
+#ifndef _LINUX_TYPE_TRAITS_H
+#define _LINUX_TYPE_TRAITS_H
+
+template<typename T, T v>
+struct integral_constant {
+	static constexpr T value = v;
+	typedef T value_type;
+	typedef integral_constant type; // using injected-typename-name
+	constexpr operator value_type() const noexcept { return value; }
+	constexpr value_type operator()() const noexcept { return value; } //since c++14
+};
+
+typedef integral_constant<bool, true>  true_type;
+typedef integral_constant<bool, false> false_type;
+
+/*
+ *  Determine if two types are the same.
+ */
+template<typename T, typename U>	struct is_same : false_type {};
+template<typename T>			struct is_same<T, T> : true_type {};
+
+/*
+ * Strip const and volatile from type.
+ */
+template<typename T> struct remove_const		{ typedef T type; };
+template<typename T> struct remove_const<const T>	{ typedef T type; };
+template<typename T> struct remove_volatile		{ typedef T type; };
+template<typename T> struct remove_volatile<volatile T>	{ typedef T type; };
+template<typename T> struct remove_cv {
+	typedef typename remove_volatile<typename remove_const<T>::type>::type type;
+};
+
+template<typename T> using remove_cv_t       = typename remove_cv<T>::type;
+template<typename T> using remove_const_t    = typename remove_const<T>::type;
+template<typename T> using remove_volatile_t = typename remove_volatile<T>::type;
+
+/*
+ * Determine if a type is the NULL pointer type.
+ */
+template<typename T> struct is_null_pointer : is_same<nullptr_t, remove_cv_t<T>> {};
+
+/*
+ * Determine if a type is an array type.
+ */
+template<typename T>		struct is_array : false_type {};
+template<typename T>		struct is_array<T[]> : true_type {};
+template<typename T, size_t N>	struct is_array<T[N]> : true_type {};
+#define __is_array(T) is_array<typeof(T)>::value
+
+#endif /* _LINUX_TYPE_TRAITS_H */
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index e2c7f4369eff..6ab6431a65a6 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -58,11 +58,12 @@
 #define OPTIMIZER_HIDE_VAR(var)						\
 	__asm__ ("" : "=r" (var) : "0" (var))
 
-#ifdef __CHECKER__
+#if defined(__CHECKER__) // || defined(__cplusplus)
 #define __must_be_array(a)	0
 #else
 /* &a[0] degrades to a pointer: a different type from an array */
-#define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
+//#define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
+#define __must_be_array(a)	BUILD_BUG_ON_ZERO(__is_array(a))
 #endif
 
 /*
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 3fd291503576..e779a7487c34 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 -*- c++ -*- */
 #ifndef _LINUX_KERNEL_H
 #define _LINUX_KERNEL_H
 
@@ -8,6 +8,7 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/compiler-c++.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <linux/typecheck.h>
