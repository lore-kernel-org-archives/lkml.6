Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483F3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E0721557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D0Dc+bRc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BxQYf+5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E0721557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeHXF3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 01:29:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43662 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeHXF3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 01:29:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 19DD560251; Fri, 24 Aug 2018 01:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535075830;
        bh=B8SvGqK+WRj3358lJw5OH3XE7y4gavCvqyZ7e8iMwP0=;
        h=From:To:Subject:Date:From;
        b=D0Dc+bRczMuLo0UX27E5aQkjI0Brc3JY003KiZOe0HWnS45+RRYh+B3bFl7aFIFKp
         T+017GqnYNEK51JCgWv5AH1JWdq5Ay0DKpQHfIrqI8KThOF1Xn6xmOwjpcyW9QUgKB
         YcZXvl+UHpIbIiG7J7LF/Bvd7n7bDA3oRCCR8z1A=
Received: from davidai-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E404460159;
        Fri, 24 Aug 2018 01:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535075829;
        bh=B8SvGqK+WRj3358lJw5OH3XE7y4gavCvqyZ7e8iMwP0=;
        h=From:To:Subject:Date:From;
        b=BxQYf+5dR86S4m+KKmEsjaQEMf+EItMNhj0dOFnuWwsJc5qqACXcUPRXQmRv822VO
         diy846jv1Coe11y8ioDNds3PiIgT9EoqxC0Un/pERU4SFuXGUSA54kkLdB5ms4/MR9
         yjVIfcJTWzePKRMfeYUBWnWW0fef2T0J76UHy8Sk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E404460159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
From:   David Dai <daidavid1@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        georgi.djakov@linaro.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, daidavid1@codeaurora.org,
        amit.kucheria@linaro.org, ilina@codeaurora.org,
        seansw@qti.qualcomm.com, grahamr@qti.qualcomm.com,
        evgreen@google.com
Subject: [PATCH v3 0/2] Add sdm845 interconnect provider driver
Date:   Thu, 23 Aug 2018 18:56:52 -0700
Message-Id: <1535075814-17343-1-git-send-email-daidavid1@codeaurora.org>
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
satisfy consumer requests across the SoC by generating commands that
communicate with the BCM through the Resource Power Manager (RPMh) driver [2]
interface. The SDM845 ICC driver also configures QoS settings specific to each
node to ensure clients have proper priority.

The SDM845 interconnect provider has dependencies on the RPMh driver
and Command DB driver [3].

Changes in v3 [6]:
 - Updated provider set prototype to be compatible with v8 of ICC framework
 - Added additional comments and fixed format (Evan G.)
 - Fixed endianess issues (Evan G.)
 - Added clean up of nodes in probe failure and qnoc_remove (Evan G.)
 - Merged sdm845 local node IDs with qcom dt-binding IDs
 - Removed IPA CORE nodes and BCMs.

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

[1]: https://lkml.org/lkml/2018/8/10/387
[2]: https://lkml.org/lkml/2018/6/20/519
[3]: https://lkml.org/lkml/2018/4/10/714
[4]: https://patchwork.kernel.org/patch/10428167/
[5]: https://lkml.org/lkml/2018/6/29/743
[6]: https://lkml.org/lkml/2018/7/18/1109

Summary of the patches:
Patch 1 creates the Qualcomm SDM845 Specific provider driver.
Patch 2 Adds dt binding for SDM845 provider

TODO:
  * Add Network-on-Chip (NoC) objects to encapsulate logical nodes for QoS.
  * Add QoS configuration specific to each NoC.

David Dai (2):
  interconnect: qcom: Add sdm845 interconnect provider driver
  arm64: dts: sdm845: Add interconnect provider DT nodes

 .../bindings/interconnect/qcom-sdm845.txt          |  22 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   5 +
 drivers/interconnect/qcom/Kconfig                  |   8 +
 drivers/interconnect/qcom/Makefile                 |   1 +
 drivers/interconnect/qcom/sdm845.c                 | 844 +++++++++++++++++++++
 include/dt-bindings/interconnect/qcom.h            | 110 ++-
 6 files changed, 989 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-sdm845.txt
 create mode 100644 drivers/interconnect/qcom/sdm845.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

