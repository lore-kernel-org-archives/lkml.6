Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40014C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D857E2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JXkNY4am";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b8kWxyxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D857E2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbeJXBxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:53:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35268 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeJXBxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:53:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8FC9660CEB; Tue, 23 Oct 2018 17:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540315764;
        bh=kB6K0tSdLvYt2Ks47uPYUbg18/vHjM3H3D7/OeLsz5I=;
        h=From:To:Cc:Subject:Date:From;
        b=JXkNY4ammaBYuRV29PRr/eGFzuYBRBwPyq/l2xlD6jQj6eyM6EYGsLgLGuWRQVFn4
         YCvwRFErp+nF8vTBs6lhWlstRtFvj1t11wbeWP7CaEjcNSTUg8N/bM+1QHHzLe25Tx
         evQoCv2k+guiHe8skNwcwbcFDxgHMLBZA9UBSFgg=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ADDED6034D;
        Tue, 23 Oct 2018 17:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540315763;
        bh=kB6K0tSdLvYt2Ks47uPYUbg18/vHjM3H3D7/OeLsz5I=;
        h=From:To:Cc:Subject:Date:From;
        b=b8kWxyxkq5gTBhm5jFemnGhA9hw0Co0gpWh1bs/qYmNlXabGnjZmkujD66EAAMYtj
         OH3sIRJ9WweW/wSu+mI1yz3tCXw+2WWOY5YBD7dRE8V9Y6iB0Ii3GenB8JihW4ofDn
         flkckskAl3Dzs1/PH7icyp8OYtNCMOgfD/jAZ0+U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ADDED6034D
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
Subject: [PATCH RESEND] drivers: qcom: rpmh: avoid sending sleep/wake sets immediately
Date:   Tue, 23 Oct 2018 22:59:08 +0530
Message-Id: <1540315748-29158-1-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the redundant call being made to send the sleep and wake requests
immediately to the controller.

As per the patch[1], the sleep and wake request votes are cached in rpmh
controller and sent during rpmh_flush(). These requests needs to be sent
only during entry of deeper system low power modes or suspend.

[1]https://patchwork.kernel.org/patch/10477533/

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/soc/qcom/rpmh.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index e6e98d4..877fe78 100644
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

