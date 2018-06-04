Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeFDGvB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:51:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:13250 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbeFDGvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:51:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,475,1520924400";
   d="scan'208";a="46203986"
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v3]: perf record: enable arbitrary event names thru name=
 modifier
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Message-ID: <c194b060-761d-0d50-3b21-bb4ed680002d@linux.intel.com>
Date: Mon, 4 Jun 2018 09:50:56 +0300
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

perf stat -e cpu/name=\'CPU_CLK_UNHALTED.THREAD:cmask=0x1\',period=0x3567e0,event=0x3c,cmask=0x1/Duk ./futex

10000000 process context switches in 16678890291ns (1667.9ns/ctxsw)

 Performance counter stats for './futex':

    88,095,770,571      CPU_CLK_UNHALTED.THREAD:cmask=0x1                                   

      16.679542407 seconds time elapsed

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v3:
- updated event name syntax in perf list docs;
- added name modifier description into perf record docs;

Changes in v2:
- aligned break according to coding guidelines;
- put comment regarding expected quoting rules; 
---
 tools/perf/Documentation/perf-list.txt   |  6 +++++-
 tools/perf/Documentation/perf-record.txt |  3 +++
 tools/perf/util/header.c                 | 20 ++++++++++++++++++--
 tools/perf/util/parse-events.l           | 18 +++++++++++++++++-
 4 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 2549c34a7895..11300dbe35c5 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -124,7 +124,11 @@ The available PMUs and their raw parameters can be listed with
 For example the raw event "LSD.UOPS" core pmu event above could
 be specified as
 
-  perf stat -e cpu/event=0xa8,umask=0x1,name=LSD.UOPS_CYCLES,cmask=1/ ...
+  perf stat -e cpu/event=0xa8,umask=0x1,name=LSD.UOPS_CYCLES,cmask=0x1/ ...
+
+  or using extended name syntax
+
+  perf stat -e cpu/event=0xa8,umask=0x1,cmask=0x1,name=\'LSD.UOPS_CYCLES:cmask=0x1\'/ ...
 
 PER SOCKET PMUS
 ---------------
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index cc37b3a4be76..04168da4268e 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -57,6 +57,9 @@ OPTIONS
 			 FP mode, "dwarf" for DWARF mode, "lbr" for LBR mode and
 			 "no" for disable callgraph.
 	  - 'stack-size': user stack size for dwarf mode
+	  - 'name' : User defined event name. Single quotes (') may be used to
+		    escape symbols in the name from parsing by shell and tool
+		    like this: name=\'CPU_CLK_UNHALTED.THREAD:cmask=0x1\'.
 
           See the linkperf:perf-list[1] man page for more parameters.
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a8bff2178fbc..08176e8cb3b4 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1459,8 +1459,24 @@ static void print_cmdline(struct feat_fd *ff, FILE *fp)
 
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
+				if (!quote)
+					break;
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
index a1a01b1ac8b8..5f761f3ed0f3 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -53,7 +53,21 @@ static int str(yyscan_t scanner, int token)
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
 	char *text = parse_events_get_text(scanner);
 
-	yylval->str = strdup(text);
+	if (text[0] != '\'') {
+		yylval->str = strdup(text);
+	} else {
+		/*
+		 * If a text tag specified on the command line
+		 * contains opening single quite ' then it is
+		 * expected that the tag ends with single quote
+		 * as well, like this:
+		 *     name=\'CPU_CLK_UNHALTED.THREAD:cmask=1\'
+		 * quotes need to be escaped to bypass shell
+		 * processing.
+		 */
+		yylval->str = strndup(&text[1], strlen(text) - 2);
+	}
+
 	return token;
 }
 
@@ -176,6 +190,7 @@ num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]+
 num_raw_hex	[a-fA-F0-9]+
 name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]]*
+name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /* If you add a modifier you need to update check_modifier() */
@@ -344,6 +359,7 @@ r{num_raw_hex}		{ return raw(yyscanner); }
 {bpf_object}		{ if (!isbpf(yyscanner)) { USER_REJECT }; return str(yyscanner, PE_BPF_OBJECT); }
 {bpf_source}		{ if (!isbpf(yyscanner)) { USER_REJECT }; return str(yyscanner, PE_BPF_SOURCE); }
 {name}			{ return pmu_str_check(yyscanner); }
+{name_tag}		{ return str(yyscanner, PE_NAME); }
 "/"			{ BEGIN(config); return '/'; }
 -			{ return '-'; }
 ,			{ BEGIN(event); return ','; }
