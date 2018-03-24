Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeCXK5v (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 06:57:51 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:27758 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeCXK5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 06:57:47 -0400
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: [PATCH net-next v2 0/2] kernel: add support to collect hardware logs in crash recovery kernel
Date: Sat, 24 Mar 2018 16:26:32 +0530
Message-Id: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
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
recovery kernel, the collected logs are exposed via /sys/kernel/crashdd/
directory, which is copied by user space scripts for post-analysis.

A kernel module crashdd is newly added. In crash recovery kernel,
crashdd exposes /sys/kernel/crashdd/ directory containing device
specific hardware/firmware logs.

The sequence of actions done by device drivers to append their device
specific hardware/firmware logs to /sys/kernel/crashdd/ directory are
as follows:

1. During probe (before hardware is initialized), device drivers
register to the crashdd module (via crashdd_add_dump()), with
callback function, along with buffer size and log name needed for
firmware/hardware log collection.

2. Crashdd creates a driver's directory under /sys/kernel/crashdd/<driver>.
Then, it allocates the buffer with requested size and invokes the
device driver's registered callback function.

3. Device driver collects all hardware/firmware logs into the buffer
and returns control back to crashdd.

4. Crashdd exposes the buffer as a file via
/sys/kernel/crashdd/<driver>/<dump_file>.

5. User space script (/usr/lib/kdump/kdump-lib-initramfs.sh) copies
the entire /sys/kernel/crashdd/ directory to /var/crash/ directory.

Patch 1 adds crashdd module to allow drivers to register callback to
collect the device specific hardware/firmware logs.  The module also
exports /sys/kernel/crashdd/ directory containing the hardware/firmware
logs.

Patch 2 shows a cxgb4 driver example using the API to collect
hardware/firmware logs in crash recovery kernel, before hardware is
initialized.  The logs for the devices are made available under
/sys/kernel/crashdd/cxgb4/ directory.

Thanks,
Rahul

RFC v1: https://lkml.org/lkml/2018/3/2/542
RFC v2: https://lkml.org/lkml/2018/3/16/326

---
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


Rahul Lakkireddy (2):
  fs/crashdd: add API to collect hardware dump in second kernel
  cxgb4: collect hardware dump in second kernel

 Documentation/ABI/testing/sysfs-kernel-crashdd   |  34 ++++
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h       |   4 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c |  25 +++
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.h |   3 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c  |  12 ++
 fs/Kconfig                                       |   1 +
 fs/Makefile                                      |   1 +
 fs/crashdd/Kconfig                               |  10 +
 fs/crashdd/Makefile                              |   3 +
 fs/crashdd/crashdd.c                             | 233 +++++++++++++++++++++++
 fs/crashdd/crashdd_internal.h                    |  24 +++
 include/linux/crashdd.h                          |  24 +++
 12 files changed, 374 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-crashdd
 create mode 100644 fs/crashdd/Kconfig
 create mode 100644 fs/crashdd/Makefile
 create mode 100644 fs/crashdd/crashdd.c
 create mode 100644 fs/crashdd/crashdd_internal.h
 create mode 100644 include/linux/crashdd.h

-- 
2.14.1
