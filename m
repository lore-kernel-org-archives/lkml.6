Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754927AbeEXAfe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 20:35:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34798 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754846AbeEXAf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 20:35:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E112602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From: Rishabh Bhatnagar <rishabhb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org,
        tsoni@codeaurora.org, ckadabi@codeaurora.org, evgreen@chromium.org,
        robh@kernel.org, andy.shevchenko@gmail.com,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v8 0/2] SDM845 System Cache Driver
Date: Wed, 23 May 2018 17:35:19 -0700
Message-Id: <1527122121-31452-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements system cache or LLCC(Last Level Cache Controller)
driver for SDM845 SOC. The purpose of the driver is to partition the
system cache and program the settings such as priortiy, lines to probe
while doing a look up in the system cache, low power related settings etc.
The partitions are called cache slices. Each cache slice is associated
with size and SCID(System Cache ID). The driver also provides API for
clients to query the cache slice details,activate and deactivate them.

The driver can be broadly classified into:
* SOC specific driver: llcc-sdm845.c: Cache partitioning and cache slice
properties for usecases on sdm845 that need to use system cache.

* API : llcc-slice.c: Exports APIs to clients to query cache slice details,
activate and deactivate cache slices.

Changes since v7:
* Change the DT node name to cache-controller.
* Use the module_platform_driver_macro
* Use GENMASK and SZ_* macros
* Correct indentation, and remove unnecessary assignemnts.
* Addresed all comments by Andy Schevchenko except the comment to ignore some
  lines of code going over 80 characters.

Changes since v6:
* Remove the max-slices property from DT.
* Make client's slice_ids as macros.
* Unlock mutex while returning from function in case of error.

Changes since v5:
* Remove client information from DT.
* Make the llcc driver data as global.
* Check return value of llcc_update_act_ctrl function
* Change error returned from -EFAULT to -EINVAL

Changes since v4:
* Remove null pointer checks as per comments.
* Remove extra blank lines.

Changes since v3:
* Use the regmap_read_poll_timeout function
* Check for regmap read/write errors.
* Remove memory barrier after regmap write
* Derive memory bank offsets using stride macro variable
* Remove debug statements from code
* Remove the qcom_llcc_remove function
* Use if IS_ENABLED in place of ifdef for built-in module
* Change EXPORT_SYMBOL to EXPORT_SYMBOL_GPL
* Remove unnecessary free functions
* Change the variable names as per review comments

Changes since v2:
* Corrected the Makefile to fix compilation.

Changes since v1:
* Added Makefile and Kconfig.

Changes since v0:
* Removed the syscon and simple-mfd approach
* Updated the device tree nodes to mention LLCC as a single HW block
* Moved llcc bank offsets from device tree and handled the offset
  in the driver.

ckadabi@codeaurora.org (2):
  dt-bindings: Documentation for qcom, llcc
  drivers: soc: Add LLCC driver

 .../devicetree/bindings/arm/msm/qcom,llcc.txt      |  26 ++
 drivers/soc/qcom/Kconfig                           |  17 ++
 drivers/soc/qcom/Makefile                          |   2 +
 drivers/soc/qcom/llcc-sdm845.c                     |  94 ++++++
 drivers/soc/qcom/llcc-slice.c                      | 335 +++++++++++++++++++++
 include/linux/soc/qcom/llcc-qcom.h                 | 180 +++++++++++
 6 files changed, 654 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
 create mode 100644 drivers/soc/qcom/llcc-sdm845.c
 create mode 100644 drivers/soc/qcom/llcc-slice.c
 create mode 100644 include/linux/soc/qcom/llcc-qcom.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
