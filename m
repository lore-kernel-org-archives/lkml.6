Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeERJ2H (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:28:07 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33817 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbeERJ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:27:51 -0400
X-Google-Smtp-Source: AB8JxZrvH1gXkCtWrAOUuPO/8m65AGoXXg98Dp+FiwJcAPIe26vcc57Vzfo+AX9h4gc8Y//fwTFEBg==
From: Jia He <hejianet@gmail.com>
To: Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc: Suzuki.Poulose@arm.com, linux-kernel@vger.kernel.org,
        Jia He <hejianet@gmail.com>, jia.he@hxt-semitech.com
Subject: [PATCH v2 2/2] KVM: arm/arm64: harden unmap_stage2_ptes in case end is not PAGE_SIZE aligned
Date: Fri, 18 May 2018 17:27:10 +0800
Message-Id: <1526635630-18917-2-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526635630-18917-1-git-send-email-hejianet@gmail.com>
References: <1526635630-18917-1-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If it passes addr=0x202920000,size=0xfe00 to unmap_stage2_range->
...->unmap_stage2_ptes, unmap_stage2_ptes will get addr=0x202920000,
end=0x20292fe00. After first while loop addr=0x202930000, end=0x20292fe00,
then addr!=end. Thus it will touch another pages by put_pages() in the
2nd loop.

This patch fixes it by hardening the break condition of while loop.

Signed-off-by: jia.he@hxt-semitech.com
---
v2: newly added

 virt/kvm/arm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 8dac311..45cd040 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -217,7 +217,7 @@ static void unmap_stage2_ptes(struct kvm *kvm, pmd_t *pmd,
 
 			put_page(virt_to_page(pte));
 		}
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+	} while (pte++, addr += PAGE_SIZE, addr < end);
 
 	if (stage2_pte_table_empty(start_pte))
 		clear_stage2_pmd_entry(kvm, pmd, start_addr);
-- 
1.8.3.1
