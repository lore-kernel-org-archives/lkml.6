Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47B4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9143721905
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WHX4plfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403810AbeLUCQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 21:16:10 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11693 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbeLUCQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 21:16:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1c4cdf0000>; Thu, 20 Dec 2018 18:16:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Dec 2018 18:16:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Dec 2018 18:16:07 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 21 Dec
 2018 02:16:04 +0000
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 21 Dec
 2018 02:16:04 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Dec 2018 02:16:04 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c1c40fe0000>; Thu, 20 Dec 2018 17:25:23 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        "Sowjanya Komatineni" <skomatineni@nvidia.com>
Subject: [PATCH V5 1/3] mmc: sdhci: Fix sdhci_do_enable_v4_mode
Date:   Thu, 20 Dec 2018 17:25:07 -0800
Message-ID: <1545355509-6914-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545355509-6914-1-git-send-email-skomatineni@nvidia.com>
References: <1545355509-6914-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545358561; bh=5VPjgfovQQgJ4LTnW17IjsU5AYDEFqzz9p8BEOlX2C4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=WHX4plfEWP+0G1Tf9SkhtmrXRtjDPgM4YWGrLR6mA1Y8q/PwpkFmfJ3fAE3Ovcj0M
         /F7LWwm17nkoEeOuUkuy6pYnpbAKKs0izHZ+gw5elJSmQmEeCpOVn3pEXUz/ndQzy5
         OE3192thrLIYCHKsWPF+N5RkkGPME7tXHAtyONuQr8rT327l4BNjquSa3avJuRNwsW
         IXn1YfZVEjvI4k7mnUhEjQwBkfglBdoxfS3Gn3R5QRObxFOEk77lz1NiMPFHNe+uRh
         ZKXMkVRJWExF/QpfmtqiOv3Kxdj7/pJow3B7XSHnlAZ/BKYWIrt0FCas068HhXip3z
         GnygjHiVeL4BQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V4_MODE is Bit-15 of SDHCI_HOST_CONTROL2 register.
Need to perform word access to this register.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 99bdae53fa2e..fde984d10619 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -127,12 +127,12 @@ static void sdhci_do_enable_v4_mode(struct sdhci_host *host)
 {
 	u16 ctrl2;
 
-	ctrl2 = sdhci_readb(host, SDHCI_HOST_CONTROL2);
+	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 	if (ctrl2 & SDHCI_CTRL_V4_MODE)
 		return;
 
 	ctrl2 |= SDHCI_CTRL_V4_MODE;
-	sdhci_writeb(host, ctrl2, SDHCI_HOST_CONTROL);
+	sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
 }
 
 /*
-- 
2.7.4

