Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A2DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F052E2150D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UtschdH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F052E2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbeI1Uh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:37:27 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4273 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbeI1UhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:37:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bae36f10001>; Fri, 28 Sep 2018 07:13:05 -0700
Received: from HQMAIL103.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 28 Sep 2018 07:13:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 28 Sep 2018 07:13:03 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Sep
 2018 14:13:03 +0000
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Sep
 2018 14:13:02 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Sep 2018 14:13:02 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.143]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bae36ed0000>; Fri, 28 Sep 2018 07:13:02 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Jon Hunter" <jonathanh@nvidia.com>
Subject: [PATCH V2 2/5] usb: xhci: tegra: Power-off power-domains on removal
Date:   Fri, 28 Sep 2018 15:11:47 +0100
Message-ID: <1538143910-24400-3-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
References: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538143985; bh=/Hwmh1mzxLsgmPNH/8Tagrh44ELf+We0bpa7KyRbSTw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=UtschdH3jXB4NSMPKr4NhasP48bb5rQBU1n6N/9lZvnqKOGjbJVbSTndorRXxxkwB
         CnTgdKiqUk//uPl1obdAbiQ1gZTas6plYR1U0IMTxdpF7J5aGkj1KB9tTOpJOwPfA7
         A4u0ye0/mjplIoXBlSF0ngLHjXIFUZ0s/VbVWp8uUwKsJtqBC9bY2DgXbC1tBx7TMD
         KcpBWyBHDE2lwm0WI/PrnwLTwII5ThIDu5e4q+BW0YktTrvG8L3/Jny7AaLIfUPWC0
         Jbsfm46pq8y6ujiK+XpDb4FIGBJh7j/xUH3rseDuqbj61G5UwwXIYu86f9g6kMlkvX
         PueZYzwVREfGA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the XUSB power domains used by the Tegra xHCI controller are
never powered off on the removal of the driver, however, they will be
powered off on probe failure. Update the removal code to be consistent
with the probe failure path to power off the XUSB power domains.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 4b463e5202a4..a586a7930a3d 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1249,6 +1249,11 @@ static int tegra_xusb_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	if (!pdev->dev.pm_domain) {
+		tegra_powergate_power_off(TEGRA_POWERGATE_XUSBC);
+		tegra_powergate_power_off(TEGRA_POWERGATE_XUSBA);
+	}
+
 	tegra_xusb_padctl_put(tegra->padctl);
 
 	return 0;
-- 
2.7.4

