Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754287AbeEaJoB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:44:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:4520 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754092AbeEaJn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:43:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="45654468"
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v1]: perf record: enable arbitrary event names thru name=
 modifier
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Message-ID: <ca21ebcd-3119-a75e-aff3-3684ebc61a68@linux.intel.com>
Date: Thu, 31 May 2018 12:43:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Enable complex event names containing [.:=,] symbols to be encoded into Perf 
trace using name= modifier e.g. like this:

perf record -e cpu/name=\'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM\',\
		period=0x3567e0,event=0x3c,cmask=0x1/Duk ./futex

Below is how it looks like in the report output. Please note explicit escaped 
quoting at cmdline string in the header so that thestring can be directly reused
for another collection in shell:

perf report --header

# ========
...
# cmdline : /root/abudanko/kernel/tip/tools/perf/perf record -v -e cpu/name=\'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM\',period=0x3567e0,event=0x3c,cmask=0x1/Duk ./futex 
# event : name = OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM, , type = 4, size = 112, config = 0x100003c, { sample_period, sample_freq } = 3500000, sample_type = IP|TID|TIME, disabled = 1, inh
...
# ========
#
#
# Total Lost Samples: 0
#
# Samples: 24K of event 'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM'
# Event count (approx.): 86492000000
#
# Overhead  Command  Shared Object     Symbol                                        
# ........  .......  ................  ..............................................
#
    14.75%  futex    [kernel.vmlinux]  [k] __entry_trampoline_start
...

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/header.c       | 19 +++++++++++++++++--
 tools/perf/util/parse-events.l |  8 +++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a8bff2178fbc..e78700385a24 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1459,8 +1459,23 @@ static void print_cmdline(struct feat_fd *ff, FILE *fp)
 
 	fprintf(fp, "# cmdline : ");
 
-	for (i = 0; i < nr; i++)
-		fprintf(fp, "%s ", ff->ph->env.cmdline_argv[i]);
+	for (i = 0; i < nr; i++) {
+		char *argv_i = strdup(ff->ph->env.cmdline_argv[i]);
+		if (!argv_i) {
+			fprintf(fp, "%s ", ff->ph->env.cmdline_argv[i]);
+		} else {
+			char *mem = argv_i;
+			do {
+				char *quote = strchr(argv_i, '\'');
+				if (!quote) break;
+				*quote++ = '\0';
+				fprintf(fp, "%s\\\'", argv_i);
+				argv_i = quote;
+			} while (1);
+			fprintf(fp, "%s ", argv_i);
+			free(mem);
+		}
+	}
 	fputc('\n', fp);
 }
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index a1a01b1ac8b8..26c28faa0f62 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -53,7 +53,11 @@ static int str(yyscan_t scanner, int token)
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
 	char *text = parse_events_get_text(scanner);
 
-	yylval->str = strdup(text);
+	if (text[0] != '\'')
+		yylval->str = strdup(text);
+	 else
+		yylval->str = strndup(&text[1], strlen(text) - 2);
+
 	return token;
 }
 
@@ -176,6 +180,7 @@ num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]+
 num_raw_hex	[a-fA-F0-9]+
 name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]]*
+name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /* If you add a modifier you need to update check_modifier() */
@@ -344,6 +349,7 @@ r{num_raw_hex}		{ return raw(yyscanner); }
 {bpf_object}		{ if (!isbpf(yyscanner)) { USER_REJECT }; return str(yyscanner, PE_BPF_OBJECT); }
 {bpf_source}		{ if (!isbpf(yyscanner)) { USER_REJECT }; return str(yyscanner, PE_BPF_SOURCE); }
 {name}			{ return pmu_str_check(yyscanner); }
+{name_tag}		{ return str(yyscanner, PE_NAME); }
 "/"			{ BEGIN(config); return '/'; }
 -			{ return '-'; }
 ,			{ BEGIN(event); return ','; }
