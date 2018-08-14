Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939C3C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5830B21728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5830B21728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbeHNUPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:15:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52410 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388032AbeHNUPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:15:15 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 01F3F40B;
        Tue, 14 Aug 2018 17:27:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.18 64/79] x86/irq: Demote irq_cpustat_t::__softirq_pending to u16
Date:   Tue, 14 Aug 2018 19:17:23 +0200
Message-Id: <20180814171340.478339964@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171336.799314117@linuxfoundation.org>
References: <20180814171336.799314117@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolai Stange <nstange@suse.de>

An upcoming patch will extend KVM's L1TF mitigation in conditional mode
to also cover interrupts after VMEXITs. For tracking those, stores to a
new per-cpu flag from interrupt handlers will become necessary.

In order to improve cache locality, this new flag will be added to x86's
irq_cpustat_t.

Make some space available there by shrinking the ->softirq_pending bitfield
from 32 to 16 bits: the number of bits actually used is only NR_SOFTIRQS,
i.e. 10.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/hardirq.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -6,7 +6,7 @@
 #include <linux/irq.h>
 
 typedef struct {
-	unsigned int __softirq_pending;
+	u16	     __softirq_pending;
 	unsigned int __nmi_count;	/* arch dependent */
 #ifdef CONFIG_X86_LOCAL_APIC
 	unsigned int apic_timer_irqs;	/* arch dependent */


