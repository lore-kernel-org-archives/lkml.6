Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0191C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A227821726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UooCVOHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfAVT4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:56:41 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4312 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfAVT4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:56:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c47755d0000>; Tue, 22 Jan 2019 11:56:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 22 Jan 2019 11:56:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 22 Jan 2019 11:56:37 -0800
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 22 Jan
 2019 19:56:37 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 22 Jan
 2019 19:56:37 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 19:56:36 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c4775740001>; Tue, 22 Jan 2019 11:56:36 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <chunyan.zhang@unisoc.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <anrao@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V10 3/4] mmc: sdhci: Add ADMA3 DMA support for V4 enabled host
Date:   Tue, 22 Jan 2019 11:56:32 -0800
Message-ID: <1548186993-6229-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548186993-6229-1-git-send-email-skomatineni@nvidia.com>
References: <1548186993-6229-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548186973; bh=Ea+nGAhuuF+JPKPnsTU8TAHG9ZaBeukiYrAoT5oPIoo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=UooCVOHe12y5omios9+s5oBBmzD2Zbcw+xqrsWV1IEb0p/8EwRsoAgefis6Hgkbzf
         V0yp2ShJpqEQG9ZiKpwauHay6jyKHBYSGgvVw7T6KW/IwSUvgZY0NksYk11Mhv/Rp/
         3iuhRUMm+brsRmYAFeRvdrdYbGiY8GKaEVBUIOcoGgrlJQozEXkHm19kX+YHsIPHC0
         FmRhth3F9ucSodyIw6ohLQTUrNTOCjP30kZmHj9uVZ0LS11gJqjH70nIB20LgmUA18
         ltjMaVBDpLRBA2/hhElcmyWXso3r6Z0jHzNibjDH20KxWgAefCDd+sWQxykKc4R7gI
         8UyMDfRTpUPIQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below are the supported DMA types in Host Control1 Register
with Version 4 enable
b'00 - SDMA
b'01 - Not Used
b'10 - ADMA2
b'11 - ADMA2 or ADMA3

ADMA3 uses Command Descriptor to issue an SD command.
A multi-block data transfer is performed by using a pair of CMD
descriptor and ADMA2 descriptor.

ADMA3 performs multiple of multi-block data transfer by using
Integrated Descriptor which is more suitable for Command Queuing
to fetch both Command and Transfer descriptors.

Host Capabilities register indiactes the supports of ADMA3 DMA.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V10]: Changes are same as V9 except this series has SDHCI core changes
	into seperate patch 

 drivers/mmc/host/sdhci.c | 9 ++++++++-
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a22e11a65658..c6afe793399e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3353,7 +3353,14 @@ void sdhci_cqe_enable(struct mmc_host *mmc)
 
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 	ctrl &= ~SDHCI_CTRL_DMA_MASK;
-	if (host->flags & SDHCI_USE_64_BIT_DMA)
+	/*
+	 * Host from V4.10 supports ADMA3 DMA type.
+	 * ADMA3 performs integrated descriptor which is more suitable
+	 * for cmd queuing to fetch both command and transfer descriptors.
+	 */
+	if (host->v4_mode && (host->caps1 & SDHCI_CAN_DO_ADMA3))
+		ctrl |= SDHCI_CTRL_ADMA3;
+	else if (host->flags & SDHCI_USE_64_BIT_DMA)
 		ctrl |= SDHCI_CTRL_ADMA64;
 	else
 		ctrl |= SDHCI_CTRL_ADMA32;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6cc9a3c2ac66..4070be49d947 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -88,6 +88,7 @@
 #define   SDHCI_CTRL_ADMA1	0x08
 #define   SDHCI_CTRL_ADMA32	0x10
 #define   SDHCI_CTRL_ADMA64	0x18
+#define   SDHCI_CTRL_ADMA3	0x18
 #define   SDHCI_CTRL_8BITBUS	0x20
 #define  SDHCI_CTRL_CDTEST_INS	0x40
 #define  SDHCI_CTRL_CDTEST_EN	0x80
@@ -230,6 +231,7 @@
 #define  SDHCI_RETUNING_MODE_SHIFT		14
 #define  SDHCI_CLOCK_MUL_MASK	0x00FF0000
 #define  SDHCI_CLOCK_MUL_SHIFT	16
+#define  SDHCI_CAN_DO_ADMA3	0x08000000
 #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
 
 #define SDHCI_CAPABILITIES_1	0x44
-- 
2.7.4

