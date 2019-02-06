Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE16BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26602184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vquy3WCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfBFLIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:08:41 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33516 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfBFLIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:08:39 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16B8bw7103484;
        Wed, 6 Feb 2019 05:08:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549451317;
        bh=JcIZCr2ZoDLLnRrlQJdSZpB3Xsnkta8Ze+j4FMA3BL0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Vquy3WCOAHbGiOAM6abAhmZgQkiwMmrHl3IDdFMnE7Num/Q1BVYj2fWlpjwsSh+Qi
         i0hiNBDUhSy6Ut3lGTAjQwmgtwRiHmzOaPVhVzcOnVwyQ+prE/YM+Kj8o4gCor/LFh
         8FWBp0vF0HnunKJ6nZVMzs9dluyR6j7U0IorBELY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16B8b7Y111780
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 05:08:37 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 05:08:37 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 05:08:36 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16B8WaZ024645;
        Wed, 6 Feb 2019 05:08:35 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Roger Quadros <rogerq@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] phy: core: Add *release* phy_ops invoked when the consumer relinquishes PHY
Date:   Wed, 6 Feb 2019 16:37:50 +0530
Message-ID: <20190206110753.28738-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206110753.28738-1-kishon@ti.com>
References: <20190206110753.28738-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new phy_ops *release* invoked when the consumer relinquishes the
PHY using phy_put/devm_phy_put. The initializations done by the PHY
driver in of_xlate call back can be can be cleaned up here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/phy-core.c  | 5 +++++
 include/linux/phy/phy.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 19b05e824ee4..d4bd85afdc91 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -564,6 +564,11 @@ void phy_put(struct phy *phy)
 	if (!phy || IS_ERR(phy))
 		return;
 
+	mutex_lock(&phy->mutex);
+	if (phy->ops->release)
+		phy->ops->release(phy);
+	mutex_unlock(&phy->mutex);
+
 	module_put(phy->ops->owner);
 	put_device(&phy->dev);
 }
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index e8e118d70fd7..feb8dce54ac2 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -63,6 +63,7 @@ union phy_configure_opts {
  * @set_mode: set the mode of the phy
  * @reset: resetting the phy
  * @calibrate: calibrate the phy
+ * @release: ops to be performed while the consumer reliquishes the PHY
  * @owner: the module owner containing the ops
  */
 struct phy_ops {
@@ -104,6 +105,7 @@ struct phy_ops {
 			    union phy_configure_opts *opts);
 	int	(*reset)(struct phy *phy);
 	int	(*calibrate)(struct phy *phy);
+	void	(*release)(struct phy *phy);
 	struct module *owner;
 };
 
-- 
2.17.1

