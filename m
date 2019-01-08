Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61989C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3050F206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976982;
	bh=nsl0kcoglIMJ9wC5Py7Ry8O59Dz6iLOGnzj455wlVkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VJabXStPzR4IhIJw5FMYsJx2pk3Hhqosu3bRNfddh0zd1RetAdQwyBcm5zOnqnN3E
	 /YFGHVhbUdWCG7VCmP+EZOZ2pkVJR1ZPS/202/vy6uUsOgwwA6DMHLEMmUBVwDU99t
	 p9HamcalYOVgFo3hmRJ6U1xtWHTTnPmkgDZ9PFcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfAHTcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:32:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731229AbfAHTbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:31:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A85CA20827;
        Tue,  8 Jan 2019 19:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975914;
        bh=nsl0kcoglIMJ9wC5Py7Ry8O59Dz6iLOGnzj455wlVkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1i+cb52kYx5DOM5bn1nPn9GBzllxP9cPUkSJSE3lHUetS4z3PqwxUDB6WY+02wk75
         47ZAlV6yxtW5g2eMqXRREN9zP/LKzdKlrO9kHOz3sQGQu8tZqa9U1ujgnat/hxDu86
         LJ/8PFPrqKxZrF+sEwWIENnNIXrKYr95iCSbeqc0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 79/97] perf tools: Add missing open_memstream() prototype for systems lacking it
Date:   Tue,  8 Jan 2019 14:29:28 -0500
Message-Id: <20190108192949.122407-79-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
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
index ff7a753cc487..f00ea77f5f08 100644
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

