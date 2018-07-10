Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBE6C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DD4208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fudi9L6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DD4208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732934AbeGJTs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:48:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41628 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbeGJTsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:48:25 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6AJlS90116828;
        Tue, 10 Jul 2018 14:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531252048;
        bh=wqmMlqToFroJuvROZb2wh3G7iDl4mpplvnCjdNNGLF0=;
        h=From:To:CC:Subject:Date;
        b=Fudi9L6ID/WdV+XebigcWPmQW/vdAu5tQ99D6b+ZFoyUpciTc2egfjJQZeLQ46xFh
         1ta2WHm5Tvq9/O1abzzvpNq8/GAmjZSq+ZBW2TB4h/0ylGeNMFqOGqYhwZWofeE6Lk
         m+yAIZj4rqboKdaXMRxKouf/C5wmExh1VwcTxE2U=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6AJlSfD026673;
        Tue, 10 Jul 2018 14:47:28 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 10
 Jul 2018 14:47:27 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 10 Jul 2018 14:47:28 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6AJlRos030440;
        Tue, 10 Jul 2018 14:47:27 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2] ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates of BTB) for secondary cores
Date:   Tue, 10 Jul 2018 14:47:25 -0500
Message-ID: <20180710194725.20339-1-nm@ti.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

NOTE: For U-boot based platforms, please make sure you are on v2018.07 at least.

Linux kernel will complain if the workaround are not activated.

Changes since V1:
* review comments update for commit message, added incode documentation +
  renamed function to better indicate this is for secondary core.

V1: https://patchwork.kernel.org/patch/10461275/

 arch/arm/mach-omap2/omap-smp.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 69df3620eca5..1c73694c871a 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -109,6 +109,45 @@ void omap5_erratum_workaround_801819(void)
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
@@ -131,6 +170,8 @@ static void omap4_secondary_init(unsigned int cpu)
 		set_cntfreq();
 		/* Configure ACR to disable streaming WA for 801819 */
 		omap5_erratum_workaround_801819();
+		/* Enable ACR to allow for ICUALLU workaround */
+		omap5_secondary_harden_predictor();
 	}
 
 	/*
-- 
2.15.1

