Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D41C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BC520852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BC520852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbeGYRvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:51:24 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:35587 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729184AbeGYRvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:51:24 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id E22AFCD59;
        Wed, 25 Jul 2018 19:38:53 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH v4 07/34] media: camss: csiphy: Ensure clock mux config is done before the rest
Date:   Wed, 25 Jul 2018 19:38:16 +0300
Message-Id: <1532536723-19062-8-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532536723-19062-1-git-send-email-todor.tomov@linaro.org>
References: <1532536723-19062-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a write memory barier after clock mux config and before the rest
of the csiphy config.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-csiphy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index b37e691..2a9adcd 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -364,6 +364,7 @@ static int csiphy_stream_on(struct csiphy_device *csiphy)
 		val |= cfg->csid_id;
 	}
 	writel_relaxed(val, csiphy->base_clk_mux);
+	wmb();
 
 	writel_relaxed(0x1, csiphy->base +
 		       CAMSS_CSI_PHY_GLBL_T_INIT_CFG0);
-- 
2.7.4

