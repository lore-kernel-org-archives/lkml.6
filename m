Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbeERQji (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:39:38 -0400
Received: from foss.arm.com ([217.140.101.70]:56004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbeERQjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:39:35 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        robh@kernel.org, sudeep.holla@arm.com, frowand.list@gmail.com,
        coresight@lists.linaro.org, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 00/11] coresight: tmc-etr Transparent buffer management
Date: Fri, 18 May 2018 17:39:16 +0100
Message-Id: <1526661567-4578-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is split of the Coresight ETR perf support patches posted
here [0]. The CATU support and perf backend support will be posted as
separate series for better management and review of the patches.

This series adds the support for TMC ETR Scatter-Gather mode to allow
using physical non-contiguous buffer for holding the trace data. It
also adds a layer to handle the buffer management in a transparent
manner, independent of the underlying mode used by the TMC ETR.
The layer chooses the ETR mode based on different parameters (size,
re-using a set of pages, presence of an SMMU etc.).

Finally we add a sysfs parameter to tune the buffer size for ETR in
sysfs-mode.

During the testing, we found out that if the TMC ETR is not properly
connected to the memory subsystem, the ETR could lock-up the system
while waiting for the "read" transactions to complete in scatter-gather
mode. So, we do not use the mode on a system unless it is safe to do
so. This is specified by a DT property "arm,scatter-gather".

Applies on v4.17-rc4

Changes since v2 in [0] :
 - Split the series in [0]
 - Address comments on v2
 - Rename DT property "scatter-gather" to "arm,scatter-gather"
 - Add ETM PID for Cortex-A35, use macros to make the listing easier

[0] - http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/574875.html

Suzuki K Poulose (11):
  coresight: ETM: Add support for Arm Cortex-A73 and Cortex-A35
  coresight: tmc: Hide trace buffer handling for file read
  coresight: tmc-etr: Do not clean trace buffer
  coresight: tmc-etr: Disallow perf mode
  coresight: Add helper for inserting synchronization packets
  dts: bindings: Restrict coresight tmc-etr scatter-gather mode
  dts: juno: Add scatter-gather support for all revisions
  coresight: Add generic TMC sg table framework
  coresight: Add support for TMC ETR SG unit
  coresight: tmc-etr: Add transparent buffer management
  coresight: tmc: Add configuration support for trace buffer size

 .../ABI/testing/sysfs-bus-coresight-devices-tmc    |    8 +
 .../devicetree/bindings/arm/coresight.txt          |    5 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi             |    1 +
 drivers/hwtracing/coresight/coresight-etb10.c      |   12 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |   32 +-
 drivers/hwtracing/coresight/coresight-priv.h       |   10 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   45 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 1032 ++++++++++++++++++--
 drivers/hwtracing/coresight/coresight-tmc.c        |   83 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |  111 ++-
 drivers/hwtracing/coresight/coresight.c            |    3 +-
 11 files changed, 1169 insertions(+), 173 deletions(-)

-- 
2.7.4
