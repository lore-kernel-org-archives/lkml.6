Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21121C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA7E20652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CU0mFNNw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mx8kyXmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA7E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeH2XKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:10:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33706 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeH2XKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:10:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4798E6053D; Wed, 29 Aug 2018 19:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535569957;
        bh=6yGPkD/Kb/gIm+nMvezNUYsSP7vowuYM9Dgn+FOsu2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=CU0mFNNwtl80/Gifl8ag0lpTHpsY+6qNW3EyZ3pTLG7Argt8cdPP7J0q1tLeAzyp4
         jG1CpZXsi/0zSgnuNtSSlk/rKcLX+QTXuuAEYTr52R1Dz4jcYZyxBTv+q9Cvgaynfz
         gv1AI/GOCq9hUtFUYTgyF0+qPzZq7tZLuGULbm6o=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7146360388;
        Wed, 29 Aug 2018 19:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535569956;
        bh=6yGPkD/Kb/gIm+nMvezNUYsSP7vowuYM9Dgn+FOsu2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Mx8kyXmfOANCk9qWpsFxSK5KVc0qNvlkUWfsbpwRZAba50wpvp5Zb/4C9ZOnEgZ+1
         grwuzmjlY0x6s8OZycLBHhA1miFfGG8VXIDpmILdJrbwslnvCRCbsVALeJEGNqSVX0
         L6jWpIJpzNZJDQDEjIBdPRvNuvfnIEy4rSfJkHxU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7146360388
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        mka@chromium.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 0/6] Add support for PDC Global on SDM845 SoCs
Date:   Thu, 30 Aug 2018 00:42:09 +0530
Message-Id: <20180829191215.10071-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support for PDC Global (Power Domain Controller)
on SDM845 SoCs and adds pdc reset lines assert/deassert to remoteproc
Q6v5 modem-pil. The first two patches adds PDC Global reset driver to
control reset signals of Modem, Compute, Display, GPU, Debug, AOP,
Sensors, Audio, SP and APPS. The last four patches (cleans up)/adds pdc
reset lines to q6v5 bindings and asserts/deasserts in modem start/stop
path.

V3:
  refactored pdc reset driver to remove unused layer of indirection
  as suggested by Matthias
  Other minor fixes suggested by Matthias/Bjorn

V2:
  Incorporated Philipp/Bjorn/Rob suggestions
  Renamed reset binding to pdc-global.txt
  replaced offset with #define of register name
  replaced with devm_reset_control_get_exclusive()
  Separted dt binding from the drivers

Sibi Sankar (6):
  dt-bindings: reset: Add PDC Global binding for SDM845 SoCs
  reset: qcom: PDC Global (Power Domain Controller) reset controller
  dt-bindings: remoteproc: qcom: Remove additional definition tag
  dt-bindings: remoteproc: Add PDC reset binding for Q6V5 PIL
  remoteproc: qcom: q6v5-pil: Explicitly get mss_restart line
  remoteproc: qcom: q6v5-pil: Add PDC reset for modem on SDM845 SoCs

 .../bindings/remoteproc/qcom,q6v5.txt         |   8 +-
 .../bindings/reset/qcom,pdc-global.txt        |  52 ++++++++
 drivers/remoteproc/qcom_q6v5_pil.c            |  31 ++++-
 drivers/reset/Kconfig                         |   9 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-qcom-pdc.c                | 124 ++++++++++++++++++
 include/dt-bindings/reset/qcom,sdm845-pdc.h   |  20 +++
 7 files changed, 237 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
 create mode 100644 drivers/reset/reset-qcom-pdc.c
 create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

