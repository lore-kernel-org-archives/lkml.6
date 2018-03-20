Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbeCTVcL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 17:32:11 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:51889 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751715AbeCTVcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 17:32:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0SzoMu-x_1521581495;
From: Yang Shi <yang.shi@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org
Subject: [RFC PATCH 7/8] x86: mpx: pass atomic parameter to do_munmap()
Date: Wed, 21 Mar 2018 05:31:25 +0800
Message-Id: <1521581486-99134-8-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass "true" to do_munmap() to not do unlock/relock to mmap_sem when
manipulating mpx map.

This is API change only.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
---
 arch/x86/mm/mpx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
index e500949..a180e94 100644
--- a/arch/x86/mm/mpx.c
+++ b/arch/x86/mm/mpx.c
@@ -780,7 +780,7 @@ static int unmap_entire_bt(struct mm_struct *mm,
 	 * avoid recursion, do_munmap() will check whether it comes
 	 * from one bounds table through VM_MPX flag.
 	 */
-	return do_munmap(mm, bt_addr, mpx_bt_size_bytes(mm), NULL);
+	return do_munmap(mm, bt_addr, mpx_bt_size_bytes(mm), NULL, true);
 }
 
 static int try_unmap_single_bt(struct mm_struct *mm,
-- 
1.8.3.1
