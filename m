Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B629AECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9192082E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5HZppsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9192082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbeKAIoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:44:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbeKAIHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 085CA2081B;
        Wed, 31 Oct 2018 23:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027249;
        bh=BUO7P0P+xdR7VJn0JH/KCflHbLnrDHUs2MdKga7UoHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5HZppsiScH+DqDRUyiHlGG5COnCXe/pncEQq38zJHyrjikELHbxw9AHunTxKBt+Y
         1EbuVhwqYfzfQiLmpHbwhPvMEmwHcevZJNrypGyg7mNrv48/tsEcC3grnlrJmuZJWI
         jZNjAGa5+LFHO92ong8x2xSWpq+I6h6S92ZrzKuQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alan Douglas <adouglas@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 119/146] PCI: cadence: Correct probe behaviour when failing to get PHY
Date:   Wed, 31 Oct 2018 19:05:14 -0400
Message-Id: <20181031230541.28822-119-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Douglas <adouglas@cadence.com>

[ Upstream commit aa77e55d48124d0d78456eabf872fffb5decdbe1 ]

Test the correct value to see whether the PHY get failed.

Use devm_phy_get() instead of devm_phy_optional_get(), since it is
only called if phy name is given in devicetree and so should exist.
If failure when getting or linking PHY, put any PHYs which were
already got and unlink them.

Fixes: dfb80534692ddc5b ("PCI: cadence: Add generic PHY support to host and EP drivers")
Reported-by: Colin King <colin.king@canonical.com>
Signed-off-by: Alan Douglas <adouglas@cadence.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-cadence.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-cadence.c b/drivers/pci/controller/pcie-cadence.c
index 975bcdd6b5c0..cd795f6fc1e2 100644
--- a/drivers/pci/controller/pcie-cadence.c
+++ b/drivers/pci/controller/pcie-cadence.c
@@ -190,14 +190,16 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 
 	for (i = 0; i < phy_count; i++) {
 		of_property_read_string_index(np, "phy-names", i, &name);
-		phy[i] = devm_phy_optional_get(dev, name);
-		if (IS_ERR(phy))
-			return PTR_ERR(phy);
-
+		phy[i] = devm_phy_get(dev, name);
+		if (IS_ERR(phy[i])) {
+			ret = PTR_ERR(phy[i]);
+			goto err_phy;
+		}
 		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
 		if (!link[i]) {
+			devm_phy_put(dev, phy[i]);
 			ret = -EINVAL;
-			goto err_link;
+			goto err_phy;
 		}
 	}
 
@@ -207,13 +209,15 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 
 	ret =  cdns_pcie_enable_phy(pcie);
 	if (ret)
-		goto err_link;
+		goto err_phy;
 
 	return 0;
 
-err_link:
-	while (--i >= 0)
+err_phy:
+	while (--i >= 0) {
 		device_link_del(link[i]);
+		devm_phy_put(dev, phy[i]);
+	}
 
 	return ret;
 }
-- 
2.17.1

