Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbeDQHp0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 03:45:26 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:35094 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeDQHpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 03:45:22 -0400
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: netdev@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: [PATCH net-next v4 0/3] kernel: add support to collect hardware logs in crash recovery kernel
Date: Tue, 17 Apr 2018 13:14:16 +0530
Message-Id: <cover.1523950321.git.rahul.lakkireddy@chelsio.com>
X-Mailer: git-send-email 2.5.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On production servers running variety of workloads over time, kernel
panic can happen sporadically after days or even months. It is
important to collect as much debug logs as possible to root cause
and fix the problem, that may not be easy to reproduce. Snapshot of
underlying hardware/firmware state (like register dump, firmware
logs, adapter memory, etc.), at the time of kernel panic will be very
helpful while debugging the culprit device driver.

This series of patches add new generic framework that enable device
drivers to collect device specific snapshot of the hardware/firmware
state of the underlying device in the crash recovery kernel. In crash
recovery kernel, the collected logs are added as elf notes to
/proc/vmcore, which is copied by user space scripts for post-analysis.

The sequence of actions done by device drivers to append their device
specific hardware/firmware logs to /proc/vmcore are as follows:

1. During probe (before hardware is initialized), device drivers
register to the vmcore module (via vmcore_add_device_dump()), with
callback function, along with buffer size and log name needed for
firmware/hardware log collection.

2. vmcore module allocates the buffer with requested size. It adds
an elf note and invokes the device driver's registered callback
function.

3. Device driver collects all hardware/firmware logs into the buffer
and returns control back to vmcore module.

The device specific hardware/firmware logs can be seen as elf notes:

# readelf -n /proc/vmcore

Displaying notes found at file offset 0x00001000 with length 0x04003288:
  Owner                 Data size	Description
  VMCOREDD_cxgb4_0000:02:00.4 0x02000fd8	Unknown note type: (0x00000700)
  VMCOREDD_cxgb4_0000:04:00.4 0x02000fd8	Unknown note type: (0x00000700)
  CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
  CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
  CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
  CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
  CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
  CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
  CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
  CORE                 0x00000150	NT_PRSTATUS (prstatus structure)
  VMCOREINFO           0x0000074f	Unknown note type: (0x00000000)

Patch 1 adds API to vmcore module to allow drivers to register callback
to collect the device specific hardware/firmware logs.  The logs will
be added to /proc/vmcore as elf notes.

Patch 2 updates read and mmap logic to append device specific hardware/
firmware logs as elf notes.

Patch 3 shows a cxgb4 driver example using the API to collect
hardware/firmware logs in crash recovery kernel, before hardware is
initialized.

Thanks,
Rahul

RFC v1: https://lkml.org/lkml/2018/3/2/542
RFC v2: https://lkml.org/lkml/2018/3/16/326

---
v4:
- Made __vmcore_add_device_dump() static.
- Moved compile check to define vmcore_add_device_dump() to
  crash_dump.h to fix compilation when vmcore.c is not compiled in.
- Convert ---help--- to help in Kconfig as indicated by checkpatch.
- Rebased to tip.

v3:
- Dropped sysfs crashdd module.
- Exported dumps as elf notes. Suggested by Eric Biederman
  <ebiederm@xmission.com>.  Added as patch 2 in this version.
- Added CONFIG_PROC_VMCORE_DEVICE_DUMP to allow configuring device
  dump support.
- Moved logic related to adding dumps from crashdd to vmcore module.
- Rename all crashdd* to vmcoredd*.
- Updated comments.

v2:
- Added ABI Documentation for crashdd.
- Directly use octal permission instead of macro.

Changes since rfc v2:
- Moved exporting crashdd from procfs to sysfs. Suggested by
  Stephen Hemminger <stephen@networkplumber.org>
- Moved code from fs/proc/crashdd.c to fs/crashdd/ directory.
- Replaced all proc API with sysfs API and updated comments.
- Calling driver callback before creating the binary file under
  crashdd sysfs.
- Changed binary dump file permission from S_IRUSR to S_IRUGO.
- Changed module name from CRASH_DRIVER_DUMP to CRASH_DEVICE_DUMP.

rfc v2:
- Collecting logs in 2nd kernel instead of during kernel panic.
  Suggested by Eric Biederman <ebiederm@xmission.com>.
- Added new crashdd module that exports /proc/crashdd/ containing
  driver's registered hardware/firmware logs in patch 1.
- Replaced the API to allow drivers to register their hardware/firmware
  log collect routine in crash recovery kernel in patch 1.
- Updated patch 2 to use the new API in patch 1.

Rahul Lakkireddy (3):
  vmcore: add API to collect hardware dump in second kernel
  vmcore: append device dumps to vmcore as elf notes
  cxgb4: collect hardware dump in second kernel

 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h       |   4 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c |  25 ++
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.h |   3 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c  |  10 +
 fs/proc/Kconfig                                  |  10 +
 fs/proc/vmcore.c                                 | 399 ++++++++++++++++++++++-
 include/linux/crash_core.h                       |   4 +
 include/linux/crash_dump.h                       |  17 +
 include/linux/kcore.h                            |   6 +
 include/uapi/linux/elf.h                         |   1 +
 10 files changed, 466 insertions(+), 13 deletions(-)

-- 
2.14.1
