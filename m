Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038E4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2231218AD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170961;
	bh=l0OYjM4O6Xp/kVheLMavtMHL68+0mo9/qExujhfNxsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cpwIJUBdGg6iIM87BJxbXHrfwfFepXXaaCw3sLku7HDyaOrNkUc/R9Qn1iO6fdZhn
	 VnFu0XGcuSvxFjWyNYQ43grKpUvwP2GB/JxA8IpKilE8AGt9VJtv+pKS8VhoIisXIL
	 eY7Y41A3eczn/wleJgjRTFvEC22wYQs9W1slfnPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeLRWJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:09:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbeLRWJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:09:17 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54501217D9;
        Tue, 18 Dec 2018 22:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170957;
        bh=l0OYjM4O6Xp/kVheLMavtMHL68+0mo9/qExujhfNxsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fdRmwWSCJhRfAw8nyX4ZvYRpmwG8OMCxvCXOwEHyxf7NQHNaRnN0k9mNulj0FwoOT
         TggOyXaAWXqD5J10oS9Q1R+QZxHCz6cwJi4kHy83kPFIVfD5xcTG7qFfAr++2aoH/2
         aPHq0X3MR+k1VbnbFjpYWCWdT7UDaa8L2IDbvvsk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 16/63] perf tools: Add missing open_memstream() prototype for systems lacking it
Date:   Tue, 18 Dec 2018 19:06:46 -0300
Message-Id: <20181218220733.15839-17-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
---
 tools/perf/Makefile.config     | 1 +
 tools/perf/builtin-timechart.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 265a9225e5fc..07c1857c3d7a 100644
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
2.19.2

