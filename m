Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829FAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467DE21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467DE21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732583AbeIXSZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:25:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56616 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbeIXSZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:25:05 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B8B27107E;
        Mon, 24 Sep 2018 12:23:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 131/173] mmc: tegra: prevent HS200 on Tegra 3
Date:   Mon, 24 Sep 2018 13:52:45 +0200
Message-Id: <20180924113125.400434950@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

[ Upstream commit 127407e36f4fe3a1d5e8b9998b479956ce83a7dc ]

The stack assumes that SDHC controller which support SD3.0 (SDR104) do
support HS200. This is not the case for Tegra 3, which does support SD
3.0
but only supports eMMC spec 4.41.

Use SDHCI_QUIRK2_BROKEN_HS200 to indicate that the controller does not
support HS200.

Note that commit 156e14b126ff ("mmc: sdhci: fix caps2 for HS200") added
the tie between SD3.0 (SDR104) and HS200. I don't think that this is
necessarly true. It is fully legitimate to support SD3.0 and not support
HS200. The quirk naming suggests something is broken in the controller,
but this is not the case: The controller simply does not support HS200.

Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-tegra.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -334,7 +334,8 @@ static const struct sdhci_pltfm_data sdh
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_BROKEN_HS200,
 	.ops  = &tegra_sdhci_ops,
 };
 


