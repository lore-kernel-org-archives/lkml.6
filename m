Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /CM2EePmGFtsRQAAmS7hNA
	; Thu, 07 Jun 2018 08:03:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0095C607E7; Thu,  7 Jun 2018 08:03:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D3CAB608CD;
	Thu,  7 Jun 2018 08:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3CAB608CD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbeFGIDr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:03:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54941 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbeFGIDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:03:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5783YqP2122397
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:03:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5783Yhi2122394;
        Thu, 7 Jun 2018 01:03:34 -0700
Date: Thu, 7 Jun 2018 01:03:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-zd1cu4zwmu21k0cxlr83y6vr@git.kernel.org>
Cc: jolsa@kernel.org, adrian.hunter@intel.com, namhyung@kernel.org,
        acme@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        wangnan0@huawei.com, hpa@zytor.com, dsahern@gmail.com,
        mingo@kernel.org
Reply-To: adrian.hunter@intel.com, namhyung@kernel.org, acme@redhat.com,
          jolsa@kernel.org, mingo@kernel.org, dsahern@gmail.com,
          wangnan0@huawei.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: __symbol__acount_cycles doesn't
 need notes
Git-Commit-ID: f40dd6d1b4b29208a7232693746575f7ae6365a5
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

Commit-ID:  f40dd6d1b4b29208a7232693746575f7ae6365a5
Gitweb:     https://git.kernel.org/tip/f40dd6d1b4b29208a7232693746575f7ae6365a5
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 May 2018 15:20:18 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:51 -0300

perf annotate: __symbol__acount_cycles doesn't need notes

It only operates on the notes->src->cyc_hist, just pass that to it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zd1cu4zwmu21k0cxlr83y6vr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0f5ed6091e00..a7221f9fa504 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -741,14 +741,11 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
 	pthread_mutex_unlock(&notes->lock);
 }
 
-static int __symbol__account_cycles(struct annotation *notes,
+static int __symbol__account_cycles(struct cyc_hist *ch,
 				    u64 start,
 				    unsigned offset, unsigned cycles,
 				    unsigned have_start)
 {
-	struct cyc_hist *ch;
-
-	ch = notes->src->cycles_hist;
 	/*
 	 * For now we can only account one basic block per
 	 * final jump. But multiple could be overlapping.
@@ -870,7 +867,7 @@ static int symbol__account_cycles(u64 addr, u64 start,
 			start = 0;
 	}
 	offset = addr - sym->start;
-	return __symbol__account_cycles(notes,
+	return __symbol__account_cycles(notes->src->cycles_hist,
 					start ? start - sym->start : 0,
 					offset, cycles,
 					!!start);
