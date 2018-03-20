Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeCTGSu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:18:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50431 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbeCTGSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:18:47 -0400
Date: Mon, 19 Mar 2018 23:18:25 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-3773138828b38f3f1364ef318cd876b16182388a@git.kernel.org>
Cc: jolsa@kernel.org, peterz@infradead.org, hpa@zytor.com,
        dsahern@gmail.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, mingo@kernel.org,
        acme@redhat.com
Reply-To: alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        jmario@redhat.com, dsahern@gmail.com, hpa@zytor.com,
        peterz@infradead.org, jolsa@kernel.org, acme@redhat.com,
        namhyung@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180309101442.9224-6-jolsa@kernel.org>
References: <20180309101442.9224-6-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf c2c report: Make calc_width work with struct
 c2c_hist_entry
Git-Commit-ID: 3773138828b38f3f1364ef318cd876b16182388a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3773138828b38f3f1364ef318cd876b16182388a
Gitweb:     https://git.kernel.org/tip/3773138828b38f3f1364ef318cd876b16182388a
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 9 Mar 2018 11:14:38 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:53:05 -0300

perf c2c report: Make calc_width work with struct c2c_hist_entry

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
