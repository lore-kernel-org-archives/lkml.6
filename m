Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4101C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80FD2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80FD2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeJBCjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:39:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:31117 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbeJBCjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:39:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 12:59:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,328,1534834800"; 
   d="scan'208";a="91210582"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2018 12:59:36 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 080B7301B79; Mon,  1 Oct 2018 12:59:36 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 1/2] perf, tools: Move perf_evsel__reset_weak_group into evlist
Date:   Mon,  1 Oct 2018 12:59:26 -0700
Message-Id: <20181001195927.14211-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

- Move the function from builtin-stat to evlist for reuse
- Rename to evlist to match purpose better
- Pass the evlist as first argument.
- No functional changes

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-stat.c | 29 ++---------------------------
 tools/perf/util/evlist.c  | 27 +++++++++++++++++++++++++++
 tools/perf/util/evlist.h  |  3 +++
 3 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 08a1e64078ca..e60f6991dbb8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -567,32 +567,6 @@ static bool perf_evsel__should_store_id(struct perf_evsel *counter)
 	return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID;
 }
 
-static struct perf_evsel *perf_evsel__reset_weak_group(struct perf_evsel *evsel)
-{
-	struct perf_evsel *c2, *leader;
-	bool is_open = true;
-
-	leader = evsel->leader;
-	pr_debug("Weak group for %s/%d failed\n",
-			leader->name, leader->nr_members);
-
-	/*
-	 * for_each_group_member doesn't work here because it doesn't
-	 * include the first entry.
-	 */
-	evlist__for_each_entry(evsel_list, c2) {
-		if (c2 == evsel)
-			is_open = false;
-		if (c2->leader == leader) {
-			if (is_open)
-				perf_evsel__close(c2);
-			c2->leader = c2;
-			c2->nr_members = 0;
-		}
-	}
-	return leader;
-}
-
 static int __run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int interval = stat_config.interval;
@@ -639,7 +613,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			if ((errno == EINVAL || errno == EBADF) &&
 			    counter->leader != counter &&
 			    counter->weak_group) {
-				counter = perf_evsel__reset_weak_group(counter);
+				counter = perf_evlist__reset_weak_group(evsel_list,
+									counter);
 				goto try_again;
 			}
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e7a4b31a84fb..de90f9097e97 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1810,3 +1810,30 @@ void perf_evlist__force_leader(struct perf_evlist *evlist)
 		leader->forced_leader = true;
 	}
 }
+
+struct perf_evsel *perf_evlist__reset_weak_group(struct perf_evlist *evsel_list,
+						 struct perf_evsel *evsel)
+{
+	struct perf_evsel *c2, *leader;
+	bool is_open = true;
+
+	leader = evsel->leader;
+	pr_debug("Weak group for %s/%d failed\n",
+			leader->name, leader->nr_members);
+
+	/*
+	 * for_each_group_member doesn't work here because it doesn't
+	 * include the first entry.
+	 */
+	evlist__for_each_entry(evsel_list, c2) {
+		if (c2 == evsel)
+			is_open = false;
+		if (c2->leader == leader) {
+			if (is_open)
+				perf_evsel__close(c2);
+			c2->leader = c2;
+			c2->nr_members = 0;
+		}
+	}
+	return leader;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index dc66436add98..9919eed6d15b 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -312,4 +312,7 @@ bool perf_evlist__exclude_kernel(struct perf_evlist *evlist);
 
 void perf_evlist__force_leader(struct perf_evlist *evlist);
 
+struct perf_evsel *perf_evlist__reset_weak_group(struct perf_evlist *evlist,
+						 struct perf_evsel *evsel);
+
 #endif /* __PERF_EVLIST_H */
-- 
2.17.1

