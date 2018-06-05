Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753102AbeFESDM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752478AbeFERvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:51:38 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 19/46] perf sort: Introduce addr_map_symbol__srcline() to make code more compact
Date: Tue,  5 Jun 2018 14:50:03 -0300
Message-Id: <20180605175030.32549-20-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since we have 'struct addr_map_symbol' and the srcline sort order keys
all operate on those, make the code more compact by introducing a
function that receives a pointer to such struct and expands the
arguments to map__srcline().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-j540wq7n3ukkh70gk5be0in5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 71096dbfeb88..4ab0b4ab24e4 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -365,19 +365,20 @@ struct sort_entry sort_srcline = {
 
 /* --sort srcline_from */
 
+static char *addr_map_symbol__srcline(struct addr_map_symbol *ams)
+{
+	return map__srcline(ams->map, ams->al_addr, ams->sym);
+}
+
 static int64_t
 sort__srcline_from_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	if (!left->branch_info->srcline_from) {
-		left->branch_info->srcline_from = map__srcline(left->branch_info->from.map,
-							       left->branch_info->from.al_addr,
-							       left->branch_info->from.sym);
-	}
-	if (!right->branch_info->srcline_from) {
-		right->branch_info->srcline_from = map__srcline(right->branch_info->from.map,
-								right->branch_info->from.al_addr,
-								right->branch_info->from.sym);
-	}
+	if (!left->branch_info->srcline_from)
+		left->branch_info->srcline_from = addr_map_symbol__srcline(&left->branch_info->from);
+
+	if (!right->branch_info->srcline_from)
+		right->branch_info->srcline_from = addr_map_symbol__srcline(&right->branch_info->from);
+
 	return strcmp(right->branch_info->srcline_from, left->branch_info->srcline_from);
 }
 
@@ -399,16 +400,12 @@ struct sort_entry sort_srcline_from = {
 static int64_t
 sort__srcline_to_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	if (!left->branch_info->srcline_to) {
-		left->branch_info->srcline_to = map__srcline(left->branch_info->to.map,
-							     left->branch_info->to.al_addr,
-							     left->branch_info->to.sym);
-	}
-	if (!right->branch_info->srcline_to) {
-		right->branch_info->srcline_to = map__srcline(right->branch_info->to.map,
-							      right->branch_info->to.al_addr,
-							      right->branch_info->to.sym);
-	}
+	if (!left->branch_info->srcline_to)
+		left->branch_info->srcline_to = addr_map_symbol__srcline(&left->branch_info->to);
+
+	if (!right->branch_info->srcline_to)
+		right->branch_info->srcline_to = addr_map_symbol__srcline(&right->branch_info->to);
+
 	return strcmp(right->branch_info->srcline_to, left->branch_info->srcline_to);
 }
 
-- 
2.14.3
