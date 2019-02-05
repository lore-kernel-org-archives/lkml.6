Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE8BC282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF362184B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549379251;
	bh=i0PF0J7D9errSUQ3SotWziEdPhuNmTaxA2UKA9QPTog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UR7JJTYSGoehK6HBloLBvJKfnWCXldU5YKQrFIrnYHpaRjjiAw5J3RuuXaOvzBNEu
	 9pmTlqMsJ4f/KpP1zkEczf6B5f7JZRprIj+fcz2qcFZf0ghAhw/rJGS/fC2wXH+0E3
	 J37OAY3Bjmc/89EZp0CKeNCbJZVKKD8gcQ80i+KE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfBEPHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:07:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfBEPH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:07:28 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5E922184D;
        Tue,  5 Feb 2019 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549379247;
        bh=i0PF0J7D9errSUQ3SotWziEdPhuNmTaxA2UKA9QPTog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXbTdH/qwQnMhOGXIV2D8L0MwgbesQSGBjYaBlL6NoFnV4hsBed9MzoXIa/ORrayt
         N+1bIXmHONhm/ecVjDk04u/GbsoIHC9SX6zX40eAdy4AA+AjZMNAjPMlv0uhU/Be8/
         0Wg+prHxaLXGqQihpJJRSOEtIo2MFA0L9TzG8tSM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 3/8] perf clang: Do not use 'return std::move(something)'
Date:   Tue,  5 Feb 2019 12:07:03 -0300
Message-Id: <20190205150708.9012-4-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205150708.9012-1-acme@kernel.org>
References: <20190205150708.9012-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.20.1

