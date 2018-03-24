Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeCXUE6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752748AbeCXUEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:04:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F382183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 36/44] perf annotate browser: Add 'P' hotkey to dump annotation to file
Date: Sat, 24 Mar 2018 17:02:03 -0300
Message-Id: <20180324200211.21326-37-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just like we have in the histograms browser used as the main screen for
'perf top --tui' and 'perf report --tui', to print the current
annotation to a file with a named composed by the symbol name and the
".annotation" suffix.

Here is one example of pressing 'A' on 'perf top' to live annotate a
kernel function and then press 'P' to dump that annotation, the
resulting file:

  # cat _raw_spin_lock_irqsave.annotation
  _raw_spin_lock_irqsave() /proc/kcore
  Event: cycles:ppp

    7.14        nop
   21.43        push   %rbx
    7.14        pushfq
                pop    %rax
                nop
                mov    %rax,%rbx
                cli
                nop
                xor    %eax,%eax
                mov    $0x1,%edx
   64.29        lock   cmpxchg %edx,(%rdi)
                test   %eax,%eax
              ↓ jne    2b
                mov    %rbx,%rax
                pop    %rbx
              ← retq
          2b:   mov    %eax,%esi
              → callq  queued_spin_lock_slowpath
                mov    %rbx,%rax
                pop    %rbx
              ← retq
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zzmnrwugb5vtk7bvg0rbx150@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c |  4 ++++
 tools/perf/util/annotate.c        | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h        |  2 ++
 3 files changed, 37 insertions(+)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 916f237c1df8..3834b264ba41 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -661,6 +661,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"t             Circulate percent, total period, samples view\n"
 		"/             Search string\n"
 		"k             Toggle line numbers\n"
+		"P             Print to [symbol_name].annotation file.\n"
 		"r             Run available scripts\n"
 		"?             Search string backwards\n");
 			continue;
@@ -737,6 +738,9 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			}
 			continue;
 		}
+		case 'P':
+			map_symbol__annotation_dump(ms, evsel);
+			continue;
 		case 't':
 			if (notes->options->show_total_period) {
 				notes->options->show_total_period = false;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 7a6a85f9fea6..a7111871440e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2037,6 +2037,37 @@ int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
 	return 0;
 }
 
+int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel)
+{
+	const char *ev_name = perf_evsel__name(evsel);
+	char buf[1024];
+	char *filename;
+	int err = -1;
+	FILE *fp;
+
+	if (asprintf(&filename, "%s.annotation", ms->sym->name) < 0)
+		return -1;
+
+	fp = fopen(filename, "w");
+	if (fp == NULL)
+		goto out_free_filename;
+
+	if (perf_evsel__is_group_event(evsel)) {
+		perf_evsel__group_desc(evsel, buf, sizeof(buf));
+		ev_name = buf;
+	}
+
+	fprintf(fp, "%s() %s\nEvent: %s\n\n",
+		ms->sym->name, ms->map->dso->long_name, ev_name);
+	symbol__annotate_fprintf2(ms->sym, fp);
+
+	fclose(fp);
+	err = 0;
+out_free_filename:
+	free(filename);
+	return err;
+}
+
 void symbol__annotate_zero_histogram(struct symbol *sym, int evidx)
 {
 	struct annotation *notes = symbol__annotation(sym);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 3faa58045b22..365e9df888cf 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -288,6 +288,8 @@ void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
 void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
 void annotated_source__purge(struct annotated_source *as);
 
+int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel);
+
 bool ui__has_annotation(void);
 
 int symbol__tty_annotate(struct symbol *sym, struct map *map,
-- 
2.14.3
