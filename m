Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB75C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EFF217FE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EFF217FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbeHDPGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:06:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbeHDPGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:06:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1319C4219DD9;
        Sat,  4 Aug 2018 13:05:57 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93788215670D;
        Sat,  4 Aug 2018 13:05:55 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 19/20] perf annotate: Add --percent-type option
Date:   Sat,  4 Aug 2018 15:05:20 +0200
Message-Id: <20180804130521.11408-20-jolsa@kernel.org>
In-Reply-To: <20180804130521.11408-1-jolsa@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 04 Aug 2018 13:05:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 04 Aug 2018 13:05:57 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding --percent-type option to set annotation percent type
from following choices:
  global-period, local-period, global-hits, local-hits

Examples:
  $ perf annotate --percent-type period-local --stdio | head -1
   Percent         |      Source code ... es, percent: local period)
  $ perf annotate --percent-type hits-local --stdio | head -1
   Percent         |      Source code ... es, percent: local hits)
  $ perf annotate --percent-type hits-global --stdio | head -1
   Percent         |      Source code ... es, percent: global hits)
  $ perf annotate --percent-type period-global --stdio | head -1
   Percent         |      Source code ... es, percent: global period)

The local/global keywords set if the percentage is computed
in the scope of the function (local) or the whole data (global).

The period/hits keywords set the base the percentage is computed
on - the samples period or the number of samples (hits).

Link: http://lkml.kernel.org/n/tip-ahnswy1p9rnjlkudhl2ig3gc@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-annotate.txt |  9 ++++
 tools/perf/builtin-annotate.c              |  4 ++
 tools/perf/util/annotate.c                 | 53 ++++++++++++++++++++++
 tools/perf/util/annotate.h                 |  3 ++
 4 files changed, 69 insertions(+)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 749cc6055dac..e8c972f89357 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -118,6 +118,15 @@ OPTIONS
 --group::
 	Show event group information together
 
+--percent-type::
+	Set annotation percent type from following choices:
+	  global-period, local-period, global-hits, local-hits
+
+	The local/global keywords set if the percentage is computed
+	in the scope of the function (local) or the whole data (global).
+	The period/hits keywords set the base the percentage is computed
+	on - the samples period or the number of samples (hits).
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1]
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 8180319285af..830481b8db26 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -542,6 +542,10 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_CALLBACK_DEFAULT(0, "stdio-color", NULL, "mode",
 			     "'always' (default), 'never' or 'auto' only applicable to --stdio mode",
 			     stdio__config_color, "always"),
+	OPT_CALLBACK(0, "percent-type", &annotate.opts, "local-period",
+		     "Set percent type local/global-period/hits",
+		     annotate_parse_percent_type),
+
 	OPT_END()
 	};
 	int ret;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 6316fa96d984..f68636c0d95a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2799,3 +2799,56 @@ void annotation_config__init(void)
 	annotation__default_options.show_total_period = symbol_conf.show_total_period;
 	annotation__default_options.show_nr_samples   = symbol_conf.show_nr_samples;
 }
+
+static unsigned int parse_percent_type(char *str1, char *str2)
+{
+	unsigned int type = (unsigned int) -1;
+
+	if (!strcmp("period", str1)) {
+		if (!strcmp("local", str2))
+			type = PERCENT_PERIOD_LOCAL;
+		else if (!strcmp("global", str2))
+			type = PERCENT_PERIOD_GLOBAL;
+	}
+
+	if (!strcmp("hits", str1)) {
+		if (!strcmp("local", str2))
+			type = PERCENT_HITS_LOCAL;
+		else if (!strcmp("global", str2))
+			type = PERCENT_HITS_GLOBAL;
+	}
+
+	return type;
+}
+
+int
+annotate_parse_percent_type(const struct option *opt, const char *_str,
+			    int unset __maybe_unused)
+{
+	struct annotation_options *opts = opt->value;
+	unsigned int type;
+	char *str1, *str2;
+	int err = -1;
+
+	str1 = strdup(_str);
+	if (!str1)
+		return -ENOMEM;
+
+	str2 = strchr(str1, '-');
+	if (!str2)
+		goto out;
+
+	*str2++ = 0;
+
+	type = parse_percent_type(str1, str2);
+	if (type == (unsigned int) -1)
+		type = parse_percent_type(str2, str1);
+	if (type != (unsigned int) -1) {
+		opts->percent_type = type;
+		err = 0;
+	}
+
+out:
+	free(str1);
+	return err;
+}
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 760a6678edff..c7337f0a1823 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -397,4 +397,7 @@ static inline int symbol__tui_annotate(struct symbol *sym __maybe_unused,
 
 void annotation_config__init(void);
 
+int
+annotate_parse_percent_type(const struct option *opt, const char *_str,
+			    int unset);
 #endif	/* __PERF_ANNOTATE_H */
-- 
2.17.1

