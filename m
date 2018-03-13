Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933115AbeCMMFm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:05:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933074AbeCMMFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:05:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9C12178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Joe Mario <jmario@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/31] perf c2c report: Make calc_width work with struct c2c_hist_entry
Date: Tue, 13 Mar 2018 09:04:42 -0300
Message-Id: <20180313120508.29327-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We are going to calculate tje column width based on the struct
c2c_hist_entry data, so making calc_width to work with struct
c2c_hist_entry.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180309101442.9224-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 95765a1db903..43ce55550c9d 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1839,20 +1839,24 @@ static inline int valid_hitm_or_store(struct hist_entry *he)
 	return has_hitm || c2c_he->stats.store;
 }
 
-static void calc_width(struct hist_entry *he)
+static void calc_width(struct c2c_hist_entry *c2c_he)
 {
 	struct c2c_hists *c2c_hists;
 
-	c2c_hists = container_of(he->hists, struct c2c_hists, hists);
-	hists__calc_col_len(&c2c_hists->hists, he);
+	c2c_hists = container_of(c2c_he->he.hists, struct c2c_hists, hists);
+	hists__calc_col_len(&c2c_hists->hists, &c2c_he->he);
 }
 
 static int filter_cb(struct hist_entry *he)
 {
+	struct c2c_hist_entry *c2c_he;
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+
 	if (c2c.show_src && !he->srcline)
 		he->srcline = hist_entry__get_srcline(he);
 
-	calc_width(he);
+	calc_width(c2c_he);
 
 	if (!valid_hitm_or_store(he))
 		he->filtered = HIST_FILTER__C2C;
@@ -1869,7 +1873,7 @@ static int resort_cl_cb(struct hist_entry *he)
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 	c2c_hists = c2c_he->hists;
 
-	calc_width(he);
+	calc_width(c2c_he);
 
 	if (display && c2c_hists) {
 		static unsigned int idx;
-- 
2.14.3
