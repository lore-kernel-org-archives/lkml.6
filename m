Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BCEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 04:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60C821908
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 04:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kO8WFGsx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kO8WFGsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbeL1Esr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 23:48:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40862 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbeL1Esr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 23:48:47 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E0724607F1; Fri, 28 Dec 2018 04:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545972526;
        bh=EvO6fWr7C+SLbSMyd4/9AZzhW7Xi2PWRjENczkcdSuE=;
        h=From:To:Cc:Subject:Date:From;
        b=kO8WFGsxOZTqSrs1vZ+eegVoCnpYbrmUZwD6ThPJj+dZCMeWnHRYJd/2d2ezYDneH
         /Fx8a3VzgUkb8NdmmTtmr7HGNwAjRk7JpB0RH6DkMRgSpf83dTDj8naCST/ltBdytR
         94Cmmmbyngojj2/lbzEQ4kjfqvQ2ap5QG1EW2+PY=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CB9E860350;
        Fri, 28 Dec 2018 04:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545972526;
        bh=EvO6fWr7C+SLbSMyd4/9AZzhW7Xi2PWRjENczkcdSuE=;
        h=From:To:Cc:Subject:Date:From;
        b=kO8WFGsxOZTqSrs1vZ+eegVoCnpYbrmUZwD6ThPJj+dZCMeWnHRYJd/2d2ezYDneH
         /Fx8a3VzgUkb8NdmmTtmr7HGNwAjRk7JpB0RH6DkMRgSpf83dTDj8naCST/ltBdytR
         94Cmmmbyngojj2/lbzEQ4kjfqvQ2ap5QG1EW2+PY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB9E860350
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org
Cc:     briannorris@chromium.org, akdwived@codeaurora.org,
        clew@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 0/2] Add firmware bindings for Q6V5 MSS/PAS
Date:   Fri, 28 Dec 2018 10:18:17 +0530
Message-Id: <20181228044819.5697-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q6V5 MSS on certain SoCs like SDM845 are capable of operating under
completely different configuration (like Non-Modem WLAN configuration)
depending on the firmware loaded without any change in boot sequence
of the Hexagon core. The patch series is ultimately aimed to avoid
multiple compatibles per SoC to just specify different upstreamed firmware
locations. This is achieved by using "firmware-name" binding to store
the relative path of mba/modem/pas firmware images.

remoteproc@4080000 { 
	...
	firmware-name = "qcom/sdm845/mss/mba.mbn",
			"qcom/sdm845/mss/modem.mdt";
	...
}

remoteproc@17300000 {
	...
	firmware-name = "qcom/sdm845/lpass/adsp.mdt";
	...
}

Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

v2:
  * Replace "qcom,firmware" with "firmware-name" as suggested
    by Rob
  * Include dt-bindings/parsing logic for PAS based remoteprocs 

Sibi Sankar (2):
  dt-bindings: remoteproc: qcom: Add firmware bindings for Q6V5
  remoteproc: qcom: Add support for parsing fw dt bindings

 .../bindings/remoteproc/qcom,adsp.txt         |  6 +++
 .../bindings/remoteproc/qcom,q6v5.txt         |  7 +++
 drivers/remoteproc/qcom_q6v5_mss.c            | 46 +++++++++++++++----
 drivers/remoteproc/qcom_q6v5_pas.c            | 11 ++++-
 4 files changed, 59 insertions(+), 11 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

