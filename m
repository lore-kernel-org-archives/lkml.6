Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeDFRFO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:05:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40483 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbeDFRFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:05:12 -0400
Date: Fri, 6 Apr 2018 10:04:59 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-i41tqh17c2dabnyzjh99r1oz@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        yao.jin@linux.intel.com, hpa@zytor.com, ak@linux.intel.com,
        acme@redhat.com, mingo@kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, namhyung@kernel.org, adrian.hunter@intel.com,
        dsahern@gmail.com
Reply-To: namhyung@kernel.org, acme@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, dsahern@gmail.com,
        adrian.hunter@intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com, hpa@zytor.com,
        ak@linux.intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Show group details on the title
 line
Git-Commit-ID: c0459a092509f9c2ff91cc070cd2645d38e7cf7b
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

Commit-ID:  c0459a092509f9c2ff91cc070cd2645d38e7cf7b
Gitweb:     https://git.kernel.org/tip/c0459a092509f9c2ff91cc070cd2645d38e7cf7b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 5 Apr 2018 11:13:24 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 5 Apr 2018 11:18:39 -0300

perf annotate: Show group details on the title line

To match what is shown in the main 'perf report/top' title lines, i.e.
if a group is being shown, either a real group (recorded with "-e
'{a,b,c}') or a forced group (using 'perf report --group' for a
perf.data file recorded without {}) we will show multiple columns,
one per event, but we were failing to show the group details, so, for:

 # perf report --header-only | grep cmdline
 # cmdline : /home/acme/bin/perf record -e {cycles,instructions,cache-misses}
 # perf report --group

The first line was showing just "cycles", now it shows the correct line,
which is:

  Samples: 578  of events 'anon group { cycles, instructions, cache-misses }', 4000 Hz, Event count (approx.): 487421794
  syscall_return_via_sysret  /lib/modules/4.16.0-rc7/build/vmlinux
    0.22   2.97   0.00 │    ↓ jmp    6c
                       │      mov    %cr3,%rdi
    1.33  10.89   4.00 │    ↓ jmp    62
                       │      mov    %rdi,%rax
<SNIP>

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 6920e2854e9a ("perf annotate browser: Show extra title line with event information")
Link: https://lkml.kernel.org/n/tip-i41tqh17c2dabnyzjh99r1oz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index fffe16af9797..fbad8dfbb186 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2600,7 +2600,7 @@ int __annotation__scnprintf_samples_period(struct annotation *notes,
 					   bool show_freq)
 {
 	const char *ev_name = perf_evsel__name(evsel);
-	char ref[30] = " show reference callgraph, ";
+	char buf[1024], ref[30] = " show reference callgraph, ";
 	char sample_freq_str[64] = "";
 	unsigned long nr_samples = 0;
 	int nr_members = 1;
@@ -2609,8 +2609,11 @@ int __annotation__scnprintf_samples_period(struct annotation *notes,
 	char unit;
 	int i;
 
-	if (perf_evsel__is_group_event(evsel))
+	if (perf_evsel__is_group_event(evsel)) {
+		perf_evsel__group_desc(evsel, buf, sizeof(buf));
+		ev_name = buf;
                 nr_members = evsel->nr_members;
+	}
 
 	for (i = 0; i < nr_members; i++) {
 		struct sym_hist *ah = annotation__histogram(notes, evsel->idx + i);
