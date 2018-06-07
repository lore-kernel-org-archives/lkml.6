Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nwwVK5XrGFunZwAAmS7hNA
	; Thu, 07 Jun 2018 08:24:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E9194608C8; Thu,  7 Jun 2018 08:24:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B26C860115;
	Thu,  7 Jun 2018 08:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B26C860115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932657AbeFGIYV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:24:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37729 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932551AbeFGIYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:24:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578O80l2127939
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:24:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578O8AQ2127936;
        Thu, 7 Jun 2018 01:24:08 -0700
Date: Thu, 7 Jun 2018 01:24:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ndfjtpiop3tdcnyjgp320ra8@git.kernel.org>
Cc: wangnan0@huawei.com, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, acme@redhat.com,
        adrian.hunter@intel.com, mingo@kernel.org, hpa@zytor.com,
        jolsa@kernel.org, tglx@linutronix.de, namhyung@kernel.org
Reply-To: tglx@linutronix.de, namhyung@kernel.org, jolsa@kernel.org,
          hpa@zytor.com, mingo@kernel.org, adrian.hunter@intel.com,
          acme@redhat.com, linux-kernel@vger.kernel.org, dsahern@gmail.com,
          wangnan0@huawei.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annnotate: Make __symbol__inc_addr_samples
 handle src->histograms == NULL
Git-Commit-ID: 8d628d26b997e6b2e93bf31cfc09e42cc496922e
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

Commit-ID:  8d628d26b997e6b2e93bf31cfc09e42cc496922e
Gitweb:     https://git.kernel.org/tip/8d628d26b997e6b2e93bf31cfc09e42cc496922e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 5 Jun 2018 16:31:21 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Jun 2018 12:52:08 -0300

perf annnotate: Make __symbol__inc_addr_samples handle src->histograms == NULL

Making it a bit more robust, this took place here when a sample appeared
right after:

  ffffffff8a925000 D __nosave_end

And before the next considered symbol, which, using kallsyms make us
over guess the size of __nosave_end, and then the sequence:

  hist_entry__inc_addr_samples ->
    symbol__inc_addr_samples ->
      symbol__hists ->
        annotated_source__alloc_histograms

Ends up not liking to allocate gigabytes of ram for annotation...

This will be alleviated by considering BSS symbols, which we should but
don't so far, and then we should investigate those samples further.

The testcase was to have:

   perf top -e cycles/call-graph=fp/,cache-misses/call-graph=dwarf/,instructions

Running for a while till it segfaulted trying to access NULL notes->src->histograms.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ndfjtpiop3tdcnyjgp320ra8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2baa22933b0e..f91775b4bc3c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -819,6 +819,11 @@ static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 
 	offset = addr - sym->start;
 	h = annotated_source__histogram(src, evidx);
+	if (h == NULL) {
+		pr_debug("%s(%d): ENOMEM! sym->name=%s, start=%#" PRIx64 ", addr=%#" PRIx64 ", end=%#" PRIx64 ", func: %d\n",
+			 __func__, __LINE__, sym->name, sym->start, addr, sym->end, sym->type == STT_FUNC);
+		return -ENOMEM;
+	}
 	h->nr_samples++;
 	h->addr[offset].nr_samples++;
 	h->period += sample->period;
