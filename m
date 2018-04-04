Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeDDSEe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 14:04:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750915AbeDDSE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 14:04:28 -0400
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@redhat.com
Cc: linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH 2/3] perf clang: Add support for recent clang versions
Date: Wed,  4 Apr 2018 23:34:18 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180404180419.19056-1-sandipan@linux.vnet.ibm.com>
References: <20180404180419.19056-1-sandipan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18040418-0040-0000-0000-0000042A76FC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040418-0041-0000-0000-0000262DAA10
Message-Id: <20180404180419.19056-2-sandipan@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804040180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clang API calls used by perf have changed in recent
releases and builds succeed with libclang-3.9 only. This
introduces compatibility with libclang-4.0 and above.

Without this patch, we will see the following compilation
errors with libclang-4.0+:

 util/c++/clang.cpp: In function ‘clang::CompilerInvocation* perf::createCompilerInvocation(llvm::opt::ArgStringList, llvm::StringRef&, clang::DiagnosticsEngine&)’:
 util/c++/clang.cpp:62:33: error: ‘IK_C’ was not declared in this scope
   Opts.Inputs.emplace_back(Path, IK_C);
                                  ^~~~
 util/c++/clang.cpp: In function ‘std::unique_ptr<llvm::Module> perf::getModuleFromSource(llvm::opt::ArgStringList, llvm::StringRef, llvm::IntrusiveRefCntPtr<clang::vfs::FileSystem>)’:
 util/c++/clang.cpp:75:26: error: no matching function for call to ‘clang::CompilerInstance::setInvocation(clang::CompilerInvocation*)’
   Clang.setInvocation(&*CI);
                           ^
 In file included from util/c++/clang.cpp:14:0:
 /usr/include/clang/Frontend/CompilerInstance.h:231:8: note: candidate: void clang::CompilerInstance::setInvocation(std::shared_ptr<clang::CompilerInvocation>)
    void setInvocation(std::shared_ptr<CompilerInvocation> Value);
         ^~~~~~~~~~~~~

Fixes: 00b86691c77c ("perf clang: Add builtin clang support ant test case")
Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 tools/perf/util/c++/clang.cpp | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
index 1bfc946e37dc..bf31ceab33bd 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -9,6 +9,7 @@
  * Copyright (C) 2016 Huawei Inc.
  */
 
+#include "clang/Basic/Version.h"
 #include "clang/CodeGen/CodeGenAction.h"
 #include "clang/Frontend/CompilerInvocation.h"
 #include "clang/Frontend/CompilerInstance.h"
@@ -58,7 +59,8 @@ createCompilerInvocation(llvm::opt::ArgStringList CFlags, StringRef& Path,
 
 	FrontendOptions& Opts = CI->getFrontendOpts();
 	Opts.Inputs.clear();
-	Opts.Inputs.emplace_back(Path, IK_C);
+	Opts.Inputs.emplace_back(Path,
+			FrontendOptions::getInputKindForExtension("c"));
 	return CI;
 }
 
@@ -71,10 +73,17 @@ getModuleFromSource(llvm::opt::ArgStringList CFlags,
 
 	Clang.setVirtualFileSystem(&*VFS);
 
+#if CLANG_VERSION_MAJOR < 4
 	IntrusiveRefCntPtr<CompilerInvocation> CI =
 		createCompilerInvocation(std::move(CFlags), Path,
 					 Clang.getDiagnostics());
 	Clang.setInvocation(&*CI);
+#else
+	std::shared_ptr<CompilerInvocation> CI(
+		createCompilerInvocation(std::move(CFlags), Path,
+					 Clang.getDiagnostics()));
+	Clang.setInvocation(CI);
+#endif
 
 	std::unique_ptr<CodeGenAction> Act(new EmitLLVMOnlyAction(&*LLVMCtx));
 	if (!Clang.ExecuteAction(*Act))
-- 
2.14.3
