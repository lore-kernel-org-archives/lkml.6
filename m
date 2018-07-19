Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBC7C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A8320671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oPZOd2Rm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oPZOd2Rm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A8320671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbeGSHzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 03:55:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42156 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbeGSHzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 03:55:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E73FA606DB; Thu, 19 Jul 2018 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531984441;
        bh=E+BVWnoP6p51PHVo65EhdBHK+jnOfH7ZGOHuweXT8Dg=;
        h=From:To:Cc:Subject:Date:From;
        b=oPZOd2RmNhAlcKTbnTOsBYN2+F7QUjLM7xa17JeRVWVrzH+uBgAJkPsrVM6y0WUL1
         lJ0q2Tz2MQAePMa+p4V2R1EEnk80BerQq7xzzscTIMqEULSgXFVvycindxy2C1fAIg
         cFwdZXvz0n4QT09hNIEzTCcDl5mewprnUnYpmSx4=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F33860116;
        Thu, 19 Jul 2018 07:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531984441;
        bh=E+BVWnoP6p51PHVo65EhdBHK+jnOfH7ZGOHuweXT8Dg=;
        h=From:To:Cc:Subject:Date:From;
        b=oPZOd2RmNhAlcKTbnTOsBYN2+F7QUjLM7xa17JeRVWVrzH+uBgAJkPsrVM6y0WUL1
         lJ0q2Tz2MQAePMa+p4V2R1EEnk80BerQq7xzzscTIMqEULSgXFVvycindxy2C1fAIg
         cFwdZXvz0n4QT09hNIEzTCcDl5mewprnUnYpmSx4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F33860116
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH 1/7] drivers: qcom: rpmh-rsc: fix the loop index check in get_req_from_tcs
Date:   Thu, 19 Jul 2018 12:43:02 +0530
Message-Id: <1531984382-11780-1-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>

get_req_from_tcs introduced in patch[1] returns tcs_request from
tcs_group. The size of tcs (of type - tcs_group) array in rsc_drv is
TCS_TYPE_NR. So the loop index needs to be iterated up to TCS_TYPE_NR only.

[1] https://patchwork.kernel.org/patch/10477547/

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index fefda0f..33fe9f9 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -190,7 +190,7 @@ static const struct tcs_request *get_req_from_tcs(struct rsc_drv *drv,
 	struct tcs_group *tcs;
 	int i;
 
-	for (i = 0; i < drv->num_tcs; i++) {
+	for (i = 0; i < TCS_TYPE_NR; i++) {
 		tcs = &drv->tcs[i];
 		if (tcs->mask & BIT(tcs_id))
 			return tcs->req[tcs_id - tcs->offset];
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

