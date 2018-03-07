Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934004AbeCGPxy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:53:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934143AbeCGPv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:51:59 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 19/19] perf build: Force llvm/clang test compile output to .make.output
Date: Wed,  7 Mar 2018 16:50:20 +0100
Message-Id: <20180307155020.32613-20-jolsa@kernel.org>
In-Reply-To: <20180307155020.32613-1-jolsa@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we can see the output of feature compile
in following files:

  tools/build/feature/test-llvm.make.output
  tools/build/feature/test-llvm-version.make.output
  tools/build/feature/test-clang.make.output

Link: http://lkml.kernel.org/n/tip-z270blatcsc718tkv3zpwfx7@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/build/feature/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index f8ad640ffe5d..dac9563b5470 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -260,11 +260,13 @@ $(OUTPUT)test-llvm.bin:
 		-I$(shell $(LLVM_CONFIG) --includedir) 		\
 		-L$(shell $(LLVM_CONFIG) --libdir)		\
 		$(shell $(LLVM_CONFIG) --libs Core BPF)		\
-		$(shell $(LLVM_CONFIG) --system-libs)
+		$(shell $(LLVM_CONFIG) --system-libs)		\
+		> $(@:.bin=.make.output) 2>&1
 
 $(OUTPUT)test-llvm-version.bin:
 	$(BUILDXX) -std=gnu++11 				\
-		-I$(shell $(LLVM_CONFIG) --includedir)
+		-I$(shell $(LLVM_CONFIG) --includedir)		\
+		> $(@:.bin=.make.output) 2>&1
 
 $(OUTPUT)test-clang.bin:
 	$(BUILDXX) -std=gnu++11 				\
@@ -274,7 +276,8 @@ $(OUTPUT)test-clang.bin:
 		  -lclangFrontend -lclangEdit -lclangLex	\
 		  -lclangAST -Wl,--end-group 			\
 		$(shell $(LLVM_CONFIG) --libs Core option)	\
-		$(shell $(LLVM_CONFIG) --system-libs)
+		$(shell $(LLVM_CONFIG) --system-libs)		\
+		> $(@:.bin=.make.output) 2>&1
 
 -include $(OUTPUT)*.d
 
-- 
2.13.6
