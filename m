Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892E6C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445FA217FE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445FA217FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbeHDPGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:06:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbeHDPGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:06:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52DBE81663FE;
        Sat,  4 Aug 2018 13:05:55 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D419B215670D;
        Sat,  4 Aug 2018 13:05:53 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 18/20] perf annotate: Display percent type in stdio output
Date:   Sat,  4 Aug 2018 15:05:19 +0200
Message-Id: <20180804130521.11408-19-jolsa@kernel.org>
In-Reply-To: <20180804130521.11408-1-jolsa@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 13:05:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 13:05:55 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In following patches we will allow to switch percent type
even for stdio annotation outputs. Adding the percent type
value into the annotation outputs title.

  $ perf annotate --stdio
   Percent         |      Sou ... instructions:u } (2805 samples, percent: local period)
  --------------------------- ... ------------------------------------------------------
  ...

  $ perf annotate --stdio2
  Samples: 2K of events 'anon ...  count (approx.): 156525487, [percent: local period]
  safe_write.c() /usr/bin/yes
  Percent
  ...

Link: http://lkml.kernel.org/n/tip-6r6t568p4m4c3bmw3urr7o3z@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/annotate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 05d15629afd0..6316fa96d984 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2056,10 +2056,12 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 		evsel_name = buf;
 	}
 
-	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples)\n",
+	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples, "
+				  "percent: %s)\n",
 				  width, width, symbol_conf.show_total_period ? "Period" :
 				  symbol_conf.show_nr_samples ? "Samples" : "Percent",
-				  d_filename, evsel_name, h->nr_samples);
+				  d_filename, evsel_name, h->nr_samples,
+				  percent_type_str(opts->percent_type));
 
 	printf("%-*.*s----\n",
 	       graph_dotted_len, graph_dotted_len, graph_dotted_line);
@@ -2434,7 +2436,8 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 	}
 
 	hists__scnprintf_title(hists, buf, sizeof(buf));
-	fprintf(stdout, "%s\n%s() %s\n", buf, sym->name, dso->long_name);
+	fprintf(stdout, "%s, [percent: %s]\n%s() %s\n",
+		buf, percent_type_str(opts->percent_type), sym->name, dso->long_name);
 	symbol__annotate_fprintf2(sym, stdout, opts);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
-- 
2.17.1

