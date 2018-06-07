Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XYvsDuvpGFvfVwAAmS7hNA
	; Thu, 07 Jun 2018 08:16:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2E8A7607F7; Thu,  7 Jun 2018 08:16:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A6EEE6089E;
	Thu,  7 Jun 2018 08:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6EEE6089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932440AbeFGIQl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:16:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49349 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbeFGIQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:16:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578GTZh2125532
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:16:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578GTbW2125529;
        Thu, 7 Jun 2018 01:16:29 -0700
Date: Thu, 7 Jun 2018 01:16:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-p6gioxkzpkpz71dtt4wcs36o@git.kernel.org>
Cc: mingo@kernel.org, wangnan0@huawei.com, jolsa@kernel.org,
        tglx@linutronix.de, namhyung@kernel.org, adrian.hunter@intel.com,
        dsahern@gmail.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        hpa@zytor.com
Reply-To: adrian.hunter@intel.com, dsahern@gmail.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          wangnan0@huawei.com, jolsa@kernel.org, tglx@linutronix.de,
          namhyung@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hists: Introduce hist_entry__has_callchain()
 method
Git-Commit-ID: 0b5d6ece5e6a8b45c4ebbaaf831675b5b605850f
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

Commit-ID:  0b5d6ece5e6a8b45c4ebbaaf831675b5b605850f
Gitweb:     https://git.kernel.org/tip/0b5d6ece5e6a8b45c4ebbaaf831675b5b605850f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 29 May 2018 13:28:24 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Jun 2018 12:51:46 -0300

perf hists: Introduce hist_entry__has_callchain() method

We'll use this helper more frequently when reworking
symbol_conf.use_callchain logic, where knowing if a hist_entry has
callchains is the important bit, so make going from hist_entry to hists
to evsel easier, compact.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-p6gioxkzpkpz71dtt4wcs36o@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index f007a26d6f6d..1a046157bfef 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -151,6 +151,12 @@ struct hist_entry {
 	struct callchain_root	callchain[0]; /* must be last member */
 };
 
+static __pure inline bool hist_entry__has_callchains(struct hist_entry *he)
+{
+	const struct perf_evsel *evsel = hists_to_evsel(he->hists);
+	return evsel__has_callchain(evsel);
+}
+
 static inline bool hist_entry__has_pairs(struct hist_entry *he)
 {
 	return !list_empty(&he->pairs.node);
