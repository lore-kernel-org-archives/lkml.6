Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ovxtA2jmGFs/QgAAmS7hNA
	; Thu, 07 Jun 2018 08:02:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1AD47607E7; Thu,  7 Jun 2018 08:02:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8CE41605A2;
	Thu,  7 Jun 2018 08:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CE41605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeFGICT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:02:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55359 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbeFGICR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:02:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5781x5V2122140
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:01:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5781x0v2122137;
        Thu, 7 Jun 2018 01:01:59 -0700
Date: Thu, 7 Jun 2018 01:01:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-xnvd07rdxliy04oi062samik@git.kernel.org>
Cc: dsahern@gmail.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, jolsa@kernel.org, wangnan0@huawei.com,
        adrian.hunter@intel.com, tglx@linutronix.de, eranian@google.com,
        acme@redhat.com, mingo@kernel.org, hpa@zytor.com
Reply-To: mingo@kernel.org, hpa@zytor.com, acme@redhat.com,
          adrian.hunter@intel.com, eranian@google.com, tglx@linutronix.de,
          wangnan0@huawei.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, jolsa@kernel.org, dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf cgroup: Make evlist__find_cgroup() more
 compact
Git-Commit-ID: 5dbe23e8772299f227f1ac974752bc853e9814bb
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

Commit-ID:  5dbe23e8772299f227f1ac974752bc853e9814bb
Gitweb:     https://git.kernel.org/tip/5dbe23e8772299f227f1ac974752bc853e9814bb
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 May 2018 11:29:07 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:50 -0300

perf cgroup: Make evlist__find_cgroup() more compact

By taking advantage that __get() routines return the pointer to the
object for which a reference count is being get.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-xnvd07rdxliy04oi062samik@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index decb91f9da82..ccd02634a616 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -93,20 +93,17 @@ static int open_cgroup(const char *name)
 static struct cgroup *evlist__find_cgroup(struct perf_evlist *evlist, const char *str)
 {
 	struct perf_evsel *counter;
-	struct cgroup *cgrp = NULL;
 	/*
 	 * check if cgrp is already defined, if so we reuse it
 	 */
 	evlist__for_each_entry(evlist, counter) {
 		if (!counter->cgrp)
 			continue;
-		if (!strcmp(counter->cgrp->name, str)) {
-			cgrp = cgroup__get(counter->cgrp);
-			break;
-		}
+		if (!strcmp(counter->cgrp->name, str))
+			return cgroup__get(counter->cgrp);
 	}
 
-	return cgrp;
+	return NULL;
 }
 
 static struct cgroup *cgroup__new(const char *name)
