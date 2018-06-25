Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893D1C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADD425F86
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="16mQ+YKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADD425F86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965016AbeFYRlt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964982AbeFYRlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:41:44 -0400
Received: from jouet.infradead.org (unknown [177.79.80.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE4B225F80;
        Mon, 25 Jun 2018 17:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529948503;
        bh=H8bSR3tBH+bgpNtPGlvnesqfG3/V/xf8uvRx6MoQoVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=16mQ+YKJCF1dzP+c94pZzz6aSQFkQqOpRitc5wKT0L8lR5NxX2WCdtwSEB/efkVEi
         ZNGHrINrxIs6k19VBaIFyPZP9Ld6v6cwWYiXgxx0WNExgki9xkErAVEJWmiX2qHrOW
         aSkgHBZg5mzCT2Ugplnxp82unu9MLwBjnwPWj2i0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/19] perf tools: Fix a clang 7.0 compilation error
Date:   Mon, 25 Jun 2018 14:40:38 -0300
Message-Id: <20180625174045.25765-13-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

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
-- 
2.14.3

