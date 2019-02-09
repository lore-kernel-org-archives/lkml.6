Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91915C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658A520863
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBIMVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:21:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:21:13 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CKwtA2624225
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:20:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CKtFe2624219;
        Sat, 9 Feb 2019 04:20:55 -0800
Date:   Sat, 9 Feb 2019 04:20:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-lehqf5x5q96l0o8myhb6blz6@git.kernel.org>
Cc:     hpa@zytor.com, adrian.hunter@intel.com, namhyung@kernel.org,
        wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        lclaudio@redhat.com, mingo@kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, acme@redhat.com
Reply-To: acme@redhat.com, jolsa@kernel.org, adrian.hunter@intel.com,
          namhyung@kernel.org, hpa@zytor.com, mingo@kernel.org,
          lclaudio@redhat.com, tglx@linutronix.de, wangnan0@huawei.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf clang: Do not use 'return
 std::move(something)'
Git-Commit-ID: d34cecfb6b2bdc35713180ba4fcfd912a2f3e9bf
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

Commit-ID:  d34cecfb6b2bdc35713180ba4fcfd912a2f3e9bf
Gitweb:     https://git.kernel.org/tip/d34cecfb6b2bdc35713180ba4fcfd912a2f3e9bf
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 4 Feb 2019 11:04:20 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Feb 2019 11:32:34 -0300

perf clang: Do not use 'return std::move(something)'

It prevents copy elision, generating this warning when building with
fedora:rawhide's clang:

  clang version 7.0.1 (Fedora 7.0.1-2.fc30)
  Target: x86_64-unknown-linux-gnu
  Thread model: posix
  InstalledDir: /usr/bin
  Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/9
  Found candidate GCC installation: /usr/lib/gcc/x86_64-redhat-linux/9
  Selected GCC installation: /usr/bin/../lib/gcc/x86_64-redhat-linux/9
  Candidate multilib: .;@m64
  Candidate multilib: 32;@m32
  Selected multilib: .;@m64

  $ make -C tools/perf CC=clang LIBCLANGLLVM=1
  <SNIP>
  util/c++/clang.cpp: In function 'std::unique_ptr<llvm::SmallVectorImpl<char> > perf::getBPFObjectFromModule(llvm::Module*)':
  util/c++/clang.cpp:163:18: error: moving a local object in a return statement prevents copy elision [-Werror=pessimizing-move]
    163 |  return std::move(Buffer);
        |         ~~~~~~~~~^~~~~~~~
  util/c++/clang.cpp:163:18: note: remove 'std::move' call
  cc1plus: all warnings being treated as errors
  <SNIP>

References:

  http://www.cplusplus.com/forum/general/186411/#msg908572
  https://en.cppreference.com/w/cpp/language/return#Notes
  https://en.cppreference.com/w/cpp/language/copy_elision

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-lehqf5x5q96l0o8myhb6blz6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/c++/clang.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
index 89512504551b..39c0004f2886 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -160,7 +160,7 @@ getBPFObjectFromModule(llvm::Module *Module)
 	}
 	PM.run(*Module);
 
-	return std::move(Buffer);
+	return Buffer;
 }
 
 }
