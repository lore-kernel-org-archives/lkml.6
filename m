Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA02C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6822659B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6822659B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeFZG6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:58:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54591 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeFZG63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:58:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5Q6wKGt1591864
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Jun 2018 23:58:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5Q6wKAr1591861;
        Mon, 25 Jun 2018 23:58:20 -0700
Date:   Mon, 25 Jun 2018 23:58:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-0c24d6fb7bd3578e5b9e4972d01bbe3d087ded33@git.kernel.org>
Cc:     tmricht@linux.ibm.com, brueckner@linux.ibm.com,
        schwidefsky@de.ibm.com, jolsa@redhat.com, acme@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        heiko.carstens@de.ibm.com, tglx@linutronix.de, hpa@zytor.com
Reply-To: tmricht@linux.ibm.com, brueckner@linux.ibm.com,
          schwidefsky@de.ibm.com, jolsa@redhat.com, acme@redhat.com,
          heiko.carstens@de.ibm.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20180615101105.47047-2-tmricht@linux.ibm.com>
References: <20180615101105.47047-2-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf alias: Rebuild alias expression string to
 make it comparable
Git-Commit-ID: 0c24d6fb7bd3578e5b9e4972d01bbe3d087ded33
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

Commit-ID:  0c24d6fb7bd3578e5b9e4972d01bbe3d087ded33
Gitweb:     https://git.kernel.org/tip/0c24d6fb7bd3578e5b9e4972d01bbe3d087ded33
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Fri, 15 Jun 2018 12:11:04 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Jun 2018 11:59:37 -0300

perf alias: Rebuild alias expression string to make it comparable

PMU alias definitions in sysfs files may have spaces, newlines and
numbers with leading zeroes. Some alias definitions may also appear in
JSON files without spaces, etc.

Scan alias definitions and remove leading zeroes, spaces, newlines, etc
and rebuild string to make alias->str member comparable.

s390 for example  has terms specified as event=0x0091 (read from files
../<PMU>/events/<FILE> and terms specified as event=0x91 (read from JSON
files).

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180615101105.47047-2-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 2738fc8d200d..f321ce97d9ec 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -241,9 +241,11 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 				 char *metric_expr,
 				 char *metric_name)
 {
+	struct parse_events_term *term;
 	struct perf_pmu_alias *alias;
 	int ret;
 	int num;
+	char newval[256];
 
 	alias = malloc(sizeof(*alias));
 	if (!alias)
@@ -262,6 +264,27 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 		return ret;
 	}
 
+	/* Scan event and remove leading zeroes, spaces, newlines, some
+	 * platforms have terms specified as
+	 * event=0x0091 (read from files ../<PMU>/events/<FILE>
+	 * and terms specified as event=0x91 (read from JSON files).
+	 *
+	 * Rebuild string to make alias->str member comparable.
+	 */
+	memset(newval, 0, sizeof(newval));
+	ret = 0;
+	list_for_each_entry(term, &alias->terms, list) {
+		if (ret)
+			ret += scnprintf(newval + ret, sizeof(newval) - ret,
+					 ",");
+		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
+			ret += scnprintf(newval + ret, sizeof(newval) - ret,
+					 "%s=%#x", term->config, term->val.num);
+		else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
+			ret += scnprintf(newval + ret, sizeof(newval) - ret,
+					 "%s=%s", term->config, term->val.str);
+	}
+
 	alias->name = strdup(name);
 	if (dir) {
 		/*
@@ -285,7 +308,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
 	}
 	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
-	alias->str = strdup(val);
+	alias->str = strdup(newval);
 
 	list_add_tail(&alias->list, list);
 
