Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C99C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 17:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1B420895
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 17:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PQ6FIkq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1B420895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932723AbeFPRrn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 13:47:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55268 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932337AbeFPRrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 13:47:42 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5GHgfpr006163
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 10:47:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=gSboO0QZwW0cTrQWKJCn64eZTeMkX9zF19fgpPudVr8=;
 b=PQ6FIkq6eqViTLrBCjP9DsMbbGDWlBVuh9wTnV+O4wbIsFLlIKt3PJGvPpoWTex42c21
 0AqWflYxDe/Iz3m1XfhjOR/FbMdpYuU72llFBVweTrFrDcdWkJYuFNlDIScMA43koEv7
 lr92DBXRkH4G7J4tdBnhjRzczeqCyySNiHw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jn0cm0m1k-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 10:47:42 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.24) with Microsoft SMTP Server (TLS) id 14.3.361.1; Sat, 16 Jun
 2018 10:47:40 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)  id
 D7DB83701240; Sat, 16 Jun 2018 10:47:39 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <acme@redhat.com>, <wangnan0@huawei.com>, <jolsa@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ast@fb.com>, <kafai@fb.com>,
        <daniel@iogearbox.net>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH] tools/perf: fix a clang 7.0 compilation error
Date:   Sat, 16 Jun 2018 10:47:39 -0700
Message-ID: <20180616174739.1076733-1-yhs@fb.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-16_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo reported the perf build failure with latest llvm/clang
compiler (7.0).

   $ make LIBCLANGLLVM=3D1 -C tools/perf/
   <SNIP>
    CC       /tmp/tmp.t53Qo38zci/tests/kmod-path.o
   util/c++/clang.cpp: In function =E2=80=98std::unique_ptr<llvm::SmallVe=
ctorImpl<char> >
       perf::getBPFObjectFromModule(llvm::Module*)=E2=80=99:
   util/c++/clang.cpp:150:43: error: no matching function for call to
       =E2=80=98llvm::TargetMachine::addPassesToEmitFile(llvm::legacy::Pa=
ssManager&,
        llvm::raw_svector_ostream&, llvm::TargetMachine::CodeGenFileType)=
=E2=80=99
               TargetMachine::CGFT_ObjectFile)) {
                                             ^
   In file included from util/c++/clang.cpp:25:0:
   /usr/local/include/llvm/Target/TargetMachine.h:254:16: note: candidate=
:
       virtual bool llvm::TargetMachine::addPassesToEmitFile(
       llvm::legacy::PassManagerBase&, llvm::raw_pwrite_stream&,
       llvm::raw_pwrite_stream*, llvm::TargetMachine::CodeGenFileType, bo=
ol,
       llvm::MachineModuleInfo*)
     virtual bool addPassesToEmitFile(PassManagerBase &, raw_pwrite_strea=
m &,
                  ^~~~~~~~~~~~~~~~~~~
  /usr/local/include/llvm/Target/TargetMachine.h:254:16: note:
      candidate expects 6 arguments, 3 provided
  mv: cannot stat '/tmp/tmp.t53Qo38zci/util/c++/.clang.o.tmp': No such fi=
le or directory
  make[7]: *** [/home/acme/git/perf/tools/build/Makefile.build:101:
      /tmp/tmp.t53Qo38zci/util/c++/clang.o] Error 1
  make[6]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: c++] =
Error 2
  make[5]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: util]=
 Error 2
  make[5]: *** Waiting for unfinished jobs....
    CC       /tmp/tmp.t53Qo38zci/tests/thread-map.o

The function addPassesToEmitFile signature changed in llvm 7.0 and such
a change caused the failure. This patch fixed the issue with using
proper function signatures under different compiler versions.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/perf/util/c++/clang.cpp | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cp=
p
index bf31cea..8951250 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -146,8 +146,15 @@ getBPFObjectFromModule(llvm::Module *Module)
 	raw_svector_ostream ostream(*Buffer);
=20
 	legacy::PassManager PM;
-	if (TargetMachine->addPassesToEmitFile(PM, ostream,
-					       TargetMachine::CGFT_ObjectFile)) {
+	bool NotAdded;
+#if CLANG_VERSION_MAJOR < 7
+	NotAdded =3D TargetMachine->addPassesToEmitFile(PM, ostream,
+						      TargetMachine::CGFT_ObjectFile);
+#else
+	NotAdded =3D TargetMachine->addPassesToEmitFile(PM, ostream, nullptr,
+						      TargetMachine::CGFT_ObjectFile);
+#endif
+	if (NotAdded) {
 		llvm::errs() << "TargetMachine can't emit a file of this type\n";
 		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);;
 	}
--=20
2.9.5

