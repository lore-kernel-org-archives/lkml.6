Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E7CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179D62054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7IUttWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179D62054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeJYWoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbeJYWoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:11 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E23720840;
        Thu, 25 Oct 2018 14:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476676;
        bh=grlzPBikMCQv4wQt+DFaXc7sS18hanNF2eHQmcywSao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7IUttWFo5Q3unrid6+iQpjAh27xc4Vf0yWDs/twya/YTlgochMWcxrGHKjbb31M7
         /9l6pfLju4qkImdoO8DalAv7aGZBrd4K56ADVmPleUvAKeqbZTyq5GBXj+IeM1JnFq
         EH30XAOyyWhEIy6BBVAQTVB9PAbK3Cyguia+uApY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kevin Hao <haokexin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 15/46] net: phy: Add general dummy stubs for MMD register access
Date:   Thu, 25 Oct 2018 10:10:22 -0400
Message-Id: <20181025141053.213330-15-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Hao <haokexin@gmail.com>

[ Upstream commit 5df7af85ecd88e8b5f1f31d6456c3cf38a8bbdda ]

For some phy devices, even though they don't support the MMD extended
register access, it does have some side effect if we are trying to
read/write the MMD registers via indirect method. So introduce general
dummy stubs for MMD register access which these devices can use to avoid
such side effect.

Fixes: b6b5e8a69118 ("gianfar: Disable EEE autoneg by default")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 17 +++++++++++++++++
 include/linux/phy.h          |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index a174d05a9752..fe76e2c4022a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1641,6 +1641,23 @@ int genphy_config_init(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(genphy_config_init);
 
+/* This is used for the phy device which doesn't support the MMD extended
+ * register access, but it does have side effect when we are trying to access
+ * the MMD register via indirect method.
+ */
+int genphy_read_mmd_unsupported(struct phy_device *phdev, int devad, u16 regnum)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(genphy_read_mmd_unsupported);
+
+int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,
+				 u16 regnum, u16 val)
+{
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(genphy_write_mmd_unsupported);
+
 int genphy_suspend(struct phy_device *phydev)
 {
 	int value;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index dca9e926b88f..efc04c2d92c9 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -879,6 +879,10 @@ static inline int genphy_no_soft_reset(struct phy_device *phydev)
 {
 	return 0;
 }
+int genphy_read_mmd_unsupported(struct phy_device *phdev, int devad,
+				u16 regnum);
+int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,
+				 u16 regnum, u16 val);
 
 /* Clause 45 PHY */
 int genphy_c45_restart_aneg(struct phy_device *phydev);
-- 
2.17.1

