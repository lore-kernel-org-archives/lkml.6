Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0219BC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A222168D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A222168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbeHNUZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:25:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58168 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbeHNUZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:25:51 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 83BF8CBA;
        Tue, 14 Aug 2018 17:37:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 087/104] x86/irq: Let interrupt handlers set kvm_cpu_l1tf_flush_l1d
Date:   Tue, 14 Aug 2018 19:17:41 +0200
Message-Id: <20180814171520.847109076@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolai Stange <nstange@suse.de>

commit ffcba43ff66c7dab34ec700debd491d2a4d319b4 upstream

The last missing piece to having vmx_l1d_flush() take interrupts after
VMEXIT into account is to set the kvm_cpu_l1tf_flush_l1d per-cpu flag on
irq entry.

Issue calls to kvm_set_cpu_l1tf_flush_l1d() from entering_irq(),
ipi_entering_ack_irq(), smp_reschedule_interrupt() and
uv_bau_message_interrupt().

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/apic.h   |    3 +++
 arch/x86/kernel/smp.c         |    1 +
 arch/x86/platform/uv/tlb_uv.c |    1 +
 3 files changed, 5 insertions(+)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -10,6 +10,7 @@
 #include <asm/fixmap.h>
 #include <asm/mpspec.h>
 #include <asm/msr.h>
+#include <asm/hardirq.h>
 
 #define ARCH_APICTIMER_STOPS_ON_C3	1
 
@@ -626,6 +627,7 @@ extern void irq_exit(void);
 static inline void entering_irq(void)
 {
 	irq_enter();
+	kvm_set_cpu_l1tf_flush_l1d();
 }
 
 static inline void entering_ack_irq(void)
@@ -638,6 +640,7 @@ static inline void ipi_entering_ack_irq(
 {
 	irq_enter();
 	ack_APIC_irq();
+	kvm_set_cpu_l1tf_flush_l1d();
 }
 
 static inline void exiting_irq(void)
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -261,6 +261,7 @@ __visible void __irq_entry smp_reschedul
 {
 	ack_APIC_irq();
 	inc_irq_stat(irq_resched_count);
+	kvm_set_cpu_l1tf_flush_l1d();
 
 	if (trace_resched_ipi_enabled()) {
 		/*
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -1285,6 +1285,7 @@ void uv_bau_message_interrupt(struct pt_
 	struct msg_desc msgdesc;
 
 	ack_APIC_irq();
+	kvm_set_cpu_l1tf_flush_l1d();
 	time_start = get_cycles();
 
 	bcp = &per_cpu(bau_control, smp_processor_id());


