Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2803C04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893C420684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP6/kP37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893C420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404491AbeKVOOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:14:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404467AbeKVOOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:14:54 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3497208E3;
        Thu, 22 Nov 2018 03:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857848;
        bh=4Q+li0vqynPBxRO06FPM9e6ucn3M9wPlCVazroU1G7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KP6/kP37zKjMa9ASYCQX4dbtVVQXz/Mg3Y6YnUunFQmmR44s8BB1xmASpkk5v2ePk
         J+cOnJsyQ3JIgjdR7WmP2dYJgM64WsztH2rM8uJhYzvsokCqeJiPTSG3QocgtwGNBi
         qFRfY1wfKKeiKRvpFcyan2llZAbIMaf1r21jE0LY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 22/28] perf pmu: Suppress potential format-truncation warning
Date:   Thu, 22 Nov 2018 00:36:05 -0300
Message-Id: <20181122033611.15890-23-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>

Depending on which functions are inlined in util/pmu.c, the snprintf()
calls in perf_pmu__parse_{scale,unit,per_pkg,snapshot}() might trigger a
warning:

  util/pmu.c: In function 'pmu_aliases':
  util/pmu.c:178:31: error: '%s' directive output may be truncated writing up to 255 bytes into a region of size between 0 and 4095 [-Werror=format-truncation=]
    snprintf(path, PATH_MAX, "%s/%s.unit", dir, name);
                               ^~

I found this when trying to build perf from Linux 3.16 with gcc 8.
However I can reproduce the problem in mainline if I force
__perf_pmu__new_alias() to be inlined.

Suppress this by using scnprintf() as has been done elsewhere in perf.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20181111184524.fux4taownc6ndbx6@decadent.org.uk
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7e49baad304d..7348eea0248f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -145,7 +145,7 @@ static int perf_pmu__parse_scale(struct perf_pmu_alias *alias, char *dir, char *
 	int fd, ret = -1;
 	char path[PATH_MAX];
 
-	snprintf(path, PATH_MAX, "%s/%s.scale", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.scale", dir, name);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
@@ -175,7 +175,7 @@ static int perf_pmu__parse_unit(struct perf_pmu_alias *alias, char *dir, char *n
 	ssize_t sret;
 	int fd;
 
-	snprintf(path, PATH_MAX, "%s/%s.unit", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.unit", dir, name);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
@@ -205,7 +205,7 @@ perf_pmu__parse_per_pkg(struct perf_pmu_alias *alias, char *dir, char *name)
 	char path[PATH_MAX];
 	int fd;
 
-	snprintf(path, PATH_MAX, "%s/%s.per-pkg", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.per-pkg", dir, name);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
@@ -223,7 +223,7 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
 	char path[PATH_MAX];
 	int fd;
 
-	snprintf(path, PATH_MAX, "%s/%s.snapshot", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.snapshot", dir, name);
 
 	fd = open(path, O_RDONLY);
 	if (fd == -1)
-- 
2.14.5

