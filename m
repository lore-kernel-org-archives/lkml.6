Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lR0NDW3oGFuITwAAmS7hNA
	; Thu, 07 Jun 2018 08:10:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EE6516089E; Thu,  7 Jun 2018 08:10:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5938C60115;
	Thu,  7 Jun 2018 08:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5938C60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753489AbeFGIKa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:10:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46907 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbeFGIK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:10:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578AK8i2124698
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:10:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578AKUT2124695;
        Thu, 7 Jun 2018 01:10:20 -0700
Date: Thu, 7 Jun 2018 01:10:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-j540wq7n3ukkh70gk5be0in5@git.kernel.org>
Cc: acme@redhat.com, namhyung@kernel.org, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, dsahern@gmail.com,
        adrian.hunter@intel.com, jolsa@kernel.org, wangnan0@huawei.com,
        tglx@linutronix.de
Reply-To: jolsa@kernel.org, tglx@linutronix.de, wangnan0@huawei.com,
          namhyung@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
          dsahern@gmail.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mingo@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf sort: Introduce addr_map_symbol__srcline()
 to make code more compact
Git-Commit-ID: bfa63519fb94fd8b4b0e5ffcd8bde650ea8b20c1
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

Commit-ID:  bfa63519fb94fd8b4b0e5ffcd8bde650ea8b20c1
Gitweb:     https://git.kernel.org/tip/bfa63519fb94fd8b4b0e5ffcd8bde650ea8b20c1
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 28 May 2018 11:11:47 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:52 -0300

perf sort: Introduce addr_map_symbol__srcline() to make code more compact

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
 
