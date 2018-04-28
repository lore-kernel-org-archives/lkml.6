Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933235AbeD1Acs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 20:32:48 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32822 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933115AbeD1Acq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 20:32:46 -0400
X-Google-Smtp-Source: AB8JxZqojX7tSE70uAVL8D9uvcHL0fxE+ycjAkMl2e2KLjSkyeW2iOFh1gwHYWeN4TTwz+7Y5U3KgQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list), davem@davemloft.net,
        cphealy@gmail.com, nikita.yoush@cogentembedded.com,
        vivien.didelot@savoirfairelinux.com, Nisar.Sayed@microchip.com,
        UNGLinuxDriver@microchip.com
Subject: [RFC net-next 0/5] Support for PHY test modes
Date: Fri, 27 Apr 2018 17:32:30 -0700
Message-Id: <20180428003237.1536-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series adds support for specifying PHY test modes through ethtool
and paves the ground for adding support for more complex test modes that might
require data to be exchanged between user and kernel space.

As an example, patches are included to add support for the IEEE electrical test
modes for 100BaseT2 and 1000BaseT. Those do not require data to be passed back
and forth.

I believe the infrastructure to be usable enough to add support for other things
like:

- cable diagnostics
- pattern generator/waveform generator with specific pattern being indicated
  for instance

Questions for Andrew, and others:

- there could be room for adding additional ETH_TEST_FL_* values in order to
  help determine how the test should be running
- some of these tests can be disruptive to connectivity, the minimum we could
  do is stop the PHY state machine and restart it when "normal" is used to exit
  those test modes

Comments welcome!

Example:

# ethtool --get-phy-tests gphy
PHY tests gphy:
     normal (Test data: No)
     100baseT2-tx-waveform (Test data: No)
     100baseT2-tx-jitter (Test data: No)
     100baseT2-tx-idle (Test data: No)
     1000baseT-tx-waveform (Test data: No)
     1000baseT-tx-jitter-master (Test data: No)
     1000baseT-tx-jitter-slave (Test data: No)
     1000BaseT-tx-distorsion (Test data: No)
# ethtool --set-phy-test gphy 100baseT2-tx-waveform
# [   65.262513] brcm-sf2 f0b00000.ethernet_switch gphy: Link is Down


Florian Fainelli (5):
  net: phy: Pass stringset argument to ethtool operations
  net: ethtool: Add UAPI for PHY test modes
  net: ethtool: Add plumbing to get/set PHY test modes
  net: phy: Add support for IEEE standard test modes
  net: phy: broadcom: Add support for PHY test modes

 drivers/net/dsa/b53/b53_common.c |   4 +-
 drivers/net/phy/Kconfig          |   6 ++
 drivers/net/phy/Makefile         |   4 +-
 drivers/net/phy/bcm-phy-lib.c    |  21 ++++--
 drivers/net/phy/bcm-phy-lib.h    |   4 +-
 drivers/net/phy/bcm7xxx.c        |   9 ++-
 drivers/net/phy/broadcom.c       |   6 +-
 drivers/net/phy/marvell.c        |  11 ++-
 drivers/net/phy/micrel.c         |  11 ++-
 drivers/net/phy/phy-tests.c      | 159 +++++++++++++++++++++++++++++++++++++++
 drivers/net/phy/smsc.c           |  10 ++-
 include/linux/phy.h              |  99 +++++++++++++++++++++---
 include/net/dsa.h                |   4 +-
 include/uapi/linux/ethtool.h     |  23 ++++++
 net/core/ethtool.c               |  86 +++++++++++++++++++--
 net/dsa/master.c                 |   9 ++-
 net/dsa/port.c                   |   8 +-
 17 files changed, 427 insertions(+), 47 deletions(-)
 create mode 100644 drivers/net/phy/phy-tests.c

-- 
2.14.1
