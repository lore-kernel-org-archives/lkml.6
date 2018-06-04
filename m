Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeFDQ3q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:29:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40688 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbeFDQ1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:27:42 -0400
Message-Id: <20180604162224.639011135@linutronix.de>
User-Agent: quilt/0.65
Date: Mon, 04 Jun 2018 17:33:57 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Dmitry Safonov <0x7f454c46@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>, Song Liu <liu.song.a23@gmail.com>,
        Joerg Roedel <jroedel@suse.de>, Mike Travis <mike.travis@hpe.com>,
        stable@vger.kernel.org
Subject: [patch 5/8] x86/ioapic: Use apic_ack_irq()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=x86-ioapic--Use-apic_ack_irq().patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To address the EBUSY fail of interrupt affinity settings in case that the
previous setting has not been cleaned up yet, use the new apic_ack_irq()
function instead of directly invoking ack_APIC_irq().

Preparatory change for the real fix

Fixes: dccfe3147b42 ("x86/vector: Simplify vector move cleanup")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/apic/io_apic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1851,7 +1851,7 @@ static void ioapic_ir_ack_level(struct i
 	 * intr-remapping table entry. Hence for the io-apic
 	 * EOI we use the pin number.
 	 */
-	ack_APIC_irq();
+	apic_ack_irq(irq_data);
 	eoi_ioapic_pin(data->entry.vector, data);
 }
 
