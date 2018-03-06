Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753232AbeCFGsh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:48:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45353 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbeCFGsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:48:36 -0500
Date: Mon, 5 Mar 2018 22:48:26 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-2f54f3a4733c0cd857992d793af5e8321b281012@git.kernel.org>
Cc: ak@linux.intel.com, hpa@zytor.com, acme@redhat.com,
        kan.liang@linux.intel.com, namhyung@kernel.org, jolsa@redhat.com,
        wangnan0@huawei.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: hpa@zytor.com, ak@linux.intel.com, acme@redhat.com,
        kan.liang@linux.intel.com, namhyung@kernel.org, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com, mingo@kernel.org,
        tglx@linutronix.de
In-Reply-To: <1519945751-37786-4-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-4-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test: Switch to new perf_mmap__read_event()
 interface for bpf
Git-Commit-ID: 2f54f3a4733c0cd857992d793af5e8321b281012
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

Commit-ID:  2f54f3a4733c0cd857992d793af5e8321b281012
Gitweb:     https://git.kernel.org/tip/2f54f3a4733c0cd857992d793af5e8321b281012
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 1 Mar 2018 18:09:01 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 10:47:54 -0300

perf test: Switch to new perf_mmap__read_event() interface for bpf

The perf test 'bpf' still use the legacy interface.

No functional change.

Committer notes:

Tested with:

  # perf test bpf
  39: BPF filter                                            :
  39.1: Basic BPF filtering                                 : Ok
  39.2: BPF pinning                                         : Ok
  39.3: BPF prologue generation                             : Ok
  39.4: BPF relocation checker                              : Ok
  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-4-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bpf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index e8399beca62b..09c9c9f9e827 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -176,13 +176,20 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		union perf_event *event;
+		struct perf_mmap *md;
+		u64 end, start;
 
-		while ((event = perf_evlist__mmap_read(evlist, i)) != NULL) {
+		md = &evlist->mmap[i];
+		if (perf_mmap__read_init(md, false, &start, &end) < 0)
+			continue;
+
+		while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 			const u32 type = event->header.type;
 
 			if (type == PERF_RECORD_SAMPLE)
 				count ++;
 		}
+		perf_mmap__read_done(md);
 	}
 
 	if (count != expect) {
