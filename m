Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005F1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98B621479
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfABU55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:57:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbfABU5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:57:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95CA7C0259;
        Wed,  2 Jan 2019 20:57:54 +0000 (UTC)
Received: from redhat.com (ovpn-120-148.rdu2.redhat.com [10.10.120.148])
        by smtp.corp.redhat.com (Postfix) with SMTP id D93C960C69;
        Wed,  2 Jan 2019 20:57:49 +0000 (UTC)
Date:   Wed, 2 Jan 2019 15:57:49 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Eli Friedman <efriedma@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Subject: [PATCH RFC 1/4] include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
Message-ID: <20190102205715.14054-2-mst@redhat.com>
References: <20190102205715.14054-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102205715.14054-1-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 02 Jan 2019 20:57:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h
mutually exclusive") clang no longer reuses the OPTIMIZER_HIDE_VAR macro
from compiler-gcc - instead it gets the version in
include/linux/compiler.h.  Unfortunately that version doesn't actually
prevent compiler from optimizing out the variable.

Fix up by moving the macro out from compiler-gcc.h to compiler.h.
Compilers without incline asm support will keep working
since it's protected by an ifdef.

Also fix up comments to match reality since we are no longer overriding
any macros.

Build-tested with gcc and clang.

Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Joe Perches <joe@perches.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/compiler-clang.h | 5 ++---
 include/linux/compiler-gcc.h   | 4 ----
 include/linux/compiler-intel.h | 4 +---
 include/linux/compiler.h       | 4 +++-
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 3e7dafb3ea80..7ddaeb5182e3 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -3,9 +3,8 @@
 #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
 #endif
 
-/* Some compiler specific definitions are overwritten here
- * for Clang compiler
- */
+/* Compiler specific definitions for Clang compiler */
+
 #define uninitialized_var(x) x = *(&(x))
 
 /* same as gcc, this was present in clang-2.6 so we can assume it works
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 2010493e1040..72054d9f0eaa 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -58,10 +58,6 @@
 	(typeof(ptr)) (__ptr + (off));					\
 })
 
-/* Make the optimizer believe the variable can be manipulated arbitrarily. */
-#define OPTIMIZER_HIDE_VAR(var)						\
-	__asm__ ("" : "=r" (var) : "0" (var))
-
 /*
  * A trick to suppress uninitialized variable warning without generating any
  * code
diff --git a/include/linux/compiler-intel.h b/include/linux/compiler-intel.h
index 517bd14e1222..b17f3cd18334 100644
--- a/include/linux/compiler-intel.h
+++ b/include/linux/compiler-intel.h
@@ -5,9 +5,7 @@
 
 #ifdef __ECC
 
-/* Some compiler specific definitions are overwritten here
- * for Intel ECC compiler
- */
+/* Compiler specific definitions for Intel ECC compiler */
 
 #include <asm/intrinsics.h>
 
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 06396c1cf127..1ad367b4cd8d 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -152,7 +152,9 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #endif
 
 #ifndef OPTIMIZER_HIDE_VAR
-#define OPTIMIZER_HIDE_VAR(var) barrier()
+/* Make the optimizer believe the variable can be manipulated arbitrarily. */
+#define OPTIMIZER_HIDE_VAR(var)						\
+	__asm__ ("" : "=r" (var) : "0" (var))
 #endif
 
 /* Not-quite-unique ID. */
-- 
MST

