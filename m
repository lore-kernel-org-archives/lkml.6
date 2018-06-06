Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65167601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeFFNd4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:33:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38797 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeFFNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:33:54 -0400
Date: Wed, 6 Jun 2018 06:33:21 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-2b04e46d8d0b9b7ac08ded672e3eab823f01d77a@git.kernel.org>
Cc: jroedel@suse.de, 0x7f454c46@gmail.com, peterz@infradead.org,
        tariqt@mellanox.com, songliubraving@fb.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@kernel.org,
        tglx@linutronix.de, mike.travis@hpe.com, liu.song.a23@gmail.com,
        hpa@zytor.com
Reply-To: mike.travis@hpe.com, liu.song.a23@gmail.com, hpa@zytor.com,
          tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, bp@alien8.de,
          songliubraving@fb.com, tariqt@mellanox.com, peterz@infradead.org,
          0x7f454c46@gmail.com, jroedel@suse.de
In-Reply-To: <20180604162224.639011135@linutronix.de>
References: <20180604162224.639011135@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/ioapic: Use apic_ack_irq()
Git-Commit-ID: 2b04e46d8d0b9b7ac08ded672e3eab823f01d77a
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

Commit-ID:  2b04e46d8d0b9b7ac08ded672e3eab823f01d77a
Gitweb:     https://git.kernel.org/tip/2b04e46d8d0b9b7ac08ded672e3eab823f01d77a
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 4 Jun 2018 17:33:57 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 15:18:21 +0200

x86/ioapic: Use apic_ack_irq()

To address the EBUSY fail of interrupt affinity settings in case that the
previous setting has not been cleaned up yet, use the new apic_ack_irq()
function instead of directly invoking ack_APIC_irq().

Preparatory change for the real fix

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
Link: https://lkml.kernel.org/r/20180604162224.639011135@linutronix.de

---
 arch/x86/kernel/apic/io_apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 7553819c74c3..3982f79d2377 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1851,7 +1851,7 @@ static void ioapic_ir_ack_level(struct irq_data *irq_data)
 	 * intr-remapping table entry. Hence for the io-apic
 	 * EOI we use the pin number.
 	 */
-	ack_APIC_irq();
+	apic_ack_irq(irq_data);
 	eoi_ioapic_pin(data->entry.vector, data);
 }
 
