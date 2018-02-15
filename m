Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968149AbeBOMaR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:30:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967921AbeBOM0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:26:40 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 1/9] tools lib symbol: Skip non-address kallsyms line
Date: Thu, 15 Feb 2018 13:26:27 +0100
Message-Id: <20180215122635.24029-2-jolsa@kernel.org>
In-Reply-To: <20180215122635.24029-1-jolsa@kernel.org>
References: <20180215122635.24029-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding check on failed attempt to parse the address
and skip the line parsing early in that case.

The address can be replaced with '(null)' string in
case user don't have enough permissions, like:

  $ cat /proc/kallsyms
      (null) A irq_stack_union
      (null) A __per_cpu_start
      ...

Link: http://lkml.kernel.org/n/tip-djqwni3p6lgctf6o7xhhwpmw@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.13.6
