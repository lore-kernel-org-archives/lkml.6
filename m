Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932629AbeDWXLE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 19:11:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44310 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932590AbeDWXLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 19:11:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 054FC600E2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From: Rishabh Bhatnagar <rishabhb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, kyan@codeaurora.org, ckadabi@codeaurora.org,
        evgreen@chromium.org, robh@kernel.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v5 0/2] SDM845 System Cache Driver
Date: Mon, 23 Apr 2018 16:09:30 -0700
Message-Id: <1524524972-12014-1-git-send-email-rishabhb@codeaurora.org>
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

 .../devicetree/bindings/arm/msm/qcom,llcc.txt      |  60 ++++
 drivers/soc/qcom/Kconfig                           |  17 +
 drivers/soc/qcom/Makefile                          |   2 +
 drivers/soc/qcom/llcc-sdm845.c                     | 108 ++++++
 drivers/soc/qcom/llcc-slice.c                      | 380 +++++++++++++++++++++
 include/linux/soc/qcom/llcc-qcom.h                 | 167 +++++++++
 6 files changed, 734 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
 create mode 100644 drivers/soc/qcom/llcc-sdm845.c
 create mode 100644 drivers/soc/qcom/llcc-slice.c
 create mode 100644 include/linux/soc/qcom/llcc-qcom.h

--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
