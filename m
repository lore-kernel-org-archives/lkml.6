Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965640AbeCADJF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 22:09:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:4096 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965563AbeCADJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 22:09:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,407,1515484800";
   d="scan'208";a="178946879"
From: Andi Kleen <andi@firstfloor.org>
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] uml: Fix build with recent glibc
Date: Wed, 28 Feb 2018 19:08:44 -0800
Message-Id: <20180301030844.23448-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Newer glibc did some include namespace "cleanups" and removed
struct ucontext and friends. This already broke a lot of software,
and UML seems to be the latest victim.

Use the typedefs which are still available. They also work on
older glibcs.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/um/os-Linux/signal.c | 2 +-
 arch/x86/um/stub_segv.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index a86d7cc2c2d8..a5c0c909c48b 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -159,7 +159,7 @@ static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
 
 static void hard_handler(int sig, siginfo_t *si, void *p)
 {
-	struct ucontext *uc = p;
+	ucontext_t *uc = p;
 	mcontext_t *mc = &uc->uc_mcontext;
 	unsigned long pending = 1UL << sig;
 
diff --git a/arch/x86/um/stub_segv.c b/arch/x86/um/stub_segv.c
index 1518d2805ae8..fd6825537b97 100644
--- a/arch/x86/um/stub_segv.c
+++ b/arch/x86/um/stub_segv.c
@@ -10,7 +10,7 @@
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_segv_handler(int sig, siginfo_t *info, void *p)
 {
-	struct ucontext *uc = p;
+	ucontext_t *uc = p;
 
 	GET_FAULTINFO_FROM_MC(*((struct faultinfo *) STUB_DATA),
 			      &uc->uc_mcontext);
-- 
2.14.3
