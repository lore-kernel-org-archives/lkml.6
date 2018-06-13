Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C656FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705F6208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MJuFpGkf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BI/WRR3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705F6208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935059AbeFMKda (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:33:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39254 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933657AbeFMKd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:33:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 16920606DB; Wed, 13 Jun 2018 10:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528886008;
        bh=q9/mPLhmVuPBswpPCeZJTDVs28oJ+pV4G3abIJV0eXE=;
        h=From:To:Cc:Subject:Date:From;
        b=MJuFpGkfF5ZorYiD4iwL+ZVpS298M+t4urgZjGcywGbiNhF8HOe+nVUEsTqx2Hddo
         WAYq3d9EzCl7xYhf4wb0HYUf3uIgr8YdvOXeg9fVUcTzSaqWOs23cCsKnc+6wyTXvL
         196jyq7qjzLgs7EF2O0jbPjzi0A6p9hNqzlwr31w=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2490260351;
        Wed, 13 Jun 2018 10:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528886007;
        bh=q9/mPLhmVuPBswpPCeZJTDVs28oJ+pV4G3abIJV0eXE=;
        h=From:To:Cc:Subject:Date:From;
        b=BI/WRR3dXOUeRLIIsignHN19j+HzdE8oiRIB6jIrK5tKXg8Bkdq6dyA/fER2TMALt
         gh7TdWDe0Y/89Pxk3WqgQ0q8Ed92XOFJtrxpIaCW2tqcml6oakdbFIqsZBNxk6Mve6
         vhWOonHmrjUI4+8kAF+QCjwUCzIGflFrshIk35tk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2490260351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 0/2] Add display clock controller driver for SDM845
Date:   Wed, 13 Jun 2018 16:03:15 +0530
Message-Id: <1528885997-10311-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 [v2]
  * Removed unused header file includes.
  * Moved the frequency table macro to a common file [1].
  * Move to pll config to probe.
  * Update SoC name in device tree binding and
    also update the Kconfig.

Add support for the display clock controller found on SDM845
based devices. This would allow display drivers to probe and
control their clocks.

The Display clock driver depends on the frequency table macro
movement to a common file [1].

 [1]:  https://lkml.org/lkml/2018/6/13/216

Taniya Das (2):
  dt-bindings: clock: Introduce QCOM Display clock bindings
  clk: qcom: Add display clock controller driver for SDM845

 .../devicetree/bindings/clock/qcom,dispcc.txt      |  19 +
 drivers/clk/qcom/Kconfig                           |  10 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/dispcc-sdm845.c                   | 674 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,dispcc-sdm845.h     |  45 ++
 5 files changed, 749 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc.txt
 create mode 100644 drivers/clk/qcom/dispcc-sdm845.c
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sdm845.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

