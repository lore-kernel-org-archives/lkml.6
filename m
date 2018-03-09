Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbeCIKO6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:14:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751237AbeCIKO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:14:56 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 5/9] perf c2c report: Make calc_width work with struct c2c_hist_entry
Date: Fri,  9 Mar 2018 11:14:38 +0100
Message-Id: <20180309101442.9224-6-jolsa@kernel.org>
In-Reply-To: <20180309101442.9224-1-jolsa@kernel.org>
References: <20180309101442.9224-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to calculate column width based on the
struct c2c_hist_entry data, so making calc_width to
work with struct c2c_hist_entry.

Link: http://lkml.kernel.org/n/tip-p775ak70wpca93dm9q5jowre@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.13.6
