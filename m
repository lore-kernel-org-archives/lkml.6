Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbeBQLfs (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:35:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40705 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbeBQLfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:35:47 -0500
Date: Sat, 17 Feb 2018 03:24:27 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-c53b4bb02b45ceec7a590e47820afbb5cef0bb81@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, jolsa@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com, acme@redhat.com,
        peterz@infradead.org, namhyung@kernel.org
Reply-To: linux-kernel@vger.kernel.org, jolsa@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com, acme@redhat.com,
        peterz@infradead.org, namhyung@kernel.org
In-Reply-To: <20180215122635.24029-2-jolsa@kernel.org>
References: <20180215122635.24029-2-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib symbol: Skip non-address kallsyms line
Git-Commit-ID: c53b4bb02b45ceec7a590e47820afbb5cef0bb81
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

Commit-ID:  c53b4bb02b45ceec7a590e47820afbb5cef0bb81
Gitweb:     https://git.kernel.org/tip/c53b4bb02b45ceec7a590e47820afbb5cef0bb81
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 15 Feb 2018 13:26:27 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:25:56 -0300

tools lib symbol: Skip non-address kallsyms line

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
index 914cb8e..689b6a1 100644
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
