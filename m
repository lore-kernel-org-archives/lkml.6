Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BE9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36FE2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jAADfVB3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DV/5lMxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfBUMlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:41:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfBUMlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:41:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B5A516098A; Thu, 21 Feb 2019 12:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550752863;
        bh=JoFJoWQYBl3+Q/ru/LRt9fHkldnHES5BxD3Tui7YiEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jAADfVB38vs5fXyB9rNXk1dM/WPNLlAYZe5AqMrQZ6Vb+bRm7K5euXtg+oETBIcj+
         b1J7MSMsD+Ejrb7BG/bgflHa6lO/rYMtzI23odWA7N4z6cVwcawbZBvwg24H9Yp77R
         tBd9emwTvgRamG9gFk7m4L0/lgblCS+2uPlwT6TQ=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3D5960397;
        Thu, 21 Feb 2019 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550752862;
        bh=JoFJoWQYBl3+Q/ru/LRt9fHkldnHES5BxD3Tui7YiEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DV/5lMxMU8IZ4qwUE1H8IdB8JZfsl5keDse53GaNVTh1EmW2TsR0yxlsiQfAzSq7p
         Dld3byJyq3nR0lTrqCPa9HL2lF+kMKVQ+JlEa+k3IdOqqkYLzX+znH9q9I2kvaQ1c2
         OqqB1EAuwT1wp+Xi+WLUi7cfFV13eZX71QRDZ6j4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3D5960397
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, ilina@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v1 1/2] drivers: qcom: rpmh: avoid sending sleep/wake sets immediately
Date:   Thu, 21 Feb 2019 18:10:35 +0530
Message-Id: <20190221124036.30535-2-rplsssn@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221124036.30535-1-rplsssn@codeaurora.org>
References: <20190221124036.30535-1-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the redundant call being made to send the sleep and wake requests
immediately to the controller.

As per the patch[1], the sleep and wake request votes are cached in rpmh
controller and sent during rpmh_flush(). These requests needs to be sent
only during entry of deeper system low power modes or suspend.

[1] https://patchwork.kernel.org/patch/10477533/

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/soc/qcom/rpmh.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index e6e98d461121..877fe78199a3 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -228,9 +228,8 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
 		WARN_ON(irqs_disabled());
 		ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
 	} else {
-		ret = rpmh_rsc_write_ctrl_data(ctrlr_to_drv(ctrlr),
-				&rpm_msg->msg);
 		/* Clean up our call by spoofing tx_done */
+		ret = 0;
 		rpmh_tx_done(&rpm_msg->msg, ret);
 	}
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

