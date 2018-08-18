Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E3AC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63903219CD
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y2QyEGUB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Of6f0hBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63903219CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeHRDOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 23:14:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40398 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeHRDOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 23:14:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 753976249F; Sat, 18 Aug 2018 00:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534550923;
        bh=ah1HpNq3mNaoX7B22MSvJvMQOu8WfyZVP+8Z/SbmB1c=;
        h=From:To:Subject:Date:From;
        b=Y2QyEGUBiRT3gny7mGcg1zAJqw71KzlsjuwEaPMSxnC4Lmzerb7eLG3AkWQt8Jvrw
         rGYQnSNZj2QULNh9Ht8YR4E1Fgmkx8aKPDH4AWPAiS5zsGFembSOHzGo98auGQlVuH
         C30CreG0mIbieGGYVRoR+joOomiPxvNnItJiEFVM=
Received: from vgutta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnkgutta@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01FD0621AD;
        Sat, 18 Aug 2018 00:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534550922;
        bh=ah1HpNq3mNaoX7B22MSvJvMQOu8WfyZVP+8Z/SbmB1c=;
        h=From:To:Subject:Date:From;
        b=Of6f0hBx8attMq1fDt57Tc1ed2PiLrtB87nQc0UkO0HNyUcfq0e6kcCiHjlufHUFB
         LCYRI69mnToERvmVLL7tWAzgG3ddxV8NYmq/q9Vq89IcXYhhIUFfohw+1oys60V2fm
         aeaJ60jY7wBSUQlEN8UAODvMsJJg6iBtZv+kuA9Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01FD0621AD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vnkgutta@codeaurora.org
From:   Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
To:     robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org, bp@alien8.de,
        evgreen@chromium.org
Subject: [PATCH v2 0/4] Add EDAC driver for QCOM SoCs
Date:   Fri, 17 Aug 2018 17:08:31 -0700
Message-Id: <1534550915-18230-1-git-send-email-vnkgutta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements EDAC driver for QCOM SoCs. As of now, this driver
supports EDAC for Last Level Cache Controller (LLCC). LLCC EDAC driver is
to detect and report single and double bit errors on Last Level Cache
Controller (LLCC) cache. This driver also takes care of dumping registers
and also adding config options to enable and disable panic when these
errors happen in LLCC.

The driver functionality is implemented in:
qcom_edac.c : This platform driver registers to edac framework and
handles the single and double bit errors in cache by registering
interrupt handlers.

llcc-slice.c: It invokes the llcc edac driver and passes platform
data to it.

This patchset depends on the LLCC driver, which is part of 4.19 release.
Link: https://patchwork.kernel.org/patch/10422531/
Link: http://lists-archives.com/linux-kernel/29157082-dt-bindings-documentation-for-qcom-llcc.html

Patch wise description given below:

Patch 1 adds the broadcast base regmap for broadcast writes in llcc.

Patch 2 adds the required changes to register edac driver from llcc driver.

Patch 3 adds the EDAC driver support for QCOM SoCS.

Patch 4 updates the dt bindings of llcc.

Changes since v1:
  * Modified the edac driver
    - Removed duplicate functions that are used to dump the syndrome registers,
      replaced that with a common function and a reg_data datastructure.
    - Removed structure containing function pointers.
    - Addressed comments on error handling to clear the interrupt status.
  * updated Kconfig

Changes since v0:
  * Added EDAC_QCOM config and updated the driver
  * Addressed comments related to indentation and other minor ones

Channagoud Kadabi (1):
  drivers: edac: Add EDAC driver support for QCOM SoCs

Venkata Narendra Kumar Gutta (3):
  drivers: soc: Add broadcast base for Last Level Cache Controller
    (LLCC)
  drivers: soc: Add support to register LLCC EDAC driver
  dt-bindigs: msm: Update documentation of qcom,llcc

 .../devicetree/bindings/arm/msm/qcom,llcc.txt      |  15 +-
 MAINTAINERS                                        |   8 +
 drivers/edac/Kconfig                               |  28 ++
 drivers/edac/Makefile                              |   1 +
 drivers/edac/qcom_edac.c                           | 446 +++++++++++++++++++++
 drivers/soc/qcom/llcc-slice.c                      |  73 ++--
 include/linux/soc/qcom/llcc-qcom.h                 |  31 +-
 7 files changed, 575 insertions(+), 27 deletions(-)
 create mode 100644 drivers/edac/qcom_edac.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

