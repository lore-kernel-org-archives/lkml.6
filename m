Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753396AbeCXUEq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753349AbeCXUEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:04:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E8721841
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
Subject: [PATCH 33/44] perf annotate: Add function header to --stdio2
Date: Sat, 24 Mar 2018 17:02:00 -0300
Message-Id: <20180324200211.21326-34-acme@kernel.org>
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
-- 
2.14.3
