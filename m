Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeDOR05 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 13:26:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47356 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752464AbeDOR04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 13:26:56 -0400
Date: Sun, 15 Apr 2018 19:26:54 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] efi updates for 4.17
Message-ID: <alpine.DEB.2.21.1804151924510.17929@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest efi-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

A single fix for an early boot warning caused by invoking this_cpu_has()
before SMP initialization.

Thanks,

	tglx

------------------>
Sai Praneeth (1):
      x86/mm: Fix bogus warning during EFI bootup, use boot_cpu_has() instead of this_cpu_has() in build_cr3_noflush()


 arch/x86/include/asm/tlbflush.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 84137c22fdfa..6690cd3fc8b1 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -131,7 +131,12 @@ static inline unsigned long build_cr3(pgd_t *pgd, u16 asid)
 static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
 {
 	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
-	VM_WARN_ON_ONCE(!this_cpu_has(X86_FEATURE_PCID));
+	/*
+	 * Use boot_cpu_has() instead of this_cpu_has() as this function
+	 * might be called during early boot. This should work even after
+	 * boot because all CPU's the have same capabilities:
+	 */
+	VM_WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_PCID));
 	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
 }
 
