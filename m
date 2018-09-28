Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FECC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20412170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20412170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeI1PGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:06:23 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50710 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbeI1PGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:06:23 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A430200077;
        Fri, 28 Sep 2018 10:43:40 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6E3972000BC;
        Fri, 28 Sep 2018 10:43:40 +0200 (CEST)
Received: from fsr-fed2164-101.ea.freescale.net (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0A0092039E;
        Fri, 28 Sep 2018 10:43:40 +0200 (CEST)
From:   Madalin Bucur <madalin.bucur@nxp.com>
To:     leoyang.li@nxp.com
Cc:     roy.pledge@nxp.com, claudiu.manoil@nxp.com,
        catalin.marinas@arm.com, oss@buserror.net,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH v2 2/5] soc/fsl/qbman: replace CPU 0 with any online CPU in hotplug handlers
Date:   Fri, 28 Sep 2018 11:43:21 +0300
Message-Id: <1538124204-31406-3-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
References: <1538124204-31406-1-git-send-email-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing code sets portal IRQ affinity to CPU 0 in the
offline hotplug handler. If CPU 0 is offline this is invalid.
Use a different online CPU instead.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/soc/fsl/qbman/bman_portal.c | 4 +++-
 drivers/soc/fsl/qbman/qman_portal.c | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
index 2f71f7df3465..088cdfa7c034 100644
--- a/drivers/soc/fsl/qbman/bman_portal.c
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -65,7 +65,9 @@ static int bman_offline_cpu(unsigned int cpu)
 	if (!pcfg)
 		return 0;
 
-	irq_set_affinity(pcfg->irq, cpumask_of(0));
+	/* use any other online CPU */
+	cpu = cpumask_any_but(cpu_online_mask, cpu);
+	irq_set_affinity(pcfg->irq, cpumask_of(cpu));
 	return 0;
 }
 
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index a120002b630e..4efd6ea598b1 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -195,8 +195,10 @@ static int qman_offline_cpu(unsigned int cpu)
 	if (p) {
 		pcfg = qman_get_qm_portal_config(p);
 		if (pcfg) {
-			irq_set_affinity(pcfg->irq, cpumask_of(0));
-			qman_portal_update_sdest(pcfg, 0);
+			/* select any other online CPU */
+			cpu = cpumask_any_but(cpu_online_mask, cpu);
+			irq_set_affinity(pcfg->irq, cpumask_of(cpu));
+			qman_portal_update_sdest(pcfg, cpu);
 		}
 	}
 	return 0;
-- 
2.1.0

