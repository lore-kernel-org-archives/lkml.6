Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE463C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16FF21486
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16FF21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbeHWMA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:00:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48034 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730656AbeHWMA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:00:27 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B78B8C74;
        Thu, 23 Aug 2018 08:31:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 173/217] ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates of BTB) for secondary cores
Date:   Thu, 23 Aug 2018 09:54:46 +0200
Message-Id: <20180823075513.365910560@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
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

From: Nishanth Menon <nm@ti.com>

[ Upstream commit 2f8b5b21830aea95989a6e67d8a971297272a086 ]

Call secure services to enable ACTLR[0] (Enable invalidates of BTB with
ICIALLU) when branch hardening is enabled for kernel.

On GP devices OMAP5/DRA7, there is no possibility to update secure
side since "secure world" is ROM and there are no override mechanisms
possible. On HS devices, appropriate PPA should do the workarounds as
well.

However, the configuration is only done for secondary core, since it is
expected that firmware/bootloader will have enabled the required
configuration for the primary boot core (note: bootloaders typically
will NOT enable secondary processors, since it has no need to do so).

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/omap-smp.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -109,6 +109,45 @@ void omap5_erratum_workaround_801819(voi
 static inline void omap5_erratum_workaround_801819(void) { }
 #endif
 
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+/*
+ * Configure ACR and enable ACTLR[0] (Enable invalidates of BTB with
+ * ICIALLU) to activate the workaround for secondary Core.
+ * NOTE: it is assumed that the primary core's configuration is done
+ * by the boot loader (kernel will detect a misconfiguration and complain
+ * if this is not done).
+ *
+ * In General Purpose(GP) devices, ACR bit settings can only be done
+ * by ROM code in "secure world" using the smc call and there is no
+ * option to update the "firmware" on such devices. This also works for
+ * High security(HS) devices, as a backup option in case the
+ * "update" is not done in the "security firmware".
+ */
+static void omap5_secondary_harden_predictor(void)
+{
+	u32 acr, acr_mask;
+
+	asm volatile ("mrc p15, 0, %0, c1, c0, 1" : "=r" (acr));
+
+	/*
+	 * ACTLR[0] (Enable invalidates of BTB with ICIALLU)
+	 */
+	acr_mask = BIT(0);
+
+	/* Do we already have it done.. if yes, skip expensive smc */
+	if ((acr & acr_mask) == acr_mask)
+		return;
+
+	acr |= acr_mask;
+	omap_smc1(OMAP5_DRA7_MON_SET_ACR_INDEX, acr);
+
+	pr_debug("%s: ARM ACR setup for CVE_2017_5715 applied on CPU%d\n",
+		 __func__, smp_processor_id());
+}
+#else
+static inline void omap5_secondary_harden_predictor(void) { }
+#endif
+
 static void omap4_secondary_init(unsigned int cpu)
 {
 	/*
@@ -131,6 +170,8 @@ static void omap4_secondary_init(unsigne
 		set_cntfreq();
 		/* Configure ACR to disable streaming WA for 801819 */
 		omap5_erratum_workaround_801819();
+		/* Enable ACR to allow for ICUALLU workaround */
+		omap5_secondary_harden_predictor();
 	}
 
 	/*


