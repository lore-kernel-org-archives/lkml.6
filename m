Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AE5ECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C7620693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FnGEvJ3X";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JNWAjQ1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C7620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbeGSDR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:17:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54674 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeGSDR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:17:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 091FF607EB; Thu, 19 Jul 2018 02:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531967829;
        bh=X7uAAuzOog9amA4fus7yaUQgwN+/VcT59LeqW/K/dTg=;
        h=From:To:Subject:Date:From;
        b=FnGEvJ3Xpsnj0hGNTTpvVIQlKCjPv7FqAvkM2fOkeix6Z3P6UCGcDBjRleNuWJ3gO
         x+99/1aww1xJ5Dk07Sb5VzVk0kOVquxsMdVApAm0kbx0Y3fYQe2IcrvDyes3f1iqvA
         b2XBv8QjMV5ixSdhTnHvRcwU2DYzCQivzG+l7WkM=
Received: from davidai-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01975602D7;
        Thu, 19 Jul 2018 02:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531967828;
        bh=X7uAAuzOog9amA4fus7yaUQgwN+/VcT59LeqW/K/dTg=;
        h=From:To:Subject:Date:From;
        b=JNWAjQ1XBkVg311+gYNMBB+fU2ow2jm45vEvFOcPssPsaTk8fPmrb7w9Yq9ZmGFlJ
         oTbzhsqhBDwn/bEtJSQNpE33nEdnrld/yTDpPrUs9vFzNWXbM4UBXYsA0YdFTfeWMe
         V+M3DFM5FXgsQYMfkanomzqmwhfsZO3DEEQ/n1SY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01975602D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
From:   David Dai <daidavid1@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        georgi.djakov@linaro.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, daidavid1@codeaurora.org,
        amit.kucheria@linaro.org, ilina@codeaurora.org,
        seansw@qti.qualcomm.com, grahamr@qti.qualcomm.com
Subject: [RFC PATCH v1 0/2] Add QCOM SDM845 interconnect provider driver
Date:   Wed, 18 Jul 2018 19:36:58 -0700
Message-Id: <1531967820-27483-1-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series adds a driver and DT binding using the interconnect (ICC)
framework [1] to describe the Qualcomm SDM845 platform's topology of its
interconnected buses and internal aggregation nodes known as
Bus Clock Managers(BCM). The SDM845 ICC provider driver would aggregate and
satisfy consumer requests accross the SoC by generating commands that
communicate with the BCM through the Resource Power Manager (RPMh) driver [2]
interface. The SDM845 ICC driver also configures QoS settings specific to each
node to ensure clients have proper priority.

The SDM845 interconnect provider has dependencies on the RPMh driver
and Command DB driver [3].

Changes in v2 [5]:
 - Updated to use the latest RPMH and CommandDB patches
 - Fixed bug in bcm aggregation
 - Updated sdm845 provider dt entry

Changes in v1 [4]:
 - Addressed review feedback from Georgi D. and Evan G.
 - Removed proposal to modify ICC aggregate callback interface
 - Moved BCM aggregation into provider set function
 - Added devicetree binding documentation
 - Fixed logic in generating TCS command list
 - Added keepalive flags for resources that are critical to platform operation
 - Added various comments to clarify intent
 - Removed unused types and struct definitions

[1]: https://lkml.org/lkml/2018/6/20/453
[2]: https://lkml.org/lkml/2018/6/20/519
[3]: https://lkml.org/lkml/2018/4/10/714
[4]: https://patchwork.kernel.org/patch/10428167/
[5]: https://lkml.org/lkml/2018/6/29/743

Summary of the patches:
Patch 1 creates the Qualcomm SDM845 Specific provider driver.
Patch 2 Adds dt binding for SDM845 provider

TODO:
  * Expand aggregation/provider to handle clients with active only requirements.
  * Add Network-on-Chip (NoC) objects to encapsulate logical nodes for QoS.
  * Add QoS configuration specific to each NoC.

David Dai (2):
  interconnect: qcom: Add sdm845 interconnect provider driver
  arm64: dts: sdm845: Add interconnect provider DT nodes

 .../bindings/interconnect/qcom-sdm845.txt          |  22 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   5 +
 drivers/interconnect/qcom/Kconfig                  |   8 +
 drivers/interconnect/qcom/Makefile                 |   1 +
 drivers/interconnect/qcom/qcom-icc-ids.h           | 142 ++++
 drivers/interconnect/qcom/sdm845.c                 | 826 +++++++++++++++++++++
 6 files changed, 1004 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-sdm845.txt
 create mode 100644 drivers/interconnect/qcom/qcom-icc-ids.h
 create mode 100644 drivers/interconnect/qcom/sdm845.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

