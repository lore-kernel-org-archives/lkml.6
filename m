Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeA3Gn0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 01:43:26 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:37707 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751322AbeA3GnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 01:43:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0SxLmNSb_1517294582;
From: Jia Zhang <zhang.jia@linux.alibaba.com>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: [PATCH 2/2] x86/mm/64: Add vsyscall page to /proc/kcore conditionally
Date: Tue, 30 Jan 2018 14:42:59 +0800
Message-Id: <1517294579-117473-2-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1517294579-117473-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1517294579-117473-1-git-send-email-zhang.jia@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vsyscall page should be visible only if
vsyscall=emulate/native when dumping /proc/kcore.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 arch/x86/mm/init_64.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index dab78f6..3d4cf33 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1186,8 +1186,9 @@ void __init mem_init(void)
 	register_page_bootmem_info();
 
 	/* Register memory areas for /proc/kcore */
-	kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR,
-		   PAGE_SIZE, KCORE_USER);
+	if (get_gate_vma(&init_mm))
+		kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR,
+			   PAGE_SIZE, KCORE_USER);
 
 	mem_init_print_info(NULL);
 }
-- 
1.8.3.1
