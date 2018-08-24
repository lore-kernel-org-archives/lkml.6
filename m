Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD01C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687E1208EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 19:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R/rr5Aqb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="az/tfzVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687E1208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeHXXKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:10:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34642 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeHXXKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:10:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4E852601D1; Fri, 24 Aug 2018 19:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535139265;
        bh=0kPaNV4tPwy0jToH8yy7bXCcnwOqIEH8ct7he1VtjEE=;
        h=From:To:Cc:Subject:Date:From;
        b=R/rr5Aqbk4Rx/GWAJEYQDpc9A76KWIIznf1kWL42ubKLG1EcME3VaHy+Y1h74ymgh
         OZUq+wEYUyTPNKvN6RysyZHGIZcB0st2f65fefB5MW1ywuRErC8dVYip05xa5wFGff
         pLBLqy3TH3fZ+7mD+WqyepMntjd8tCWoKilAyCwM=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91F06601D1;
        Fri, 24 Aug 2018 19:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535139264;
        bh=0kPaNV4tPwy0jToH8yy7bXCcnwOqIEH8ct7he1VtjEE=;
        h=From:To:Cc:Subject:Date:From;
        b=az/tfzVFKmyTSjEDh4yNtIovgbN1TUnKtwSOuVJmUTUT1TGZ/3qa/aPwIARCrGEKN
         PBxLEbWRtIGfRK6TpmZW+Vccm6nsOtnUAifZb7jOYzKLXjCyUCuVm277WVg9pAQlJj
         IjORoFQ8xP1WIih5P2maazE0oxh+i67GvF64ympI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91F06601D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH] drivers: qcom: rpmh: avoid sending sleep/wake sets immediately
Date:   Sat, 25 Aug 2018 01:04:12 +0530
Message-Id: <1535139252-20066-1-git-send-email-rplsssn@codeaurora.org>
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
---
 drivers/soc/qcom/rpmh.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index f81488b..390e779 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -237,9 +237,8 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
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
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.

