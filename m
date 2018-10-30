Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ADEC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FE320838
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2Xkcxq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FE320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeJ3WVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbeJ3WV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:21:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DBC62084A;
        Tue, 30 Oct 2018 13:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906080;
        bh=m1AuNftMyCzvaPPYIbyT8xezByurmRPv4vKFCxC9UnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2Xkcxq0HB9AHgkWQxDRM9v3b4Nf164ecZFsXP12aI9adiheX9Zr1l2ltZlFTbm0U
         5Wma3TZosOzKfMeId0zUwlon51lTVG6gcFxDUDF9DJ3/hwqlI7vcI7P5vXmbz6PN0C
         LoEIqBjvm/8a+gYBFYkndasyY7blK+MJbT82Q+Wo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jarod Wilson <jarod@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        William Cohen <wcohen@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 22/33] perf tools: Fix use of alternatives to find JDIR
Date:   Tue, 30 Oct 2018 09:26:46 -0400
Message-Id: <20181030132657.217970-22-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarod Wilson <jarod@redhat.com>

[ Upstream commit 36b8d4628d3cc8f5a748e508cce8673bc00fc63c ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 67b042738ed7..986151732d68 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -831,7 +831,7 @@ ifndef NO_JVMTI
     JDIR=$(shell /usr/sbin/update-java-alternatives -l | head -1 | awk '{print $$3}')
   else
     ifneq (,$(wildcard /usr/sbin/alternatives))
-      JDIR=$(shell alternatives --display java | tail -1 | cut -d' ' -f 5 | sed 's%/jre/bin/java.%%g')
+      JDIR=$(shell /usr/sbin/alternatives --display java | tail -1 | cut -d' ' -f 5 | sed 's%/jre/bin/java.%%g')
     endif
   endif
   ifndef JDIR
-- 
2.17.1

