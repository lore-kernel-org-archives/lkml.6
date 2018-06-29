Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD445C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D2727E8E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m2Au75rF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BtwWwDjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D2727E8E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936152AbeF2Lg4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:36:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39360 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932331AbeF2Lgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:36:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 091EF60452; Fri, 29 Jun 2018 11:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530272214;
        bh=rxAkJVAnc7mAegan/CMD0Hn/W0Zh1egr/57GjNa7dMk=;
        h=From:To:Cc:Subject:Date:From;
        b=m2Au75rFmewqxo74q/St/3RomUoWDv1+MSoLv4SsJr+jmlnDqd6DkQRB2S+P7av8m
         YnqT7pRQ3Ks75SoB07NdEdZwW1nlA+SwPL5tkwagIrXW4RpYK60K5YxHxn5cgY5zJX
         D7d+FzGxORpE1LEritlBHF8U+qP2MTzSEFbzsBHk=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9612360452;
        Fri, 29 Jun 2018 11:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530272213;
        bh=rxAkJVAnc7mAegan/CMD0Hn/W0Zh1egr/57GjNa7dMk=;
        h=From:To:Cc:Subject:Date:From;
        b=BtwWwDjNWzZp0c794CDNg3y0nbr+fPRQOWiyg3fC3l0KfkNkwfH3aIgD6snYWsztI
         +Z8Fxwvvn+N3hGdbmPxsacsNQ7+jHfLqNBaxl+PoSAGnADYvGMK+1n5j6Cvkpiofxs
         NNhAki1YL/dyGENH2IoSJq91Sa3Bo0YEdXZ4ONUc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9612360452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org
Cc:     andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH RESEND 1/1] clk/mmcc-msm8996: Make mmagic_bimc_gdsc ALWAYS_ON
Date:   Fri, 29 Jun 2018 17:06:40 +0530
Message-Id: <20180629113640.11888-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch (7705bb7176b9 clk: qcom: mmcc-msm8996: leave all mmagic gdscs
and clocks always enabled") makes all mmgaic gdscs ALWAYS_ON.
The mmagic_bimc_gdsc is also needed to be turned on to get display
working on 8x96.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

 - Corrected the hash id of upstream patch in commit message.

 drivers/clk/qcom/mmcc-msm8996.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/mmcc-msm8996.c b/drivers/clk/qcom/mmcc-msm8996.c
index dfc5b4e431d3..38311a67e846 100644
--- a/drivers/clk/qcom/mmcc-msm8996.c
+++ b/drivers/clk/qcom/mmcc-msm8996.c
@@ -2910,6 +2910,7 @@ static struct gdsc mmagic_bimc_gdsc = {
 		.name = "mmagic_bimc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = ALWAYS_ON,
 };
 
 static struct gdsc mmagic_video_gdsc = {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

