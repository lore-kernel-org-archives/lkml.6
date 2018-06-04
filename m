Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeFDQ3p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:29:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40691 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeFDQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:27:43 -0400
Message-Id: <20180604162224.721691398@linutronix.de>
User-Agent: quilt/0.65
Date: Mon, 04 Jun 2018 17:33:58 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Dmitry Safonov <0x7f454c46@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>, Song Liu <liu.song.a23@gmail.com>,
        Joerg Roedel <jroedel@suse.de>, Mike Travis <mike.travis@hpe.com>,
        stable@vger.kernel.org
Subject: [patch 6/8] x86/platform/uv: Use apic_ack_irq()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=x86-platform-uv--Use-apic_ack_irq().patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To address the EBUSY fail of interrupt affinity settings in case that the
previous setting has not been cleaned up yet, use the new apic_ack_irq()
function instead of the special uv_ack_apic() implementation which is
merily a wrapper around ack_APIC_irq().

Preparatory change for the real fix

Fixes: dccfe3147b42 ("x86/vector: Simplify vector move cleanup")
Reported-by: Song Liu <liu.song.a23@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/x86/platform/uv/uv_irq.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -47,11 +47,6 @@ static void uv_program_mmr(struct irq_cf
 
 static void uv_noop(struct irq_data *data) { }
 
-static void uv_ack_apic(struct irq_data *data)
-{
-	ack_APIC_irq();
-}
-
 static int
 uv_set_irq_affinity(struct irq_data *data, const struct cpumask *mask,
 		    bool force)
@@ -73,7 +68,7 @@ static struct irq_chip uv_irq_chip = {
 	.name			= "UV-CORE",
 	.irq_mask		= uv_noop,
 	.irq_unmask		= uv_noop,
-	.irq_eoi		= uv_ack_apic,
+	.irq_eoi		= apic_ack_irq,
 	.irq_set_affinity	= uv_set_irq_affinity,
 };
 
