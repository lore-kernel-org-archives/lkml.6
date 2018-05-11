Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753418AbeEKPF7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:05:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43172 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753145AbeEKPF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:05:57 -0400
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>,
        linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: [PATCH REPOST 2/5] ARM: Use update_thread_flag()
Date: Fri, 11 May 2018 16:05:01 +0100
Message-Id: <1526051104-15995-3-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526051104-15995-1-git-send-email-Dave.Martin@arm.com>
References: <1526051104-15995-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses the new update_thread_flag() helper to simplify an
if () set; else clear; construct.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/kernel/elf.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/elf.c b/arch/arm/kernel/elf.c
index 1824229..aade393 100644
--- a/arch/arm/kernel/elf.c
+++ b/arch/arm/kernel/elf.c
@@ -68,12 +68,9 @@ void elf_set_personality(const struct elf32_hdr *x)
 	 * binary is EABI or softfloat (and thus, guaranteed not to use
 	 * FPA instructions.)
 	 */
-	if (elf_hwcap & HWCAP_IWMMXT &&
-	    eflags & (EF_ARM_EABI_MASK | EF_ARM_SOFT_FLOAT)) {
-		set_thread_flag(TIF_USING_IWMMXT);
-	} else {
-		clear_thread_flag(TIF_USING_IWMMXT);
-	}
+	update_thread_flag(TIF_USING_IWMMXT,
+			   elf_hwcap & HWCAP_IWMMXT &&
+			   eflags & (EF_ARM_EABI_MASK | EF_ARM_SOFT_FLOAT));
 }
 EXPORT_SYMBOL(elf_set_personality);
 
-- 
2.1.4
