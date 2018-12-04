Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4250C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6031520850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HA2WTpto";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GTjnLMMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6031520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeLDDui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 22:50:38 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35268 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeLDDui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 22:50:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 16A4C606FA; Tue,  4 Dec 2018 03:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543895437;
        bh=Piv1dxtL5r8CQuZmB4FFCKVnhS+8aMckNPd7B/Db6i0=;
        h=From:To:Cc:Subject:Date:From;
        b=HA2WTpto+kkTrA8djV0nMBvPt5o57nZclJ/NHfDJY/EgyofFgJYsDkIXD+85FTbaN
         YtjqWVoM44VMqWKh5w39MIV64r66QbV69V1+mStVlf9m0fl7LNk7wnCqQDleORkqvd
         0KmTM/a850IiHE1yhFV3OZirwmoiac4ogfSJ6ohM=
Received: from davidai-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 462736019F;
        Tue,  4 Dec 2018 03:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543895436;
        bh=Piv1dxtL5r8CQuZmB4FFCKVnhS+8aMckNPd7B/Db6i0=;
        h=From:To:Cc:Subject:Date:From;
        b=GTjnLMMsu+whq+sASwbduiU3MfEpryzrFbkp1cVCw5769TKpp9mW4EiWs5h9jzPZw
         jDkBG/Por+O0yZtLjuOLR8YlT3r9IqvXb4cbmX2Q4P/xcL+0W6cMHC3E/4plMOg2pZ
         v0oT+5gJ1ivbn+CvK41GTEItG6kJzX0bgcd8in/U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 462736019F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
From:   David Dai <daidavid1@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     David Dai <daidavid1@codeaurora.org>, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        tdas@codeaurora.org, elder@linaro.org
Subject: [RFC PATCH] Add IPA clock support for clk-rpmh
Date:   Mon,  3 Dec 2018 19:50:12 -0800
Message-Id: <1543895413-1553-1-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends the existing clk-rpmh driver to support a different
type of RPMh resource known as Bus Clock Manager(BCM) in order to scale
performance for the Qualcomm IP Accelerator(IPA) core clock.

David Dai (1):
  clk: qcom: clk-rpmh: Add IPA clock support

 drivers/clk/qcom/clk-rpmh.c           | 142 ++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/qcom,rpmh.h |   1 +
 2 files changed, 143 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

