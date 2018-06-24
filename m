Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2803BC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE3825026
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE3825026
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755484AbeFXPgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:36:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59574 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755129AbeFXPgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:36:48 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3E52749B;
        Sun, 24 Jun 2018 15:36:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Song Liu <songliubraving@fb.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <liu.song.a23@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Mike Travis <mike.travis@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: [PATCH 4.16 49/64] x86/apic: Provide apic_ack_irq()
Date:   Sun, 24 Jun 2018 23:22:30 +0800
Message-Id: <20180624142746.761994211@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142743.613370789@linuxfoundation.org>
References: <20180624142743.613370789@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit c0255770ccdc77ef2184d2a0a2e0cde09d2b44a4 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/apic.h   |    2 ++
 arch/x86/kernel/apic/vector.c |    9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -442,6 +442,8 @@ static inline void apic_set_eoi_write(vo
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 
+extern void apic_ack_irq(struct irq_data *data);
+
 static inline void ack_APIC_irq(void)
 {
 	/*
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -809,13 +809,18 @@ static int apic_retrigger_irq(struct irq
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


