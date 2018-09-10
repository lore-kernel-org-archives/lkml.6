Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61726C43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75E920855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BXZQV+D5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I47c2/OJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75E920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeIKEnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:43:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeIKEng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:43:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AD5B3606DD; Mon, 10 Sep 2018 23:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536623229;
        bh=/UURcMK0Y4IU2vUYwtFxWYEndSCkll5M2A9R34tXnyk=;
        h=From:To:Subject:Date:From;
        b=BXZQV+D5uAyvZMDS0HlnyxRo/+CzWvCpF4bRCPhQ7xjv4fqcafXzAJ6bCty0GDSxX
         tvx9Hav2q/FkCfHveAYU5gd165jfjp4DrsCSKAX47Deb+6fe5NOIm8/8pGe7x9SxrF
         JePijUG/V5zArZI2H3EvKhdWEcENL0jKMCj2VQKY=
Received: from vgutta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnkgutta@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28456606DD;
        Mon, 10 Sep 2018 23:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536623228;
        bh=/UURcMK0Y4IU2vUYwtFxWYEndSCkll5M2A9R34tXnyk=;
        h=From:To:Subject:Date:From;
        b=I47c2/OJkUm7tj9YPrp8BH5QlRb8RGg4n5lljAW71gyXDToA7Xd01NWmHSsANQxEA
         9yd4UTtrjyUUhGZegWnDrhUK/7YMf/Ufhfva02/D4qIFV/PWfPBsS9HSfXkmOixMzJ
         J14ebG2for7Li8vx9u96esHygaFPsgUxqGZ7vNsQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28456606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vnkgutta@codeaurora.org
From:   Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
To:     Borislav Petkov <bp@alien8.de>, evgreen@chromium.org,
        robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH v5 0/4] Add EDAC driver for QCOM SoCs
Date:   Mon, 10 Sep 2018 16:46:51 -0700
Message-Id: <1536623215-20018-1-git-send-email-vnkgutta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements EDAC driver for QCOM SoCs. As of now, this driver
supports EDAC for Last Level Cache Controller (LLCC). LLCC EDAC driver is
to detect and report single and double bit errors on Last Level Cache
Controller (LLCC) cache. Interrupts are triggered when the errors happen
in the cache, the driver handles those interrupts and dumps the syndrome
registers.

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

Changes since v4:
  * Removed of_device_id struct entry from edac driver
  * Modified reg-names in the documentation

Changes since v3:
  * Updated the Kconfig and addressed minor comments in the driver

Changes since v2:
  * Modified the edac driver and Kconfig
    -  removed unnecessary header files, typecasting and redundant comments.
    -  Changed the initialization of reg_data datastructure to static,
       Also updated the llcc_edac_reg_data member names and datatypes.
    -  Removed "EDAC_QCOM_LLCC_PANIC_ON_UE" Kconfig variable

Changes since v1:
  * Modified the edac driver
    - Removed duplicate functions that are used to dump the syndrome registers,
      replaced that with a common function and a reg_data datastructure.
    - Removed structure containing function pointers.
    - Addressed comments on error handling to clear the interrupt status.
  * Updated Kconfig

Changes since v0:
  * Added EDAC_QCOM config and updated the driver
  * Addressed comments related to indentation and other minor ones

Channagoud Kadabi (1):
  drivers: edac: Add EDAC driver support for QCOM SoCs

Venkata Narendra Kumar Gutta (3):
  drivers: soc: Add broadcast base for Last Level Cache Controller
    (LLCC)
  drivers: soc: Add support to register LLCC EDAC driver
  dt-bindings: msm: Update documentation of qcom,llcc

 .../devicetree/bindings/arm/msm/qcom,llcc.txt      |  19 +-
 MAINTAINERS                                        |   8 +
 drivers/edac/Kconfig                               |  14 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/qcom_edac.c                           | 414 +++++++++++++++++++++
 drivers/soc/qcom/llcc-slice.c                      |  73 ++--
 include/linux/soc/qcom/llcc-qcom.h                 |  30 +-
 7 files changed, 531 insertions(+), 28 deletions(-)
 create mode 100644 drivers/edac/qcom_edac.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

