Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF554C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2CC2150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2CC2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeHXBHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 21:07:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50812 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbeHXBHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 21:07:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5187420750; Thu, 23 Aug 2018 23:36:07 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 27A26204AE;
        Thu, 23 Aug 2018 23:36:07 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Roy Pledge <roy.pledge@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when qman is not available
Date:   Thu, 23 Aug 2018 23:35:59 +0200
Message-Id: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the qman driver (qman_ccsr) doesn't probe or fail to probe before
qman_portal, qm_ccsr_start will be either NULL or a stale pointer to an
unmapped page.

This leads to a crash when probing  qman_portal as the init_pcfg function
calls qman_liodn_fixup that tries to read qman registers.

Assume that qman didn't probe when the pool mask is 0.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/soc/fsl/qbman/qman_portal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index a120002b630e..4fc80d2c8feb 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -277,6 +277,8 @@ static int qman_portal_probe(struct platform_device *pdev)
 	}
 
 	pcfg->pools = qm_get_pools_sdqcr();
+	if (pcfg->pools == 0)
+		return -EPROBE_DEFER;
 
 	spin_lock(&qman_lock);
 	cpu = cpumask_next_zero(-1, &portal_cpus);
-- 
2.18.0

