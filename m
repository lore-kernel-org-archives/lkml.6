Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbeDHGnZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 02:43:25 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:36008 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751126AbeDHGnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 02:43:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=zoucao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0T-q8ln8_1523169795;
From: zoucao@linux.alibaba.com
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86/boot/e820: add new chareater "-" to free BIOS memory in memmap bootargs
Date: Sun,  8 Apr 2018 14:41:34 +0800
Message-Id: <20180408064134.77385-2-zoucao@linux.alibaba.com>
X-Mailer: git-send-email 2.14.1.40.g8e62ba1
In-Reply-To: <20180408064134.77385-1-zoucao@linux.alibaba.com>
References: <20180408064134.77385-1-zoucao@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zoucao <zoucao@linux.alibaba.com>

Normally every BIOS reserved memory is used for some features, we can
not use them, but in some conditions,  users can ensure some BIOS memorys
are not used and reserved memory is well to free, they have not a good
way to free these memroys, here add a new chareater "-" in memmap to free
reserved memory.

Signed-off-by: zou cao <zoucao@linux.alibaba.com>
---
 7u/Documentation/kernel-parameters.txt | 6 ++++++
 7u/arch/x86/kernel/e820.c              | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/7u/Documentation/kernel-parameters.txt b/7u/Documentation/kernel-parameters.txt
index 9a1abb99a..dbea75e12 100644
--- a/7u/Documentation/kernel-parameters.txt
+++ b/7u/Documentation/kernel-parameters.txt
@@ -1677,6 +1677,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			         or
 			         memmap=0x10000$0x18690000
 
+	memmap=nn[KMG]-ss[KMG]
+			Free E820 reserved memory, as specified by the user.
+			Region of reserved memory to be free, from ss to ss+nn.
+			Example: free reserved memory from 0x18690000-0x186a0000
+					memmap=0x4101000-0x6aeff000
+
 	memory_corruption_check=0/1 [X86]
 			Some BIOSes seem to corrupt the first 64k of
 			memory when doing things like suspend/resume.
diff --git a/7u/arch/x86/kernel/e820.c b/7u/arch/x86/kernel/e820.c
index 174da5fc5..b8a042981 100644
--- a/7u/arch/x86/kernel/e820.c
+++ b/7u/arch/x86/kernel/e820.c
@@ -875,6 +875,9 @@ static int __init parse_memmap_one(char *p)
 	} else if (*p == '$') {
 		start_at = memparse(p+1, &p);
 		e820_add_region(start_at, mem_size, E820_RESERVED);
+	} else if (*p == '-') {
+		start_at = memparse(p+1, &p);
+		e820_remove_range(start_at, mem_size, E820_RESERVED, E820_RAM);
 	} else
 		e820_remove_range(mem_size, ULLONG_MAX - mem_size, E820_RAM, 1);
 
-- 
2.14.1.40.g8e62ba1
