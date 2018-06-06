Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2DF8E601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbeFFNea (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:34:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44677 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbeFFNe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:34:26 -0400
Date: Wed, 6 Jun 2018 06:33:51 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-839b0f1c4ef674cd929a42304c078afca278581a@git.kernel.org>
Cc: peterz@infradead.org, tglx@linutronix.de, jroedel@suse.de,
        hpa@zytor.com, mike.travis@hpe.com, bp@alien8.de,
        0x7f454c46@gmail.com, mingo@kernel.org, songliubraving@fb.com,
        tariqt@mellanox.com, liu.song.a23@gmail.com,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, 0x7f454c46@gmail.com,
          linux-kernel@vger.kernel.org, tariqt@mellanox.com,
          liu.song.a23@gmail.com, songliubraving@fb.com, jroedel@suse.de,
          peterz@infradead.org, tglx@linutronix.de, mike.travis@hpe.com,
          bp@alien8.de, hpa@zytor.com
In-Reply-To: <20180604162224.721691398@linutronix.de>
References: <20180604162224.721691398@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/platform/uv: Use apic_ack_irq()
Git-Commit-ID: 839b0f1c4ef674cd929a42304c078afca278581a
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

Commit-ID:  839b0f1c4ef674cd929a42304c078afca278581a
Gitweb:     https://git.kernel.org/tip/839b0f1c4ef674cd929a42304c078afca278581a
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 4 Jun 2018 17:33:58 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 15:18:21 +0200

x86/platform/uv: Use apic_ack_irq()

To address the EBUSY fail of interrupt affinity settings in case that the
previous setting has not been cleaned up yet, use the new apic_ack_irq()
function instead of the special uv_ack_apic() implementation which is
merily a wrapper around ack_APIC_irq().

Preparatory change for the real fix

Fixes: dccfe3147b42 ("x86/vector: Simplify vector move cleanup")
Reported-by: Song Liu <liu.song.a23@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Song Liu <songliubraving@fb.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: stable@vger.kernel.org
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tariq Toukan <tariqt@mellanox.com>
Link: https://lkml.kernel.org/r/20180604162224.721691398@linutronix.de

---
 arch/x86/platform/uv/uv_irq.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index e4cb9f4cde8a..fc13cbbb2dce 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -47,11 +47,6 @@ static void uv_program_mmr(struct irq_cfg *cfg, struct uv_irq_2_mmr_pnode *info)
 
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
 
