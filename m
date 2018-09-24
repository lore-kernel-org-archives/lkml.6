Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647BEC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1341321508
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaZuNBqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1341321508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbeIXVGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729892AbeIXVGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:06:07 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C7F214D5;
        Mon, 24 Sep 2018 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537801412;
        bh=R7YmLXX/tJZ707P7/hRjHAzqBdyfnYU2ElXb/i0wcr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OaZuNBqyyBWBJHJGqomtxtBblHZ8dDHTNa8PlK0pzPY25NV7TzshVzciPYVO5KqgP
         3bzsEo2UW+ke952fMsivhfJAOno0toLEtjXZyf+dkk77IWHhRgUre05T4QFe7BSE1d
         A0hmw/4nU3bST8UJw/H/mnZYhu4AinW397xqktHc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/27] perf script: Print DSO for callindent
Date:   Mon, 24 Sep 2018 12:02:20 -0300
Message-Id: <20180924150242.14235-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

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
-- 
2.14.4

