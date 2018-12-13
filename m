Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D9EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D594A20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ERG5tWP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D594A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeLMUeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:34:10 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11066 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeLMUeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:34:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c12c23d0000>; Thu, 13 Dec 2018 12:34:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 13 Dec 2018 12:34:08 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 13 Dec 2018 12:34:08 -0800
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 20:34:08 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 20:34:08 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 20:34:08 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c12c2400000>; Thu, 13 Dec 2018 12:34:08 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Sowjanya Komatineni" <skomatineni@nvidia.com>
Subject: [PATCH V1] mmc: sdhci: Fix sdhci_do_enable_v4_mode
Date:   Thu, 13 Dec 2018 12:34:06 -0800
Message-ID: <1544733246-11678-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544733245; bh=5VPjgfovQQgJ4LTnW17IjsU5AYDEFqzz9p8BEOlX2C4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=ERG5tWP22wcUGIj/9jZA2X32aYSNkiROvIGqEJXoSDa6TDhappPztjaNSCK8ykMAn
         rtMmY6cJiu362wD7akiS7vhb48pV2qnkKFOZQ7Qy8QV8Rz0EYqQq9BCuI3E9iWcDPz
         4tYkzMtfE34JzSOV2tPok1dPVcZ8LVGBgTNSOnIRiiVywUg4UEIXa/HhIU4EN0nYsB
         wO03RdEOiPteRGd/iu/eSCQQvGkci/Rc/R5SrPYElEmQXYVbCZ9DYKFD70IGj68W2k
         a4Gt/JClPP06taXlc+e0Hl4w+ULSrpdj5aJKRxuOigclaH+4CvfJiFIOxDf8qld/lq
         WZVHmsoV9Yb0Q==
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

