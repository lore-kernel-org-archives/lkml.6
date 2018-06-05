Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbeFERvn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbeFERvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:51:41 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 20/46] perf srcline: Make hist_entry srcline helper consistent with map's
Date: Tue,  5 Jun 2018 14:50:04 -0300
Message-Id: <20180605175030.32549-21-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No need to have "get_srcline", plain hist_entry__srcline() is enough and
shorter.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-irhzpfmgdaf6cyk0uqqexoh9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 2 +-
 tools/perf/util/sort.c   | 8 ++++----
 tools/perf/util/sort.h   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 2126bfbcb385..307b3594525f 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1976,7 +1976,7 @@ static int filter_cb(struct hist_entry *he)
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 
 	if (c2c.show_src && !he->srcline)
-		he->srcline = hist_entry__get_srcline(he);
+		he->srcline = hist_entry__srcline(he);
 
 	calc_width(c2c_he);
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 4ab0b4ab24e4..fed2952ab45a 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -331,7 +331,7 @@ struct sort_entry sort_sym = {
 
 /* --sort srcline */
 
-char *hist_entry__get_srcline(struct hist_entry *he)
+char *hist_entry__srcline(struct hist_entry *he)
 {
 	return map__srcline(he->ms.map, he->ip, he->ms.sym);
 }
@@ -340,9 +340,9 @@ static int64_t
 sort__srcline_cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	if (!left->srcline)
-		left->srcline = hist_entry__get_srcline(left);
+		left->srcline = hist_entry__srcline(left);
 	if (!right->srcline)
-		right->srcline = hist_entry__get_srcline(right);
+		right->srcline = hist_entry__srcline(right);
 
 	return strcmp(right->srcline, left->srcline);
 }
@@ -351,7 +351,7 @@ static int hist_entry__srcline_snprintf(struct hist_entry *he, char *bf,
 					size_t size, unsigned int width)
 {
 	if (!he->srcline)
-		he->srcline = hist_entry__get_srcline(he);
+		he->srcline = hist_entry__srcline(he);
 
 	return repsep_snprintf(bf, size, "%-.*s", width, he->srcline);
 }
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 9e6896293bbd..f007a26d6f6d 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -292,5 +292,5 @@ int64_t
 sort__daddr_cmp(struct hist_entry *left, struct hist_entry *right);
 int64_t
 sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right);
-char *hist_entry__get_srcline(struct hist_entry *he);
+char *hist_entry__srcline(struct hist_entry *he);
 #endif	/* __PERF_SORT_H */
-- 
2.14.3
