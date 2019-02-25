Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577A8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C8C21841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130272;
	bh=7Qpa2GLiJyH3j5BLiudMJWt7g7G7CucHxVqyzqtDWPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D/aCYwsAcvaNxV68RO9MW+T2yKgjKfIfQKNKbaetOZ1LJwxbi18iKpuQ/7MQ6CJ2W
	 ZV1c9Ct+S7h5ndJDfP/TEJvZ52V7R4Y/JeDUnKsnd/wp7NIgyXag8+LLDgrPgCMt4+
	 5Pb6O4oQhVAEnMOO8Ein/0vVijldjIZ2JUS3uIXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbfBYVbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:31:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732038AbfBYVbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:31:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A8742184D;
        Mon, 25 Feb 2019 21:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130265;
        bh=7Qpa2GLiJyH3j5BLiudMJWt7g7G7CucHxVqyzqtDWPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HeiuJ4eAgB+75WK2TeepChpnElPgsRJlAe6UnRKwyZ6z0sEuKpP4a22wPhryPp+Hj
         thEQwLIjX1RDq3wMcHwj1YrGQG+YOoVXVtvUHWusR7ex+DdttlTKhdgrP7R3peWLff
         8+8kTqMwqWVjryTwj0gQBwdRrDYq17IQblT01poY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eli Friedman <efriedma@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 059/183] include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
Date:   Mon, 25 Feb 2019 22:10:32 +0100
Message-Id: <20190225195104.432674475@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3e2ffd655cc6a694608d997738989ff5572a8266 ]

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
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/compiler-clang.h | 5 ++---
 include/linux/compiler-gcc.h   | 4 ----
 include/linux/compiler-intel.h | 4 +---
 include/linux/compiler.h       | 4 +++-
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 3e7dafb3ea809..7ddaeb5182e33 100644
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
index 977ddf2774f97..c61c4bb2bd15f 100644
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
index 517bd14e12224..b17f3cd18334d 100644
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
index fc5004a4b07d7..445348facea97 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -161,7 +161,9 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #endif
 
 #ifndef OPTIMIZER_HIDE_VAR
-#define OPTIMIZER_HIDE_VAR(var) barrier()
+/* Make the optimizer believe the variable can be manipulated arbitrarily. */
+#define OPTIMIZER_HIDE_VAR(var)						\
+	__asm__ ("" : "=r" (var) : "0" (var))
 #endif
 
 /* Not-quite-unique ID. */
-- 
2.19.1



