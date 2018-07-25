Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80498C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB4920852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB4920852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbeGYRyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:54:24 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:35606 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729819AbeGYRvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:51:25 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 27120CD60;
        Wed, 25 Jul 2018 19:38:54 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH v4 14/34] media: camss: vfe: Do not disable CAMIF when clearing its status
Date:   Wed, 25 Jul 2018 19:38:23 +0300
Message-Id: <1532536723-19062-15-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532536723-19062-1-git-send-email-todor.tomov@linaro.org>
References: <1532536723-19062-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "no change" value when clearing CAMIF status and make sure
this is done before configuring the new command.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 77167f1..15a1a01 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -156,6 +156,7 @@
 #define VFE_0_CAMIF_CMD				0x2f4
 #define VFE_0_CAMIF_CMD_DISABLE_FRAME_BOUNDARY	0
 #define VFE_0_CAMIF_CMD_ENABLE_FRAME_BOUNDARY	1
+#define VFE_0_CAMIF_CMD_NO_CHANGE		3
 #define VFE_0_CAMIF_CMD_CLEAR_CAMIF_STATUS	(1 << 2)
 #define VFE_0_CAMIF_CFG				0x2f8
 #define VFE_0_CAMIF_CFG_VFE_OUTPUT_EN		(1 << 6)
@@ -1021,8 +1022,10 @@ static void vfe_set_camif_cfg(struct vfe_device *vfe, struct vfe_line *line)
 
 static void vfe_set_camif_cmd(struct vfe_device *vfe, u32 cmd)
 {
-	writel_relaxed(VFE_0_CAMIF_CMD_CLEAR_CAMIF_STATUS,
+	writel_relaxed(VFE_0_CAMIF_CMD_CLEAR_CAMIF_STATUS |
+		       VFE_0_CAMIF_CMD_NO_CHANGE,
 		       vfe->base + VFE_0_CAMIF_CMD);
+	wmb();
 
 	writel_relaxed(cmd, vfe->base + VFE_0_CAMIF_CMD);
 }
-- 
2.7.4

