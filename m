Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0D3C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24082150F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24082150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390731AbeHNUc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:32:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60004 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbeHNUc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:32:27 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4887EC8D;
        Tue, 14 Aug 2018 17:44:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 089/107] x86/irq: Let interrupt handlers set kvm_cpu_l1tf_flush_l1d
Date:   Tue, 14 Aug 2018 19:17:52 +0200
Message-Id: <20180814171526.267812164@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
References: <20180814171520.883143803@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/apic.h   |    3 +++
 arch/x86/kernel/smp.c         |    1 +
 arch/x86/platform/uv/tlb_uv.c |    1 +
 3 files changed, 5 insertions(+)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -12,6 +12,7 @@
 #include <asm/mpspec.h>
 #include <asm/msr.h>
 #include <asm/idle.h>
+#include <asm/hardirq.h>
 
 #define ARCH_APICTIMER_STOPS_ON_C3	1
 
@@ -647,6 +648,7 @@ static inline void entering_irq(void)
 {
 	irq_enter();
 	exit_idle();
+	kvm_set_cpu_l1tf_flush_l1d();
 }
 
 static inline void entering_ack_irq(void)
@@ -659,6 +661,7 @@ static inline void ipi_entering_ack_irq(
 {
 	irq_enter();
 	ack_APIC_irq();
+	kvm_set_cpu_l1tf_flush_l1d();
 }
 
 static inline void exiting_irq(void)
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -271,6 +271,7 @@ __visible void __irq_entry smp_reschedul
 	/*
 	 * KVM uses this interrupt to force a cpu out of guest mode
 	 */
+	kvm_set_cpu_l1tf_flush_l1d();
 }
 
 __visible void __irq_entry smp_trace_reschedule_interrupt(struct pt_regs *regs)
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -1283,6 +1283,7 @@ void uv_bau_message_interrupt(struct pt_
 	struct msg_desc msgdesc;
 
 	ack_APIC_irq();
+	kvm_set_cpu_l1tf_flush_l1d();
 	time_start = get_cycles();
 
 	bcp = &per_cpu(bau_control, smp_processor_id());


