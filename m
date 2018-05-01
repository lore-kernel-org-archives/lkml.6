Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeEAJLL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:11:11 -0400
Received: from foss.arm.com ([217.140.101.70]:44004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750994AbeEAJLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:11:08 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 00/27] coresight: TMC ETR backend support for perf
Date: Tue,  1 May 2018 10:10:30 +0100
Message-Id: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series achieves two goals :

 a) Support for all possible backends in ETR buffer and
    transparent management of the buffer irrespective of the
    backend in use.
 b) Adds support for perf using ETR as a sink, using the
    best possible backend.

For (a), we add support TMC ETR in-built scatter gather unit and
the new dedicated scatter-gather component, Coresight Address
Translation Unit (CATU) - new IP, part of the Arm Coresight SoC-600
family to provide improved SG mechanism.

With the addition of CATU, we could operate the ETR in 3 possible
combinations of buffers.

 1) Contiguous DMA buffer
 2) TMC-ETR built-in Scatter Gather table
 3) CATU backed scatter gather table.

To avoid the complications of the managing the buffer, this series
adds a layer for managing the ETR buffer, which makes the best possibly
choice based on what is available. The allocation can be tuned by passing
in flags, existing pages (e.g, perf ring buffer) etc.

Towards supporting ETR Scatter Gather mode and CATU tables, we introduce
a generic TMC scatter-gather table which can be used to manage the data
and table pages. The table can be filled in the respective mode (CATU
vs ETR_SG) by the mode specific code.

During the testing of v1 of the ETR SG driver, we found out that a couple
of the boards (Hikey 960 and DB410c. Juno is fine) have an unusable
Scatter-Gather mode. In SG mode the ETR performs both READs
(for next table pointer) and WRITEs (the trace data) simultaneously.
So if the READ transaction doesn't complete (which is what we
have observed), that could hold up the ETR from writing the data
as it doesn't know the buffer address and hence stalling it. This
has also been confirmed by reading the buffer data via RRD for the
ETR, which implies that there are some issues with the READ transactions
from the ETR. Juno is the only platform we have tested the SG mode
successfully. So, in order to avoid causing problems by using SG mode,
we disable the SG mode by default on all platforms unless it is known
to be safe. We add a DT bindings for white listing an ETR for scatter
gather mode.

The TMC ETR-SG mechanism doesn't allow starting the trace at non-zero
offset (required by perf). So we make some tricky changes to the table
at run time to allow starting at any "Page aligned" offset and then
wrap around to the beginning of the buffer with very less overhead.
See patches for more description.

The series also improves the way the ETR is controlled by different modes
(sysfs vs. perf) by keeping mode specific data. This allows access
to the trace data collected in sysfs mode, even when the ETR is
operated in perf mode. Also with the transparent management of the
buffer and scatter-gather mechanism, we can allow the user to
request for larger trace buffers for sysfs mode. This is supported
by providing a sysfs file, "buffer_size" which accepts a page aligned
size, which will be used by the ETR when allocating a buffer.

Finally, it cleans up the etm perf sink callbacks a little bit and
then adds the support for ETR sink. For the ETR, we try our best to
use the perf ring buffer as the target hardware buffer, provided :
 1) The ETR is dma coherent (since the pages will be shared with
    userspace perf tool).
 2) The perf is used in snapshot mode (The ETR cannot be stopped
    based on the size of the data written hence we could easily
    overwrite the buffer. We may be able to fix this in the future)
 3) The ETR supports one of the Scatter-Gather modes (in-built SG
    or a CATU).

TODO: The conditions above need some discussion. Please see the
last patch for more information.

If we can't use the perf buffers directly, we fallback to using
software buffering where we have to copy the trace data back
to the perf ring buffer.

Tested on Juno, an FPGA platform with CATU.

Applies on 4.17-rc3 and is also available at :

	git://linux-arm.org/linux-skp.git etr-perf-catu/v2

Changes since V1 :
 [ http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/538151.html ]

 - Address comments on v1
 - Fix build failure on arm32
 - Add CATU (Coresight Address Translation Unit) support.
 - Provide buffer isolation. i.e hide the buffer consumed by userspace from
   the ETR when using ETR SG or CATU
 - Add device-tree bindings to allow usage of ETR scatter-gather mode.


Suzuki K Poulose (27):
  coresight: ETM: Add support for ARM Cortex-A73
  coresight: Cleanup device subtype struct
  coresight: Add helper device type
  coresight: Introduce support for Coresight Addrss Translation Unit
  dts: bindings: Document device tree binding for CATU
  coresight: tmc etr: Disallow perf mode temporarily
  coresight: tmc: Hide trace buffer handling for file read
  coresight: tmc-etr: Do not clean trace buffer
  coresight: Add helper for inserting synchronization packets
  dts: bindings: Restrict coresight tmc-etr scatter-gather mode
  dts: juno: Add scatter-gather support for all revisions
  coresight: tmc-etr: Allow commandline option to override SG use
  coresight: Add generic TMC sg table framework
  coresight: Add support for TMC ETR SG unit
  coresight: tmc-etr: Make SG table circular
  coresight: tmc-etr: Add transparent buffer management
  coresight: etr: Add support for save restore buffers
  coresight: catu: Add support for scatter gather tables
  coresight: catu: Plug in CATU as a backend for ETR buffer
  coresight: tmc: Add configuration support for trace buffer size
  coresight: Convert driver messages to dev_dbg
  coresight: tmc-etr: Track if the device is coherent
  coresight: tmc-etr: Handle driver mode specific ETR buffers
  coresight: tmc-etr: Relax collection of trace from sysfs mode
  coresight: etr_buf: Add helper for padding an area of trace data
  coresight: perf: Remove reset_buffer call back for sinks
  coresight: etm-perf: Add support for ETR backend

 .../ABI/testing/sysfs-bus-coresight-devices-tmc    |    8 
 Documentation/admin-guide/kernel-parameters.txt    |    8 +
 .../devicetree/bindings/arm/coresight.txt          |   55 +
 arch/arm64/boot/dts/arm/juno-base.dtsi             |    1 +
 drivers/hwtracing/coresight/Kconfig                |   10 +
 drivers/hwtracing/coresight/Makefile               |    1 +
 drivers/hwtracing/coresight/coresight-catu.c       |  785 +++++++++
 drivers/hwtracing/coresight/coresight-catu.h       |  119 ++
 .../coresight/coresight-dynamic-replicator.c       |    4 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |   74 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |    9 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      |    4 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |   28 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |    4 +-
 drivers/hwtracing/coresight/coresight-priv.h       |   10 +-
 drivers/hwtracing/coresight/coresight-replicator.c |    4 +-
 drivers/hwtracing/coresight/coresight-stm.c        |    4 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  111 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 1767 ++++++++++++++++++--
 drivers/hwtracing/coresight/coresight-tmc.c        |   94 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |  160 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       |    4 +-
 drivers/hwtracing/coresight/coresight.c            |   49 +-
 include/linux/coresight.h                          |   51 +-
 24 files changed, 3065 insertions(+), 299 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-catu.c
 create mode 100644 drivers/hwtracing/coresight/coresight-catu.h

-- 
2.7.4
