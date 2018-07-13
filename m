Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69D0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648E520873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nuN2R26T";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QkJgxbMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648E520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeGMKIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:08:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50242 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeGMKIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:08:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5FEFC6078C; Fri, 13 Jul 2018 09:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531475656;
        bh=71fUGI73NBkpOHwuXaLS9PGk+98bEPMw5LTMDCWvXXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nuN2R26Tn2F0CEuoHcsPDRqwwck/ms3l0RWN/HbSyZ1VV2z/9H10R67czgvyu/mlB
         IHWAAGcB36J+Kpd2YH69h/DpQB1doW2b4Upobn4QfzVc0VXIyu21F8/G+g9WhAGsb/
         yEqAHJ3tzYJaqS3RP1JzPLuO2xoJKn98WyBNoWqE=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4BDA605FF;
        Fri, 13 Jul 2018 09:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531475655;
        bh=71fUGI73NBkpOHwuXaLS9PGk+98bEPMw5LTMDCWvXXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QkJgxbMWLm3Ltm6+8G4K9cjn2Ps38r/5cTFnVYOJj+x4uYN9WfefPO7eaQt6lfp/a
         31VSP3FrZVl7VULbArmucuF+q8jPEWgVLU4Le2iu+rH2WuzsdVz+LwrYIUIY145LZF
         SSO6AAxQRLyAGiorgQmQI+KzZnNpsUmQvvprOJnE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4BDA605FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, vviswana@codeaurora.org,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, sayalil@codeaurora.org
Subject: [PATCH RFC 6/7] mmc: sdhci-msm: Enable clock scaling property
Date:   Fri, 13 Jul 2018 15:23:02 +0530
Message-Id: <1531475583-7050-7-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
References: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
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

