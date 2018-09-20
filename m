Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141D9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8B221526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8B221526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387967AbeITUvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:51:03 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47928 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387858AbeITUvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:51:02 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E6261A01BC;
        Thu, 20 Sep 2018 17:07:07 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 22A3E1A00A0;
        Thu, 20 Sep 2018 17:07:07 +0200 (CEST)
Received: from fsr-fed2164-101.ea.freescale.net (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id A9F8320618;
        Thu, 20 Sep 2018 17:07:06 +0200 (CEST)
From:   Madalin Bucur <madalin.bucur@nxp.com>
To:     leoyang.li@nxp.com
Cc:     roy.pledge@nxp.com, claudiu.manoil@nxp.com,
        catalin.marinas@arm.com, oss@buserror.net,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 3/4] soc/fsl/qbman: Use last response to determine valid bit
Date:   Thu, 20 Sep 2018 18:06:50 +0300
Message-Id: <1537456011-10769-4-git-send-email-madalin.bucur@nxp.com>
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

Use the last valid response when determining what valid bit
to use next for management commands. This is needed in the
case that the portal was previously used by other software
like a bootloader or if the kernel is restarted without a
hardware reset.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 7dbcb475a59c..7f4c57999e08 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -850,12 +850,24 @@ static inline void qm_mr_set_ithresh(struct qm_portal *portal, u8 ithresh)
 
 static inline int qm_mc_init(struct qm_portal *portal)
 {
+	u8 rr0, rr1;
 	struct qm_mc *mc = &portal->mc;
 
 	mc->cr = portal->addr.ce + QM_CL_CR;
 	mc->rr = portal->addr.ce + QM_CL_RR0;
-	mc->rridx = (mc->cr->_ncw_verb & QM_MCC_VERB_VBIT)
-		    ? 0 : 1;
+	/*
+	 * The expected valid bit polarity for the next CR command is 0
+	 * if RR1 contains a valid response, and is 1 if RR0 contains a
+	 * valid response. If both RR contain all 0, this indicates either
+	 * that no command has been executed since reset (in which case the
+	 * expected valid bit polarity is 1)
+	 */
+	rr0 = mc->rr->verb;
+	rr1 = (mc->rr+1)->verb;
+	if ((rr0 == 0 && rr1 == 0) || rr0 != 0)
+		mc->rridx = 1;
+	else
+		mc->rridx = 0;
 	mc->vbit = mc->rridx ? QM_MCC_VERB_VBIT : 0;
 #ifdef CONFIG_FSL_DPAA_CHECKING
 	mc->state = qman_mc_idle;
-- 
2.1.0

