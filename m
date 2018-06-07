Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Y43gJlzoGFu8TwAAmS7hNA
	; Thu, 07 Jun 2018 08:10:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 81C0E6089E; Thu,  7 Jun 2018 08:10:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BF3B2607E7;
	Thu,  7 Jun 2018 08:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF3B2607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932279AbeFGIKA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:10:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46533 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753028AbeFGIJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:09:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5789nBk2124650
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:09:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5789nbC2124647;
        Thu, 7 Jun 2018 01:09:49 -0700
Date: Thu, 7 Jun 2018 01:09:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-2d7d1nzd3ksqornloqeer99r@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, jolsa@kernel.org, hpa@zytor.com,
        mingo@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
        acme@redhat.com, namhyung@kernel.org, dsahern@gmail.com,
        wangnan0@huawei.com
Reply-To: wangnan0@huawei.com, dsahern@gmail.com, acme@redhat.com,
          namhyung@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
          mingo@kernel.org, jolsa@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf srcline: Introduce map__srcline() to make
 code more compact
Git-Commit-ID: e2d88aaa649e65851463426b133d87b61d3accbd
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

Commit-ID:  e2d88aaa649e65851463426b133d87b61d3accbd
Gitweb:     https://git.kernel.org/tip/e2d88aaa649e65851463426b133d87b61d3accbd
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 28 May 2018 11:05:20 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:52 -0300

perf srcline: Introduce map__srcline() to make code more compact

Replacing a common open coded sequence.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2d7d1nzd3ksqornloqeer99r@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c  | 12 ++++++----
 tools/perf/util/map.h  |  1 +
 tools/perf/util/sort.c | 60 +++++++++++---------------------------------------
 3 files changed, 22 insertions(+), 51 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 6ae97eda370b..92abc8e248c5 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -415,16 +415,20 @@ size_t map__fprintf_dsoname(struct map *map, FILE *fp)
 	return fprintf(fp, "%s", dsoname);
 }
 
+char *map__srcline(struct map *map, u64 addr, struct symbol *sym)
+{
+	if (map == NULL)
+		return SRCLINE_UNKNOWN;
+	return get_srcline(map->dso, map__rip_2objdump(map, addr), sym, true, true, addr);
+}
+
 int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 			 FILE *fp)
 {
-	char *srcline;
 	int ret = 0;
 
 	if (map && map->dso) {
-		srcline = get_srcline(map->dso,
-				      map__rip_2objdump(map, addr), NULL,
-				      true, true, addr);
+		char *srcline = map__srcline(map, addr, NULL);
 		if (srcline != SRCLINE_UNKNOWN)
 			ret = fprintf(fp, "%s%s", prefix, srcline);
 		free_srcline(srcline);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 97e2a063bd65..4cb90f242bed 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -169,6 +169,7 @@ static inline void __map__zput(struct map **map)
 int map__overlap(struct map *l, struct map *r);
 size_t map__fprintf(struct map *map, FILE *fp);
 size_t map__fprintf_dsoname(struct map *map, FILE *fp);
+char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
 int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 			 FILE *fp);
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 4058ade352a5..71096dbfeb88 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -333,13 +333,7 @@ struct sort_entry sort_sym = {
 
 char *hist_entry__get_srcline(struct hist_entry *he)
 {
-	struct map *map = he->ms.map;
-
-	if (!map)
-		return SRCLINE_UNKNOWN;
-
-	return get_srcline(map->dso, map__rip_2objdump(map, he->ip),
-			   he->ms.sym, true, true, he->ip);
+	return map__srcline(he->ms.map, he->ip, he->ms.sym);
 }
 
 static int64_t
@@ -375,28 +369,14 @@ static int64_t
 sort__srcline_from_cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	if (!left->branch_info->srcline_from) {
-		struct map *map = left->branch_info->from.map;
-		if (!map)
-			left->branch_info->srcline_from = SRCLINE_UNKNOWN;
-		else
-			left->branch_info->srcline_from = get_srcline(map->dso,
-					   map__rip_2objdump(map,
-							     left->branch_info->from.al_addr),
-							 left->branch_info->from.sym,
-							 true, true,
-							 left->branch_info->from.al_addr);
+		left->branch_info->srcline_from = map__srcline(left->branch_info->from.map,
+							       left->branch_info->from.al_addr,
+							       left->branch_info->from.sym);
 	}
 	if (!right->branch_info->srcline_from) {
-		struct map *map = right->branch_info->from.map;
-		if (!map)
-			right->branch_info->srcline_from = SRCLINE_UNKNOWN;
-		else
-			right->branch_info->srcline_from = get_srcline(map->dso,
-					     map__rip_2objdump(map,
-							       right->branch_info->from.al_addr),
-						     right->branch_info->from.sym,
-						     true, true,
-						     right->branch_info->from.al_addr);
+		right->branch_info->srcline_from = map__srcline(right->branch_info->from.map,
+								right->branch_info->from.al_addr,
+								right->branch_info->from.sym);
 	}
 	return strcmp(right->branch_info->srcline_from, left->branch_info->srcline_from);
 }
@@ -420,28 +400,14 @@ static int64_t
 sort__srcline_to_cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	if (!left->branch_info->srcline_to) {
-		struct map *map = left->branch_info->to.map;
-		if (!map)
-			left->branch_info->srcline_to = SRCLINE_UNKNOWN;
-		else
-			left->branch_info->srcline_to = get_srcline(map->dso,
-					   map__rip_2objdump(map,
-							     left->branch_info->to.al_addr),
-							 left->branch_info->from.sym,
-							 true, true,
-							 left->branch_info->to.al_addr);
+		left->branch_info->srcline_to = map__srcline(left->branch_info->to.map,
+							     left->branch_info->to.al_addr,
+							     left->branch_info->to.sym);
 	}
 	if (!right->branch_info->srcline_to) {
-		struct map *map = right->branch_info->to.map;
-		if (!map)
-			right->branch_info->srcline_to = SRCLINE_UNKNOWN;
-		else
-			right->branch_info->srcline_to = get_srcline(map->dso,
-					     map__rip_2objdump(map,
-							       right->branch_info->to.al_addr),
-						     right->branch_info->to.sym,
-						     true, true,
-						     right->branch_info->to.al_addr);
+		right->branch_info->srcline_to = map__srcline(right->branch_info->to.map,
+							      right->branch_info->to.al_addr,
+							      right->branch_info->to.sym);
 	}
 	return strcmp(right->branch_info->srcline_to, left->branch_info->srcline_to);
 }
