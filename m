Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89082C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAAD20854
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DYLa5dEo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UUZAHWXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfAGKKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:10:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55616 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfAGKKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:10:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1AEBB6098B; Mon,  7 Jan 2019 10:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546855813;
        bh=i8393fO0xFZxIDnL/Mml58pM8wv9rBd15s32GFi5XcM=;
        h=From:To:Cc:Subject:Date:From;
        b=DYLa5dEofbdyVJthC9YU6rOT9tspkzJc+j2U7PExUTTOYEe2SenEm3HW3BxQ6wfFp
         WVcSOIPg63gKlZHSQRRm8vDVgk9JnyQtDYMLDIT4OtzJotWNd6K+r9M5gzw8VZSZ8S
         5xWWO55BIy1cgCLyywa4YQz1JaX5awO/nZTtjO0c=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 099A46079C;
        Mon,  7 Jan 2019 10:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546855810;
        bh=i8393fO0xFZxIDnL/Mml58pM8wv9rBd15s32GFi5XcM=;
        h=From:To:Cc:Subject:Date:From;
        b=UUZAHWXwSKpJN/gwG/I9+6aBTvKQ4WDEIKL5ITRSfF3oe3nXMwn5lQR/kWPcaX2Ln
         K2XLn+Crt7+ydirhwHOka1scBBaxlMcxz0rjLqoGrCC+8KP448YYnMdx3uXNlPoz9w
         9URINTQ2MZlMsba4huwg6RzVb5vmUaJdOrM9zm4g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 099A46079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v9 00/10] Add power domain driver for corners on msm8996/sdm845
Date:   Mon,  7 Jan 2019 15:39:49 +0530
Message-Id: <20190107100959.14528-1-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v9:
* Updated qcom-opp bindings to be generic and usable across other SoCs 
with similar needs (Like MediaTek)
* Removed the simple_opp_to_performance_state() helper and added a
dev_pm_opp_of_get_level() helper instead
* Rebased on 5.0-rc1

Changes in v8:
* Patch 01/10: Bindings updated to mention opp-hz is optional
* Patch 02/10: Fixed #power-domain-cells
* All dependencies for 'Patch 10/10' are on their way to 4.21 via the pm tree

Changes in v7:
* Rebased on Andy's for-next, and used the updated cmd_db_read_aux_data()
* Other minor fixes, all in 'PATCH 06/10' as suggested by Stephen

Changes in v6:
* OPP binding updates for qcom,level reviewed by Rob
* DT bindings for rpmpd and rpmhpd updated to specify the
OPP tables as child nodes of the power-controller itself
* Removed some module specific remains from the drivers,
now that they can only be built-in
* Added a simple_opp_to_performance_state() helper

Changes in v5:
* First 6 patches are unchanged
* Patch 7/8 adds the DT node for rpmh power-controller on sdm845 and the
corresponding OPP tables for it to describe the performance states
* Patch 8/8 adds a parent/child relationship across mx/cx and mx_ao/cx_ao
as needed on sdm845 platform. This patch is dependent on the series from
Viresh [1] which adds support to propogate performance states across the
power domain hierarchy which is still being reviewed

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

[1] https://lkml.org/lkml/2018/11/26/333

Rajendra Nayak (10):
  dt-bindings: opp: Introduce opp-level bindings
  dt-bindings: power: Add qcom rpm power domain driver bindings
  soc: qcom: rpmpd: Add a Power domain driver to model corners
  soc: qcom: rpmpd: Add support for get/set performance state
  arm64: dts: msm8996: Add rpmpd device node
  soc: qcom: rpmhpd: Add RPMh power domain driver
  arm64: dts: sdm845: Add rpmh powercontroller node
  OPP: Add a dev_pm_opp_of_get_level() helper
  soc: qcom: rpmpd: Use dev_pm_opp_of_get_level() helper
  soc: qcom: rpmhpd: Mark mx as a parent for cx

 .../devicetree/bindings/opp/opp-level.txt     |  29 ++
 .../devicetree/bindings/power/qcom,rpmpd.txt  | 145 +++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  34 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  51 +++
 drivers/opp/of.c                              |  23 +
 drivers/soc/qcom/Kconfig                      |  18 +
 drivers/soc/qcom/Makefile                     |   2 +
 drivers/soc/qcom/rpmhpd.c                     | 402 ++++++++++++++++++
 drivers/soc/qcom/rpmpd.c                      | 317 ++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h        |  39 ++
 include/linux/pm_opp.h                        |   5 +
 11 files changed, 1065 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/opp-level.txt
 create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
 create mode 100644 drivers/soc/qcom/rpmhpd.c
 create mode 100644 drivers/soc/qcom/rpmpd.c
 create mode 100644 include/dt-bindings/power/qcom-rpmpd.h

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

