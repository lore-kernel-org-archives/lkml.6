Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507BEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED3220862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fde3ONo0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Duoz5+X2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED3220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbeHAWVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 18:21:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbeHAWVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 18:21:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 08FA860714; Wed,  1 Aug 2018 20:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533155628;
        bh=rf5r2KB9k3dua26fU+anCp3alD1+Z7VKbDjdKEkNm94=;
        h=From:To:Subject:Date:From;
        b=Fde3ONo0a7BRe6FOgofTkt8a5WETfYf3caqznoNk4vmVmOrJmLBZBtjyJ7g4GQ0Y+
         Nm+fUcDYrrGDmRJwgW4kk6u5h7ExPhRNq7xqw93h7Yin1xJzpQ328jgtT9bFcI56qv
         /fEMVDI9LZVMa6mkok0IkeHtYESnHFKVogKG5Vuk=
Received: from vgutta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnkgutta@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B259606DD;
        Wed,  1 Aug 2018 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533155627;
        bh=rf5r2KB9k3dua26fU+anCp3alD1+Z7VKbDjdKEkNm94=;
        h=From:To:Subject:Date:From;
        b=Duoz5+X2f91t+KfE6t923KDYvrNjviPeaAQ4StCuAGYSzRYBEvolDOZnWqorNTWCG
         Osv3ZUwn+avN/SnfAXPZxISOl+c6nk5Hp93nWCmxkF4OHUiRVqh0vPToZhiZaneuqb
         l9RP1TGU97cCq0ZbGlwhlS0bBTzHmiN9bOxBDIUE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B259606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vnkgutta@codeaurora.org
From:   Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
To:     evgreen@chromium.org, robh@kernel.org, mchehab@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org, bp@alien8.de
Subject: [PATCH v1 0/4] Add EDAC driver for QCOM SoCs
Date:   Wed,  1 Aug 2018 13:33:31 -0700
Message-Id: <1533155615-27929-1-git-send-email-vnkgutta@codeaurora.org>
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

This patchset depends on the LLCC driver, which is yet to be merged.
Link: https://patchwork.kernel.org/patch/10422531/
Link: http://lists-archives.com/linux-kernel/29157082-dt-bindings-documentation-for-qcom-llcc.html

Changes since v0:
  * Added EDAC_QCOM config and updated the driver
  * Addressed comments related to indentation and other minor ones

Channagoud Kadabi (1):
  drivers: edac: Add EDAC driver support for QCOM SoCs

Venkata Narendra Kumar Gutta (3):
  drivers: soc: Add broadcast base for Last Level Cache Controller
    (LLCC)
  drivers: soc: Add support to register LLCC EDAC driver
  dt-bindigs: Update documentation of qcom,llcc

 .../devicetree/bindings/arm/msm/qcom,llcc.txt      |  15 +-
 MAINTAINERS                                        |   7 +
 drivers/edac/Kconfig                               |  28 ++
 drivers/edac/Makefile                              |   1 +
 drivers/edac/qcom_edac.c                           | 507 +++++++++++++++++++++
 drivers/soc/qcom/llcc-slice.c                      |  73 ++-
 include/linux/soc/qcom/llcc-qcom.h                 |   6 +-
 7 files changed, 610 insertions(+), 27 deletions(-)
 create mode 100644 drivers/edac/qcom_edac.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

