Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3A4ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244E321470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLHQ6aDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244E321470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeJRGxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbeJRGxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:53:34 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 076852087A;
        Wed, 17 Oct 2018 22:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539816940;
        bh=iW8zQLc4wNSCOL2ahA6Qp7dYA7K6jaI3V5BpugIxpa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLHQ6aDs7t3tLgBgd2kyZaXaLbzfoEXgA7WMsTosTdEgOe/OdjINgyy+CrdorW9ad
         auOq9994RX5CkgzmCY0CihancgEqFJsVBaex52o2DnQ2gmZjAS9+4En6Q16B/Z+hIF
         h/dFylQtAsxinau5gjGQP5JwJqkfzyHbra4b0tM4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jarod Wilson <jarod@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        William Cohen <wcohen@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/11] perf tools: Fix use of alternatives to find JDIR
Date:   Wed, 17 Oct 2018 19:54:56 -0300
Message-Id: <20181017225501.32150-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181017225501.32150-1-acme@kernel.org>
References: <20181017225501.32150-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarod Wilson <jarod@redhat.com>

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
-- 
2.14.4

