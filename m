Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gq8CO6jpGFu3VgAAmS7hNA
	; Thu, 07 Jun 2018 08:15:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A80936089E; Thu,  7 Jun 2018 08:15:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2383E60115;
	Thu,  7 Jun 2018 08:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2383E60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932480AbeFGIPi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:15:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58439 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753415AbeFGIPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:15:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578FRtX2125434
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:15:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578FRsM2125430;
        Thu, 7 Jun 2018 01:15:27 -0700
Date: Thu, 7 Jun 2018 01:15:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-inxl7k49q9f9w1se039fbxuw@git.kernel.org>
Cc: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, acme@redhat.com, wangnan0@huawei.com,
        namhyung@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        dsahern@gmail.com, jolsa@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
          wangnan0@huawei.com, namhyung@kernel.org, jolsa@kernel.org,
          dsahern@gmail.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, adrian.hunter@intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Check if evsel has callchains before
 trying to use it
Git-Commit-ID: b879833cbaac85b1437f574791b8855d26b0dc80
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

Commit-ID:  b879833cbaac85b1437f574791b8855d26b0dc80
Gitweb:     https://git.kernel.org/tip/b879833cbaac85b1437f574791b8855d26b0dc80
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 4 Jun 2018 10:34:20 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 5 Jun 2018 10:09:54 -0300

perf script: Check if evsel has callchains before trying to use it

We were checking just if callchain processing was asked for by the
user, not if the evsel itself has callchains, and since we can have
some evsels with callchains and others without, check that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-inxl7k49q9f9w1se039fbxuw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 48e940efb3cb..b3bf35512d21 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -606,7 +606,7 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 	if (PRINT_FIELD(COMM)) {
 		if (latency_format)
 			printed += fprintf(fp, "%8.8s ", thread__comm_str(thread));
-		else if (PRINT_FIELD(IP) && symbol_conf.use_callchain)
+		else if (PRINT_FIELD(IP) && evsel__has_callchain(evsel) && symbol_conf.use_callchain)
 			printed += fprintf(fp, "%s ", thread__comm_str(thread));
 		else
 			printed += fprintf(fp, "%16s ", thread__comm_str(thread));
