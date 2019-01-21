Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E41C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983CB20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lg9VzX1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfAUHfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:35:07 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55088 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfAUHfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:35:05 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0L7Z3ZK007138;
        Mon, 21 Jan 2019 01:35:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548056103;
        bh=1OR4FV6bic24WdSJXJpptCw50x0hnyU1VN8fM2fF2dM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lg9VzX1ZfYaK33YO3pV7Lh9fXzd/A0FnedzWiSRLByOmxim12B1yseXXVxern8c9Z
         N86AuL0dBaR3AS5vBodfhDDJqwwyEaERoDL+qtoxWewxt13FyughAL+/rEsZUV2llx
         ALPVQZAROSJQRP9spLhZ0dCQ9PhRwN04Zb9HDpr4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0L7Z3mK057553
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 01:35:03 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 21
 Jan 2019 01:35:03 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 21 Jan 2019 01:35:03 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0L7YwI8026303;
        Mon, 21 Jan 2019 01:35:01 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, Roger Quadros <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/3] phy: core: Invoke pm_runtime_get_*/pm_runtime_put_* before invoking reset callback
Date:   Mon, 21 Jan 2019 12:18:11 +0530
Message-ID: <20190121064813.18444-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190121064813.18444-1-kishon@ti.com>
References: <20190121064813.18444-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHY drivers may try to access PHY registers in the ->reset() callback.
Invoke phy_pm_runtime_get_sync() before invoking the ->reset() callback
so that the PHY drivers don't have to enable clocks by themselves before
accessing PHY registers.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/phy-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 19b05e824ee4..bf3a1fc18117 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -384,10 +384,16 @@ int phy_reset(struct phy *phy)
 	if (!phy || !phy->ops->reset)
 		return 0;
 
+	ret = phy_pm_runtime_get_sync(phy);
+	if (ret < 0 && ret != -ENOTSUPP)
+		return ret;
+
 	mutex_lock(&phy->mutex);
 	ret = phy->ops->reset(phy);
 	mutex_unlock(&phy->mutex);
 
+	phy_pm_runtime_put(phy);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(phy_reset);
-- 
2.17.1

