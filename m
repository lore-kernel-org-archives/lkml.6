Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C053B6070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeFFLoj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:44:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35735 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeFFLog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:44:36 -0400
Date: Wed, 6 Jun 2018 04:43:58 -0700
From: tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-336628128826a9acb045571a960e32e4414ccb61@git.kernel.org>
Cc: douly.fnst@cn.fujitsu.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org
Reply-To: mingo@kernel.org, douly.fnst@cn.fujitsu.com, tglx@linutronix.de,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180523023555.2933-1-douly.fnst@cn.fujitsu.com>
References: <20180523023555.2933-1-douly.fnst@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/idt: Simplify the
 idt_setup_apic_and_irq_gates()
Git-Commit-ID: 336628128826a9acb045571a960e32e4414ccb61
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

Commit-ID:  336628128826a9acb045571a960e32e4414ccb61
Gitweb:     https://git.kernel.org/tip/336628128826a9acb045571a960e32e4414ccb61
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Wed, 23 May 2018 10:35:55 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 13:38:01 +0200

x86/idt: Simplify the idt_setup_apic_and_irq_gates()

The idt_setup_apic_and_irq_gates() sets the gates from
FIRST_EXTERNAL_VECTOR up to FIRST_SYSTEM_VECTOR first. then secondly, from
FIRST_SYSTEM_VECTOR to NR_VECTORS, it takes both APIC=y and APIC=n into
account.

But for APIC=n, the FIRST_SYSTEM_VECTOR is equal to NR_VECTORS, all
vectors has been set at the first step.

Simplify the second step, make it just work for APIC=y.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20180523023555.2933-1-douly.fnst@cn.fujitsu.com

---
 arch/x86/kernel/idt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 2c3a1b4294eb..74383a3780dc 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -317,15 +317,12 @@ void __init idt_setup_apic_and_irq_gates(void)
 		set_intr_gate(i, entry);
 	}
 
-	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
 #ifdef CONFIG_X86_LOCAL_APIC
+	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
 		set_bit(i, system_vectors);
 		set_intr_gate(i, spurious_interrupt);
-#else
-		entry = irq_entries_start + 8 * (i - FIRST_EXTERNAL_VECTOR);
-		set_intr_gate(i, entry);
-#endif
 	}
+#endif
 }
 
 /**
