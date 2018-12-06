Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2743FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D124A2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131814;
	bh=MnfQ0ZIFGXDl3K70jwpBMyJ40SHMhB2O8Tann/2MgcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tofyeQcayqSCbKQ/u8qWiYDAqVWSWyRzzgUo9BJfcCn10mPJQIV+tVXPJzpXdt7X7
	 MErzblQZJKb6rm9C0qJsqdyD3YMbhxQ3x33SQf0K/RZvM56NWfqKir3WNwMYeB8DVl
	 aSoP6669HYszafOa6R2Smxks+yr7/s+gtNyODRAc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D124A2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeLFVaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:30:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbeLFVaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:30:11 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 363322082B;
        Thu,  6 Dec 2018 21:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131810;
        bh=MnfQ0ZIFGXDl3K70jwpBMyJ40SHMhB2O8Tann/2MgcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUxv97++A7ujivU0aJ4o6p9XuDSfp5KcvYpt5anzwVLhrBeOFi7UoCzvTMSez+y9o
         z+3RcccNuo+XhMkRScCVCj2oisa46BTc7l8+NRJBzjkHmpaJIpl6fIPIzevN5ay90T
         KkmP0PoDqWeB3pF/jCSdNG7qvmVt1ztjN1tS0O+8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 56/75] perf top: Move perf_top__reset_sample_counters() to after counts display
Date:   Thu,  6 Dec 2018 18:25:43 -0300
Message-Id: <20181206212602.20474-57-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the perf_top__reset_sample_counters() call to right after we
display the counters so we can see the updated numbers for longer.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-o72pyiwt05f3p2juprwmz2jo@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c       | 4 ----
 tools/perf/ui/browsers/hists.c | 3 +++
 tools/perf/util/top.c          | 1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f22c531be366..fe3ecfb2e64b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -273,8 +273,6 @@ static void perf_top__print_sym_table(struct perf_top *top)
 	perf_top__header_snprintf(top, bf, sizeof(bf));
 	printf("%s\n", bf);
 
-	perf_top__reset_sample_counters(top);
-
 	printf("%-*.*s\n", win_width, win_width, graph_dotted_line);
 
 	if (!top->record_opts.overwrite &&
@@ -573,8 +571,6 @@ static void perf_top__sort_new_samples(void *arg)
 
 	if (t->lost || t->drop)
 		pr_warning("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
-
-	perf_top__reset_sample_counters(t);
 }
 
 static void stop_top(void)
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 36b262c49f51..ffac1d54a3d4 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2229,8 +2229,11 @@ static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf
 
 		if (top->zero)
 			printed += scnprintf(bf + printed, size - printed, " [z]");
+
+		perf_top__reset_sample_counters(top);
 	}
 
+
 	return printed;
 }
 
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index 31a8dee9af69..4c8da8c4435f 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -107,6 +107,7 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 					top->evlist->cpus->nr > 1 ? "s" : "");
 	}
 
+	perf_top__reset_sample_counters(top);
 	return ret;
 }
 
-- 
2.19.2

