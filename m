Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752687AbeDQKoZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 06:44:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54516 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbeDQKoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 06:44:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A868560F94
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: vbabka@suse.cz, labbott@redhat.com, catalin.marinas@arm.com,
        hannes@cmpxchg.org, f.fainelli@gmail.com, xieyisheng1@huawei.com,
        ard.biesheuvel@linaro.org, richard.weiyang@gmail.com,
        byungchul.park@lge.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        khandual@linux.vnet.ibm.com, mhocko@kernel.org,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v2 2/2] mm: vmalloc: Pass proper vm_start into debugobjects
Date: Tue, 17 Apr 2018 16:13:48 +0530
Message-Id: <1523961828-9485-3-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523961828-9485-1-git-send-email-cpandya@codeaurora.org>
References: <1523961828-9485-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Client can call vunmap with some intermediate 'addr'
which may not be the start of the VM area. Entire
unmap code works with vm->vm_start which is proper
but debug object API is called with 'addr'. This
could be a problem within debug objects.

Pass proper start address into debug object API.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 mm/vmalloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 12d675c..033c918 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1124,15 +1124,15 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 	BUG_ON(addr > VMALLOC_END);
 	BUG_ON(!PAGE_ALIGNED(addr));
 
-	debug_check_no_locks_freed(mem, size);
-
 	if (likely(count <= VMAP_MAX_ALLOC)) {
+		debug_check_no_locks_freed(mem, size);
 		vb_free(mem, size);
 		return;
 	}
 
 	va = find_vmap_area(addr);
 	BUG_ON(!va);
+	debug_check_no_locks_freed(va->va_start, (va->va_end - va->va_start));
 	free_unmap_vmap_area(va);
 }
 EXPORT_SYMBOL(vm_unmap_ram);
@@ -1507,8 +1507,8 @@ static void __vunmap(const void *addr, int deallocate_pages)
 		return;
 	}
 
-	debug_check_no_locks_freed(addr, get_vm_area_size(area));
-	debug_check_no_obj_freed(addr, get_vm_area_size(area));
+	debug_check_no_locks_freed(area->addr, get_vm_area_size(area));
+	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));
 
 	remove_vm_area(addr);
 	if (deallocate_pages) {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
