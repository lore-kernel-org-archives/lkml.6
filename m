Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68964C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301B521104
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRqFk1Kz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301B521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbeKLJzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:55:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731933AbeKLIRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:44 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4375821731;
        Sun, 11 Nov 2018 22:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975268;
        bh=ipmYIZzd8QlDFq7L9Y2sb/esF+eDHJwp7P/GCiP2FGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hRqFk1Kzmq5Fs0g0OmPGEOsLeXaRii8i0NnGChNB+08tHIQcVD+XrgCfR+gCaxj6J
         ZGEPAcQP0ZygxI3Hy2NlRIcZM9AybUMY7uEPZQ4A8yxt9BB4Tc8zktdRXSmD5IBURa
         EBMVyUwkF+63Z9CLJHVIYAluhNgIrMwohFhtkB60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin King <colin.king@canonical.com>,
        Alan Douglas <adouglas@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 163/361] PCI: cadence: Correct probe behaviour when failing to get PHY
Date:   Sun, 11 Nov 2018 14:18:30 -0800
Message-Id: <20181111221643.285987365@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pcie-cadence.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/drivers/pci/controller/pcie-cadence.c
+++ b/drivers/pci/controller/pcie-cadence.c
@@ -190,14 +190,16 @@ int cdns_pcie_init_phy(struct device *de
 
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
 
@@ -207,13 +209,15 @@ int cdns_pcie_init_phy(struct device *de
 
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


