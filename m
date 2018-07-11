Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85EBC468C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905192147A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R7Q2yWWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905192147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390893AbeGKXs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 19:48:59 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33338 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390738AbeGKXs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 19:48:58 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6BNgF06111271;
        Wed, 11 Jul 2018 18:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531352535;
        bh=Sq216FgCJo3sGBSy/wPU8Y3qSwsKFiOCXyl6Cp3chrU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=R7Q2yWWPjM7H+Gyqi14dSzOwTUqTQoBDfn28KpCRPO8+Xlx/TsY2b0BBU1dXdJp3u
         wYi3tEKm3L1bRD8YVrRYd8CVrgTVe0JbgP3dAzWArNjijk39bXvApJun2kiWUaiTqe
         cZOOm0AmPRjfulw3Qkuqns/jXkYzFxExTHOEM9QE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6BNgFaJ003817;
        Wed, 11 Jul 2018 18:42:15 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 11
 Jul 2018 18:42:15 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 11 Jul 2018 18:42:15 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6BNgFN8010665;
        Wed, 11 Jul 2018 18:42:15 -0500
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w6BNgFx17981;
        Wed, 11 Jul 2018 18:42:15 -0500 (CDT)
From:   Suman Anna <s-anna@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/2] mailbox/omap: use of_device_get_match_data() to get match data
Date:   Wed, 11 Jul 2018 18:42:12 -0500
Message-ID: <20180711234212.7756-3-s-anna@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711234212.7756-1-s-anna@ti.com>
References: <20180711234212.7756-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OMAP Mailbox driver is directly using an integer value as
match data for distinguishing the interrupt register layout
between OMAP2 and OMAP4+ SoCs. Introduce a dedicated structure
for storing this match data, and simplify the probe function by
using the of_device_get_match_data() function. This allows the
driver to scale for 64-bit platforms by eliminating the unnecessary
type-casting between a u32 and a void pointer types.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 97c7d9b7f46f..db66e952a871 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -69,6 +69,10 @@ struct omap_mbox_queue {
 	bool full;
 };
 
+struct omap_mbox_match_data {
+	u32 intr_type;
+};
+
 struct omap_mbox_device {
 	struct device *dev;
 	struct mutex cfg_lock;
@@ -638,18 +642,21 @@ static const struct dev_pm_ops omap_mbox_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(omap_mbox_suspend, omap_mbox_resume)
 };
 
+static const struct omap_mbox_match_data omap2_data = { MBOX_INTR_CFG_TYPE1 };
+static const struct omap_mbox_match_data omap4_data = { MBOX_INTR_CFG_TYPE2 };
+
 static const struct of_device_id omap_mailbox_of_match[] = {
 	{
 		.compatible	= "ti,omap2-mailbox",
-		.data		= (void *)MBOX_INTR_CFG_TYPE1,
+		.data		= &omap2_data,
 	},
 	{
 		.compatible	= "ti,omap3-mailbox",
-		.data		= (void *)MBOX_INTR_CFG_TYPE1,
+		.data		= &omap2_data,
 	},
 	{
 		.compatible	= "ti,omap4-mailbox",
-		.data		= (void *)MBOX_INTR_CFG_TYPE2,
+		.data		= &omap4_data,
 	},
 	{
 		/* end */
@@ -692,7 +699,7 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	struct omap_mbox_fifo *fifo;
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *child;
-	const struct of_device_id *match;
+	const struct omap_mbox_match_data *match_data;
 	u32 intr_type, info_count;
 	u32 num_users, num_fifos;
 	u32 tmp[3];
@@ -704,10 +711,10 @@ static int omap_mbox_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	match = of_match_device(omap_mailbox_of_match, &pdev->dev);
-	if (!match)
+	match_data = of_device_get_match_data(&pdev->dev);
+	if (!match_data)
 		return -ENODEV;
-	intr_type = (u32)match->data;
+	intr_type = match_data->intr_type;
 
 	if (of_property_read_u32(node, "ti,mbox-num-users", &num_users))
 		return -ENODEV;
-- 
2.17.1

