Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7AF7CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AEA208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AEA208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935272AbeFMBHF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:07:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:64688 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754202AbeFMBBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:01:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 18:01:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,216,1526367600"; 
   d="scan'208";a="47283458"
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
        Marc Zyngier <marc.zyngier@arm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Doug Berger <opendmb@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        iommu@lists.linux-foundation.org
Subject: [RFC PATCH 02/23] genirq: Introduce IRQD_DELIVER_AS_NMI
Date:   Tue, 12 Jun 2018 17:57:22 -0700
Message-Id: <1528851463-21140-3-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain interrupt controllers (e.g., APIC) are capable of delivering
interrupts to the CPU as non-maskable. Add the new IRQD_DELIVER_AS_NMI
interrupt state flag. The purpose of this flag is to communicate to the
underlying irqchip whether the interrupt must be delivered in this manner.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Doug Berger <opendmb@gmail.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 include/linux/irq.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 65916a3..7271a2c 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -208,6 +208,7 @@ struct irq_data {
  * IRQD_SINGLE_TARGET		- IRQ allows only a single affinity target
  * IRQD_DEFAULT_TRIGGER_SET	- Expected trigger already been set
  * IRQD_CAN_RESERVE		- Can use reservation mode
+ * IRQD_DELIVER_AS_NMI		- Deliver this interrupt as non-maskable
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -230,6 +231,7 @@ enum {
 	IRQD_SINGLE_TARGET		= (1 << 24),
 	IRQD_DEFAULT_TRIGGER_SET	= (1 << 25),
 	IRQD_CAN_RESERVE		= (1 << 26),
+	IRQD_DELIVER_AS_NMI		= (1 << 27),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -389,6 +391,16 @@ static inline bool irqd_can_reserve(struct irq_data *d)
 	return __irqd_to_state(d) & IRQD_CAN_RESERVE;
 }
 
+static inline void irqd_set_deliver_as_nmi(struct irq_data *d)
+{
+	__irqd_to_state(d) |= IRQD_DELIVER_AS_NMI;
+}
+
+static inline bool irqd_deliver_as_nmi(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_DELIVER_AS_NMI;
+}
+
 #undef __irqd_to_state
 
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
-- 
2.7.4

