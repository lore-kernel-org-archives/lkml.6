Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C987C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B6620827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977700;
	bh=qecpa5Vr4I+vywNWKyie1PaSPse4BmBbrLVVMGSb69U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g1CcUQfYpqaRGWbdVR9F2ZpxdYt0dUJ9OwRrjzqcigW2P74/k5PDHgVb/up12M3ca
	 /3F0mquZs2hOevyHu62JQATZ1r3uDKruzVxlDLgZl/ozcIaElb4BEf+qs5Wg1Abkxc
	 xw2vOUTqvkwaoeqAjmfQM0kculEAjvJsM5scz/XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfAHT3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:29:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730329AbfAHT3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7876320883;
        Tue,  8 Jan 2019 19:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975751;
        bh=qecpa5Vr4I+vywNWKyie1PaSPse4BmBbrLVVMGSb69U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w71i/ixipdoK30oqx1vdbCIu0YODFxvYWgdUaXDhO/KRtzy7Tug83cMCf/E1xJ4+K
         nZHvhU+06/nmCcPtxQpFPd26dg70Qnz1QCD0mcClfJl03tpLyqlt3/eUE0+0WUG9oo
         S7ptSPZZJlLTcVsJDPXldAucpsRALunTmWTYHqjA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 095/117] perf tools: Add missing open_memstream() prototype for systems lacking it
Date:   Tue,  8 Jan 2019 14:26:03 -0500
Message-Id: <20190108192628.121270-95-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit d7a8c4a6a055097a67ccfa3ca7c9ff1b64603a70 ]

There are systems such as the Android NDK API level 24 has the
open_memstream() function but doesn't provide a prototype, adding noise
to the build:

  builtin-timechart.c: In function 'cat_backtrace':
  builtin-timechart.c:486:2: warning: implicit declaration of function 'open_memstream' [-Wimplicit-function-declaration]
    FILE *f = open_memstream(&p, &p_len);
    ^
  builtin-timechart.c:486:2: warning: nested extern declaration of 'open_memstream' [-Wnested-externs]
  builtin-timechart.c:486:12: warning: initialization makes pointer from integer without a cast
    FILE *f = open_memstream(&p, &p_len);
              ^

Define a LACKS_OPEN_MEMSTREAM_PROTOTYPE define so that code needing that
can get a prototype.

Checked in the bionic git repo to be available since level 23:

https://android.googlesource.com/platform/bionic/+/master/libc/include/stdio.h#241

  FILE* open_memstream(char** __ptr, size_t* __size_ptr) __INTRODUCED_IN(23);

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-343ashae97e5bq6vizusyfno@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Makefile.config     | 1 +
 tools/perf/builtin-timechart.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e106e7ce6933..acbb657f7ce2 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -295,6 +295,7 @@ ifndef NO_BIONIC
   ifeq ($(feature-bionic), 1)
     BIONIC := 1
     CFLAGS += -DLACKS_SIGQUEUE_PROTOTYPE
+    CFLAGS += -DLACKS_OPEN_MEMSTREAM_PROTOTYPE
     EXTLIBS := $(filter-out -lrt,$(EXTLIBS))
     EXTLIBS := $(filter-out -lpthread,$(EXTLIBS))
   endif
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index a827919c6263..775b99833e51 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -43,6 +43,10 @@
 #include "util/data.h"
 #include "util/debug.h"
 
+#ifdef LACKS_OPEN_MEMSTREAM_PROTOTYPE
+FILE *open_memstream(char **ptr, size_t *sizeloc);
+#endif
+
 #define SUPPORT_OLD_POWER_EVENTS 1
 #define PWR_EVENT_EXIT -1
 
-- 
2.19.1

