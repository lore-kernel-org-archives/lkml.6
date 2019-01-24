Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256FAC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D2421903
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358637;
	bh=z3sR/lM0PUFuRHQKtQq808cTfy9eVjR5Erv5nhoH8TU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O8AquNBodXSjQgpERZi6yVa6E08u3fKwtxyDbUlMSfiBo8vXAlKh8NyRYSwHrbloB
	 AkhX7tEamsFLPrzgLGDFXYxuGQsbaUsQvXH4+yDLX+3U2FNU0uO1kjCUYm9ON/ANoI
	 K6S/f3BMGd5Ysu3Tey7840ME2UcwwWiA08SOXvjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbfAXThP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:37:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732607AbfAXThL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:37:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 304BD218FC;
        Thu, 24 Jan 2019 19:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358630;
        bh=z3sR/lM0PUFuRHQKtQq808cTfy9eVjR5Erv5nhoH8TU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tZVDuREcOSS77qpyDemZQZFa14OkeHvBWM0YqyB6LRn2Z2TegGkc4h+D9mL4Dj4oV
         AxGGRisk1qCWnk6fLYo7GMnIQ5Xsjr5eAOyJHZ+1xFG7RCCmwpmgHEaGJ5/EzMBBHt
         +DHTDpL4wFHFe2RtkvLGUZIJwwCFmw3sb2llkUKQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 077/106] tools lib subcmd: Dont add the kernel sources to the include path
Date:   Thu, 24 Jan 2019 20:20:34 +0100
Message-Id: <20190124190211.131509748@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



