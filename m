Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeDJFa5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 01:30:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39747 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbeDJFa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 01:30:56 -0400
Date: Mon, 9 Apr 2018 22:30:47 -0700
From: tip-bot for Sandipan Das <tipbot@zytor.com>
Message-ID: <tip-7854e499f33fd9c7e63288692ffb754d9b1d02fd@git.kernel.org>
Cc: sandipan@linux.vnet.ibm.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        acme@redhat.com, jolsa@redhat.com, naveen.n.rao@linux.vnet.ibm.com
Reply-To: tglx@linutronix.de, sandipan@linux.vnet.ibm.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, acme@redhat.com, jolsa@redhat.com
In-Reply-To: <20180404180419.19056-2-sandipan@linux.vnet.ibm.com>
References: <20180404180419.19056-2-sandipan@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf clang: Add support for recent clang versions
Git-Commit-ID: 7854e499f33fd9c7e63288692ffb754d9b1d02fd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7854e499f33fd9c7e63288692ffb754d9b1d02fd
Gitweb:     https://git.kernel.org/tip/7854e499f33fd9c7e63288692ffb754d9b1d02fd
Author:     Sandipan Das <sandipan@linux.vnet.ibm.com>
AuthorDate: Wed, 4 Apr 2018 23:34:18 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 9 Apr 2018 11:13:08 -0300

perf clang: Add support for recent clang versions

The clang API calls used by perf have changed in recent releases and
builds succeed with libclang-3.9 only. This introduces compatibility
with libclang-4.0 and above.

Without this patch, we will see the following compilation errors with
libclang-4.0+:

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

Committer testing:

Tested on Fedora 27 after installing the clang-devel and llvm-devel
packages, versions:

  # rpm -qa | egrep llvm\|clang
  llvm-5.0.1-6.fc27.x86_64
  clang-libs-5.0.1-5.fc27.x86_64
  clang-5.0.1-5.fc27.x86_64
  clang-tools-extra-5.0.1-5.fc27.x86_64
  llvm-libs-5.0.1-6.fc27.x86_64
  llvm-devel-5.0.1-6.fc27.x86_64
  clang-devel-5.0.1-5.fc27.x86_64
  #

Make sure you don't have some older version lying around in /usr/local,
etc, then:

  $ make LIBCLANGLLVM=1 -C tools/perf install-bin

And in the end perf will be linked agains these libraries:

  # ldd ~/bin/perf | egrep -i llvm\|clang
	libclangAST.so.5 => /lib64/libclangAST.so.5 (0x00007f8bb2eb4000)
	libclangBasic.so.5 => /lib64/libclangBasic.so.5 (0x00007f8bb29e3000)
	libclangCodeGen.so.5 => /lib64/libclangCodeGen.so.5 (0x00007f8bb23f7000)
	libclangDriver.so.5 => /lib64/libclangDriver.so.5 (0x00007f8bb2060000)
	libclangFrontend.so.5 => /lib64/libclangFrontend.so.5 (0x00007f8bb1d06000)
	libclangLex.so.5 => /lib64/libclangLex.so.5 (0x00007f8bb1a3e000)
	libclangTooling.so.5 => /lib64/libclangTooling.so.5 (0x00007f8bb17d4000)
	libclangEdit.so.5 => /lib64/libclangEdit.so.5 (0x00007f8bb15c5000)
	libclangSema.so.5 => /lib64/libclangSema.so.5 (0x00007f8bb0cc9000)
	libclangAnalysis.so.5 => /lib64/libclangAnalysis.so.5 (0x00007f8bb0a23000)
	libclangParse.so.5 => /lib64/libclangParse.so.5 (0x00007f8bb0725000)
	libclangSerialization.so.5 => /lib64/libclangSerialization.so.5 (0x00007f8bb039a000)
	libLLVM-5.0.so => /lib64/libLLVM-5.0.so (0x00007f8bace98000)
	libclangASTMatchers.so.5 => /lib64/../lib64/libclangASTMatchers.so.5 (0x00007f8bab735000)
	libclangFormat.so.5 => /lib64/../lib64/libclangFormat.so.5 (0x00007f8bab4b2000)
	libclangRewrite.so.5 => /lib64/../lib64/libclangRewrite.so.5 (0x00007f8bab2a1000)
	libclangToolingCore.so.5 => /lib64/../lib64/libclangToolingCore.so.5 (0x00007f8bab08e000)
  #

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Fixes: 00b86691c77c ("perf clang: Add builtin clang support ant test case")
Link: http://lkml.kernel.org/r/20180404180419.19056-2-sandipan@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
