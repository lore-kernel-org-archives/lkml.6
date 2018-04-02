Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754326AbeDBJq4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 05:46:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56198 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754282AbeDBJqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 05:46:55 -0400
X-Google-Smtp-Source: AIpwx48cstoIJi1wKKx6zjv9xV4lxprQaBr/IxEGEkU2ybsl7DSIw9uPMImmX+0287Xi38I7P3Q2pA==
Date: Mon, 2 Apr 2018 11:46:51 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/asm changes for v4.17
Message-ID: <20180402094651.n7ejtudfudieyrtw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-asm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

   # HEAD: 16c5055a5ff5e1ff13c5211e44514a2b1d2c1dae x86/asm: Trim clear_page.S includes

A clobber list fix and cleanups.

 Thanks,

	Ingo

------------------>
Alexey Dobriyan (2):
      x86/asm: Clobber flags in clear_page()
      x86/asm: Trim clear_page.S includes


 arch/x86/include/asm/page_64.h | 2 +-
 arch/x86/lib/clear_page_64.S   | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 4baa6bceb232..f8a85c65f150 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -47,7 +47,7 @@ static inline void clear_page(void *page)
 			   clear_page_erms, X86_FEATURE_ERMS,
 			   "=D" (page),
 			   "0" (page)
-			   : "memory", "rax", "rcx");
+			   : "cc", "memory", "rax", "rcx");
 }
 
 void copy_page(void *to, void *from);
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index 81b1635d67de..88acd349911b 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -1,6 +1,4 @@
 #include <linux/linkage.h>
-#include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
 #include <asm/export.h>
 
 /*
