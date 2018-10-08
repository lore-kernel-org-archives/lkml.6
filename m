Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C43C676D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B2B2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b3/gMtu7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DvFwf2Ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B2B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeJHULG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:11:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49878 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeJHULG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:11:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4CD5C60C7D; Mon,  8 Oct 2018 12:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539003569;
        bh=71fUGI73NBkpOHwuXaLS9PGk+98bEPMw5LTMDCWvXXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b3/gMtu73tCHHD9wpr6fPrHeVo4Qh9dAMGeW69ts4H/AajbSAP28tPuUMOIOvu2JX
         hVy7XNdBfRdMEhCMN/e4cLsUOCJLvhKMobL8MOOCsrK/ra3hHa1q4jFTu0dSQiB5gP
         an68y4vo+KciN8CHhVkAAYi2dShTB5BC1Gsk7/UY=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BE10960C82;
        Mon,  8 Oct 2018 12:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539003565;
        bh=71fUGI73NBkpOHwuXaLS9PGk+98bEPMw5LTMDCWvXXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvFwf2UtNXdUvD86ddXb6Tpen6Q3gbopGHQrrZeYHOAEBPun1Lywb84RyABcIhaF5
         u8ibdoWfL2cSfj4+kDDQJrRx5NYVk593l6U8HEptond6mWzmBHDOMk1RrKmQW8IXfy
         3L63Ov4cbi47XYU12DwYwa7zBnj1zdKAn5BEe/vA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE10960C82
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, vviswana@codeaurora.org,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, dianders@google.com,
        sayalil@codeaurora.org
Subject: [PATCH V1 6/7] mmc: sdhci-msm: Enable clock scaling property
Date:   Mon,  8 Oct 2018 18:28:05 +0530
Message-Id: <1539003486-24087-7-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539003486-24087-1-git-send-email-sayalil@codeaurora.org>
References: <1539003486-24087-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change enables clock scaling capability for sdhci-msm
platform driver.

Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index e9fe8c6..8846a76 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1803,6 +1803,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	msm_offset = msm_host->offset;
 
 	sdhci_get_of_property(pdev);
+	msm_host->mmc->caps2 |= MMC_CAP2_CLK_SCALE;
 
 	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

