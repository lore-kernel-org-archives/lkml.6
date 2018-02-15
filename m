Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968115AbeBOM3i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:29:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968002AbeBOM0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:26:46 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 5/9] perf tools: Generalize machine__set_kernel_mmap function
Date: Thu, 15 Feb 2018 13:26:31 +0100
Message-Id: <20180215122635.24029-6-jolsa@kernel.org>
In-Reply-To: <20180215122635.24029-1-jolsa@kernel.org>
References: <20180215122635.24029-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So it could be called without event object, just with start
and end values. It will be used in following patch.

Link: http://lkml.kernel.org/n/tip-u4hu7m5fmwwsscy6ki70hhq6@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b1f1961b13f4..292e70c774bd 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1262,15 +1262,15 @@ int machine__create_kernel_maps(struct machine *machine)
 	return 0;
 }
 
-static void machine__set_kernel_mmap_len(struct machine *machine,
-					 union perf_event *event)
+static void machine__set_kernel_mmap(struct machine *machine,
+				     u64 start, u64 end)
 {
 	int i;
 
 	for (i = 0; i < MAP__NR_TYPES; i++) {
-		machine->vmlinux_maps[i]->start = event->mmap.start;
-		machine->vmlinux_maps[i]->end   = (event->mmap.start +
-						   event->mmap.len);
+		machine->vmlinux_maps[i]->start = start;
+		machine->vmlinux_maps[i]->end   = end;
+
 		/*
 		 * Be a bit paranoid here, some perf.data file came with
 		 * a zero sized synthesized MMAP event for the kernel.
@@ -1375,7 +1375,8 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		if (strstr(kernel->long_name, "vmlinux"))
 			dso__set_short_name(kernel, "[kernel.vmlinux]", false);
 
-		machine__set_kernel_mmap_len(machine, event);
+		machine__set_kernel_mmap(machine, event->mmap.start,
+					 event->mmap.start + event->mmap.len);
 
 		/*
 		 * Avoid using a zero address (kptr_restrict) for the ref reloc
-- 
2.13.6
