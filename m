Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427513AbeCBMV1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:21:27 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:40628 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423042AbeCBMVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:21:15 -0500
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kexec@lists.infradead.org
Cc: davem@davemloft.net, ebiederm@xmission.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: [RFC 0/2] kernel: add support to collect hardware logs in panic
Date: Fri,  2 Mar 2018 17:49:56 +0530
Message-Id: <cover.1519911559.git.rahul.lakkireddy@chelsio.com>
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
state of the underlying device at the time of kernel panic. The
collected logs are appended to vmcore along with details, such as
start address and length of the logs, which are required for
extraction during post-analysis.

Device drivers can use crash_driver_dump_register() to register their
callback that collects underlying device specific hardware/firmware
logs during kernel panic (i.e. before booting into the second kernel).
Drivers can unregister with crash_driver_dump_unregister().

To extract the device specific hardware/firmware logs using crash:

crash> help -D | grep DRIVERDUMP
DRIVERDUMP=(cxgb4_0000:02:00.4, ffffb131090bd000, 37782968)

crash> rd ffffb131090bd000 37782968 -r hardware.log
37782968 bytes copied from 0xffffb131090bd000 to hardware.log

Patch 1 adds API to allow drivers to register callback to
collect the device specific hardware/firmware logs.

Patch 2 shows a cxgb4 driver example using the API to collect
hardware/firmware logs during kernel panic.

Suggestions and feedback will be much appreciated.

Thanks,
Rahul

Rahul Lakkireddy (2):
  kernel/crash_core: add API to collect hardware dump in kernel panic
  cxgb4: collect hardware dump in kernel panic

 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h       |  6 ++
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c | 95 +++++++++++++++++++++++-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.h |  4 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c  | 12 +++
 include/linux/crash_core.h                       | 33 ++++++++
 kernel/crash_core.c                              | 83 ++++++++++++++++++++-
 kernel/kexec_core.c                              |  1 +
 7 files changed, 229 insertions(+), 5 deletions(-)

-- 
2.14.1
