Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbeDDXdA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 19:33:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57665 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbeDDXc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 19:32:57 -0400
Date: Wed, 4 Apr 2018 16:31:28 -0700
From: tip-bot for Sai Praneeth <tipbot@zytor.com>
Message-ID: <tip-162ee5a8ab49be40d253f90e94aef712470a3a24@git.kernel.org>
Cc: jlee@suse.com, ravi.v.shankar@intel.com, matt@codeblueprint.co.uk,
        a.p.zijlstra@chello.nl, luto@kernel.org, akpm@linux-foundation.org,
        tony.luck@intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, dave.hansen@intel.com,
        mst@redhat.com, ricardo.neri@intel.com, sai.praneeth.prakhya@intel.com,
        hpa@zytor.com, ard.biesheuvel@linaro.org, peterz@infradead.org,
        tglx@linutronix.de, bp@alien8.de
Reply-To: hpa@zytor.com, ard.biesheuvel@linaro.org, tglx@linutronix.de,
        peterz@infradead.org, bp@alien8.de, a.p.zijlstra@chello.nl,
        matt@codeblueprint.co.uk, jlee@suse.com, ravi.v.shankar@intel.com,
        luto@kernel.org, tony.luck@intel.com, akpm@linux-foundation.org,
        mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, sai.praneeth.prakhya@intel.com,
        ricardo.neri@intel.com, mst@redhat.com, dave.hansen@intel.com
In-Reply-To: <1522870459-7432-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1522870459-7432-1-git-send-email-sai.praneeth.prakhya@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] x86/mm: Fix bogus warning during EFI bootup, use
 boot_cpu_has() instead of this_cpu_has() in build_cr3_noflush()
Git-Commit-ID: 162ee5a8ab49be40d253f90e94aef712470a3a24
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

Commit-ID:  162ee5a8ab49be40d253f90e94aef712470a3a24
Gitweb:     https://git.kernel.org/tip/162ee5a8ab49be40d253f90e94aef712470a3a24
Author:     Sai Praneeth <sai.praneeth.prakhya@intel.com>
AuthorDate: Wed, 4 Apr 2018 12:34:19 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 5 Apr 2018 01:27:49 +0200

x86/mm: Fix bogus warning during EFI bootup, use boot_cpu_has() instead of this_cpu_has() in build_cr3_noflush()

Linus reported the following boot warning:

  WARNING: CPU: 0 PID: 0 at arch/x86/include/asm/tlbflush.h:134 load_new_mm_cr3+0x114/0x170
  [...]
  Call Trace:
  switch_mm_irqs_off+0x267/0x590
  switch_mm+0xe/0x20
  efi_switch_mm+0x3e/0x50
  efi_enter_virtual_mode+0x43f/0x4da
  start_kernel+0x3bf/0x458
  secondary_startup_64+0xa5/0xb0

... after merging:

  03781e40890c: x86/efi: Use efi_switch_mm() rather than manually twiddling with %cr3

When the platform supports PCID and if CONFIG_DEBUG_VM=y is enabled,
build_cr3_noflush() (called via switch_mm()) does a sanity check to see
if X86_FEATURE_PCID is set.

Presently, build_cr3_noflush() uses "this_cpu_has(X86_FEATURE_PCID)" to
perform the check but this_cpu_has() works only after SMP is initialized
(i.e. per cpu cpu_info's should be populated) and this happens to be very
late in the boot process (during rest_init()).

As efi_runtime_services() are called during (early) kernel boot time
and run time, modify build_cr3_noflush() to use boot_cpu_has() all the
time. As suggested by Dave Hansen, this should be OK because all CPU's have
same capabilities on x86.

With this change the warning is fixed.

( Dave also suggested that we put a warning in this_cpu_has() if it's used
  early in the boot process. This is still work in progress as it affects
  MCE. )

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Lee Chun-Yi <jlee@suse.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/1522870459-7432-1-git-send-email-sai.praneeth.prakhya@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
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
 
