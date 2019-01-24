Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67ACC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9514321726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359674;
	bh=TvCDfCsIeYtuapI3wGNY0umnt6SfAFv7Dm8Du15TsiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VsaMLR7LrpGJvowDa6I1qP9T8Ti6F3i9S3kJ9/jWryqvcfcbtpCVUfhE4LL6LdNC5
	 uB9uYo/WE7sQXsPL+PPB8cdhM8m49dn1z2K6rB6aw0acNEnj6+NigNdcUSiYJy6l2X
	 BV59n6dLAZRdfC+HWB6tqJJxUbhYmDr/MGwcE1Yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbfAXTh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:37:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731092AbfAXThY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:37:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75BE0218FC;
        Thu, 24 Jan 2019 19:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358644;
        bh=TvCDfCsIeYtuapI3wGNY0umnt6SfAFv7Dm8Du15TsiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7ibDxnGY5oagFKwKFEZzooV5PnGSC3a3QSP+lmxTTDb+u2sww8xTjIM6tb1/6xH/
         z9U0+jQOHQleD4eJDCWa4cFmQ4Ram2vqTsX4QCP4SH/xa3Z7K6tk618+5QInzSpnhy
         g+qEEfwMW4MfzHduGC7z7qJz+6W4zjTZwiBl5Gng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 081/106] perf tools: Add missing open_memstream() prototype for systems lacking it
Date:   Thu, 24 Jan 2019 20:20:38 +0100
Message-Id: <20190124190211.326902572@linuxfoundation.org>
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



