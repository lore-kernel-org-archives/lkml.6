Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753003AbeBFUXj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 15:23:39 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40046 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbeBFUXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 15:23:38 -0500
X-Google-Smtp-Source: AH8x227ZzPxZbaaeFW2zQAJqnYu1vNWKYZjw0/oLeBqQ+b3m86rua6r4roC0f93V+btdofvbJxcC+g==
Date: Tue, 6 Feb 2018 21:23:34 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking updates
Message-ID: <20180206202334.tvq3rhuhsy7uoq7x@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

   # HEAD: ca66e797120fb09b8138623fb4b563e952586ef5 locking/qrwlock: include asm/byteorder.h as needed

An endianness fix and a jump labels branch hint update.

 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      locking/qrwlock: include asm/byteorder.h as needed

Peter Zijlstra (1):
      jump_label: Add branch hints to static_branch_{un,}likely()


 include/asm-generic/qrwlock_types.h | 1 +
 include/linux/jump_label.h          | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/qrwlock_types.h b/include/asm-generic/qrwlock_types.h
index 137ecdd16daa..c36f1d5a2572 100644
--- a/include/asm-generic/qrwlock_types.h
+++ b/include/asm-generic/qrwlock_types.h
@@ -3,6 +3,7 @@
 #define __ASM_GENERIC_QRWLOCK_TYPES_H
 
 #include <linux/types.h>
+#include <asm/byteorder.h>
 #include <asm/spinlock_types.h>
 
 /*
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index e0340ca08d98..b6a29c126cc4 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -393,7 +393,7 @@ extern bool ____wrong_branch_error(void);
 		branch = !arch_static_branch_jump(&(x)->key, true);		\
 	else									\
 		branch = ____wrong_branch_error();				\
-	branch;									\
+	likely(branch);								\
 })
 
 #define static_branch_unlikely(x)						\
@@ -405,7 +405,7 @@ extern bool ____wrong_branch_error(void);
 		branch = arch_static_branch(&(x)->key, false);			\
 	else									\
 		branch = ____wrong_branch_error();				\
-	branch;									\
+	unlikely(branch);							\
 })
 
 #else /* !HAVE_JUMP_LABEL */
