Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB9D860555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeFFNdF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:33:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38179 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752338AbeFFNdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:33:03 -0400
Date: Wed, 6 Jun 2018 06:32:23 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-c0255770ccdc77ef2184d2a0a2e0cde09d2b44a4@git.kernel.org>
Cc: jroedel@suse.de, liu.song.a23@gmail.com, hpa@zytor.com,
        0x7f454c46@gmail.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, mike.travis@hpe.com,
        songliubraving@fb.com, mingo@kernel.org, tariqt@mellanox.com,
        peterz@infradead.org
Reply-To: mike.travis@hpe.com, bp@alien8.de, peterz@infradead.org,
          tariqt@mellanox.com, songliubraving@fb.com, mingo@kernel.org,
          hpa@zytor.com, liu.song.a23@gmail.com, jroedel@suse.de,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          0x7f454c46@gmail.com
In-Reply-To: <20180604162224.471925894@linutronix.de>
References: <20180604162224.471925894@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/apic: Provide apic_ack_irq()
Git-Commit-ID: c0255770ccdc77ef2184d2a0a2e0cde09d2b44a4
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

Commit-ID:  c0255770ccdc77ef2184d2a0a2e0cde09d2b44a4
Gitweb:     https://git.kernel.org/tip/c0255770ccdc77ef2184d2a0a2e0cde09d2b44a4
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 4 Jun 2018 17:33:55 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 15:18:20 +0200

x86/apic: Provide apic_ack_irq()

apic_ack_edge() is explicitely for handling interrupt affinity cleanup when
interrupt remapping is not available or disable.

Remapped interrupts and also some of the platform specific special
interrupts, e.g. UV, invoke ack_APIC_irq() directly.

To address the issue of failing an affinity update with -EBUSY the delayed
affinity mechanism can be reused, but ack_APIC_irq() does not handle
that. Adding this to ack_APIC_irq() is not possible, because that function
is also used for exceptions and directly handled interrupts like IPIs.

Create a new function, which just contains the conditional invocation of
irq_move_irq() and the final ack_APIC_irq().

Reuse the new function in apic_ack_edge().

Preparatory change for the real fix.

Fixes: dccfe3147b42 ("x86/vector: Simplify vector move cleanup")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Song Liu <songliubraving@fb.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <liu.song.a23@gmail.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: stable@vger.kernel.org
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tariq Toukan <tariqt@mellanox.com>
Link: https://lkml.kernel.org/r/20180604162224.471925894@linutronix.de

---
 arch/x86/include/asm/apic.h   | 2 ++
 arch/x86/kernel/apic/vector.c | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 08acd954f00e..74a9e06b6cfd 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -436,6 +436,8 @@ static inline void apic_set_eoi_write(void (*eoi_write)(u32 reg, u32 v)) {}
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 
+extern void apic_ack_irq(struct irq_data *data);
+
 static inline void ack_APIC_irq(void)
 {
 	/*
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 72b575a0b662..b708f597eee3 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -809,13 +809,18 @@ static int apic_retrigger_irq(struct irq_data *irqd)
 	return 1;
 }
 
-void apic_ack_edge(struct irq_data *irqd)
+void apic_ack_irq(struct irq_data *irqd)
 {
-	irq_complete_move(irqd_cfg(irqd));
 	irq_move_irq(irqd);
 	ack_APIC_irq();
 }
 
+void apic_ack_edge(struct irq_data *irqd)
+{
+	irq_complete_move(irqd_cfg(irqd));
+	apic_ack_irq(irqd);
+}
+
 static struct irq_chip lapic_controller = {
 	.name			= "APIC",
 	.irq_ack		= apic_ack_edge,
