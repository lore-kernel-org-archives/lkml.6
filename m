Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A23ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33EB208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="menLpbNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33EB208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbeJYWwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730655AbeJYWwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:39 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F43C2146E;
        Thu, 25 Oct 2018 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477182;
        bh=8zsI32S7eOFA4HVWpgqgd9N4CNVvXXQDMvTb56u++M4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=menLpbNaAaWeJPzbrsL1j+9v1lFta2i4pdrQXKV6G7KNrF9t52VdZpRITXIAM+xJu
         TBvYb5rT6udPUG6USyq7iYyum49chg/x1vat4WB6gN+GXvH2f2uDKxIx3+DaAC8cEC
         zO3ICHQn8fJ6kSUWR4FRy39isA6UPI3Wr++3KMhw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vince Hsu <vinceh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 32/98] usb: host: ehci-tegra: request deferred probe when failing to get phy
Date:   Thu, 25 Oct 2018 10:17:47 -0400
Message-Id: <20181025141853.214051-32-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vince Hsu <vinceh@nvidia.com>

[ Upstream commit f56e67f0a880a5b795cdb5f62614aafe264c5304 ]

The commit 1290a958d48e ("usb: phy: propagate __of_usb_find_phy()'s error on
failure") changed the condition to return -EPROBE_DEFER to host driver.
Originally the Tegra host driver depended on the returned -EPROBE_DEFER to
get the phy device later when booting. Now we have to do that explicitly.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
Tested-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ehci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index aad253559bcd..b4cc4c90b8e3 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -451,7 +451,7 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 
 	u_phy = devm_usb_get_phy_by_phandle(&pdev->dev, "nvidia,phy", 0);
 	if (IS_ERR(u_phy)) {
-		err = PTR_ERR(u_phy);
+		err = -EPROBE_DEFER;
 		goto cleanup_clk_en;
 	}
 	hcd->usb_phy = u_phy;
-- 
2.17.1

