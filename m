Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753261AbeDDFgX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:36:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50751 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeDDFgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:36:22 -0400
Date: Tue, 3 Apr 2018 22:36:10 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ujy46x7cldyhyxelyf2b9quy@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        namhyung@kernel.org, hpa@zytor.com, wangnan0@huawei.com,
        mliska@suse.cz, mingo@kernel.org, dsahern@gmail.com, acme@redhat.com,
        tglx@linutronix.de, jolsa@kernel.org
Reply-To: adrian.hunter@intel.com, namhyung@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, dsahern@gmail.com,
        tglx@linutronix.de, jolsa@kernel.org, wangnan0@huawei.com,
        mingo@kernel.org, mliska@suse.cz
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate stdio2: Print more descriptive
 event information header
Git-Commit-ID: 520d3f01ea5322edeedff4bb25a0aff07ad72d43
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  520d3f01ea5322edeedff4bb25a0aff07ad72d43
Gitweb:     https://git.kernel.org/tip/520d3f01ea5322edeedff4bb25a0aff07ad72d43
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 2 Apr 2018 16:42:01 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 3 Apr 2018 16:05:13 -0300

perf annotate stdio2: Print more descriptive event information header

To match the recently added event header information to --tui, e.g.:

  # perf annotate --ignore-vmlinux --stdio2 _raw_spin_lock_irqsave
  Samples: 128  of event 'cycles:ppp', 4000 Hz, Event count (approx.): 48617682
  _raw_spin_lock_irqsave() /proc/kcore
    0.78        nop
    7.03        push   %rbx
    3.12        pushfq
    6.25        pop    %rax
                nop
                mov    %rax,%rbx
    3.12        cli
                nop
                xor    %eax,%eax
                mov    $0x1,%edx
   79.69        lock   cmpxchg %edx,(%rdi)
                test   %eax,%eax
              ↓ jne    2b
                mov    %rbx,%rax
                pop    %rbx
              ← retq
          2b:   mov    %eax,%esi
              → callq  *ffffffffb30eaed0
                mov    %rbx,%rax
                pop    %rbx
              ← retq
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ujy46x7cldyhyxelyf2b9quy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b956bb7eabcf..fffe16af9797 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2325,7 +2325,7 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 	struct dso *dso = map->dso;
 	struct rb_root source_line = RB_ROOT;
 	struct annotation_options opts = annotation__default_options;
-	const char *ev_name = perf_evsel__name(evsel);
+	struct annotation *notes = symbol__annotation(sym);
 	char buf[1024];
 
 	if (symbol__annotate2(sym, map, evsel, &opts, NULL) < 0)
@@ -2337,12 +2337,8 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 		print_summary(&source_line, dso->long_name);
 	}
 
-	if (perf_evsel__is_group_event(evsel)) {
-		perf_evsel__group_desc(evsel, buf, sizeof(buf));
-		ev_name = buf;
-	}
-
-	fprintf(stdout, "%s() %s\nEvent: %s\n\n", sym->name, dso->long_name, ev_name);
+	annotation__scnprintf_samples_period(notes, buf, sizeof(buf), evsel);
+	fprintf(stdout, "%s\n%s() %s\n", buf, sym->name, dso->long_name);
 	symbol__annotate_fprintf2(sym, stdout);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
