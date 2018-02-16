Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750980AbeBPTjO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:39:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753455AbeBPTSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:18:41 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32B0217C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/41] tools lib symbol: Skip non-address kallsyms line
Date: Fri, 16 Feb 2018 16:17:16 -0300
Message-Id: <20180216191746.11095-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding check on failed attempt to parse the address and skip the line
parsing early in that case.

The address can be replaced with '(null)' string in case user don't have
enough permissions, like:

  $ cat /proc/kallsyms
      (null) A irq_stack_union
      (null) A __per_cpu_start
      ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180215122635.24029-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/symbol/kallsyms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
index 914cb8e3d40b..689b6a130dd7 100644
--- a/tools/lib/symbol/kallsyms.c
+++ b/tools/lib/symbol/kallsyms.c
@@ -38,6 +38,10 @@ int kallsyms__parse(const char *filename, void *arg,
 
 		len = hex2u64(line, &start);
 
+		/* Skip the line if we failed to parse the address. */
+		if (!len)
+			continue;
+
 		len++;
 		if (len + 2 >= line_len)
 			continue;
-- 
2.14.3
