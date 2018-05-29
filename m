Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934925AbeE2OAS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:00:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934802AbeE2OAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:00:12 -0400
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
Subject: [PATCH 2/3] x86:add missing CONFIG_STRICT_KERNEL_RWX for mark_rodata_ro
Date: Tue, 29 May 2018 21:36:22 +0800
Message-ID: <20180529133622.26982-1-nixiaoming@huawei.com>
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
 arch/x86/mm/init_32.c | 2 ++
 arch/x86/mm/init_64.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index c893c6a..121c567 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -920,6 +920,7 @@ static void mark_nxdata_nx(void)
 	set_pages_nx(virt_to_page(start), size >> PAGE_SHIFT);
 }
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
 void mark_rodata_ro(void)
 {
 	unsigned long start = PFN_ALIGN(_text);
@@ -957,3 +958,4 @@ void mark_rodata_ro(void)
 	if (__supported_pte_mask & _PAGE_NX)
 		debug_checkwx();
 }
+#endif /*end of CONFIG_STRICT_KERNEL_RWX*/
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0a40060..1b7a1a7 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1245,6 +1245,7 @@ void set_kernel_text_ro(void)
 	set_memory_ro(start, (end - start) >> PAGE_SHIFT);
 }
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
 void mark_rodata_ro(void)
 {
 	unsigned long start = PFN_ALIGN(_text);
@@ -1298,6 +1299,7 @@ void mark_rodata_ro(void)
 	 */
 	pti_clone_kernel_text();
 }
+#endif
 
 int kern_addr_valid(unsigned long addr)
 {
-- 
2.10.1
