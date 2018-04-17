Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeDQKoR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 06:44:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54324 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeDQKoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 06:44:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57ABA60F8E
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
Subject: [PATCH v2 1/2] mm: vmalloc: Avoid racy handling of debugobjects in vunmap
Date: Tue, 17 Apr 2018 16:13:47 +0530
Message-Id: <1523961828-9485-2-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523961828-9485-1-git-send-email-cpandya@codeaurora.org>
References: <1523961828-9485-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, __vunmap flow is,
 1) Release the VM area
 2) Free the debug objects corresponding to that vm area.

This leave some race window open.
 1) Release the VM area
 1.5) Some other client gets the same vm area
 1.6) This client allocates new debug objects on the same
      vm area
 2) Free the debug objects corresponding to this vm area.

Here, we actually free 'other' client's debug objects.

Fix this by freeing the debug objects first and then
releasing the VM area.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 mm/vmalloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6729400..12d675c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1500,7 +1500,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			addr))
 		return;
 
-	area = remove_vm_area(addr);
+	area = find_vmap_area((unsigned long)addr)->vm;
 	if (unlikely(!area)) {
 		WARN(1, KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n",
 				addr);
@@ -1510,6 +1510,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
 	debug_check_no_locks_freed(addr, get_vm_area_size(area));
 	debug_check_no_obj_freed(addr, get_vm_area_size(area));
 
+	remove_vm_area(addr);
 	if (deallocate_pages) {
 		int i;
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
