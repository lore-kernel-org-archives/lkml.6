Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752423AbeFERvb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752369AbeFERv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:51:26 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 15/46] perf tools: Ditch the symbol_conf.nr_events global
Date: Tue,  5 Jun 2018 14:49:59 -0300
Message-Id: <20180605175030.32549-16-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since over time the places where we need to pass this got reduced
because we can obtain it from evsel->evlist->nr_entries, no need to have
this global anymore.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ovhikrfj8pzdv93yq3gt6sei@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kvm.c | 2 --
 tools/perf/builtin-top.c | 2 --
 tools/perf/util/header.c | 4 ----
 tools/perf/util/symbol.h | 1 -
 4 files changed, 9 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 72e2ca096bf5..2b1ef704169f 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1438,8 +1438,6 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 		goto out;
 	}
 
-	symbol_conf.nr_events = kvm->evlist->nr_entries;
-
 	if (perf_evlist__create_maps(kvm->evlist, &kvm->opts.target) < 0)
 		usage_with_options(live_usage, live_options);
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 04fe04885e99..4284840022a3 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1462,8 +1462,6 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
-	symbol_conf.nr_events = top.evlist->nr_entries;
-
 	if (top.delay_secs < 1)
 		top.delay_secs = 1;
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a8bff2178fbc..2625cc38a0d6 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3312,8 +3312,6 @@ int perf_session__read_header(struct perf_session *session)
 		lseek(fd, tmp, SEEK_SET);
 	}
 
-	symbol_conf.nr_events = nr_attrs;
-
 	perf_header__process_sections(header, fd, &session->tevent,
 				      perf_file_section__process);
 
@@ -3739,8 +3737,6 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 		perf_evlist__id_add(evlist, evsel, 0, i, event->attr.id[i]);
 	}
 
-	symbol_conf.nr_events = evlist->nr_entries;
-
 	return 0;
 }
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 1a16438eb3ce..1be9a6bad967 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -90,7 +90,6 @@ struct intlist;
 
 struct symbol_conf {
 	unsigned short	priv_size;
-	unsigned short	nr_events;
 	bool		try_vmlinux_path,
 			init_annotation,
 			force,
-- 
2.14.3
