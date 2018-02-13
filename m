Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933979AbeBMJJv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:09:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58365 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934019AbeBMJIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:08:30 -0500
Date: Tue, 13 Feb 2018 01:08:09 -0800
From: tip-bot for Jia Zhang <tipbot@zytor.com>
Message-ID: <tip-cd026ca2861e7f384d677626a483da797c76b9da@git.kernel.org>
Cc: jolsa@kernel.org, mingo@kernel.org, hpa@zytor.com,
        zhang.jia@linux.alibaba.com, peterz@infradead.org, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Reply-To: tglx@linutronix.de, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, mingo@kernel.org, hpa@zytor.com,
        zhang.jia@linux.alibaba.com, peterz@infradead.org
In-Reply-To: <1518446694-21124-3-git-send-email-zhang.jia@linux.alibaba.com>
References: <1518446694-21124-3-git-send-email-zhang.jia@linux.alibaba.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm/kcore: Add vsyscall page to /proc/kcore
 conditionally
Git-Commit-ID: cd026ca2861e7f384d677626a483da797c76b9da
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

Commit-ID:  cd026ca2861e7f384d677626a483da797c76b9da
Gitweb:     https://git.kernel.org/tip/cd026ca2861e7f384d677626a483da797c76b9da
Author:     Jia Zhang <zhang.jia@linux.alibaba.com>
AuthorDate: Mon, 12 Feb 2018 22:44:54 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 09:15:59 +0100

x86/mm/kcore: Add vsyscall page to /proc/kcore conditionally

The vsyscall page should be visible only if vsyscall=emulate/native when dumping /proc/kcore.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: jolsa@redhat.com
Link: http://lkml.kernel.org/r/1518446694-21124-3-git-send-email-zhang.jia@linux.alibaba.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/init_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 6aa33d1..8ba9c31 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1193,7 +1193,8 @@ void __init mem_init(void)
 	register_page_bootmem_info();
 
 	/* Register memory areas for /proc/kcore */
-	kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR, PAGE_SIZE, KCORE_USER);
+	if (get_gate_vma(&init_mm))
+		kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR, PAGE_SIZE, KCORE_USER);
 
 	mem_init_print_info(NULL);
 }
