Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbeCYWW1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:22:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33701 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeCYWWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:22:23 -0400
Date: Sun, 25 Mar 2018 15:22:12 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-i86yfyzl8m194ioxgj1jo32f@git.kernel.org>
Cc: acme@redhat.com, yao.jin@linux.intel.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, mingo@kernel.org,
        tglx@linutronix.de, dsahern@gmail.com, hpa@zytor.com
Reply-To: hpa@zytor.com, dsahern@gmail.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        adrian.hunter@intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com, ak@linux.intel.com,
        acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Add function header to --stdio2
Git-Commit-ID: 864298f224f20fb7b981b05dd0f77315c75eb189
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

Commit-ID:  864298f224f20fb7b981b05dd0f77315c75eb189
Gitweb:     https://git.kernel.org/tip/864298f224f20fb7b981b05dd0f77315c75eb189
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 16 Mar 2018 15:17:23 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Mar 2018 12:53:41 -0300

perf annotate: Add function header to --stdio2

  # perf annotate --stdio2 _raw_spin_lock_irqsave
  _raw_spin_lock_irqsave() /lib/modules/4.16.0-rc4/build/vmlinux
  Event: anon group { cycles, instructions }

    0.00   3.17      → callq  __fentry__
    0.00   7.94        push   %rbx
    7.69  36.51      → callq  __page_file_index
                       mov    %rax,%rbx
    7.69   3.17      → callq  *ffffffff82225cd0
                       xor    %eax,%eax
                       mov    $0x1,%edx
   80.77  49.21        lock   cmpxchg %edx,(%rdi)
                       test   %eax,%eax
                     ↓ jne    2b
    3.85   0.00        mov    %rbx,%rax
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
Link: https://lkml.kernel.org/n/tip-i86yfyzl8m194ioxgj1jo32f@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ea83b9754ab0..7a6a85f9fea6 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2244,6 +2244,8 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 	struct dso *dso = map->dso;
 	struct rb_root source_line = RB_ROOT;
 	struct annotation_options opts = annotation__default_options;
+	const char *ev_name = perf_evsel__name(evsel);
+	char buf[1024];
 
 	if (symbol__annotate2(sym, map, evsel, &opts, NULL) < 0)
 		return -1;
@@ -2254,6 +2256,12 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 		print_summary(&source_line, dso->long_name);
 	}
 
+	if (perf_evsel__is_group_event(evsel)) {
+		perf_evsel__group_desc(evsel, buf, sizeof(buf));
+		ev_name = buf;
+	}
+
+	fprintf(stdout, "%s() %s\nEvent: %s\n\n", sym->name, dso->long_name, ev_name);
 	symbol__annotate_fprintf2(sym, stdout);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
