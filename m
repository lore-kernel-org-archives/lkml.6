Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72237C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDC521E21
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMC97V30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDC521E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733036AbeHIR0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbeHIR0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:26:19 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B38FC214FF;
        Thu,  9 Aug 2018 15:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826861;
        bh=yJrrrHgaCi7NhjQkG693yU0a4vPmIvckK2m5RhtrIN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMC97V30fe18CQM1lULFU2ZLxWycf4zfyUoCSV2NlhnXkUDUfqVnmS0wGPpuN1RWe
         rc/bro7EtbohK1GRSKazD00Erdjq+ST5RL3xUdTtWSqEhNmF/WSSvZls+19c7YyuIR
         yihHPy5YEtlztuR3D0PTNeIHOcikf+KrT+XO7Yrs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/44] perf annotate: Display percent type in stdio output
Date:   Thu,  9 Aug 2018 11:58:08 -0300
Message-Id: <20180809145822.21391-31-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

In following patches we will allow to switch percent type even for stdio
annotation outputs. Adding the percent type value into the annotation
outputs title.

  $ perf annotate --stdio
   Percent         |      Sou ... instructions:u } (2805 samples, percent: local period)
  --------------------------- ... ------------------------------------------------------
  ...

  $ perf annotate --stdio2
  Samples: 2K of events 'anon ...  count (approx.): 156525487, [percent: local period]
  safe_write.c() /usr/bin/yes
  Percent
  ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-19-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.4

