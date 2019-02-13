Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD218C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADE6222CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025286;
	bh=czenjSTG1ljAv4LkUvnKRQP/4xeHqoDp06x9vE3F3hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xm3RFhhmKw9U7tSjxVGIMnafYdI6/3kUIYbHJ27YXejYCxunlFoSHV76qnPUeja6h
	 ekJfi+6pH2zQF86uMvsFWhRc5nTngJFr37DNvyYmqTHyujm2/DUTLRCcxcP2oUelwS
	 nB9YRyrsEPI2GdNgWscQRuxPf1u0cB7+XZZEQmS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbfBMCeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:34:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730485AbfBMCek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:34:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5D19206B6;
        Wed, 13 Feb 2019 02:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025279;
        bh=czenjSTG1ljAv4LkUvnKRQP/4xeHqoDp06x9vE3F3hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGhTuLoBSn4opZMiLninxw5DndfMMOqYncjKCa75d3aeLreg7D8SnZsPKEk0K/Ouj
         k4X6PdJ5fjaSRHCWN3nC5MKII+yk3fdWGgOflRIwfPXxKsvFw+m+10spxQ2+f7LHqe
         KLeQbksumaKP0YWsXpJBeksWJdCeFPqr+jTRmWqE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Eli Friedman <efriedma@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 041/105] include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
Date:   Tue, 12 Feb 2019 21:32:32 -0500
Message-Id: <20190213023336.19019-41-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>

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
index 977ddf2774f9..c61c4bb2bd15 100644
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
index fc5004a4b07d..445348facea9 100644
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

