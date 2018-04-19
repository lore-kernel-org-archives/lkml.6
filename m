Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeDSS0I (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 14:26:08 -0400
Received: from 8bytes.org ([81.169.241.247]:51022 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752937AbeDSS0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 14:26:07 -0400
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: rjw@rjwysocki.net, pavel@ucw.cz, hpa@zytor.com,
        Michal Kubecek <mkubecek@suse.cz>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] x86/power/64: Fix page-table setup for temporary text mapping
Date: Thu, 19 Apr 2018 20:26:00 +0200
Message-Id: <1524162360-26179-1-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

When we have a 4-level page-table there is no p4d, so we map
the pud in the pgd. The old code before commit fb43d6cb91ef
already did that.

With the change from above commit we end up with an invalid
page-table which causes undefined behavior. In one report it
caused triple faults.

Fix it by changing the p4d back to pud so that we have a
correct page-table.

Reported-by: Borislav Petkov <bp@suse.de>
Fixes: fb43d6cb91ef ('x86/mm: Do not auto-massage page protections')
Tested-by: Michal Kubecek <mkubecek@suse.cz>
Tested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/power/hibernate_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index 48b14b534897..ccf4a49bb065 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -98,7 +98,7 @@ static int set_up_temporary_text_mapping(pgd_t *pgd)
 		set_pgd(pgd + pgd_index(restore_jump_address), new_pgd);
 	} else {
 		/* No p4d for 4-level paging: point the pgd to the pud page table */
-		pgd_t new_pgd = __pgd(__pa(p4d) | pgprot_val(pgtable_prot));
+		pgd_t new_pgd = __pgd(__pa(pud) | pgprot_val(pgtable_prot));
 		set_pgd(pgd + pgd_index(restore_jump_address), new_pgd);
 	}
 
-- 
2.13.6
