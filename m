Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD50CC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922B32084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mHp22QJm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kGpkgOPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922B32084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJHUKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:10:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48386 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeJHUKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:10:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ABA9A60769; Mon,  8 Oct 2018 12:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539003504;
        bh=wv/NyJ0xiuKnqwhOLRq/Jc2oMtrikrjwb0WDi14S9dU=;
        h=From:To:Cc:Subject:Date:From;
        b=mHp22QJmPHg4TyVgJuV0PI03OC/FNFFUjr4FVald2WoBvuBMcqAtYcOw7sSIKy1Gx
         ZSvco+BopZpzCb2S2fKvyUjUaMlaUjD8pISBMbhbf3nO9sW+TfuJYiC0YM6wNdnrCf
         FFEisBH/iBYqac8Cu1Wro3SeFvshNIhvGxu11sps=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B43A7605A2;
        Mon,  8 Oct 2018 12:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539003503;
        bh=wv/NyJ0xiuKnqwhOLRq/Jc2oMtrikrjwb0WDi14S9dU=;
        h=From:To:Cc:Subject:Date:From;
        b=kGpkgOPUcBiv04M9tyLCJ5bmGzFXQ2ShO2dPjRhitWIrrw+HyLYWgn+dnNDr+dPtr
         RPTko34rIU6o4pTiqESye20ZSKxcxtvlnXvH3oacvlNjS4BggiR/tpEy2rHzfj2ap2
         tdVntUF6/95W7ivl9+Xr/W5jg4rXXZmD+ll84eQA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B43A7605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, vviswana@codeaurora.org,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, dianders@google.com,
        sayalil@codeaurora.org
Subject: [PATCH V1 0/7] Add devfreq based clock scaling support for mmc
Date:   Mon,  8 Oct 2018 18:27:59 +0530
Message-Id: <1539003486-24087-1-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds the use of devfreq based clock scaling to MMC.
Both eMMC and SD card can use it.
For some workloads, such as video playback, it isn't necessary
for these cards to run at high speed. Running at lower frequency,
in such cases can still meet the deadlines for data transfers.
Scaling down the clock frequency dynamically has power savings
not only because the bus is running at lower frequency but also
has an advantage of scaling down the system core voltage, if supported.
Provide an ondemand clock scaling support similar to the cpufreq
ondemand governor having two thresholds, up_threshold and
down_threshold to decide whether to increase the frequency or
scale it down respectively as per load.

Changes since RFC --> V1 :
	mmc: core: devfreq: Add devfreq based clock scaling support
	Updated condition to check *freq passed to mmc_devfreq_set_target()
	with target_freq instead of checking with current freq.

Sahitya Tummala (1):
  devfreq: Add new flag to do simple clock scaling

Sayali Lokhande (6):
  mmc: core: devfreq: Add devfreq based clock scaling support
  mmc: core: Add sysfs entries for dynamic control of clock scaling
  mmc: core: add support for devfreq suspend/resume
  mmc: sdhci-msm: Kconfig: select devfreq ondemand for sdhci-msm
  mmc: sdhci-msm: Enable clock scaling property
  mmc: core: Add a debugfs entry to set max clock rate

 .../devicetree/bindings/mmc/sdhci-msm.txt          |  10 +
 Documentation/mmc/mmc-dev-attrs.txt                |  38 ++
 drivers/devfreq/governor_simpleondemand.c          |  25 +-
 drivers/mmc/core/core.c                            | 668 +++++++++++++++++++++
 drivers/mmc/core/core.h                            |   9 +
 drivers/mmc/core/debugfs.c                         |  90 +++
 drivers/mmc/core/host.c                            | 163 ++++-
 drivers/mmc/core/mmc.c                             | 227 ++++++-
 drivers/mmc/core/sd.c                              |  85 ++-
 drivers/mmc/host/Kconfig                           |   2 +
 drivers/mmc/host/sdhci-msm.c                       |  38 ++
 drivers/mmc/host/sdhci-pltfm.c                     |  11 +
 drivers/mmc/host/sdhci.c                           |  27 +
 drivers/mmc/host/sdhci.h                           |   8 +
 include/linux/devfreq.h                            |   4 +
 include/linux/mmc/card.h                           |   5 +
 include/linux/mmc/host.h                           |  70 +++
 17 files changed, 1471 insertions(+), 9 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

