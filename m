Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF25C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D190E2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D190E2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391855AbeKVNtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:49:24 -0500
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:34480
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730504AbeKVNtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:49:23 -0500
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id PfOQgqzUCse9VPfOQgywCR; Wed, 21 Nov 2018 20:11:02 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gPfOP-0004GQ-SO; Wed, 21 Nov 2018 20:11:01 -0700
From:   kys@linuxonhyperv.com
To:     will.deacon@arm.com, catalin.marinas@armm.com,
        mark.rutland@arm.com, marc.zyngier@arm.com,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com,
        sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com,
        vkuznets@redhat.com
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 3/4] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
Date:   Thu, 22 Nov 2018 03:10:58 +0000
Message-Id: <20181122031059.16338-3-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122031059.16338-1-kys@linuxonhyperv.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
MIME-Version: 1.0
Reply-To: kys@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLJu3a4QI8aw6Tzl5UCoLusefq6FAcOrnyMe75v908rojsSVShaQRGsYFMiKZKRl8gL/JWmm5uwsyooKF0ojAQWKN7ohNJiBM4RfmDR+PtV6BWqEZ5Vf
 /P+m78RZusUKyRvgZe45CxRqSbeyvy5kI8dPY7XXEtmUhZ7GHfS+2FERB25hDZUBQ3oReb3A5GcncYxu8zOOTDC+AzR4yHw+ZThH42e8fy6p9QUlGbqhqjmT
 8xk+R1vqMoNGcF+Kvszp1ZsvpLCrdoSz9XZOo4rC8jritvpeF6unI/Vh4/cGJmjuVln+ZWLGhZ530H1R0/V1bmpppax4cwS9fxuKbVJ3hiPzyeCmVuUB5pvG
 MpLcWCHMoHt60l0QE5ePs6CDTjZnLrItsPesaWi3UAtm8tcQmwLCKSs0cIbZUVFWMhF59UeYwxRpyWsSqUQzbr+FXY0nuI/xvuv4jTqhHsKz+aYVaPqjshmM
 vInPi/A2/5d1ZEcm0wEb45O9A6UyrEcm2BX+9B0sbEcN03Jro7aXvBmynLQ8voLqj7Kw20NMS4DZ3cNwlJWr9pkEX/WAl+TZdJ2l4dvdALuwsoY53d7t0hnf
 8qNpGs30NN+dpL6hX+e9H/fiScmcEGI/RW/B6GqFVraw+yC0w5tCMdj95rsqOYSLPYTgPM57HlcTMiWhlYkUSZbw5SY4/HB3ghWKVcjTxADsLn3KoKGUlGOV
 VgZ2I3mpvYXiACmCAziuqz9sOUoS+pca1HXs+rxJ2QLdzapQNjPz/g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

Add hooks to enable/disable a per-CPU IRQ for VMbus. These hooks
are in the architecture independent setup and shutdown paths for
Hyper-V, and are needed by Linux guests on Hyper-V on ARM64.  The
x86/x64 implementation is null because VMbus interrupts on x86/x64
don't use an IRQ.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 4 ++++
 drivers/hv/hv.c                 | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 0d6271cce198..8d97bd3a13a6 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -109,6 +109,10 @@ void hyperv_vector_handler(struct pt_regs *regs);
 void hv_setup_vmbus_irq(void (*handler)(void));
 void hv_remove_vmbus_irq(void);
 
+/* On x86/x64, there isn't a real IRQ to be enabled/disable */
+static inline void hv_enable_vmbus_irq(void) {}
+static inline void hv_disable_vmbus_irq(void) {}
+
 void hv_setup_kexec_handler(void (*handler)(void));
 void hv_remove_kexec_handler(void);
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 166c2501de17..d0bb09a4bd73 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -307,6 +307,7 @@ int hv_synic_init(unsigned int cpu)
 	hv_set_siefp(siefp.as_uint64);
 
 	/* Setup the shared SINT. */
+	hv_enable_vmbus_irq();
 	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	shared_sint.vector = HYPERVISOR_CALLBACK_VECTOR;
@@ -434,6 +435,7 @@ int hv_synic_cleanup(unsigned int cpu)
 	/* Disable the global synic bit */
 	sctrl.enable = 0;
 	hv_set_synic_state(sctrl.as_uint64);
+	hv_disable_vmbus_irq();
 
 	return 0;
 }
-- 
2.19.1

