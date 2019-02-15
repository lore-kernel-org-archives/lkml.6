Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09ABC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CB3222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191714;
	bh=2pKrDYAeeE/fz0EJf5Y7i+ibSlJwnzzIc/8ob0HaFdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h5bUYwjjsq+4zl3ueKQP1FQEpw2drhuHDwOnNo4KqQXe9YhONwA3sapvWjHctFW2d
	 Au13OggE0MzYyEKqWw+Slw+/QpFnLgGbkcsQA9L0bY82So9l7HiX2lIp2Nnp+NUpKS
	 N2us/6y2Nd0OWdcNy/ebYaPsZhHHPLSX370nl2C8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389708AbfBOAsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:48:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:47582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389617AbfBOAs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:48:29 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D59C62229F;
        Fri, 15 Feb 2019 00:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191708;
        bh=2pKrDYAeeE/fz0EJf5Y7i+ibSlJwnzzIc/8ob0HaFdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvsA/q6+Coq6rctz7LsFh+rRyy3bJeCytgNzlDhhNZS2yqnLLG64vRwWjlRQ7/4bp
         OWyeRRQ79QK10LCJsmg/NVfSRe+LM2cyZ/PNFWDuL0KsyL81JnFfoOeHUWUCbMmlAU
         Gdg+6Bwqseh2HAiQzvqt0IYQg7s7ge5BwyBSXlSM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 36/43] perf tools: Compile perf with libperf-in.o instead of libperf.a
Date:   Thu, 14 Feb 2019 21:45:32 -0300
Message-Id: <20190215004539.23571-37-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no need for perf build to use libperf.a,
we can use directly libperf-in.o.

The libperf.a stays as a target if needed:

  $ make libperf.a
  ...
    CC       util/pmu.o
    CC       util/pmu-flex.o
    LD       util/libperf-in.o
    LD       libperf-in.o
    AR       libperf.a

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190213123246.4015-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c2ccc54618d1..93de7c7b8007 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -346,7 +346,7 @@ export PERL_PATH
 
 LIB_FILE=$(OUTPUT)libperf.a
 
-PERFLIBS = $(LIB_FILE) $(LIBAPI) $(LIBTRACEEVENT) $(LIBSUBCMD)
+PERFLIBS = $(LIBAPI) $(LIBTRACEEVENT) $(LIBSUBCMD)
 ifndef NO_LIBBPF
   PERFLIBS += $(LIBBPF)
 endif
@@ -549,6 +549,8 @@ JEVENTS_IN    := $(OUTPUT)pmu-events/jevents-in.o
 
 PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
 
+LIBPERF_IN := $(OUTPUT)libperf-in.o
+
 export JEVENTS
 
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
@@ -565,9 +567,12 @@ $(JEVENTS): $(JEVENTS_IN)
 $(PMU_EVENTS_IN): $(JEVENTS) FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
-$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
+$(LIBPERF_IN): prepare FORCE
+	$(Q)$(MAKE) $(build)=libperf
+
+$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBPERF_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS) \
-		$(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
+		$(PERF_IN) $(PMU_EVENTS_IN) $(LIBPERF_IN) $(LIBS) -o $@
 
 $(GTK_IN): FORCE
 	$(Q)$(MAKE) $(build)=gtk
@@ -683,11 +688,6 @@ endif
 
 $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
 
-LIBPERF_IN := $(OUTPUT)libperf-in.o
-
-$(LIBPERF_IN): prepare FORCE
-	$(Q)$(MAKE) $(build)=libperf
-
 $(LIB_FILE): $(LIBPERF_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN) $(LIB_OBJS)
 
-- 
2.19.1

