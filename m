Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751124AbeBQLgs (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:36:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38567 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeBQLgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:36:47 -0500
Date: Sat, 17 Feb 2018 03:26:25 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-05db6ff73d805ecc70947c9eee2ed9948d0be52b@git.kernel.org>
Cc: jolsa@kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
        mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org
Reply-To: namhyung@kernel.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, dsahern@gmail.com, mingo@kernel.org,
        tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <20180215122635.24029-6-jolsa@kernel.org>
References: <20180215122635.24029-6-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Generalize machine__set_kernel_mmap()
Git-Commit-ID: 05db6ff73d805ecc70947c9eee2ed9948d0be52b
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

Commit-ID:  05db6ff73d805ecc70947c9eee2ed9948d0be52b
Gitweb:     https://git.kernel.org/tip/05db6ff73d805ecc70947c9eee2ed9948d0be52b
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 15 Feb 2018 13:26:31 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:25:57 -0300

perf machine: Generalize machine__set_kernel_mmap()

So it could be called without event object, just with start and end
values. It will be used in following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180215122635.24029-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b1f1961..292e70c 100644
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
