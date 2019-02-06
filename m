Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1836C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D268218D4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479062;
	bh=i0PF0J7D9errSUQ3SotWziEdPhuNmTaxA2UKA9QPTog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tFKuSDn/bLynUY5+kWHEOEugtSm+S5tzqE4gJ205uya1NGY9z5kONo3Tz5aLakeK/
	 f6RUSzMZgT/5AD0nLNvUXPezrsMDaxcJvuAjHCBIeZxjvGYGgiTGNq3afDOi0774FA
	 rfGhkPJZaLqYWUINgkenmC4MZvCK3GXS/3kg67k0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfBFSvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:51:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:45200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfBFSu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:50:56 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C378206DD;
        Wed,  6 Feb 2019 18:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479055;
        bh=i0PF0J7D9errSUQ3SotWziEdPhuNmTaxA2UKA9QPTog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IiYAKzXSefONck/CWxjTUHVQgRaFDXKP+FrpMwwQzc7eypM1Ntdse/x03p3lD6YQL
         aFS+IdtTrlmf0ADNS+ncIDtI8oy88224ASAc/cChZ6o7BUHVhQ6KAAXFxXooIKhrf8
         DPEhzqOd+i35p3/4tabu2i3dICU3nx8V0oWhREVI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 31/53] perf clang: Do not use 'return std::move(something)'
Date:   Wed,  6 Feb 2019 15:48:41 -0300
Message-Id: <20190206184903.24054-32-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
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

