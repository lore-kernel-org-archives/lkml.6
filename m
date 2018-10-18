Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E87C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D9B21477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D9B21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJROSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:18:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50619 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeJROSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:18:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9I6IbcY707873
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Oct 2018 23:18:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9I6Ib5G707870;
        Wed, 17 Oct 2018 23:18:37 -0700
Date:   Wed, 17 Oct 2018 23:18:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jarod Wilson <tipbot@zytor.com>
Message-ID: <tip-36b8d4628d3cc8f5a748e508cce8673bc00fc63c@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, wcohen@redhat.com,
        namhyung@kernel.org, mingo@kernel.org, eranian@google.com,
        jarod@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        acme@redhat.com, jolsa@redhat.com
Reply-To: acme@redhat.com, jolsa@redhat.com, tglx@linutronix.de,
          hpa@zytor.com, jarod@redhat.com, eranian@google.com,
          mingo@kernel.org, namhyung@kernel.org, wcohen@redhat.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20180906221812.11167-1-jarod@redhat.com>
References: <20180906221812.11167-1-jarod@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix use of alternatives to find JDIR
Git-Commit-ID: 36b8d4628d3cc8f5a748e508cce8673bc00fc63c
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

Commit-ID:  36b8d4628d3cc8f5a748e508cce8673bc00fc63c
Gitweb:     https://git.kernel.org/tip/36b8d4628d3cc8f5a748e508cce8673bc00fc63c
Author:     Jarod Wilson <jarod@redhat.com>
AuthorDate: Thu, 6 Sep 2018 18:18:12 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 16 Oct 2018 12:06:47 -0300

perf tools: Fix use of alternatives to find JDIR

When a build is run from something like a cron job, the user's $PATH is
rather minimal, of note, not including /usr/sbin in my own case. Because
of that, an automated rpm package build ultimately fails to find
libperf-jvmti.so, because somewhere within the build, this happens...

  /bin/sh: alternatives: command not found
  /bin/sh: alternatives: command not found
  Makefile.config:849: No openjdk development package found, please install
  JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

...and while the build continues, libperf-jvmti.so isn't built, and
things fall down when rpm tries to find all the %files specified. Exact
same system builds everything just fine when the job is launched from a
login shell instead of a cron job, since alternatives is in $PATH, so
openjdk is actually found.

The test required to get into this section of code actually specifies
the full path, as does a block just above it, so let's do that here too.

Signed-off-by: Jarod Wilson <jarod@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: William Cohen <wcohen@redhat.com>
Fixes: d4dfdf00d43e ("perf jvmti: Plug compilation into perf build")
Link: http://lkml.kernel.org/r/20180906221812.11167-1-jarod@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index f6d1a03c7523..e30d20fb482d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -833,7 +833,7 @@ ifndef NO_JVMTI
     JDIR=$(shell /usr/sbin/update-java-alternatives -l | head -1 | awk '{print $$3}')
   else
     ifneq (,$(wildcard /usr/sbin/alternatives))
-      JDIR=$(shell alternatives --display java | tail -1 | cut -d' ' -f 5 | sed 's%/jre/bin/java.%%g')
+      JDIR=$(shell /usr/sbin/alternatives --display java | tail -1 | cut -d' ' -f 5 | sed 's%/jre/bin/java.%%g')
     endif
   endif
   ifndef JDIR
