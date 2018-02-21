Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeBUBet (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 20:34:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeBUBes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 20:34:48 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEB921783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        kernel-team@lge.com, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/5] perf machine: Fix paranoid check in machine__set_kernel_mmap()
Date: Tue, 20 Feb 2018 22:34:28 -0300
Message-Id: <20180221013431.11738-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180221013431.11738-1-acme@kernel.org>
References: <20180221013431.11738-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

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
index fe27ef55cbb9..12b7427444a3 100644
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
-- 
2.14.3
