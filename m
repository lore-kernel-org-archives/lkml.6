Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33619C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85ED20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVnmd2rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85ED20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388059AbeKFVbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:31:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388034AbeKFVbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:31:45 -0500
Received: from jouet.infradead.org (unknown [189.40.102.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6474C20862;
        Tue,  6 Nov 2018 12:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541506010;
        bh=C+CjcnvyebvbqffpR6Re98JDGkTpts6d3KNWGjrAF+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SVnmd2rx3fq73zg1y183dm4za1RjmgJ1pYjRgwFBmY0+LfYU8OC4BxC1I7PNqvAD8
         tW0r11pqhAh9cht9O56jATGV0nNSyEL93JWOpF1Q3/Nqjt3psahYBTBmCsCCphEU5R
         GDWlu8m5G1UsBkIs5meHsRt7Ms+DcaOpwpZS5bts=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/18] perf evlist: Move perf_evsel__reset_weak_group into evlist
Date:   Tue,  6 Nov 2018 09:06:00 -0300
Message-Id: <20181106120612.8262-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
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
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181001195927.14211-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 28 +---------------------------
 tools/perf/util/evlist.c  | 27 +++++++++++++++++++++++++++
 tools/perf/util/evlist.h  |  3 +++
 3 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d1028d7755bb..a635abfa77b6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -383,32 +383,6 @@ static bool perf_evsel__should_store_id(struct perf_evsel *counter)
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
 static bool is_target_alive(struct target *_target,
 			    struct thread_map *threads)
 {
@@ -477,7 +451,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			if ((errno == EINVAL || errno == EBADF) &&
 			    counter->leader != counter &&
 			    counter->weak_group) {
-				counter = perf_evsel__reset_weak_group(counter);
+				counter = perf_evlist__reset_weak_group(evsel_list, counter);
 				goto try_again;
 			}
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e88e6f9b1463..668d2a9ef0f4 100644
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
2.14.4

