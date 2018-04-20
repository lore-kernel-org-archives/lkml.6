Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754486AbeDTJzk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:55:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34765 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754420AbeDTJzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:55:35 -0400
Date: Fri, 20 Apr 2018 02:55:20 -0700
From: tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-05189820da23fc87ee2a7d87c20257f298af27f4@git.kernel.org>
Cc: bp@suse.de, jroedel@suse.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mkubecek@suse.cz, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, mkubecek@suse.cz, hpa@zytor.com,
        dave.hansen@linux.intel.com, jroedel@suse.de, bp@suse.de,
        mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <1524162360-26179-1-git-send-email-joro@8bytes.org>
References: <1524162360-26179-1-git-send-email-joro@8bytes.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/power/64: Fix page-table setup for temporary
 text mapping
Git-Commit-ID: 05189820da23fc87ee2a7d87c20257f298af27f4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  05189820da23fc87ee2a7d87c20257f298af27f4
Gitweb:     https://git.kernel.org/tip/05189820da23fc87ee2a7d87c20257f298af27f4
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Thu, 19 Apr 2018 20:26:00 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Apr 2018 11:52:00 +0200

x86/power/64: Fix page-table setup for temporary text mapping

On a system with 4-level page-tables there is no p4d, so the pud in the pgd
should be mapped. The old code before commit fb43d6cb91ef already did that.

The change from above commit causes an invalid page-table which causes
undefined behavior. In one report it caused triple faults.

Fix it by changing the p4d back to pud.

Fixes: fb43d6cb91ef ('x86/mm: Do not auto-massage page protections')
Reported-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michal Kubecek <mkubecek@suse.cz>
Tested-by: Borislav Petkov <bp@suse.de>
Cc: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net
Cc: pavel@ucw.cz
Cc: hpa@zytor.com
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/1524162360-26179-1-git-send-email-joro@8bytes.org

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
 
