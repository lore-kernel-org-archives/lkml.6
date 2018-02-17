Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbeBQHT3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 02:19:29 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:43167 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeBQHT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 02:19:28 -0500
X-Google-Smtp-Source: AH8x225CHvD8vh9vXsmXh3Gz/8pM7/xF4amB3WjZijJtjvVkfr4GH+ClENnipdi67FWAnyLmOGctZA==
Date: Sat, 17 Feb 2018 10:19:24 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] proc: check permissions earlier for /proc/*/wchan
Message-ID: <20180217071923.GA16074@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_wchan() accesses stack page before permissions are checked,
let's not play this game.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -391,14 +391,17 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long wchan;
 	char symname[KSYM_NAME_LEN];
 
-	wchan = get_wchan(task);
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
+		goto print0;
 
-	if (wchan && ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)
-			&& !lookup_symbol_name(wchan, symname))
+	wchan = get_wchan(task);
+	if (wchan && !lookup_symbol_name(wchan, symname)) {
 		seq_printf(m, "%s", symname);
-	else
-		seq_putc(m, '0');
+		return 0;
+	}
 
+print0:
+	seq_putc(m, '0');
 	return 0;
 }
 #endif /* CONFIG_KALLSYMS */
