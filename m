Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BF3C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828C32177B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547260107;
	bh=YtrS9Eu6vSLzd1eZiv2zYRFV5MTPlYIgS5GA9OxPs3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mk0OWqrAd1Z5RadKHfiSWpvT8EMBW83yfePu3CY8cilb2GHD9g0x+3Fa9fuvVtkgG
	 YKOIBjaxAv6Ru5DMOKxPPPbPExqhmHJ6ry5gcat6k5aV4rpoyUndLq4PT9KVoMyPfS
	 9fMR5IM1/iCA8tCDCpZIV4X2rXlcjvFqtTeItMvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfALC20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:28:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfALC20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 21:28:26 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4319B204FD;
        Sat, 12 Jan 2019 02:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547260105;
        bh=YtrS9Eu6vSLzd1eZiv2zYRFV5MTPlYIgS5GA9OxPs3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ebP93Dwf1++xq/hlbZMv2byQukpK6HwhrDLMdVFEBj1R66fMYzs2eJyc4SKLqtjSV
         4xWYWX0cj9QF64SyOw5jY+bh2hoaM2bmD4R0yfy5BB2s9Dh5KHb38y7wnb6O6Uw339
         ktTFYEGSQSJ3RpPSO6WxYKznaIshZTpV5IqtVEGA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 5/9] kprobes: Search non-suffixed symbol in blacklist
Date:   Sat, 12 Jan 2019 11:28:02 +0900
Message-Id: <154726008226.18060.9082091974811290044.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154725993986.18060.2759150647140353514.stgit@devbox>
References: <154725993986.18060.2759150647140353514.stgit@devbox>
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
index e8c76164f541..faa519f07aad 100644
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
 

