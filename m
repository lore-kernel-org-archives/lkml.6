Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934017AbeBMJI0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:08:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34045 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933897AbeBMJIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:08:05 -0500
Date: Tue, 13 Feb 2018 01:07:42 -0800
From: tip-bot for Jia Zhang <tipbot@zytor.com>
Message-ID: <tip-595dd46ebfc10be041a365d0a3fa99df50b6ba73@git.kernel.org>
Cc: torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, mingo@kernel.org,
        zhang.jia@linux.alibaba.com, tglx@linutronix.de, peterz@infradead.org,
        viro@zeniv.linux.org.uk
Reply-To: peterz@infradead.org, viro@zeniv.linux.org.uk, tglx@linutronix.de,
        zhang.jia@linux.alibaba.com, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        torvalds@linux-foundation.org
In-Reply-To: <1518446694-21124-2-git-send-email-zhang.jia@linux.alibaba.com>
References: <1518446694-21124-2-git-send-email-zhang.jia@linux.alibaba.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] vfs/proc/kcore, x86/mm/kcore: Fix SMAP fault when
 dumping vsyscall user page
Git-Commit-ID: 595dd46ebfc10be041a365d0a3fa99df50b6ba73
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

Commit-ID:  595dd46ebfc10be041a365d0a3fa99df50b6ba73
Gitweb:     https://git.kernel.org/tip/595dd46ebfc10be041a365d0a3fa99df50b6ba73
Author:     Jia Zhang <zhang.jia@linux.alibaba.com>
AuthorDate: Mon, 12 Feb 2018 22:44:53 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 09:15:58 +0100

vfs/proc/kcore, x86/mm/kcore: Fix SMAP fault when dumping vsyscall user page

Commit:

  df04abfd181a ("fs/proc/kcore.c: Add bounce buffer for ktext data")

... introduced a bounce buffer to work around CONFIG_HARDENED_USERCOPY=y.
However, accessing the vsyscall user page will cause an SMAP fault.

Replace memcpy() with copy_from_user() to fix this bug works, but adding
a common way to handle this sort of user page may be useful for future.

Currently, only vsyscall page requires KCORE_USER.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: jolsa@redhat.com
Link: http://lkml.kernel.org/r/1518446694-21124-2-git-send-email-zhang.jia@linux.alibaba.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/init_64.c | 3 +--
 fs/proc/kcore.c       | 4 ++++
 include/linux/kcore.h | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 1ab42c8..6aa33d1 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1193,8 +1193,7 @@ void __init mem_init(void)
 	register_page_bootmem_info();
 
 	/* Register memory areas for /proc/kcore */
-	kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR,
-			 PAGE_SIZE, KCORE_OTHER);
+	kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR, PAGE_SIZE, KCORE_USER);
 
 	mem_init_print_info(NULL);
 }
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index e8a93bc..d1e8276 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -510,6 +510,10 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 			/* we have to zero-fill user buffer even if no read */
 			if (copy_to_user(buffer, buf, tsz))
 				return -EFAULT;
+		} else if (m->type == KCORE_USER) {
+			/* User page is handled prior to normal kernel page: */
+			if (copy_to_user(buffer, (char *)start, tsz))
+				return -EFAULT;
 		} else {
 			if (kern_addr_valid(start)) {
 				/*
diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index 7ff25a8..80db19d 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -10,6 +10,7 @@ enum kcore_type {
 	KCORE_VMALLOC,
 	KCORE_RAM,
 	KCORE_VMEMMAP,
+	KCORE_USER,
 	KCORE_OTHER,
 };
 
