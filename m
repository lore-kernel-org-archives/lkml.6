Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbeBUKgw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:36:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56179 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933054AbeBUKgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:36:50 -0500
Date: Wed, 21 Feb 2018 02:25:42 -0800
From: tip-bot for Namhyung Kim <tipbot@zytor.com>
Message-ID: <tip-1d12cec6ce99614297e10945d917fd8a62cd2b09@git.kernel.org>
Cc: jolsa@kernel.org, hpa@zytor.com, acme@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        dsahern@gmail.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Reply-To: namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        dsahern@gmail.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
        jolsa@kernel.org
In-Reply-To: <20180219101936.GD1583@sejong>
References: <20180219101936.GD1583@sejong>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Fix paranoid check in
 machine__set_kernel_mmap()
Git-Commit-ID: 1d12cec6ce99614297e10945d917fd8a62cd2b09
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

Commit-ID:  1d12cec6ce99614297e10945d917fd8a62cd2b09
Gitweb:     https://git.kernel.org/tip/1d12cec6ce99614297e10945d917fd8a62cd2b09
Author:     Namhyung Kim <namhyung@kernel.org>
AuthorDate: Mon, 19 Feb 2018 19:00:46 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 19 Feb 2018 09:17:46 -0300

perf machine: Fix paranoid check in machine__set_kernel_mmap()

The machine__set_kernel_mmap() is to setup addresses of the kernel map
using external info.  But it has a check when the address is given from
an incorrect input which should have the start and end address of 0
(i.e. machine__process_kernel_mmap_event).

But we also use the end address of 0 for a valid input so change it to
check both start and end addresses.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20180219101936.GD1583@sejong
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index fe27ef5..12b7427 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1226,7 +1226,7 @@ static void machine__set_kernel_mmap(struct machine *machine,
 		 * Be a bit paranoid here, some perf.data file came with
 		 * a zero sized synthesized MMAP event for the kernel.
 		 */
-		if (machine->vmlinux_maps[i]->end == 0)
+		if (start == 0 && end == 0)
 			machine->vmlinux_maps[i]->end = ~0ULL;
 	}
 }
