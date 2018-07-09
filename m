Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FE2C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13DF208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PNSvxhSB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EhfMwSv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13DF208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933632AbeGIPMf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:12:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43674 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933299AbeGIPMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:12:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4A0C8606AC; Mon,  9 Jul 2018 15:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531149152;
        bh=g+TvRpVx09570I3bQK4yvqg3hH9WdZv2ulCIAKQ7HpM=;
        h=From:To:Cc:Subject:Date:From;
        b=PNSvxhSBgg7XHfbUqsXj2zCA/7O9KSRQ0KMg9lITROtybe0XpXhzco8Edu7g2v0Pe
         uTlcYO2l+/8goDjJas6h96S42SuC6tPwvJ9NmG1ziu4BF415ujt8Zs65YSjrhQuMAp
         voFPhCWPdcHOGkEtWkbwSpQE1J0wQWqvVRbjO8v0=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 464DA6063F;
        Mon,  9 Jul 2018 15:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531149151;
        bh=g+TvRpVx09570I3bQK4yvqg3hH9WdZv2ulCIAKQ7HpM=;
        h=From:To:Cc:Subject:Date:From;
        b=EhfMwSv5Nbz4NQJvkHxB/eWJL62mJq0+craTHE9aGYDNzaV95+GDZOMRizRARSPVu
         q3J9G2dfdBMj/Bf/o4fwE+WRGVuTnEMPykK+PrsKqkIXPGzLEnaTDyjlohXOrOiVHD
         uDxQaBdzs9XuvBzJgpapgP6oiXWLDwsffqcr4kq0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 464DA6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH] remoteproc: qcom: q6v5-pil: fix modem hang on SDM845 after axis2 clk unvote
Date:   Mon,  9 Jul 2018 20:42:20 +0530
Message-Id: <20180709151220.12641-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC_MSS_AXIS2 clock is used for disabling boot IMEM (a part of
AP boot up). With Boot IMEM disable now a part TZ/ATF, AXIS2
clock is no longer required post AP boot up and expected to
remain untouched. However if the clock is turned ON after Q6
is brought out of reset and later turned off, it results in
modem hang. When Q6 attempts a power collapse the internal
handshaking to check if AXIS2 is idle never goes through since
it is turned off preventing the RSC from getting triggered,
leaving modem in a funky state. Hence removing AXIS2 clk
enable/disable from the driver.

[bjorn: identified unvoting axis2 clk caused modem hang]
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index e04319573c91..d7a4b9eca5d2 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -1243,7 +1243,6 @@ static const struct rproc_hexagon_res sdm845_mss = {
 	.hexagon_mba_image = "mba.mbn",
 	.proxy_clk_names = (char*[]){
 			"xo",
-			"axis2",
 			"prng",
 			NULL
 	},
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

