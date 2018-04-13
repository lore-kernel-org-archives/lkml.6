Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754521AbeDMLeY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:34:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39590 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754474AbeDMLeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:34:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59D9D60FED
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: vbabka@suse.cz, labbott@redhat.com, catalin.marinas@arm.com,
        hannes@cmpxchg.org, f.fainelli@gmail.com, xieyisheng1@huawei.com,
        ard.biesheuvel@linaro.org, richard.weiyang@gmail.com,
        byungchul.park@lge.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH 2/2] mm: vmalloc: Pass proper vm_start into debugobjects
Date: Fri, 13 Apr 2018 17:03:54 +0530
Message-Id: <1523619234-17635-3-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523619234-17635-1-git-send-email-cpandya@codeaurora.org>
References: <1523619234-17635-1-git-send-email-cpandya@codeaurora.org>
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
 mm/vmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9ff21a1..28034c55 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1526,8 +1526,8 @@ static void __vunmap(const void *addr, int deallocate_pages)
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
