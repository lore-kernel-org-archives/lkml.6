Return-Path: <blackzert@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519679659; cv=none;
        d=google.com; s=arc-20160816;
        b=G3AZQh+vWfqRWU7U8RqupH8dr7Thc2yrv4doIAmN/l/cyir4m4b7eXygkurPWQUA5q
         MajgBfHh+QdXNJ3sno+qWV0HzdLdOSGpFugV7W9ABJimSycD0FOfuC2Sikd2uMSRuh5A
         9lixFbFKCFoAcTXr7kSTYNfX6p8884Y6e/s2pwClDojaSv30xKJauHUOxVlxTWfCQSix
         aO2VVIj4RaK7aR6npwUmMe9k8qx4s/NYQDeFiG4Xk5Ue9iTi4Dt1FrRfKIUg/GEkYek4
         zROP2WRikfHVaUp62QLzeM6e8ceZUCjDcrcgN9wiCZXWLes7hhGv8uX8PMx8qYI8qTCu
         y49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=i289Kps8/WCOZz8b3MsDosmihuLz7vh+cC/s4mwF54Q=;
        b=BOEXkGysut2ieyRp/q2XPT89BdBleEUm2p2ZKOCjb4ROKYtI+4QZPljwFCRvCYfXjl
         nmzZuWGF4hjiIPZwxI49MjQpuW8Nbsc5R4J2RjM0Q/n1p2fOJ+DBy59w7c/0V4GJbnvd
         vn9B/RQglvfeZTPIiD1cA8DBCvASozvfWyb5Ikasvz5k/wXaQMzmYJJzHjydlB6c+l+c
         BW8IlFOYOMAHg0FeNoploFojaqDhQeR0BdKyj87RZIhBsMmmVtpsmjL8xEqsdqJ21Oyp
         pnuoU+iyMJedJyyO00UdFAGRxVO7PkdRp+bD8BmLvd7PoT1c1DGSvMesd6/RiycFS/w7
         oaqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eYxOgkXv;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eYxOgkXv;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtAGvo+0WJlDAbR8LYCOPjEL9nGvpT1/dz/MMQ2K2zElroLxwhXqzo7vppqwBsNmV9C8mq0kw==
From: Ilya Smith <blackzert@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	x86@kernel.org,
	kirill.shutemov@linux.intel.com,
	dsafonov@virtuozzo.com,
	mhocko@suse.com,
	hughd@google.com,
	gregkh@linuxfoundation.org,
	craigb@google.com,
	oleg@redhat.com,
	linux-kernel@vger.kernel.org
Cc: Ilya Smith <blackzert@gmail.com>
Subject: [RFC PATCH] Take mmap_min_addr into account while choosing unmapped address for x86-64.
Date: Tue, 27 Feb 2018 00:12:57 +0300
Message-Id: <20180226211257.63067-1-blackzert@gmail.com>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593499619093217840?=
X-GMAIL-MSGID: =?utf-8?q?1593499619093217840?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It prevent situation when vm_unmapped_area chose address between
PAGE_SIZE and mmap_min_addr range. In this case mmap will fail with
EPERM without a good reason.

As test-case of such situation we may hard-code address between
PAGE_SIZE and 65536 inside unmapped_area_topdown function.

Signed-off-by: Ilya Smith <blackzert@gmail.com>
---
 arch/x86/kernel/sys_x86_64.c | 5 +++--
 arch/x86/mm/mmap.c           | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 676774b9bb8d..1752fe5cb735 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -17,6 +17,7 @@
 #include <linux/random.h>
 #include <linux/uaccess.h>
 #include <linux/elf.h>
+#include <linux/security.h>
 
 #include <asm/elf.h>
 #include <asm/compat.h>
@@ -185,7 +186,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 		return addr;
 
 	/* requested length too big for entire address space */
-	if (len > TASK_SIZE)
+	if (len > TASK_SIZE - mmap_min_addr)
 		return -ENOMEM;
 
 	/* No address checking. See comment at mmap_address_hint_valid() */
@@ -210,7 +211,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-	info.low_limit = PAGE_SIZE;
+	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
 	info.high_limit = get_mmap_base(0);
 
 	/*
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index 155ecbac9e28..b6d0c317639e 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -31,6 +31,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/compat.h>
+#include <linux/security.h>
 #include <asm/elf.h>
 
 #include "physaddr.h"
@@ -220,6 +221,9 @@ bool mmap_address_hint_valid(unsigned long addr, unsigned long len)
 	if (TASK_SIZE - len < addr)
 		return false;
 
+	if (addr < mmap_min_addr)
+		return false;
+
 	return (addr > DEFAULT_MAP_WINDOW) == (addr + len > DEFAULT_MAP_WINDOW);
 }
 
-- 
2.14.1
