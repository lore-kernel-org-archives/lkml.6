Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49048C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2DD2152B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="alstx+1M";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m1974ts2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2DD2152B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeHXQxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:53:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54894 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeHXQxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:53:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F1C6B6053B; Fri, 24 Aug 2018 13:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535116753;
        bh=44vK5nGppzkyqG/kegWEEH3k9W+w2CJuGNO963OCFsI=;
        h=From:To:Cc:Subject:Date:From;
        b=alstx+1MVfOW7QtZcaJNyHbsUjouxeL/Pb14Zk6r9L3lcdmh28VeAcL3HxPTfxuz8
         UcMESs41+QXqzJfEZgTfwGI8SRubDWjV/tmGpM0/FzkYot3NkrBqqbxOOA9UKujxNx
         UgW2ETb2ir1Z3RNl/mZRuQiNU9RMMpPEZ2KBp94M=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5070A60251;
        Fri, 24 Aug 2018 13:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535116752;
        bh=44vK5nGppzkyqG/kegWEEH3k9W+w2CJuGNO963OCFsI=;
        h=From:To:Cc:Subject:Date:From;
        b=m1974ts261I6MB9M11iQeajBkk9k/sTyJQkYNt1Cm4otroHPtLja+np8BpiWLiDtc
         YSXL9c10YNYqFoqnwLOxbPuMFiHtD6reG8vLHxhQBxH4tHBYj1zo7pRKanmIe1Rpcd
         KxDgvGgoqujeVQNG3HBeO2/25FdlA9DXUA5yb7iw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5070A60251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 0/6] Add support for PDC Global on SDM845 SoCs
Date:   Fri, 24 Aug 2018 18:48:54 +0530
Message-Id: <20180824131900.5353-1-sibis@codeaurora.org>
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

v2:
  Incorporated Philipp/Bjorn/Rob suggestions
  Renamed reset binding to pdc-global.txt
  replaced offset with #define of register name
  replaced with devm_reset_control_get_exclusive()
  Separted dt binding from the drivers 

The last 4 remoteproc patches can be picked up after the pdc global
reset driver lands on linux-next.

Sibi Sankar (6):
  dt-bindings: reset: Add PDC Global binding for SDM845 SoCs
  reset: qcom: PDC Global (Power Domain Controller) reset controller
  dt-bindings: remoteproc: Remove additional definition tag
  dt-bindings: remoteproc: Add PDC reset binding for Q6V5 PIL
  remoteproc: qcom: q6v5-pil: Explicitly get mss_restart line
  remoteproc: qcom: q6v5-pil: Add PDC reset for modem on SDM845 SoCs

 .../bindings/remoteproc/qcom,q6v5.txt         |   6 +-
 .../bindings/reset/qcom,pdc-global.txt        |  52 +++++++
 drivers/remoteproc/qcom_q6v5_pil.c            |  31 +++-
 drivers/reset/Kconfig                         |   9 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-qcom-pdc.c                | 142 ++++++++++++++++++
 include/dt-bindings/reset/qcom,sdm845-pdc.h   |  20 +++
 7 files changed, 254 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
 create mode 100644 drivers/reset/reset-qcom-pdc.c
 create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

