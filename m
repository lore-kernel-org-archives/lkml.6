Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA6BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E89206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E89206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeIZO7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:59:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58225 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbeIZO7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:59:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8Q8j7sj3771523
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 01:45:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8Q8j7KI3771520;
        Wed, 26 Sep 2018 01:45:07 -0700
Date:   Wed, 26 Sep 2018 01:45:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-a78cdee6fbb136694334ade4cedb331a9d0b4d5e@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, ak@linux.intel.com,
        jolsa@kernel.org, mingo@kernel.org, kim.phillips@arm.com,
        adrian.hunter@intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, kim.phillips@arm.com, mingo@kernel.org,
          jolsa@kernel.org, ak@linux.intel.com, tglx@linutronix.de,
          hpa@zytor.com
In-Reply-To: <20180918123214.26728-6-andi@firstfloor.org>
References: <20180918123214.26728-6-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script: Print DSO for callindent
Git-Commit-ID: a78cdee6fbb136694334ade4cedb331a9d0b4d5e
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

Commit-ID:  a78cdee6fbb136694334ade4cedb331a9d0b4d5e
Gitweb:     https://git.kernel.org/tip/a78cdee6fbb136694334ade4cedb331a9d0b4d5e
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Tue, 18 Sep 2018 05:32:10 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 15:25:51 -0300

perf script: Print DSO for callindent

Now that we don't need to print the IP/ADDR for callindent the DSO is
also not printed. It's useful for some cases, so add an own DSO printout
for callindent for the case when IP/ADDR is not enabled.

Before:

% perf script --itrace=cr -F +callindent,-ip,-sym,-symoff,-addr
         swapper     0 [000]  3377.917072:          1   branches: pt_config
         swapper     0 [000]  3377.917072:          1   branches:     pt_config
         swapper     0 [000]  3377.917072:          1   branches:     pt_event_add
         swapper     0 [000]  3377.917072:          1   branches:     perf_pmu_enable
         swapper     0 [000]  3377.917072:          1   branches:     perf_pmu_nop_void
         swapper     0 [000]  3377.917072:          1   branches:     event_sched_in.isra.107
         swapper     0 [000]  3377.917072:          1   branches:     __x86_indirect_thunk_rax
         swapper     0 [000]  3377.917072:          1   branches:     perf_pmu_nop_int
         swapper     0 [000]  3377.917072:          1   branches:     group_sched_in
         swapper     0 [000]  3377.917072:          1   branches:     event_filter_match
         swapper     0 [000]  3377.917072:          1   branches:     event_filter_match
         swapper     0 [000]  3377.917072:          1   branches:     group_sched_in

After:

         swapper     0 [000]  3377.917072:          1   branches: ([unknown])   pt_config
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       pt_config
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       pt_event_add
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       perf_pmu_enable
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       perf_pmu_nop_void
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       event_sched_in.isra.107
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       __x86_indirect_thunk_rax
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       perf_pmu_nop_int
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       group_sched_in
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       event_filter_match
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       event_filter_match
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])       group_sched_in
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])           __x86_indirect_thunk_rax
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])           perf_pmu_nop_txn
         swapper     0 [000]  3377.917072:          1   branches: ([kernel.kallsyms])           event_sched_in.isra.107

(in the kernel case of course it's not very useful, but it's important
with user programs where symbols are not unique)

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Link: http://lkml.kernel.org/r/20180918123214.26728-6-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7aa59696e97a..7732346bd9dd 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1115,6 +1115,7 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 	const char *name = NULL;
 	static int spacing;
 	int len = 0;
+	int dlen = 0;
 	u64 ip = 0;
 
 	/*
@@ -1141,6 +1142,12 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 			ip = sample->ip;
 	}
 
+	if (PRINT_FIELD(DSO) && !(PRINT_FIELD(IP) || PRINT_FIELD(ADDR))) {
+		dlen += fprintf(fp, "(");
+		dlen += map__fprintf_dsoname(al->map, fp);
+		dlen += fprintf(fp, ")\t");
+	}
+
 	if (name)
 		len = fprintf(fp, "%*s%s", (int)depth * 4, "", name);
 	else if (ip)
@@ -1159,7 +1166,7 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 	if (len < spacing)
 		len += fprintf(fp, "%*s", spacing - len, "");
 
-	return len;
+	return len + dlen;
 }
 
 static int perf_sample__fprintf_insn(struct perf_sample *sample,
