Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbeELC2R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 22:28:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34164 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeELC2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 22:28:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BBB11601EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
From: David Collins <collinsd@codeaurora.org>
To: broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: David Collins <collinsd@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org, sboyd@kernel.org,
        dianders@chromium.org
Subject: [PATCH v3 0/2] regulator: add QCOM RPMh regulator driver
Date: Fri, 11 May 2018 19:28:04 -0700
Message-Id: <cover.1526088081.git.collinsd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a driver and device tree binding documentation for
PMIC regulator control via Resource Power Manager-hardened (RPMh) on some
Qualcomm Technologies, Inc. SoCs such as SDM845.  RPMh is a hardware block
which contains several accelerators which are used to manage various
hardware resources that are shared between the processors of the SoC.  The
final hardware state of a regulator is determined within RPMh by performing
max aggregation of the requests made by all of the processors.

The RPMh regulator driver depends upon the RPMh driver [1] and command DB
driver [2] which are both still undergoing review.  It also depends upon
two recent of_regulator changes: [3] and [4].

Changes since v2 [5]:
 - Replaced '_' with '-' in device tree supply property names
 - Renamed qcom_rpmh-regulator.c to be qcom-rpmh-regulator.c
 - Updated various DT property names to use "microvolt" and "microamp"
 - Moved allowed modes constraint specification out of the driver [4]
 - Replaced rpmh_client with device pointer to match new RPMh API [1]
 - Corrected drms mode threshold checking
 - Initialized voltage_selector to -EINVAL when not specified in DT
 - Added constants for PMIC regulator hardware modes
 - Corrected type sign of mode mapping tables
 - Made variable names for mode arrays plural
 - Simplified Kconfig depends on
 - Removed unnecessary constants and struct fields
 - Added some descriptive comments

Changes since v1 [6]:
 - Addressed review feedback from Doug, Mark, and Stephen
 - Replaced set_voltage()/get_voltage() callbacks with set_voltage_sel()/
   get_voltage_sel()
 - Added set_bypass()/get_bypass() callbacks for BOB pass-through mode
   control
 - Removed top-level PMIC data structures
 - Removed initialization variables from structs and passed them as
   function parameters
 - Removed various comments and error messages
 - Simplified mode handling
 - Refactored per-PMIC rpmh-regulator data specification
 - Simplified probe function
 - Moved header into DT patch
 - Removed redundant property listings from DT binding documentation

[1]: https://lkml.org/lkml/2018/5/9/729
[2]: https://lkml.org/lkml/2018/4/10/714
[3]: https://patchwork.kernel.org/patch/10348629
[4]: https://lkml.org/lkml/2018/5/11/696
[5]: https://lkml.org/lkml/2018/4/13/687
[6]: https://lkml.org/lkml/2018/3/16/1431

David Collins (2):
  regulator: dt-bindings: add QCOM RPMh regulator bindings
  regulator: add QCOM RPMh regulator driver

 .../bindings/regulator/qcom,rpmh-regulator.txt     | 208 +++++
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/qcom-rpmh-regulator.c            | 925 +++++++++++++++++++++
 .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 +
 5 files changed, 1179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
 create mode 100644 drivers/regulator/qcom-rpmh-regulator.c
 create mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
