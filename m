Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C93FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EFF20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qr0QhvgV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZfSqBQN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EFF20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeGTLeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:34:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49522 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeGTLeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:34:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AC3CE60B1E; Fri, 20 Jul 2018 10:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532083583;
        bh=XxF18Osk6F8SZa/7XlBmS4bYbwdyZZ3UmCesyn2AoUw=;
        h=From:To:Cc:Subject:Date:From;
        b=Qr0QhvgVL6XtpoJIzsp7c7adgOpOxNrtGvMEKToCaqWh45Rv6P4oW42vzGEjsbGmS
         C3YkZ+OG7dez00b3jIP+K49nCqu0fGCBh17fNIQq5UWl/P7lW9tE9kO5n+8jzKAJTk
         nBCBPI6cdipwMsVgtT+BlCX6zAWE8xxf3yzqFQts=
Received: from hydcbspbld03.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vviswana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D97B2606AC;
        Fri, 20 Jul 2018 10:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532083582;
        bh=XxF18Osk6F8SZa/7XlBmS4bYbwdyZZ3UmCesyn2AoUw=;
        h=From:To:Cc:Subject:Date:From;
        b=ZfSqBQN0aWSg35b0M8HAvOkUF3woLmb1MDn28t3EeNclTyuzmp6w1/IEvCjrlD2Uz
         EUDegZ6l26Z40M5Cf7gfVL5kgh3z3Lg2H1BxG7VwsNHFiD+LUOG4/FZFqYbX72m0Bf
         tNSOT4aE/lM59U8K65EJ3n46vhf/MPjybTyPlbHk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D97B2606AC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
From:   Vijay Viswanath <vviswana@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        vviswana@codeaurora.org, bjorn.andersson@linaro.org,
        riteshh@codeaurora.org, vbadigan@codeaurora.org,
        evgreen@chromium.org, dianders@google.com, sayalil@codeaurora.org
Subject: [PATCH V1 0/3] Internal voltage control for platform drivers 
Date:   Fri, 20 Jul 2018 16:16:03 +0530
Message-Id: <1532083566-43215-1-git-send-email-vviswana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain SDHC controllers may require that voltage switching happen after
sepcial conditions. Added a QUIRK for such controllers to use.

For SDHCI-MSM controllers, power irq is a signal from controller to SW
that it is ready for voltage switch. So added support to register
voltage regulators from the msm driver and use them.
Voltage switching from core layer is causing CRC/cmd timeout errors in
some chipsets.

Changes since RFC:
	- Added DT option to pass regulator load values the sdhci-msm driver
	should vote during BUS_ON and BUS_OFF power irq.
	- Removed quirk and used local flags in sdhci_add_host to to avoid
	scenario of both sdhci & sdhci-msm layer controlling the regulators.
	- Introduced two sdhci msm layer APIs to replace the respective
	sdhci layer APIs. This is again to stop sdhci layer from
	controlling regulators if sdhci_msm layer is present.

Tested on: sdm845
Requies patch series:"[PATCH V3 0/4] Changes for SDCC5 version"

Vijay Viswanath (3):
  mmc: sdhci: Allow platform controlled voltage switching
  Documentation: sdhci-msm: Add entries for passing load values
  mmc: sdhci-msm: Use internal voltage control

 .../devicetree/bindings/mmc/sdhci-msm.txt          |   6 +
 drivers/mmc/host/sdhci-msm.c                       | 220 +++++++++++++++++++--
 drivers/mmc/host/sdhci.c                           |  21 +-
 3 files changed, 231 insertions(+), 16 deletions(-)

-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

