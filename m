Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbeCIOCc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:02:32 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:46288 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbeCIOCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:02:24 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
To: christoffer.dall@linaro.org, marc.zyngier@arm.com
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH] KVM:arm/arm64: dcache need be coherent unconditionally
Date: Sat, 10 Mar 2018 06:15:03 +0800
Message-Id: <1520633703-15121-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-03-09 22:02:23,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-03-09 22:01:57,
        Serialize complete at 2018-03-09 22:01:57
X-MAIL: mse01.zte.com.cn w29E2DAL042614
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For emulation devices just like vga, keeping coherent dcache between
guest and host timely is needed.
Now the display of vnc-viewer will not update continuously and the
patch can fix up.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 virt/kvm/arm/mmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index ec62d1c..4a28395e 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1416,8 +1416,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			kvm_set_pfn_dirty(pfn);
 		}
 
-		if (fault_status != FSC_PERM)
-			clean_dcache_guest_page(pfn, PMD_SIZE);
+		clean_dcache_guest_page(pfn, PMD_SIZE);
 
 		if (exec_fault) {
 			new_pmd = kvm_s2pmd_mkexec(new_pmd);
@@ -1438,8 +1437,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			mark_page_dirty(kvm, gfn);
 		}
 
-		if (fault_status != FSC_PERM)
-			clean_dcache_guest_page(pfn, PAGE_SIZE);
+		clean_dcache_guest_page(pfn, PAGE_SIZE);
 
 		if (exec_fault) {
 			new_pte = kvm_s2pte_mkexec(new_pte);
-- 
1.8.3.1
