Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Wu0hNebmGFslRwAAmS7hNA
	; Thu, 07 Jun 2018 08:06:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D746B607F7; Thu,  7 Jun 2018 08:06:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 54F07605A2;
	Thu,  7 Jun 2018 08:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54F07605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbeFGIGY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:06:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60627 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbeFGIGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:06:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w57867fE2124153
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:06:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w57867Ni2124150;
        Thu, 7 Jun 2018 01:06:07 -0700
Date: Thu, 7 Jun 2018 01:06:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-4iatualjskia7sojmdb65cmm@git.kernel.org>
Cc: tglx@linutronix.de, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        wangnan0@huawei.com, acme@redhat.com, jolsa@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, dsahern@gmail.com
Reply-To: mingo@kernel.org, wangnan0@huawei.com,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          tglx@linutronix.de, adrian.hunter@intel.com, hpa@zytor.com,
          jolsa@kernel.org, dsahern@gmail.com, acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Introduce symbol__hists()
Git-Commit-ID: e8ea922a7e077b491c6363755e3ac94d350ea253
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

Commit-ID:  e8ea922a7e077b491c6363755e3ac94d350ea253
Gitweb:     https://git.kernel.org/tip/e8ea922a7e077b491c6363755e3ac94d350ea253
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 May 2018 16:37:53 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:51 -0300

perf annotate: Introduce symbol__hists()

In this case we're wanting just notes->src->histograms, allocating it if needed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-4iatualjskia7sojmdb65cmm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a5a6d686004e..467bae0279ce 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -863,18 +863,38 @@ static struct annotation *symbol__get_annotation(struct symbol *sym, bool cycles
 	return notes;
 }
 
+static struct annotated_source *symbol__hists(struct symbol *sym)
+{
+	struct annotation *notes = symbol__annotation(sym);
+
+	if (notes->src == NULL) {
+		notes->src = annotated_source__new();
+		if (notes->src == NULL)
+			return NULL;
+		goto alloc_histograms;
+	}
+
+	if (notes->src->histograms == NULL) {
+alloc_histograms:
+		annotated_source__alloc_histograms(notes->src, symbol__size(sym),
+						   symbol_conf.nr_events);
+	}
+
+	return notes->src;
+}
+
 static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 				    struct perf_evsel *evsel, u64 addr,
 				    struct perf_sample *sample)
 {
-	struct annotation *notes;
+	struct annotated_source *src;
 
 	if (sym == NULL)
 		return 0;
-	notes = symbol__get_annotation(sym, false);
-	if (notes == NULL)
+	src = symbol__hists(sym);
+	if (src == NULL)
 		return -ENOMEM;
-	return __symbol__inc_addr_samples(sym, map, notes->src, evsel->idx, addr, sample);
+	return __symbol__inc_addr_samples(sym, map, src, evsel->idx, addr, sample);
 }
 
 static int symbol__account_cycles(u64 addr, u64 start,
