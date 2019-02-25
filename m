Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78ECC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BADA2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551132104;
	bh=XMUa9Fxm/nMwpMk0lyntWxL/bwYSCpL2ThcmTMoFap8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aTSr15p/V35O6zbvaTHuGOl2dN7HXv9iWUCBSkpLhT6ul1uoa5mGMo6uWzEdTa3/g
	 2oqY459wtFVyibhO1rKdr7QxqLKM2lqpy94Not9ILicV953+E8z+bn8ZTHC0SK+WUz
	 j/ZCGnF5TZhP6tm9Uk3DCtuPWzIEj5esKGSe3c54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbfBYWBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:48368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729278AbfBYVQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:16:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 987B3217F4;
        Mon, 25 Feb 2019 21:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129396;
        bh=XMUa9Fxm/nMwpMk0lyntWxL/bwYSCpL2ThcmTMoFap8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wqkp9ocm6ct2W8l6fSVSvzihgPYQqGgKaAJ6zbe3wvJv6ng3LnJEd+vIwAg0ZV4mO
         +qpcSmOkcERwa7XVdaI8i5QvPazXVuhvHIfCPEInPkoxrk+5HImNTvc0t/lRMWd099
         BgfJU3PYhDuoI9UXCBfnCYqc39OZRveP8yjWF8tk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 18/71] mfd: qcom_rpm: write fw_version to CTRL_REG
Date:   Mon, 25 Feb 2019 22:11:20 +0100
Message-Id: <20190225195035.880034846@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 52fafea06067e..8d420c37b2a61 100644
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



