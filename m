Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165873AbeE1OnD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161120AbeE1Kag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:30:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia Zhang <zhang.jia@linux.alibaba.com>,
        Jiri Olsa <jolsa@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, jolsa@redhat.com,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 098/329] vfs/proc/kcore, x86/mm/kcore: Fix SMAP fault when dumping vsyscall user page
Date: Mon, 28 May 2018 12:00:27 +0200
Message-Id: <20180528100250.962528905@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jia Zhang <zhang.jia@linux.alibaba.com>

[ Upstream commit 595dd46ebfc10be041a365d0a3fa99df50b6ba73 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/init_64.c |    3 +--
 fs/proc/kcore.c       |    4 ++++
 include/linux/kcore.h |    1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1014,8 +1014,7 @@ void __init mem_init(void)
 	after_bootmem = 1;
 
 	/* Register memory areas for /proc/kcore */
-	kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR,
-			 PAGE_SIZE, KCORE_OTHER);
+	kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR, PAGE_SIZE, KCORE_USER);
 
 	mem_init_print_info(NULL);
 }
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -505,6 +505,10 @@ read_kcore(struct file *file, char __use
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
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -9,6 +9,7 @@ enum kcore_type {
 	KCORE_VMALLOC,
 	KCORE_RAM,
 	KCORE_VMEMMAP,
+	KCORE_USER,
 	KCORE_OTHER,
 };
 
