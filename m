Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52AFC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923AD2184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EJetejEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfBFLIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:08:42 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33520 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbfBFLIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:08:40 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16B8dH7103492;
        Wed, 6 Feb 2019 05:08:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549451319;
        bh=QbjnrCOwfvbyve0jHgDFi86DKkrVu+fyy4HtOfhZMps=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EJetejEOOvfBYgSFiAIAkQ3eQ+YAPxVoAvnppalLyc8NmvMEJfxYSv+e4ts88hGds
         fqOVXycJh2qHZAKiPexgtyJUm/I9GKR9htLxmxE4nsv9EMOTxp98W/HE4grDhhiV/M
         NSf5HOou9xdlVORtnR4Owo5DHh6deSmu9NSuPams=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16B8dXf015369
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 05:08:39 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 05:08:38 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 05:08:38 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16B8Waa024645;
        Wed, 6 Feb 2019 05:08:37 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Roger Quadros <rogerq@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] phy: core: Invoke pm_runtime_get_*/pm_runtime_put_* before invoking reset callback
Date:   Wed, 6 Feb 2019 16:37:51 +0530
Message-ID: <20190206110753.28738-3-kishon@ti.com>
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

PHY drivers may try to access PHY registers in the ->reset() callback.
Invoke phy_pm_runtime_get_sync() before invoking the ->reset() callback
so that the PHY drivers don't have to enable clocks by themselves before
accessing PHY registers.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/phy-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index d4bd85afdc91..fb66f93cd61c 100644
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

