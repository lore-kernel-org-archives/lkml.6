Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932636AbeDWVw4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:52:56 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:41145 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932318AbeDWVww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:52:52 -0400
X-Google-Smtp-Source: AIpwx4/y3ANWdk2dmccLiakxLYR8xbAsW5L1EAkOleYHbpzeb8SdVJ97yXhKnqMsRrPgZ3PMrgmKhA==
Date: Tue, 24 Apr 2018 00:52:48 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc: use "unsigned int" for /proc/*/stack
Message-ID: <20180423215248.GG9043@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct stack_trace::nr_entries is defined as "unsigned int" (YAY!)
so the iterator should be unsigned as well.

It saves 1 byte of code or something like that.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -430,7 +430,6 @@ static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
 	struct stack_trace trace;
 	unsigned long *entries;
 	int err;
-	int i;
 
 	entries = kmalloc(MAX_STACK_TRACE_DEPTH * sizeof(*entries), GFP_KERNEL);
 	if (!entries)
@@ -443,6 +442,8 @@ static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
 
 	err = lock_trace(task);
 	if (!err) {
+		unsigned int i;
+
 		save_stack_trace_tsk(task, &trace);
 
 		for (i = 0; i < trace.nr_entries; i++) {
