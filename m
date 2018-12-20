Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFFDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B45E217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbeLTSFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:05:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54561 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731288AbeLTSFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:05:35 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKI5RRg3680921
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:05:27 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKI5RQ83680918;
        Thu, 20 Dec 2018 10:05:27 -0800
Date:   Thu, 20 Dec 2018 10:05:27 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-lmhpev1uni9kdrv7j29glyov@git.kernel.org>
Cc:     mingo@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
        jolsa@kernel.org, hpa@zytor.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org
Reply-To: acme@redhat.com, hpa@zytor.com, jolsa@kernel.org,
          namhyung@kernel.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add missing sigqueue() prototype for
 systems lacking it
Git-Commit-ID: 748fe0889c1ff12d378946bd5326e8ee8eacf5cf
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

Commit-ID:  748fe0889c1ff12d378946bd5326e8ee8eacf5cf
Gitweb:     https://git.kernel.org/tip/748fe0889c1ff12d378946bd5326e8ee8eacf5cf
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 11 Dec 2018 15:48:47 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:56 -0300

perf tools: Add missing sigqueue() prototype for systems lacking it

There are systems such as the Android NDK API level 24 has the
sigqueue() function but doesn't provide a prototype, adding noise to the
build:

  util/evlist.c: In function 'perf_evlist__prepare_workload':
  util/evlist.c:1494:4: warning: implicit declaration of function 'sigqueue' [-Wimplicit-function-declaration]
      if (sigqueue(getppid(), SIGUSR1, val))
      ^
  util/evlist.c:1494:4: warning: nested extern declaration of 'sigqueue' [-Wnested-externs]

Define a LACKS_SIGQUEUE_PROTOTYPE define so that code needing that can
get a prototype.

Checked in the bionic git repo to be available since level 23:

https://android.googlesource.com/platform/bionic/+/master/libc/include/signal.h#123

  int sigqueue(pid_t __pid, int __signal, const union sigval __value) __INTRODUCED_IN(23);

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lmhpev1uni9kdrv7j29glyov@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 1 +
 tools/perf/util/evlist.c   | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b66f97a04b12..265a9225e5fc 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -294,6 +294,7 @@ ifndef NO_BIONIC
   $(call feature_check,bionic)
   ifeq ($(feature-bionic), 1)
     BIONIC := 1
+    CFLAGS += -DLACKS_SIGQUEUE_PROTOTYPE
     EXTLIBS := $(filter-out -lrt,$(EXTLIBS))
     EXTLIBS := $(filter-out -lpthread,$(EXTLIBS))
   endif
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e90575192209..8c902276d4b4 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -34,6 +34,10 @@
 #include <linux/log2.h>
 #include <linux/err.h>
 
+#ifdef LACKS_SIGQUEUE_PROTOTYPE
+int sigqueue(pid_t pid, int sig, const union sigval value);
+#endif
+
 #define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
 #define SID(e, x, y) xyarray__entry(e->sample_id, x, y)
 
