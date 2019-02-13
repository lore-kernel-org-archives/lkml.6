Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A55C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE7C20835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026610;
	bh=MFeAnHiJ4r6YGufQ8LsUH1G9t/JAmsxD/hPI1z5JOmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ASZyaBJGnQKEIvncrEerKOMgb2cm6cmmEKir5HWP2IWjsUFJwiUHD9owkNhFpzBZ3
	 HlonMeKr03AGNl5Muh/tTlilYxx21xuGBDrV8Van31MFNQjndot4ZR8OcZwbYsoYtR
	 Gi155dpA4OnYorLFPAUheFNLgPhdnezKuDFUpeNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390129AbfBMC4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388256AbfBMChQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:37:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C2A8206B6;
        Wed, 13 Feb 2019 02:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025436;
        bh=MFeAnHiJ4r6YGufQ8LsUH1G9t/JAmsxD/hPI1z5JOmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ldXki8z9P56zSIRzBPLzaY+JlAzbV/toEOimYtWzxRLi9R9Z8g2ELnNr0dzn/H6Y2
         peLf6ZWHnQ8kiBLmH0J+mtMLtpywBy1Anr4c79sdZGuUr384fDlvUK6nUzela+0sXc
         FU6jQKhN1nmxFQB09eNfCEwW5XASmgsDste2mxDU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonathan Marek <jonathan@marek.ca>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 12/83] mfd: qcom_rpm: write fw_version to CTRL_REG
Date:   Tue, 12 Feb 2019 21:35:50 -0500
Message-Id: <20190213023701.20286-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Marek <jonathan@marek.ca>

[ Upstream commit 504e4175829c44328773b96ad9c538e4783a8d22 ]

This is required as part of the initialization sequence on certain SoCs.

If these registers are not initialized, the hardware can be unresponsive.
This fixes the driver on apq8060 (HP TouchPad device).

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/qcom_rpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
index 52fafea06067..8d420c37b2a6 100644
--- a/drivers/mfd/qcom_rpm.c
+++ b/drivers/mfd/qcom_rpm.c
@@ -638,6 +638,10 @@ static int qcom_rpm_probe(struct platform_device *pdev)
 		return -EFAULT;
 	}
 
+	writel(fw_version[0], RPM_CTRL_REG(rpm, 0));
+	writel(fw_version[1], RPM_CTRL_REG(rpm, 1));
+	writel(fw_version[2], RPM_CTRL_REG(rpm, 2));
+
 	dev_info(&pdev->dev, "RPM firmware %u.%u.%u\n", fw_version[0],
 							fw_version[1],
 							fw_version[2]);
-- 
2.19.1

