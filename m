Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691D4C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5BA20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5BA20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbeKGEjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:39:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42199 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387537AbeKGEjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:39:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6JCweA910750
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 11:12:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6JCvYP910746;
        Tue, 6 Nov 2018 11:12:57 -0800
Date:   Tue, 6 Nov 2018 11:12:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-c3537fc251503af18085b8f84126d13743663970@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, tglx@linutronix.de, jolsa@kernel.org,
        ak@linux.intel.com
Reply-To: tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, jolsa@kernel.org
In-Reply-To: <20181001195927.14211-1-andi@firstfloor.org>
References: <20181001195927.14211-1-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf evlist: Move perf_evsel__reset_weak_group
 into evlist
Git-Commit-ID: c3537fc251503af18085b8f84126d13743663970
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

Commit-ID:  c3537fc251503af18085b8f84126d13743663970
Gitweb:     https://git.kernel.org/tip/c3537fc251503af18085b8f84126d13743663970
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Mon, 1 Oct 2018 12:59:26 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Nov 2018 14:37:09 -0300

perf evlist: Move perf_evsel__reset_weak_group into evlist

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
@@ -477,7 +451,7 @@ try_again:
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
