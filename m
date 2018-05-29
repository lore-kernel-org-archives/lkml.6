Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934904AbeE2OAJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:00:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43594 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S934802AbeE2OAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:00:06 -0400
From: nixiaoming <nixiaoming@huawei.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <ard.biesheuvel@linaro.org>, <marc.zyngier@arm.com>,
        <james.morse@arm.com>, <kristina.martsenko@arm.com>,
        <steve.capper@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <mhocko@suse.com>, <dave.hansen@linux.intel.com>,
        <dan.j.williams@intel.com>, <kirill.shutemov@linux.intel.com>,
        <zhang.jia@linux.alibaba.com>, <schwidefsky@de.ibm.com>,
        <heiko.carstens@de.ibm.com>, <gregkh@linuxfoundation.org>
CC: <nixiaoming@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        <linux-s390@vger.kernel.org>
Subject: [PATCH 3/3] s390:add missing CONFIG_STRICT_KERNEL_RWX for mark_rodata_ro
Date: Tue, 29 May 2018 21:36:28 +0800
Message-ID: <20180529133628.27055-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.10.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mark_rodata_ro is only called by the function mark_readonly
when CONFIG_STRICT_KERNEL_RWX=y

if CONFIG_STRICT_KERNEL_RWX is not set
a compile warning may be triggered: unused function

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---
 arch/s390/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 3fa3e53..a96fc3f 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -116,6 +116,7 @@ void __init paging_init(void)
 	free_area_init_nodes(max_zone_pfns);
 }
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
 void mark_rodata_ro(void)
 {
 	unsigned long size = __end_ro_after_init - __start_ro_after_init;
@@ -123,6 +124,7 @@ void mark_rodata_ro(void)
 	set_memory_ro((unsigned long)__start_ro_after_init, size >> PAGE_SHIFT);
 	pr_info("Write protected read-only-after-init data: %luk\n", size >> 10);
 }
+#endif
 
 void __init mem_init(void)
 {
-- 
2.10.1
