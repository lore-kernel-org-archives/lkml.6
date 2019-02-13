Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BE1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205A0222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391131AbfBMJCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:02:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52097 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731952AbfBMJCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:02:01 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1D91O3N196166
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 01:01:24 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1D91Oo6196163;
        Wed, 13 Feb 2019 01:01:24 -0800
Date:   Wed, 13 Feb 2019 01:01:24 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-6143c6fb1e8f9bde9c434038f7548a19d36b55e7@git.kernel.org>
Cc:     mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, acme@redhat.com,
        righi.andrea@gmail.com, torvalds@linux-foundation.org,
        peterz@infradead.org, rostedt@goodmis.org, mingo@kernel.org,
        hpa@zytor.com, jolsa@redhat.com, alexander.shishkin@linux.intel.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          acme@redhat.com, mhiramat@kernel.org,
          mathieu.desnoyers@efficios.com, peterz@infradead.org,
          rostedt@goodmis.org, alexander.shishkin@linux.intel.com,
          jolsa@redhat.com, hpa@zytor.com, mingo@kernel.org,
          righi.andrea@gmail.com, torvalds@linux-foundation.org
In-Reply-To: <154998799234.31052.6136378903570418008.stgit@devbox>
References: <154998799234.31052.6136378903570418008.stgit@devbox>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] kprobes: Search non-suffixed symbol in blacklist
Git-Commit-ID: 6143c6fb1e8f9bde9c434038f7548a19d36b55e7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6143c6fb1e8f9bde9c434038f7548a19d36b55e7
Gitweb:     https://git.kernel.org/tip/6143c6fb1e8f9bde9c434038f7548a19d36b55e7
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Wed, 13 Feb 2019 01:13:12 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 13 Feb 2019 08:16:40 +0100

kprobes: Search non-suffixed symbol in blacklist

Newer GCC versions can generate some different instances of a function
with suffixed symbols if the function is optimized and only
has a part of that. (e.g. .constprop, .part etc.)

In this case, it is not enough to check the entry of kprobe
blacklist because it only records non-suffixed symbol address.

To fix this issue, search non-suffixed symbol in blacklist if
given address is within a symbol which has a suffix.

Note that this can cause false positive cases if a kprobe-safe
function is optimized to suffixed instance and has same name
symbol which is blacklisted.
But I would like to chose a fail-safe design for this issue.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrea Righi <righi.andrea@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/154998799234.31052.6136378903570418008.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/kprobes.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f4ddfdd2d07e..c83e54727131 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1396,7 +1396,7 @@ bool __weak arch_within_kprobe_blacklist(unsigned long addr)
 	       addr < (unsigned long)__kprobes_text_end;
 }
 
-bool within_kprobe_blacklist(unsigned long addr)
+static bool __within_kprobe_blacklist(unsigned long addr)
 {
 	struct kprobe_blacklist_entry *ent;
 
@@ -1410,7 +1410,26 @@ bool within_kprobe_blacklist(unsigned long addr)
 		if (addr >= ent->start_addr && addr < ent->end_addr)
 			return true;
 	}
+	return false;
+}
 
+bool within_kprobe_blacklist(unsigned long addr)
+{
+	char symname[KSYM_NAME_LEN], *p;
+
+	if (__within_kprobe_blacklist(addr))
+		return true;
+
+	/* Check if the address is on a suffixed-symbol */
+	if (!lookup_symbol_name(addr, symname)) {
+		p = strchr(symname, '.');
+		if (!p)
+			return false;
+		*p = '\0';
+		addr = (unsigned long)kprobe_lookup_name(symname, 0);
+		if (addr)
+			return __within_kprobe_blacklist(addr);
+	}
 	return false;
 }
 
