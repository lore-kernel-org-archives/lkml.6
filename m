Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbeDZFpK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:45:10 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39151 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750775AbeDZFpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:45:08 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="39329976"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH] x86/idt: Simplify the idt_setup_apic_and_irq_gates()
Date: Thu, 26 Apr 2018 13:44:52 +0800
Message-ID: <20180426054452.32308-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: AA52E4B31484.AFBE9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vectors between FIRST_SYSTEM_VECTOR and NR_VECTORS are special IRQ
vectors used by the SMP architecture. But, if X86_LOCAL_APIC=n, it will
not be used, and the FIRST_SYSTEM_VECTOR is equal to NR_VECTORS.

idt_setup_apic_and_irq_gates() didn't notice that, which make the code
a little complex.

Remove the code of the X86_LOCAL_APIC=n case to simplify it.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 arch/x86/kernel/idt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 2c3a1b4294eb..8b4174890706 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -317,15 +317,16 @@ void __init idt_setup_apic_and_irq_gates(void)
 		set_intr_gate(i, entry);
 	}
 
-	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
+	/*
+	 * If X86_LOCAL_APIC=n, the FIRST_SYSTEM_VECTOR is equal to NR_VECTORS
+	 * Just consider the X86_LOCAL_APIC=y case
+	 */
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
