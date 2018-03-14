Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeCNLYs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 07:24:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51666 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeCNLYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 07:24:47 -0400
From: Andy Whitcroft <apw@canonical.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Andy Whitcroft <apw@canonical.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] x86/speculation, objtool: Annotate indirect calls/jumps for objtool on 32bit
Date: Wed, 14 Mar 2018 11:24:27 +0000
Message-Id: <20180314112427.22351-1-apw@canonical.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 9e0e3c5130e9 ("x86/speculation, objtool: Annotate indirect calls/jumps
for objtool") we added annotations for CALL_NOSPEC/JMP_NOSPEC on x86 64bit.
We did not annotate the 32bit path.  Annotate it similarly.

Signed-off-by: Andy Whitcroft <apw@canonical.com>
---
 arch/x86/include/asm/nospec-branch.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

    While reviewing indirect calls in our builds I noted that the
    i386 retpoline CALL_NOSPEC is not annotated safe even though
    its amd64 equivalent is.  I cannot see any reason this is not
    also inherantly safe.  Peter was there a reason that you did
    not annotate this one too?  Anyhow, on the assumption this was
    just missed, this patch annotates it.

    -apw

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index d0dabeae0505..07886162bdf8 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -183,7 +183,10 @@
  * otherwise we'll run out of registers. We don't care about CET
  * here, anyway.
  */
-# define CALL_NOSPEC ALTERNATIVE("call *%[thunk_target]\n",	\
+# define CALL_NOSPEC 						\
+	ALTERNATIVE(						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"call *%[thunk_target]\n",				\
 	"       jmp    904f;\n"					\
 	"       .align 16\n"					\
 	"901:	call   903f;\n"					\
-- 
2.15.1
