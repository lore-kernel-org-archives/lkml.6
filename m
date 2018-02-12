Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932614AbeBLDIr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 22:08:47 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:56778 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932443AbeBLDIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 22:08:44 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <cover.1518397634.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net v4 00/13] Fixes, cleanup and modernization for some legacy ethernet NIC drivers
Date: Sun, 11 Feb 2018 22:08:43 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds Driver Model support to Mac NIC drivers,
fixes some bugs, removes some dead code and adopts netif_* calls to
reduce code duplication.

This series results in a reduction of about 100 lines of code.

It has been tested on a variety of Macs, with coverage for the
changes to lib8390.c, mac8390.c, macsonic.c, sonic.c and macmace.c.

Much of this patch series depends on the NuBus modernization series
which has been merged for 4.16-rc.

Changes since v3:
- Rebased on current nubus code.
- Renamed some more struct nubus_rsrc pointers that were misleadingly
  called 'dev' and 'ndev'.
- Removed an unused struct member from the mac89x0 driver.
- Dropped gratuitous log message changes (capitalization, punctuation
  etc.) so that the old messages can still be grep'd.
- Improved patch descriptions.
- Revised code style to reduce checkpatch.pl noise.
- Addressed two more 8390 logging issues.
- Added a new patch to remove redundant 8390.o dependencies.
- Re-ordered some patches for easier cherry picking.

Changes since v2:
- Modernized the Mac NIC drivers by adopting the Linux Driver Model.
- Used dev_foo() in NuBus drivers.
- Removed device probe messages logged after register_netdev().

Changes since v1:
- Retained the once_is_enough test in mac89x0.c.
- Added tested-by tags.
- Moved netdev_info() call to correct branch in macmace.c.


Finn Thain (13):
  net/8390: Remove redundant make dependencies
  net/8390: Fix msg_enable patch snafu
  net/smc9194: Remove bogus CONFIG_MAC reference
  net/macmace: Fix and clean up log messages
  net/mac89x0: Remove dead or unreachable code
  net/mac89x0: Convert to platform_driver
  net/mac89x0: Fix and modernize log messages
  net/mac89x0: Replace custom debug logging with netif_* calls
  net/mac8390: Convert to nubus_driver
  net/mac8390: Fix log messages
  net/macsonic: Convert to nubus_driver
  net/sonic: Clean up and modernize log messages
  net/sonic: Replace custom debug logging with netif_* calls

 arch/m68k/mac/config.c                   |   4 +
 drivers/net/Space.c                      |   6 -
 drivers/net/ethernet/8390/Makefile       |   6 +-
 drivers/net/ethernet/8390/ax88796.c      |   3 -
 drivers/net/ethernet/8390/axnet_cs.c     |   2 -
 drivers/net/ethernet/8390/etherh.c       |  17 ---
 drivers/net/ethernet/8390/hydra.c        |   4 -
 drivers/net/ethernet/8390/lib8390.c      |   2 +
 drivers/net/ethernet/8390/mac8390.c      | 170 ++++++++++------------
 drivers/net/ethernet/8390/mcf8390.c      |   4 -
 drivers/net/ethernet/8390/ne.c           |   2 +-
 drivers/net/ethernet/8390/pcnet_cs.c     |   4 -
 drivers/net/ethernet/8390/wd.c           |   2 +-
 drivers/net/ethernet/8390/zorro8390.c    |   5 -
 drivers/net/ethernet/apple/macmace.c     |   9 +-
 drivers/net/ethernet/cirrus/mac89x0.c    | 157 +++++++-------------
 drivers/net/ethernet/natsemi/jazzsonic.c |  32 +---
 drivers/net/ethernet/natsemi/macsonic.c  | 241 ++++++++++++++++++-------------
 drivers/net/ethernet/natsemi/sonic.c     |  92 ++++++------
 drivers/net/ethernet/natsemi/sonic.h     |   2 +
 drivers/net/ethernet/natsemi/xtsonic.c   |  30 +---
 drivers/net/ethernet/smsc/Kconfig        |   2 +-
 include/net/Space.h                      |   2 -
 23 files changed, 347 insertions(+), 451 deletions(-)

-- 
2.13.6
