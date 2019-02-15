Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39C3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C858220675
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393402AbfBOJsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:48:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47759 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390106AbfBOJsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:48:03 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9lpOw1121102
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:47:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9louh1121099;
        Fri, 15 Feb 2019 01:47:50 -0800
Date:   Fri, 15 Feb 2019 01:47:50 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-d0bfbedad72b74f93b028c26474acba1ba3d73ed@git.kernel.org>
Cc:     namhyung@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com,
        peterz@infradead.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, hpa@zytor.com
Reply-To: tglx@linutronix.de, jolsa@kernel.org, namhyung@kernel.org,
          acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          peterz@infradead.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20190213123246.4015-2-jolsa@kernel.org>
References: <20190213123246.4015-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Compile perf with libperf-in.o instead
 of libperf.a
Git-Commit-ID: d0bfbedad72b74f93b028c26474acba1ba3d73ed
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

Commit-ID:  d0bfbedad72b74f93b028c26474acba1ba3d73ed
Gitweb:     https://git.kernel.org/tip/d0bfbedad72b74f93b028c26474acba1ba3d73ed
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 13 Feb 2019 13:32:37 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:08 -0300

perf tools: Compile perf with libperf-in.o instead of libperf.a

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
 
