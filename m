Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964844AbeBLOpY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:45:24 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:43792 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935941AbeBLOpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:45:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Sy3nJF7_1518446695;
From: Jia Zhang <zhang.jia@linux.alibaba.com>
To: tglx@linutronix.de, jolsa@redhat.com, mingo@redhat.com, hpa@zytor.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/mm/64: Add vsyscall page to /proc/kcore conditionally
Date: Mon, 12 Feb 2018 22:44:54 +0800
Message-Id: <1518446694-21124-3-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1518446694-21124-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1518446694-21124-1-git-send-email-zhang.jia@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vsyscall page should be visible only if
vsyscall=emulate/native when dumping /proc/kcore.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/mm/init_64.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 14cd7f8..cbd6ea4 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1193,8 +1193,10 @@ void __init mem_init(void)
 	register_page_bootmem_info();
 
 	/* Register memory areas for /proc/kcore */
-	kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR,
-		   PAGE_SIZE, KCORE_USER);
+	if (get_gate_vma(&init_mm)) {
+		kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR,
+			   PAGE_SIZE, KCORE_USER);
+	}
 
 	mem_init_print_info(NULL);
 }
-- 
1.8.3.1
