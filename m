Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeBFSYf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:24:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752488AbeBFSY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:24:26 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 06/17] tools lib symbol: Skip non-address kallsyms line
Date: Tue,  6 Feb 2018 19:18:02 +0100
Message-Id: <20180206181813.10943-7-jolsa@kernel.org>
In-Reply-To: <20180206181813.10943-1-jolsa@kernel.org>
References: <20180206181813.10943-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding check on failed attempt to parse the address
and skip the line parsing early in that case.

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
