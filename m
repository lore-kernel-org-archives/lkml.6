Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753734AbeEWCgG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 22:36:06 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38993 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752658AbeEWCgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 22:36:05 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="40234414"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <tglx@linutronix.de>, Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v2] x86/idt: Simplify the idt_setup_apic_and_irq_gates()
Date: Wed, 23 May 2018 10:35:55 +0800
Message-ID: <20180523023555.2933-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: EBEAA4B41E7C.A2833
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idt_setup_apic_and_irq_gates() sets the gates from
FIRST_EXTERNAL_VECTOR up to FIRST_SYSTEM_VECTOR first. then secondly,
from FIRST_SYSTEM_VECTOR to NR_VECTORS, it takes both APIC=y and APIC=n
into account.

But for APIC=n, the FIRST_SYSTEM_VECTOR is equal to NR_VECTORS, all
vectors has been set at the first step.

Simplify the second step, make it just work for APIC=y.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
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
-- 
2.14.3
