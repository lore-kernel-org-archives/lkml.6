Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D7CC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 04:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F590266CE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 04:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YIyNpmng";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="om5ZZNdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F590266CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeF0ExF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 00:53:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57488 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbeF0ExD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 00:53:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 70946606FA; Wed, 27 Jun 2018 04:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530075182;
        bh=lvhplJa4cvAehezo3DI2d/XiZ0PSuQgVmNtsvAZXaOw=;
        h=From:To:Cc:Subject:Date:From;
        b=YIyNpmng3ooUvzNxBEkozqxFfUge/I32Omufekv85nH8sjHf+3EBzDYHSQ4eVMlSU
         C+Iub2CQIw9u+Mhp2oEWEEfzphI3kQQeU/8RwyviSeB6wM52qpv7pRWxWwpxbxFHq+
         ILNMCw9cQ/nGFOFYEQjcsGpCPxTc4lY4MKJk5Fhs=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E174C606FA;
        Wed, 27 Jun 2018 04:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530075181;
        bh=lvhplJa4cvAehezo3DI2d/XiZ0PSuQgVmNtsvAZXaOw=;
        h=From:To:Cc:Subject:Date:From;
        b=om5ZZNdj4CyY9u2AURENGIqtJeqULZc2n0WYDuyDz5XaLIkgqEKTsG2eTUSbkfk+f
         kS+bVFvwHDl/V6xqZ+4IiRdLrW8oIB9zrSvXLtl7dIH7/jhCNVepGfwalA1bwCQaLP
         GZ2+TcEoI0e/PA3tOmQYcRvGEiSgirOveHd3oi/4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E174C606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v4 0/6] Add power domain driver for corners on msm8996/sdm845
Date:   Wed, 27 Jun 2018 10:22:28 +0530
Message-Id: <20180627045234.27403-1-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
* Included the patch to add qcom-opp bindings (dropped accidentally in v3)
* merged the patches to add bindings for rpm and rpmh, added consumer binding example
* Made the drivers built in, removed .remove
* Added better description in changelog for PATCH 6/6
* Updated rpmhpd_aggregate_corner() based on Davids feedback
* rpmhpd_set_performance_state() returns max corner, in cases where its called
with an INT_MAX
* Dropped the patch to max vote on all corners at init, the patch did not
work anyway, and it shouldn't be needed now

Changes in v3:
* Bindings split into seperate patches
* Bindings updated to remove duplicate OPP table phandles
* DT headers defining macros for Power domain indexes and OPP levels
* Optimisations to use rpmh_write_async() whereever applicable
* Fixed up handling of ACTIVE_ONLY/WAKE_ONLY/SLEEP voting for RPMh
* Fixed the vlvl to hlvl conversions in set_performance
* Other minor fixes based on review of v2
* TODO: This series does not handle the case where all VDD_MX votes
should be higher than VDD_CX from APPs, as pointed out
by David Collins in v2. This needs support at genpd to propogate performance
state up the parents, if we model these as Parent/Child to handle the
interdependency.

Changes in v2:
* added a power domain driver for sdm845 which supports communicating to RPMh
* dropped the changes to sdhc driver to move over to using OPP
as there is active discussion on using OPP as the interface vs
handling all of it in clock drivers
* Other minor binding updates based on review of v1

With performance state support for genpd/OPP merged, this is an effort
to model a power domain driver to communicate corner/level
values for qualcomm platforms to RPM (Remote Power Manager) and RPMh.

Rajendra Nayak (6):
  dt-bindings: opp: Introduce qcom-opp bindings
  dt-bindings: power: Add qcom rpm power domain driver bindings
  soc: qcom: rpmpd: Add a Power domain driver to model corners
  soc: qcom: rpmpd: Add support for get/set performance state
  arm64: dts: msm8996: Add rpmpd device node
  soc: qcom: rpmhpd: Add RPMh Power domain driver

 .../devicetree/bindings/opp/qcom-opp.txt      |  25 ++
 .../devicetree/bindings/power/qcom,rpmpd.txt  | 146 +++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  34 ++
 drivers/soc/qcom/Kconfig                      |  18 +
 drivers/soc/qcom/Makefile                     |   2 +
 drivers/soc/qcom/rpmhpd.c                     | 406 ++++++++++++++++++
 drivers/soc/qcom/rpmpd.c                      | 340 +++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h        |  39 ++
 8 files changed, 1010 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
 create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
 create mode 100644 drivers/soc/qcom/rpmhpd.c
 create mode 100644 drivers/soc/qcom/rpmpd.c
 create mode 100644 include/dt-bindings/power/qcom-rpmpd.h

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

