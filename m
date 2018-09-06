Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9071DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5D22083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5D22083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbeIGCzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:55:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728241AbeIGCzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:55:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E1268010FDF;
        Thu,  6 Sep 2018 22:18:18 +0000 (UTC)
Received: from hp-dl360pgen8-07.khw.lab.eng.bos.redhat.com (hp-dl360pgen8-07.khw.lab.eng.bos.redhat.com [10.16.184.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 244547D4D4;
        Thu,  6 Sep 2018 22:18:16 +0000 (UTC)
From:   Jarod Wilson <jarod@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarod Wilson <jarod@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] tools/perf: fix use of alternatives to find JDIR
Date:   Thu,  6 Sep 2018 18:18:12 -0400
Message-Id: <20180906221812.11167-1-jarod@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 06 Sep 2018 22:18:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 06 Sep 2018 22:18:18 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jarod@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a build is run from something like a cron job, the user's $PATH is
rather minimal, of note, not including /usr/sbin in my own case. Because
of that, an automated rpm package build ultimately fails to find
libperf-jvmti.so, because somewhere within the build, this happens...

/bin/sh: alternatives: command not found
/bin/sh: alternatives: command not found
Makefile.config:849: No openjdk development package found, please install
JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

...and while the build continues, libperf-jvmti.so isn't built, and things
fall down when rpm tries to find all the %files specified. Exact same
system builds everything just fine when the job is launched from a login
shell instead of a cron job, since alternatives is in $PATH, so openjdk is
actually found.

The test required to get into this section of code actually specifies the
full path, as does a block just above it, so let's do that here too.

CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Jiri Olsa <jolsa@redhat.com>
CC: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jarod Wilson <jarod@redhat.com>
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
-- 
2.16.1

