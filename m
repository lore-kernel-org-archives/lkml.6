Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7AAC46471
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5D32168D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5D32168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbeHNUZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:25:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58136 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbeHNUZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:25:41 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 758A2CBA;
        Tue, 14 Aug 2018 17:37:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 084/104] x86/irq: Demote irq_cpustat_t::__softirq_pending to u16
Date:   Tue, 14 Aug 2018 19:17:38 +0200
Message-Id: <20180814171520.660397255@linuxfoundation.org>
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

commit 9aee5f8a7e30330d0a8f4c626dc924ca5590aba5 upstream

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


