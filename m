Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA151C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D32F20831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D32F20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392490AbeKVRve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:51:34 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37023 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733047AbeKVRvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:51:33 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM7D3uw3692286
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:13:03 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM7D2M73692283;
        Wed, 21 Nov 2018 23:13:02 -0800
Date:   Wed, 21 Nov 2018 23:13:02 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ben Hutchings <tipbot@zytor.com>
Message-ID: <tip-11a64a05dc649815670b1be9fe63d205cb076401@git.kernel.org>
Cc:     ben@decadent.org.uk, acme@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        jolsa@redhat.com, mingo@kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, hpa@zytor.com
Reply-To: hpa@zytor.com, jolsa@redhat.com, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          ben@decadent.org.uk, namhyung@kernel.org, acme@redhat.com
In-Reply-To: <20181111184524.fux4taownc6ndbx6@decadent.org.uk>
References: <20181111184524.fux4taownc6ndbx6@decadent.org.uk>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf pmu: Suppress potential format-truncation
 warning
Git-Commit-ID: 11a64a05dc649815670b1be9fe63d205cb076401
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

Commit-ID:  11a64a05dc649815670b1be9fe63d205cb076401
Gitweb:     https://git.kernel.org/tip/11a64a05dc649815670b1be9fe63d205cb076401
Author:     Ben Hutchings <ben@decadent.org.uk>
AuthorDate: Sun, 11 Nov 2018 18:45:24 +0000
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 22:39:56 -0300

perf pmu: Suppress potential format-truncation warning

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
