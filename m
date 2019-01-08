Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7664C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8888120883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976012;
	bh=kMUio/CIE75FQuW9CLR1Dth70BxYd3hKUWZP6aC1EG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xUW1p4eL7uUW0fJK2gpL5eG9fLRC3G5W+PrRpmUvfDDbP6nUaWpFyCQUvjJNL6/Q5
	 W103e7jMAgPTUSnxn9GTFYpXx2epvrBtZyseTVAXuCRjDS9V5+WaFooS8UXGSpMbNT
	 2qP5M9YtD/Lbe0lmmXuadca5q7oV/wr1Fb0argCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbfAHTdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:33:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731700AbfAHTd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:33:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70EBF20827;
        Tue,  8 Jan 2019 19:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976007;
        bh=kMUio/CIE75FQuW9CLR1Dth70BxYd3hKUWZP6aC1EG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9A8mumPm2mLzHWO0XPEjhdtJ2n/M724J//pK3rh7g1geBeDYjRdrI5hEV0Ecnmhk
         Rq65Mcbbf03W1UUHHQGQuaHKVVAHeF7qc8G0wtM1YIjwCNj4J6c7HeP5HqrFYPF2H5
         IN8EtplWAPbmUiFK8NLuO4d2mDsCQMX6nCf5vSyk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 40/53] tools lib subcmd: Don't add the kernel sources to the include path
Date:   Tue,  8 Jan 2019 14:32:08 -0500
Message-Id: <20190108193222.123316-40-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193222.123316-1-sashal@kernel.org>
References: <20190108193222.123316-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit ece9804985b57e1ccd83b1fb6288520955a29d51 ]

At some point we decided not to directly include kernel sources files
when building tools/perf/, but when tools/lib/subcmd/ was forked from
tools/perf it somehow ended up adding it via these two lines in its
Makefile:

  CFLAGS += -I$(srctree)/include/uapi
  CFLAGS += -I$(srctree)/include

As $(srctree) points to the kernel sources.

Removing those lines and keeping just:

  CFLAGS += -I$(srctree)/tools/include/

Is enough to build tools/perf and tools/objtool.

This fixes the build when building from the sources in environments such
as the Android NDK crossbuilding from a fedora:26 system:

  subcmd-util.h:11:15: error: expected ',' or ';' before 'void'
   static inline void report(const char *prefix, const char *err, va_list params)
                 ^
  In file included from /git/perf/include/uapi/linux/stddef.h:2:0,
                   from /git/perf/include/uapi/linux/posix_types.h:5,
                   from /opt/android-ndk-r12b/platforms/android-24/arch-arm/usr/include/sys/types.h:36,
                   from /opt/android-ndk-r12b/platforms/android-24/arch-arm/usr/include/unistd.h:33,
                   from run-command.c:2:
  subcmd-util.h:18:17: error: '__no_instrument_function__' attribute applies only to functions

The /opt/android-ndk-r12b/platforms/android-24/arch-arm/usr/include/sys/types.h
file that includes linux/posix_types.h ends up getting the one in the kernel
sources causing the breakage. Fix it.

Test built tools/objtool/ too.

Reported-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 4b6ab94eabe4 ("perf subcmd: Create subcmd library")
Link: https://lkml.kernel.org/n/tip-5lhaoecrj12t0bqwvpiu14sm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/subcmd/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 95563b8e1ad7..ed61fb3a46c0 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -36,8 +36,6 @@ endif
 CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
 
 CFLAGS += -I$(srctree)/tools/include/
-CFLAGS += -I$(srctree)/include/uapi
-CFLAGS += -I$(srctree)/include
 
 SUBCMD_IN := $(OUTPUT)libsubcmd-in.o
 
-- 
2.19.1

