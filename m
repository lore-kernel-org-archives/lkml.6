Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F00FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694272175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfA2PGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:06:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:7039 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbfA2PBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:01:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 07:01:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="142391781"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2019 07:01:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 17107D4; Tue, 29 Jan 2019 17:01:43 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH 00/28] thunderbolt: Software connection manager improvements
Date:   Tue, 29 Jan 2019 18:01:15 +0300
Message-Id: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Software connection manager (drivers/thunderbolt/tb.c) is used on older
Apple hardware with Light Ridge, Cactus Ridge or Falcon Ridge controllers
to create PCIe tunnels when a Thunderbolt device is connected. Currently
only one PCIe tunnel is supported. On newer Alpine Ridge based Apple
systems the driver starts the firmware which then takes care creating
tunnels.

This series improves the software connection manager so that it will
support:

  - Full PCIe daisy chains (up to 6 devices)
  - Display Port tunneling
  - P2P networking

We also add support for Titan Ridge based Apple systems where we can use
the same flows than with Alpine Ridge to start the firmware.

Note in order to prevent possible DMA attacks on these systems we should
make sure IOMMU is enabled. One option is to force dmar_platform_optin()
return true on Apple hardware. However, it is not part of this series. I'm
trusting people using Linux on such systems to take care of it.  :-)

The first patch is for the networking driver (to make it work on both
software and firmware CM systems). I'm looking for either an ACK from
the network maintainers so I can take it with the rest of the series via
thunderbolt tree, or alternatively it can be picked directly into the
networking tree as it is independent of the rest of the series.

Thanks!

Mika Westerberg (28):
  net: thunderbolt: Unregister ThunderboltIP protocol handler when suspending
  thunderbolt: Do not allocate switch if depth is greater than 6
  thunderbolt: Enable TMU access when accessing port space on legacy devices
  thunderbolt: Add dummy read after port capability list walk on Light Ridge
  thunderbolt: Move LC specific functionality into a separate file
  thunderbolt: Configure lanes when switch is initialized
  thunderbolt: Set sleep bit when suspending switch
  thunderbolt: Properly disable path
  thunderbolt: Cache adapter specific capability offset into struct port
  thunderbolt: Rename tunnel_pci to tunnel
  thunderbolt: Generalize tunnel creation functionality
  thunderbolt: Add functions for allocating and releasing hop IDs
  thunderbolt: Add helper function to iterate from one port to another
  thunderbolt: Extend tunnel creation to more than 2 adjacent switches
  thunderbolt: Deactivate all paths before restarting them
  thunderbolt: Discover preboot PCIe paths the boot firmware established
  thunderbolt: Add support for full PCIe daisy chains
  thunderbolt: Scan only valid NULL adapter ports in hotplug
  thunderbolt: Generalize port finding routines to support all port types
  thunderbolt: Rework NFC credits handling
  thunderbolt: Add support for Display Port tunnels
  thunderbolt: Run tb_xdp_handle_request() in system workqueue
  thunderbolt: Add XDomain UUID exchange support
  thunderbolt: Add support for DMA tunnels
  thunderbolt: Make tb_switch_alloc() return ERR_PTR()
  thunderbolt: Add support for XDomain connections
  thunderbolt: Make rest of the logging to happen at debug level
  thunderbolt: Start firmware on Titan Ridge Apple systems

 drivers/net/thunderbolt.c        |   3 +
 drivers/thunderbolt/Makefile     |   4 +-
 drivers/thunderbolt/cap.c        |  89 +++-
 drivers/thunderbolt/ctl.c        |   2 +-
 drivers/thunderbolt/icm.c        |  15 +-
 drivers/thunderbolt/lc.c         | 179 ++++++++
 drivers/thunderbolt/path.c       | 326 +++++++++++++--
 drivers/thunderbolt/switch.c     | 466 ++++++++++++++++++---
 drivers/thunderbolt/tb.c         | 529 ++++++++++++++++++------
 drivers/thunderbolt/tb.h         |  68 ++-
 drivers/thunderbolt/tb_msgs.h    |  11 +
 drivers/thunderbolt/tb_regs.h    |  50 ++-
 drivers/thunderbolt/tunnel.c     | 681 +++++++++++++++++++++++++++++++
 drivers/thunderbolt/tunnel.h     |  75 ++++
 drivers/thunderbolt/tunnel_pci.c | 226 ----------
 drivers/thunderbolt/tunnel_pci.h |  31 --
 drivers/thunderbolt/xdomain.c    | 142 ++++++-
 include/linux/thunderbolt.h      |   8 +
 18 files changed, 2389 insertions(+), 516 deletions(-)
 create mode 100644 drivers/thunderbolt/lc.c
 create mode 100644 drivers/thunderbolt/tunnel.c
 create mode 100644 drivers/thunderbolt/tunnel.h
 delete mode 100644 drivers/thunderbolt/tunnel_pci.c
 delete mode 100644 drivers/thunderbolt/tunnel_pci.h

-- 
2.20.1

