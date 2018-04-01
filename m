Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754132AbeDAUlG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:41:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753951AbeDAUlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:41:04 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/45] C++: Implement abs() as an inline template function
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:41:03 +0100
Message-ID: <152261526342.30503.10484708592420310318.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement abs() as an C++ inline template function as that greatly
simplifies the source.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/kernel.h |   19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index e779a7487c34..59089f76c7d8 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -246,20 +246,11 @@ extern int _cond_resched(void);
  *
  * Return: an absolute value of x.
  */
-#define abs(x)	__abs_choose_expr(x, long long,				\
-		__abs_choose_expr(x, long,				\
-		__abs_choose_expr(x, int,				\
-		__abs_choose_expr(x, short,				\
-		__abs_choose_expr(x, char,				\
-		__builtin_choose_expr(					\
-			__builtin_types_compatible_p(typeof(x), char),	\
-			(char)({ signed char __x = (x); __x<0?-__x:__x; }), \
-			((void)0)))))))
-
-#define __abs_choose_expr(x, type, other) __builtin_choose_expr(	\
-	__builtin_types_compatible_p(typeof(x),   signed type) ||	\
-	__builtin_types_compatible_p(typeof(x), unsigned type),		\
-	({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
+template<typename T>
+static inline T abs(T v)
+{
+	return v < 0 ? -v : v;
+}
 
 /**
  * reciprocal_scale - "scale" a value into range [0, ep_ro)
