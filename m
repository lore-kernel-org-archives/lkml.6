Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbeFDTQo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:16:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40394 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeFDTQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:16:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1F21606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
From: David Collins <collinsd@codeaurora.org>
To: broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: David Collins <collinsd@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org, sboyd@kernel.org,
        dianders@chromium.org
Subject: [PATCH v6 0/2] regulator: add QCOM RPMh regulator driver
Date: Mon,  4 Jun 2018 12:15:10 -0700
Message-Id: <cover.1528138319.git.collinsd@codeaurora.org>
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
three recent regulator changes: [3], [4], and [5].

Changes since v5 [6]:
 - Removed unused constants
 - Added Reviewed-by tag for DT patch 1/2

Changes since v4 [7]:
 - Removed support for DT properties qcom,regulator-drms-modes and
   qcom,drms-mode-max-microamps
 - Specified fixed DRMS high power mode minimum limits for LDO type
   regulators
 - Removed DRMS support for SMPS and BOB type regulators
 - Simplified voltage caching logic

Changes since v3 [8]:
 - Removed support for DT properties qcom,regulator-initial-microvolt
   and qcom,headroom-microvolt
 - Renamed DT property qcom,allowed-drms-modes to be
   qcom,regulator-drms-modes
 - Updated DT binding documentation to mention which common regulator
   bindings can be used for qcom-rpmh-regulator devices
 - Added voltage caching so that voltage requests are only sent to RPMh
   after the regulator has been enabled at least once
 - Changed 'voltage_selector' default value to be -ENOTRECOVERABLE to
   interact with [5]
 - Initialized 'enabled' to -EINVAL so that unused regulators are
   disabled by regulator_late_cleanup()
 - Removed rpmh_regulator_load_default_parameters() as it is no longer
   needed
 - Updated the mode usage description in qcom,rpmh-regulator.h

Changes since v2 [9]:
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

Changes since v1 [10]:
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
[3]: https://lkml.org/lkml/2018/4/18/556
[4]: https://lkml.org/lkml/2018/5/11/696
[5]: https://lkml.org/lkml/2018/5/15/1005
[6]: https://lkml.org/lkml/2018/6/1/895
[7]: https://lkml.org/lkml/2018/5/22/1168
[8]: https://lkml.org/lkml/2018/5/11/701
[9]: https://lkml.org/lkml/2018/4/13/687
[10]: https://lkml.org/lkml/2018/3/16/1431

David Collins (2):
  regulator: dt-bindings: add QCOM RPMh regulator bindings
  regulator: add QCOM RPMh regulator driver

 .../bindings/regulator/qcom,rpmh-regulator.txt     | 160 +++++
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/qcom-rpmh-regulator.c            | 767 +++++++++++++++++++++
 .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 +
 5 files changed, 973 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
 create mode 100644 drivers/regulator/qcom-rpmh-regulator.c
 create mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
