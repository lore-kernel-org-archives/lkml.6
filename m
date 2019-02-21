Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232D1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B452086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RDp4l8nQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q7SZI44o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfBUMlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:41:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57260 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfBUMlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:41:08 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EE31F6098D; Thu, 21 Feb 2019 12:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550752868;
        bh=nmjeWWs8FE+8VqdSsNVik9k0lUupJvBKOX8s3o8on7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RDp4l8nQKvhhRukF/3A073ARZ+/IZJJ86X3LPYmdkQKt1K+WWcHlM24/DCCErmUag
         zJTw8L4RidE7Nu2335Mfvw2Hca08JBqqJbM1QnVgj13r5wzf+umiY8iE14SDp0kqhq
         ZSPlThFE+SiVRo9s9z7cVRIiQF0I6y7CPUzg7Ns8=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A8CC6090C;
        Thu, 21 Feb 2019 12:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550752867;
        bh=nmjeWWs8FE+8VqdSsNVik9k0lUupJvBKOX8s3o8on7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7SZI44oLvDGkmX08TvHtFjlkBdHnUPXCYD5DwEQGaAe1GFRf0NY96+5XeH8z1b7k
         q7HZ6YTrlyvkErbey8nPK1zlWXYFm7/0omXHCngWy5wzsNFDjmz/RtWawVWeawfzQq
         nEnIodNYpuDNHu0hALnu2galSW5Np+Then9Z/vUw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A8CC6090C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, ilina@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>
Subject: [PATCH v1 2/2] drivers: soc: qcom: rpmh-rsc: Correct check for slot number
Date:   Thu, 21 Feb 2019 18:10:36 +0530
Message-Id: <20190221124036.30535-3-rplsssn@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221124036.30535-1-rplsssn@codeaurora.org>
References: <20190221124036.30535-1-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maulik Shah <mkshah@codeaurora.org>

The return index value from bitmap_find_next_zero_area can be higher
than available slot. So correct the check to return error in such case.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 10b3102298c7..3ff3bebd4d71 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -491,7 +491,7 @@ static int find_slots(struct tcs_group *tcs, const struct tcs_request *msg,
 	do {
 		slot = bitmap_find_next_zero_area(tcs->slots, MAX_TCS_SLOTS,
 						  i, msg->num_cmds, 0);
-		if (slot == tcs->num_tcs * tcs->ncpt)
+		if (slot >= tcs->num_tcs * tcs->ncpt)
 			return -ENOMEM;
 		i += tcs->ncpt;
 	} while (slot + msg->num_cmds - 1 >= i);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

