Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405B3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17901217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388452AbeLTSFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:05:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55313 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeLTSE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:04:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKI4qNF3680766
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:04:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKI4qdB3680763;
        Thu, 20 Dec 2018 10:04:52 -0800
Date:   Thu, 20 Dec 2018 10:04:52 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-5lhaoecrj12t0bqwvpiu14sm@git.kernel.org>
Cc:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jolsa@kernel.org, namhyung@kernel.org,
        acme@redhat.com, jpoimboe@redhat.com, tglx@linutronix.de,
        mingo@kernel.org
Reply-To: namhyung@kernel.org, tglx@linutronix.de, jpoimboe@redhat.com,
          acme@redhat.com, adrian.hunter@intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib subcmd: Don't add the kernel sources to
 the include path
Git-Commit-ID: ece9804985b57e1ccd83b1fb6288520955a29d51
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

Commit-ID:  ece9804985b57e1ccd83b1fb6288520955a29d51
Gitweb:     https://git.kernel.org/tip/ece9804985b57e1ccd83b1fb6288520955a29d51
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 11 Dec 2018 15:00:52 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:56 -0300

tools lib subcmd: Don't add the kernel sources to the include path

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
 
