Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751608AbeA3GnX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 01:43:23 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:46890 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751510AbeA3GnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 01:43:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0SxLwH-Q_1517294580;
From: Jia Zhang <zhang.jia@linux.alibaba.com>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: [PATCH 1/2] /proc/kcore: Fix SMAP violation when dumping vsyscall user page
Date: Tue, 30 Jan 2018 14:42:58 +0800
Message-Id: <1517294579-117473-1-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit df04abfd181a
("fs/proc/kcore.c: Add bounce buffer for ktext data") introduces a
bounce buffer to work around CONFIG_HARDENED_USERCOPY=y. However,
accessing vsyscall user page will cause SMAP violation in this way.

In order to fix this issue, simply replace memcpy() with copy_from_user()
may work, but using a common way to handle this sort of user page may be
useful for future.

Currently, only vsyscall page requires KCORE_USER.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 arch/x86/mm/init_64.c | 2 +-
 fs/proc/kcore.c       | 4 ++++
 include/linux/kcore.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 4a83728..dab78f6 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1187,7 +1187,7 @@ void __init mem_init(void)
 
 	/* Register memory areas for /proc/kcore */
 	kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR,
-			 PAGE_SIZE, KCORE_OTHER);
+		   PAGE_SIZE, KCORE_USER);
 
 	mem_init_print_info(NULL);
 }
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 4bc85cb..e4b0204 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -510,6 +510,10 @@ static void elf_kcore_store_hdr(char *bufp, int nphdr, int dataoff)
 			/* we have to zero-fill user buffer even if no read */
 			if (copy_to_user(buffer, buf, tsz))
 				return -EFAULT;
+		} else if (m->type == KCORE_USER) {
+			/* user page is handled prior to normal kernel page */
+			if (copy_to_user(buffer, (char *)start, tsz))
+				return -EFAULT;
 		} else {
 			if (kern_addr_valid(start)) {
 				unsigned long n;
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
 
-- 
1.8.3.1
