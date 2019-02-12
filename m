Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C38C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A89217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549988017;
	bh=6jnmvEU0+6T1UAxD7pf7iAk01qe90EQAG6XlZSBrsnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UwdPhfrAyUs5PQVBaB0YtxKONsqRcO+h8y3WI3M8tsYg9QrpEi96P/7AZ5JSi0Lqw
	 6dBPeVbLg9daQsT19jFqjObywohc9TUMMyhP6KcEBjUiZ2V0MlQgmZn2tzYChTyQxi
	 q9biUlmWwj+069bJQ2Fb6i991bOI25SCjQYq4LlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbfBLQNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:13:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbfBLQNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:13:36 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56B3621773;
        Tue, 12 Feb 2019 16:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549988015;
        bh=6jnmvEU0+6T1UAxD7pf7iAk01qe90EQAG6XlZSBrsnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eHyQBYvW0/UsVua55sSqU/qjmkdYNDSTRR4fT17DEYVPlzHDfMQR0ZIR0cLuTxQss
         5vI860jeahTuYX5UMvKJo3V28oPVtsB/cLimVGY/k4RXcR8VhtljqHgx3XZhx4OedX
         YPzsNC3qKHrQMQoDkRyuofYsYjAfSQBBYc1Fr1Q8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -tip v3 05/10] kprobes: Search non-suffixed symbol in blacklist
Date:   Wed, 13 Feb 2019 01:13:12 +0900
Message-Id: <154998799234.31052.6136378903570418008.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154998785011.31052.1475728497912659748.stgit@devbox>
References: <154998785011.31052.1475728497912659748.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer gcc can generate some different instances of a function
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
---
 kernel/kprobes.c |   21 ++++++++++++++++++++-
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
 

