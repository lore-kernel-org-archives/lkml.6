Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02754C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4B42659B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4B42659B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeFZG5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:57:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37317 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbeFZG5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:57:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5Q6vLYY1591797
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Jun 2018 23:57:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5Q6vLZa1591794;
        Mon, 25 Jun 2018 23:57:21 -0700
Date:   Mon, 25 Jun 2018 23:57:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yonghong Song <tipbot@zytor.com>
Message-ID: <tip-c6555c14572aeadf4fe2819abd971c4e7608b926@git.kernel.org>
Cc:     tglx@linutronix.de, kafai@fb.com, ast@fb.com, wangnan0@huawei.com,
        yhs@fb.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, hpa@zytor.com, daniel@iogearbox.net,
        acme@redhat.com
Reply-To: wangnan0@huawei.com, yhs@fb.com, ast@fb.com, tglx@linutronix.de,
          kafai@fb.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
          mingo@kernel.org, hpa@zytor.com, daniel@iogearbox.net,
          acme@redhat.com
In-Reply-To: <20180616174739.1076733-1-yhs@fb.com>
References: <20180616174739.1076733-1-yhs@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix a clang 7.0 compilation error
Git-Commit-ID: c6555c14572aeadf4fe2819abd971c4e7608b926
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c6555c14572aeadf4fe2819abd971c4e7608b926
Gitweb:     https://git.kernel.org/tip/c6555c14572aeadf4fe2819abd971c4e7608b926
Author:     Yonghong Song <yhs@fb.com>
AuthorDate: Sat, 16 Jun 2018 10:47:39 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Jun 2018 11:59:37 -0300

perf tools: Fix a clang 7.0 compilation error

Arnaldo reported the perf build failure with latest llvm/clang compiler
(7.0).

   $ make LIBCLANGLLVM=1 -C tools/perf/
   <SNIP>
    CC       /tmp/tmp.t53Qo38zci/tests/kmod-path.o
   util/c++/clang.cpp: In function ‘std::unique_ptr<llvm::SmallVectorImpl<char> >
       perf::getBPFObjectFromModule(llvm::Module*)’:
   util/c++/clang.cpp:150:43: error: no matching function for call to
       ‘llvm::TargetMachine::addPassesToEmitFile(llvm::legacy::PassManager&,
        llvm::raw_svector_ostream&, llvm::TargetMachine::CodeGenFileType)’
               TargetMachine::CGFT_ObjectFile)) {
                                             ^
   In file included from util/c++/clang.cpp:25:0:
   /usr/local/include/llvm/Target/TargetMachine.h:254:16: note: candidate:
       virtual bool llvm::TargetMachine::addPassesToEmitFile(
       llvm::legacy::PassManagerBase&, llvm::raw_pwrite_stream&,
       llvm::raw_pwrite_stream*, llvm::TargetMachine::CodeGenFileType, bool,
       llvm::MachineModuleInfo*)
     virtual bool addPassesToEmitFile(PassManagerBase &, raw_pwrite_stream &,
                  ^~~~~~~~~~~~~~~~~~~
  /usr/local/include/llvm/Target/TargetMachine.h:254:16: note:
      candidate expects 6 arguments, 3 provided
  mv: cannot stat '/tmp/tmp.t53Qo38zci/util/c++/.clang.o.tmp': No such file or directory
  make[7]: *** [/home/acme/git/perf/tools/build/Makefile.build:101:
      /tmp/tmp.t53Qo38zci/util/c++/clang.o] Error 1
  make[6]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: c++] Error 2
  make[5]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
  make[5]: *** Waiting for unfinished jobs....
    CC       /tmp/tmp.t53Qo38zci/tests/thread-map.o

The function addPassesToEmitFile signature changed in llvm 7.0 and such
a change caused the failure. This patch fixed the issue with using
proper function signatures under different compiler versions.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20180616174739.1076733-1-yhs@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/c++/clang.cpp | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
index bf31ceab33bd..89512504551b 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -146,8 +146,15 @@ getBPFObjectFromModule(llvm::Module *Module)
 	raw_svector_ostream ostream(*Buffer);
 
 	legacy::PassManager PM;
-	if (TargetMachine->addPassesToEmitFile(PM, ostream,
-					       TargetMachine::CGFT_ObjectFile)) {
+	bool NotAdded;
+#if CLANG_VERSION_MAJOR < 7
+	NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream,
+						      TargetMachine::CGFT_ObjectFile);
+#else
+	NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream, nullptr,
+						      TargetMachine::CGFT_ObjectFile);
+#endif
+	if (NotAdded) {
 		llvm::errs() << "TargetMachine can't emit a file of this type\n";
 		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);;
 	}
