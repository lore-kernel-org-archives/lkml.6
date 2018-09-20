Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA0BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36FB21526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36FB21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387884AbeITUvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:51:00 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53918 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387823AbeITUu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:50:59 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9002A2001DD;
        Thu, 20 Sep 2018 17:07:04 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 823372001C8;
        Thu, 20 Sep 2018 17:07:04 +0200 (CEST)
Received: from fsr-fed2164-101.ea.freescale.net (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D71420618;
        Thu, 20 Sep 2018 17:07:04 +0200 (CEST)
From:   Madalin Bucur <madalin.bucur@nxp.com>
To:     leoyang.li@nxp.com
Cc:     roy.pledge@nxp.com, claudiu.manoil@nxp.com,
        catalin.marinas@arm.com, oss@buserror.net,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 1/4] soc/fsl/qbman: Check if CPU is offline when initializing portals
Date:   Thu, 20 Sep 2018 18:06:48 +0300
Message-Id: <1537456011-10769-2-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
References: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roy Pledge <roy.pledge@nxp.com>

If the affine portal for a specific CPU is offline at boot time
affine its interrupt to CPU 0. If the CPU is later brought online
the hotplug handler will correctly adjust the affinity.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/soc/fsl/qbman/bman.c | 17 +++++++++++++----
 drivers/soc/fsl/qbman/qman.c | 18 +++++++++++++-----
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
index f9485cedc648..2e6e682bf16b 100644
--- a/drivers/soc/fsl/qbman/bman.c
+++ b/drivers/soc/fsl/qbman/bman.c
@@ -562,10 +562,19 @@ static int bman_create_portal(struct bman_portal *portal,
 		dev_err(c->dev, "request_irq() failed\n");
 		goto fail_irq;
 	}
-	if (c->cpu != -1 && irq_can_set_affinity(c->irq) &&
-	    irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
-		dev_err(c->dev, "irq_set_affinity() failed\n");
-		goto fail_affinity;
+	if (cpu_online(c->cpu) && c->cpu != -1 &&
+	    irq_can_set_affinity(c->irq)) {
+		if (irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
+			dev_err(c->dev, "irq_set_affinity() failed %d\n",
+				c->cpu);
+			goto fail_affinity;
+		}
+	} else {
+		/* CPU is offline, direct IRQ to CPU 0 */
+		if (irq_set_affinity(c->irq, cpumask_of(0))) {
+			dev_err(c->dev, "irq_set_affinity() cpu 0 failed\n");
+			goto fail_affinity;
+		}
 	}
 
 	/* Need RCR to be empty before continuing */
diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index ecb22749df0b..7dbcb475a59c 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -935,7 +935,6 @@ static inline int qm_mc_result_timeout(struct qm_portal *portal,
 			break;
 		udelay(1);
 	} while (--timeout);
-
 	return timeout;
 }
 
@@ -1210,10 +1209,19 @@ static int qman_create_portal(struct qman_portal *portal,
 		dev_err(c->dev, "request_irq() failed\n");
 		goto fail_irq;
 	}
-	if (c->cpu != -1 && irq_can_set_affinity(c->irq) &&
-	    irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
-		dev_err(c->dev, "irq_set_affinity() failed\n");
-		goto fail_affinity;
+	if (cpu_online(c->cpu) && c->cpu != -1 &&
+	    irq_can_set_affinity(c->irq)) {
+		if (irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
+			dev_err(c->dev, "irq_set_affinity() failed %d\n",
+				c->cpu);
+			goto fail_affinity;
+		}
+	} else {
+		/* CPU is offline, direct IRQ to CPU 0 */
+		if (irq_set_affinity(c->irq, cpumask_of(0))) {
+			dev_err(c->dev, "irq_set_affinity() cpu 0 failed\n");
+			goto fail_affinity;
+		}
 	}
 
 	/* Need EQCR to be empty before continuing */
-- 
2.1.0

