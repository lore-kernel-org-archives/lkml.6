Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D5C5BC07D5C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899DC2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899DC2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935053AbeFMBBg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:01:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:64685 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754416AbeFMBBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:01:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 18:01:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,216,1526367600"; 
   d="scan'208";a="47283461"
Received: from voyager.sc.intel.com ([10.3.52.149])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2018 18:01:30 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Doug Berger <opendmb@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        iommu@lists.linux-foundation.org
Subject: [RFC PATCH 03/23] genirq: Introduce IRQF_DELIVER_AS_NMI
Date:   Tue, 12 Jun 2018 17:57:23 -0700
Message-Id: <1528851463-21140-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain interrupt controllers (such as APIC) are capable of delivering
interrupts as non-maskable. Likewise, drivers or subsystems (e.g., the
hardlockup detector) might be interested in requesting a non-maskable
interrupt. The new flag IRQF_DELIVER_AS_NMI serves this purpose.

When setting up an interrupt, non-maskable delivery will be set in the
interrupt state data only if supported by the underlying interrupt
controller chips.

Interrupt controller chips can declare that they support non-maskable
delivery by using the new flag IRQCHIP_CAN_DELIVER_AS_NMI.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Doug Berger <opendmb@gmail.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 include/linux/interrupt.h |  3 +++
 include/linux/irq.h       |  3 +++
 kernel/irq/manage.c       | 22 +++++++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5426627..dbc5e02 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -61,6 +61,8 @@
  *                interrupt handler after suspending interrupts. For system
  *                wakeup devices users need to implement wakeup detection in
  *                their interrupt handlers.
+ * IRQF_DELIVER_AS_NMI - Configure interrupt to be delivered as non-maskable, if
+ *                supported by the chip.
  */
 #define IRQF_SHARED		0x00000080
 #define IRQF_PROBE_SHARED	0x00000100
@@ -74,6 +76,7 @@
 #define IRQF_NO_THREAD		0x00010000
 #define IRQF_EARLY_RESUME	0x00020000
 #define IRQF_COND_SUSPEND	0x00040000
+#define IRQF_DELIVER_AS_NMI	0x00080000
 
 #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
 
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 7271a2c..d2520ae 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -515,6 +515,8 @@ struct irq_chip {
  * IRQCHIP_SKIP_SET_WAKE:	Skip chip.irq_set_wake(), for this irq chip
  * IRQCHIP_ONESHOT_SAFE:	One shot does not require mask/unmask
  * IRQCHIP_EOI_THREADED:	Chip requires eoi() on unmask in threaded mode
+ * IRQCHIP_CAN_DELIVER_AS_NMI	Chip can deliver interrupts it receives as non-
+ *				maskable.
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED		= (1 <<  0),
@@ -524,6 +526,7 @@ enum {
 	IRQCHIP_SKIP_SET_WAKE		= (1 <<  4),
 	IRQCHIP_ONESHOT_SAFE		= (1 <<  5),
 	IRQCHIP_EOI_THREADED		= (1 <<  6),
+	IRQCHIP_CAN_DELIVER_AS_NMI	= (1 <<  7),
 };
 
 #include <linux/irqdesc.h>
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e3336d9..d058aa8 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1137,7 +1137,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 {
 	struct irqaction *old, **old_ptr;
 	unsigned long flags, thread_mask = 0;
-	int ret, nested, shared = 0;
+	int ret, nested, shared = 0, deliver_as_nmi = 0;
 
 	if (!desc)
 		return -EINVAL;
@@ -1156,6 +1156,16 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	if (!(new->flags & IRQF_TRIGGER_MASK))
 		new->flags |= irqd_get_trigger_type(&desc->irq_data);
 
+	/* Only deliver as non-maskable interrupt if supported by chip. */
+	if (new->flags & IRQF_DELIVER_AS_NMI) {
+		if (desc->irq_data.chip->flags & IRQCHIP_CAN_DELIVER_AS_NMI) {
+			irqd_set_deliver_as_nmi(&desc->irq_data);
+			deliver_as_nmi = 1;
+		} else {
+			return -EINVAL;
+		}
+	}
+
 	/*
 	 * Check whether the interrupt nests into another interrupt
 	 * thread.
@@ -1166,6 +1176,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 			ret = -EINVAL;
 			goto out_mput;
 		}
+
+		/* Don't allow nesting if interrupt will be delivered as NMI. */
+		if (deliver_as_nmi) {
+			ret = -EINVAL;
+			goto out_mput;
+		}
+
 		/*
 		 * Replace the primary handler which was provided from
 		 * the driver for non nested interrupt handling by the
@@ -1186,6 +1203,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	 * thread.
 	 */
 	if (new->thread_fn && !nested) {
+		if (deliver_as_nmi)
+			goto out_mput;
+
 		ret = setup_irq_thread(new, irq, false);
 		if (ret)
 			goto out_mput;
-- 
2.7.4

