Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752932AbeC2N6i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:58:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33893 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752899AbeC2N6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:58:37 -0400
Date: Thu, 29 Mar 2018 06:58:26 -0700
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-f58385f629c87a9e210108b39c1f4950d0363ad2@git.kernel.org>
Cc: jolsa@kernel.org, kan.liang@linux.intel.com, tglx@linutronix.de,
        acme@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com, namhyung@kernel.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, wangnan0@huawei.com, mingo@kernel.org,
        namhyung@kernel.org, jolsa@kernel.org, acme@redhat.com,
        tglx@linutronix.de, kan.liang@linux.intel.com, hpa@zytor.com
In-Reply-To: <1522071729-16776-1-git-send-email-kan.liang@linux.intel.com>
References: <1522071729-16776-1-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf mmap: Fix accessing unmapped mmap in
 perf_mmap__read_done()
Git-Commit-ID: f58385f629c87a9e210108b39c1f4950d0363ad2
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

Commit-ID:  f58385f629c87a9e210108b39c1f4950d0363ad2
Gitweb:     https://git.kernel.org/tip/f58385f629c87a9e210108b39c1f4950d0363ad2
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 26 Mar 2018 09:42:09 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 27 Mar 2018 13:13:38 -0300

perf mmap: Fix accessing unmapped mmap in perf_mmap__read_done()

There is a segmentation fault when running 'perf trace'. For example:

  [root@jouet e]# perf trace -e *chdir -o /tmp/bla perf report --ignore-vmlinux -i ../perf.data

The perf_mmap__consume() could unmap the mmap. It needs to check the
refcnt in perf_mmap__read_done().

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: ee023de05f35 ("perf mmap: Introduce perf_mmap__read_done()")
Link: http://lkml.kernel.org/r/1522071729-16776-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 38ca3ffb9d61..f6cfc52ff1fe 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -317,5 +317,11 @@ out:
  */
 void perf_mmap__read_done(struct perf_mmap *map)
 {
+	/*
+	 * Check if event was unmapped due to a POLLHUP/POLLERR.
+	 */
+	if (!refcount_read(&map->refcnt))
+		return;
+
 	map->prev = perf_mmap__read_head(map);
 }
