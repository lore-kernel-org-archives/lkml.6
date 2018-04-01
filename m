Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754592AbeDAUnt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:43:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753901AbeDAUnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:43:47 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 35/45] C++: Fix static_branch_likely/unlikely()
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:43:45 +0100
Message-ID: <152261542576.30503.8474929957674990486.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix static_branch_likely/unlikely() to use C++ function overloading to
simplify the source.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/jump_label.h |   41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 2168cc6b8b30..25683b1764bf 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -387,29 +387,26 @@ extern bool ____wrong_branch_error(void);
  * See jump_label_type() / jump_label_init_type().
  */
 
-#define static_branch_likely(x)							\
-({										\
-	bool branch;								\
-	if (__builtin_types_compatible_p(typeof(*x), struct static_key_true))	\
-		branch = !arch_static_branch(&(x)->key, true);			\
-	else if (__builtin_types_compatible_p(typeof(*x), struct static_key_false)) \
-		branch = !arch_static_branch_jump(&(x)->key, true);		\
-	else									\
-		branch = ____wrong_branch_error();				\
-	likely(branch);								\
-})
 
-#define static_branch_unlikely(x)						\
-({										\
-	bool branch;								\
-	if (__builtin_types_compatible_p(typeof(*x), struct static_key_true))	\
-		branch = arch_static_branch_jump(&(x)->key, false);		\
-	else if (__builtin_types_compatible_p(typeof(*x), struct static_key_false)) \
-		branch = arch_static_branch(&(x)->key, false);			\
-	else									\
-		branch = ____wrong_branch_error();				\
-	unlikely(branch);							\
-})
+static inline bool static_branch_likely(struct static_key_true *x)
+{
+	return likely(!arch_static_branch(&(x)->key, true));
+}
+
+static inline bool static_branch_likely(struct static_key_false *x)
+{
+	return likely(!arch_static_branch_jump(&(x)->key, true));
+}
+
+static inline bool static_branch_unlikely(struct static_key_true *x)
+{
+	return unlikely(!arch_static_branch_jump(&(x)->key, true));
+}
+
+static inline bool static_branch_unlikely(struct static_key_false *x)
+{
+	return unlikely(!arch_static_branch(&(x)->key, true));
+}
 
 #else /* !HAVE_JUMP_LABEL */
 
