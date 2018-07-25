Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073C3C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48ED20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WJsMNBQ0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P26Br2NX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48ED20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbeGYS5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:57:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60348 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbeGYS5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:57:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 27C4760B11; Wed, 25 Jul 2018 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532540704;
        bh=tHv8WUl37jV6vrbI9qsriIpA1hr+NCi3NSWIrjE6CjU=;
        h=From:To:Subject:Date:From;
        b=WJsMNBQ0hWT8AAfckBO+6nEsmdSY2ZRv3YBXz9jaVaGwnzqO8eBWqRQA/ysbaoUTP
         XDU0AE5uB2Ev+sYDZGODOe1ZBopsOAhtEEGETC0Cz1npAv7BM52X2pO7WQevDbddAB
         UyvlWkVwfsGezKESIWZtH5NDQXYMQ9Q7EBenUg3o=
Received: from vgutta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnkgutta@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C090E60594;
        Wed, 25 Jul 2018 17:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532540703;
        bh=tHv8WUl37jV6vrbI9qsriIpA1hr+NCi3NSWIrjE6CjU=;
        h=From:To:Subject:Date:From;
        b=P26Br2NXzg3UXwzyxQsawy32XO9FHekz/eijjZP2bKQ20BAmRocsrUlh7vIznrbXy
         3ZRuF6jhPcjQXXF1vMfrjxm+VseCKHVXk4CjpK6KKdPNuEESGEwSVEXGINGtOESDej
         pc/RKwkK+fM1r1f649ctuPeOWzq0HbKbH/PEamRY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C090E60594
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vnkgutta@codeaurora.org
From:   Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
To:     evgreen@chromium.org, robh@kernel.org, bp@alien8.de,
        mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        tsoni@codeaurora.org, ckadabi@codeaurora.org,
        rishabhb@codeaurora.org
Subject: [PATCH v0 0/4] Add cache erp driver for Last Level Cache Controller (LLCC)
Date:   Wed, 25 Jul 2018 10:44:53 -0700
Message-Id: <1532540697-26630-1-git-send-email-vnkgutta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements cache erp driver for Last Level Cache Controller 
(LLCC). Cache erp driver is to detect and report single and double bit
errors on Last Level Cache Controller (LLCC) cache. This driver also takes
care of dumping registers and have config options to enable and disable
panic when these errors happen in LLCC.

The driver functionality is implemented in:
qcom_llcc_edac.c : This platform driver registers to edac framework and
handles the single and double bit errors in llcc cache by registering
interrupt handlers. 

llcc-slice.c: It invokes the llcc cache erp driver and passes platform
data to it. 

This patchset depends on the LLCC driver, which is yet to be merged.
Link: https://patchwork.kernel.org/patch/10422531/
Link: Link: http://lists-archives.com/linux-kernel/29157082-dt-bindings-documentation-for-qcom-llcc.html

Venkata Narendra Kumar Gutta (4):
  drivers: soc: Add broadcast base for Last Level Cache Controller
    (LLCC)
  drivers: soc: Support to add cache erp driver for Last Level Cache
    Controller (LLCC)
  drivers: edac: Add cache erp driver for Last Level Cache Controller
    (LLCC)
  dt-bindigs: Update documentation of qcom,llcc

 .../devicetree/bindings/arm/msm/qcom,llcc.txt      |  41 ++
 drivers/edac/Kconfig                               |  21 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/qcom_llcc_edac.c                      | 523 +++++++++++++++++++++
 drivers/soc/qcom/llcc-slice.c                      |  74 ++-
 include/linux/soc/qcom/llcc-qcom.h                 |   6 +-
 6 files changed, 640 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
 create mode 100644 drivers/edac/qcom_llcc_edac.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

