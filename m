Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754450AbeDAUmo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:42:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754438AbeDAUml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:42:41 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 24/45] C++: Fix BUILD_BUG_ON_ZERO()
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:42:39 +0100
Message-ID: <152261535982.30503.18110930471409401085.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix BUILD_BUG_ON_ZERO() to work in C++.  The construction format:

	(struct { ... })

is something C++ doesn't like.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/build_bug.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index 43d1fd50d433..7445385cd26f 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -20,13 +20,16 @@
 #define BUILD_BUG_ON_NOT_POWER_OF_2(n)			\
 	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
 
+extern int __build_bug_on_zero(void)
+	__compiletime_error("Build bug on zero");
+
 /*
  * Force a compilation error if condition is true, but also produce a
  * result (of value 0 and type size_t), so the expression can be used
  * e.g. in a structure initializer (or where-ever else comma expressions
  * aren't permitted).
  */
-#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
+#define BUILD_BUG_ON_ZERO(e)  ((e) ? 0 : __build_bug_on_zero())
 
 /*
  * BUILD_BUG_ON_INVALID() permits the compiler to check the validity of the
