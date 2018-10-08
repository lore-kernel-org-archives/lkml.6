Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A37C6787A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3057C213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YHDTg8OE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3057C213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeJIHEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:04:54 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59164 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeJIHEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:04:09 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w98Nnq6R074788;
        Mon, 8 Oct 2018 18:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539042592;
        bh=O2+B9ZyS4qEEL4pahdJEhkZn9FK377JlFf1+Tyq5uW8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YHDTg8OE4FAVezLbct5fi86T6mSyoYjJ3eEO8b9yDBW3a3KknuqYiUbWSZNUvd1L6
         BHNCZyVq81liX0myG3Buq4/1rppj53QvESzXDH+ei4YfxjzSfiyKcraGlf4xB8FIaz
         rD9WTuD7pb0PuTS1RS8zqVdSLnrV28uAaZwJdyWM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98NnqmW023941;
        Mon, 8 Oct 2018 18:49:52 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 8 Oct
 2018 18:49:51 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 8 Oct 2018 18:49:51 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98Nnp7q027737;
        Mon, 8 Oct 2018 18:49:51 -0500
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w98Nnpx25212;
        Mon, 8 Oct 2018 18:49:51 -0500 (CDT)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH 01/11] phy: core add phy_set_netif_mode() api
Date:   Mon, 8 Oct 2018 18:49:39 -0500
Message-ID: <20181008234949.15416-2-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20181008234949.15416-1-grygorii.strashko@ti.com>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new API phy_set_netif_mode(struct phy *phy, phy_interface_t mode) and
new PHY operation callback .set_netif_mode() which intended to be implemnte
by PHY drivers which supports Network interrfaces mode selection. Both
accepts phy_interface_t vlaue as input parameter.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/phy/phy-core.c  | 15 +++++++++++++++
 include/linux/phy/phy.h | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 35fd38c..d9aba1a 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -377,6 +377,21 @@ int phy_set_mode(struct phy *phy, enum phy_mode mode)
 }
 EXPORT_SYMBOL_GPL(phy_set_mode);
 
+int phy_set_netif_mode(struct phy *phy, phy_interface_t mode)
+{
+	int ret;
+
+	if (!phy || !phy->ops->set_netif_mode)
+		return 0;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->set_netif_mode(phy, mode);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_set_netif_mode);
+
 int phy_reset(struct phy *phy)
 {
 	int ret;
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 9713aeb..bc73d2b 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/device.h>
+#include <linux/phy.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
@@ -49,6 +50,7 @@ enum phy_mode {
  * @power_on: powering on the phy
  * @power_off: powering off the phy
  * @set_mode: set the mode of the phy
+ * @set_netif_mode: set the mode of the net interface phy
  * @reset: resetting the phy
  * @calibrate: calibrate the phy
  * @owner: the module owner containing the ops
@@ -59,6 +61,7 @@ struct phy_ops {
 	int	(*power_on)(struct phy *phy);
 	int	(*power_off)(struct phy *phy);
 	int	(*set_mode)(struct phy *phy, enum phy_mode mode);
+	int	(*set_netif_mode)(struct phy *phy, phy_interface_t mode);
 	int	(*reset)(struct phy *phy);
 	int	(*calibrate)(struct phy *phy);
 	struct module *owner;
@@ -163,6 +166,7 @@ int phy_exit(struct phy *phy);
 int phy_power_on(struct phy *phy);
 int phy_power_off(struct phy *phy);
 int phy_set_mode(struct phy *phy, enum phy_mode mode);
+int phy_set_netif_mode(struct phy *phy, phy_interface_t mode);
 static inline enum phy_mode phy_get_mode(struct phy *phy)
 {
 	return phy->attrs.mode;
@@ -283,6 +287,14 @@ static inline int phy_set_mode(struct phy *phy, enum phy_mode mode)
 	return -ENOSYS;
 }
 
+static inline int phy_set_netif_mode(struct phy *phy,
+				     phy_interface_t mode)
+{
+	if (!phy)
+		return 0;
+	return -ENOTSUPP;
+}
+
 static inline enum phy_mode phy_get_mode(struct phy *phy)
 {
 	return PHY_MODE_INVALID;
-- 
2.10.5

