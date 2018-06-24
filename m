Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0BBC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE4B24EB1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE4B24EB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbeFXL3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 07:29:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44845 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbeFXL3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 07:29:02 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fX3CW-0004Ed-NM; Sun, 24 Jun 2018 13:29:01 +0200
Date:   Sun, 24 Jun 2018 13:29:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86 pti updates for 4.18
Message-ID: <alpine.DEB.2.21.1806241324000.8650@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-pti-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

Two small updates for the speculative distractions:

  - Make it more clear to the compiler that array_index_mask_nospec()
    is not subject for optimizations. It's not perfect, but ...

  - Don't report XEN PV guests as vulnerable because their mitigation state
    depends on the hypervisor. Report unknown and refer to the hypervisor
    requirement.

Thanks,

	tglx

------------------>
Dan Williams (1):
      x86/spectre_v1: Disable compiler optimizations over array_index_mask_nospec()

Jiri Kosina (1):
      x86/pti: Don't report XenPV as vulnerable


 arch/x86/include/asm/barrier.h | 2 +-
 arch/x86/kernel/cpu/bugs.c     | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 042b5e892ed1..14de0432d288 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -38,7 +38,7 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 {
 	unsigned long mask;
 
-	asm ("cmp %1,%2; sbb %0,%0;"
+	asm volatile ("cmp %1,%2; sbb %0,%0;"
 			:"=r" (mask)
 			:"g"(size),"r" (index)
 			:"cc");
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index cd0fda1fff6d..404df26b7de8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -27,6 +27,7 @@
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
 #include <asm/intel-family.h>
+#include <asm/hypervisor.h>
 
 static void __init spectre_v2_select_mitigation(void);
 static void __init ssb_select_mitigation(void);
@@ -664,6 +665,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 		if (boot_cpu_has(X86_FEATURE_PTI))
 			return sprintf(buf, "Mitigation: PTI\n");
 
+		if (hypervisor_is_type(X86_HYPER_XEN_PV))
+			return sprintf(buf, "Unknown (XEN PV detected, hypervisor mitigation required)\n");
+
 		break;
 
 	case X86_BUG_SPECTRE_V1:
