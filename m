Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD3CC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8292173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547089009;
	bh=YtrS9Eu6vSLzd1eZiv2zYRFV5MTPlYIgS5GA9OxPs3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uZytyNlxqhYfdhjz3bM8FYwXK42plV5Gk2CKYaN72Q1PUq9yPBPcnFkT21tRP/ojF
	 qCHjU+x16PulCmD2RPCM4AtVFOTOaj8z7MogR320vg0IFbmCYObAKtEjzLhZ62VsIV
	 4owWdhsCNuR5V6o55k0aQ/pfQm2chpu4+yAyPhjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfAJC4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:38908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfAJC4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 21:56:48 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FB6D20665;
        Thu, 10 Jan 2019 02:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547089007;
        bh=YtrS9Eu6vSLzd1eZiv2zYRFV5MTPlYIgS5GA9OxPs3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nn3aa2A05OkuoAcTE1usSj+FsLq3Sg9kaFG2XzC2bRyiRy2cqPlkp9LxNFbBQLcoh
         Q7c48u/8v0/f7n8Y19Dnv/q4W+hQq30tliqqwgYyvTB8k3Z/fiFiq20A1l/dJQpgJu
         zT5PVyeyQ7+dzVcIMaYNryuWEpvq7z15A0ho8gUA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: [PATCH 5/9] kprobes: Search non-suffixed symbol in blacklist
Date:   Thu, 10 Jan 2019 11:56:24 +0900
Message-Id: <154708898461.6325.17046972809561067053.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154708884117.6325.4454464467156828009.stgit@devbox>
References: <154708884117.6325.4454464467156828009.stgit@devbox>
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
 

