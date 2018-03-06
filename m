Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbeCFGuZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:50:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40363 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeCFGuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:50:24 -0500
Date: Mon, 5 Mar 2018 22:50:13 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-1d1b5632ed0b797721a409bbed718d85384168a2@git.kernel.org>
Cc: acme@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, jolsa@redhat.com, ak@linux.intel.com,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        wangnan0@huawei.com
Reply-To: namhyung@kernel.org, acme@redhat.com, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        wangnan0@huawei.com
In-Reply-To: <1519945751-37786-8-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-8-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test: Switch to new perf_mmap__read_event()
 interface for tp fields
Git-Commit-ID: 1d1b5632ed0b797721a409bbed718d85384168a2
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

Commit-ID:  1d1b5632ed0b797721a409bbed718d85384168a2
Gitweb:     https://git.kernel.org/tip/1d1b5632ed0b797721a409bbed718d85384168a2
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 1 Mar 2018 18:09:05 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 10:49:59 -0300

perf test: Switch to new perf_mmap__read_event() interface for tp fields

The perf test 'syscalls:sys_enter_openat event fields' still use the
legacy interface.

No functional change.

Committer notes:

Testing it:

  # perf test sys_enter_openat
  15: syscalls:sys_enter_openat event fields                : Ok
  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-8-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/openat-syscall-tp-fields.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 43519267b93b..620b21023f72 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -86,8 +86,14 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 
 		for (i = 0; i < evlist->nr_mmaps; i++) {
 			union perf_event *event;
+			struct perf_mmap *md;
+			u64 end, start;
 
-			while ((event = perf_evlist__mmap_read(evlist, i)) != NULL) {
+			md = &evlist->mmap[i];
+			if (perf_mmap__read_init(md, false, &start, &end) < 0)
+				continue;
+
+			while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 				const u32 type = event->header.type;
 				int tp_flags;
 				struct perf_sample sample;
@@ -95,7 +101,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 				++nr_events;
 
 				if (type != PERF_RECORD_SAMPLE) {
-					perf_evlist__mmap_consume(evlist, i);
+					perf_mmap__consume(md, false);
 					continue;
 				}
 
@@ -115,6 +121,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 
 				goto out_ok;
 			}
+			perf_mmap__read_done(md);
 		}
 
 		if (nr_events == before)
