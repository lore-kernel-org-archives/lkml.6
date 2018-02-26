Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753462AbeBZOLG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:11:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:55042 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753307AbeBZOKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:10:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="203825801"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jeremy McNicoll <jmcnicol@redhat.com>,
        Andrei Emeltchenko <andrei.emeltchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 00/18] thunderbolt: Add support for Intel Titan Ridge
Date: Mon, 26 Feb 2018 17:10:30 +0300
Message-Id: <20180226141048.83949-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for Intel Titan Ridge Thunderbolt controller.
Titan Ridge is the next generation Thunderbolt 3 controller and successor
of Alpine Ridge.

In addition to fixes and Titan Ridge support this series adds following:

  - USB only security level (SL4).

  - A new attribute for devices telling whether they were connected
    automatically during boot.

  - Preboot ACL allows userspace to specify a list of devices (based on
    device unique_id) that the firmware automatically connects during boot.

Bjorn, I would like to get your ACK/NACK for patch [2/18] because it is
using pci_unlock/lock_rescan_remove() from PCI subsystem.

Thanks!

The previous version of the patch series can be seen here:

  https://www.spinics.net/lists/kernel/msg2721243.html

Changes from v1:

  - Add stable tag to patch [6/18].
  - Use tb_xdomain_get() instead of open coding it in patch [12/18].
  - If ->get_boot_acl() fails unlock and goto out immediately (follow more
    standard pattern) in patch [12/18].
  - Make newline optional in boot_acl_store() in patch [12/18].
  - Update Documentation/admin-guide/thunderbolt.rst to show the new
    "usbonly" security level in patch [17/18].
  - Order DMA ports from 3 to 7 in patch [18/18].
  - Use 0xffULL instead in get_parent_route() in patch [18/18].
  - Sort Titan Ridge PCI IDs numerically in patch [18/18].
  - Use GENMASK() in patch [18/18].
  - Added Andy's tag to patches 1-17.

Mika Westerberg (13):
  thunderbolt: Resume control channel after hibernation image is created
  thunderbolt: Serialize PCIe tunnel creation with PCI rescan
  thunderbolt: Handle connecting device in place of host properly
  thunderbolt: Do not overwrite error code when domain adding fails
  thunderbolt: Wait a bit longer for root switch config space
  thunderbolt: Wait a bit longer for ICM to authenticate the active NVM
  thunderbolt: Handle rejected Thunderbolt devices
  thunderbolt: Factor common ICM add and update operations out
  thunderbolt: Add tb_switch_get()
  thunderbolt: Add constant for approval timeout
  thunderbolt: Move driver ready handling to struct icm
  thunderbolt: Add support for preboot ACL
  thunderbolt: Introduce USB only (SL4) security level

Radion Mirchevsky (4):
  thunderbolt: Correct function name in kernel-doc comment
  thunderbolt: Add tb_switch_find_by_route()
  thunderbolt: Add tb_xdomain_find_by_route()
  thunderbolt: Add support for Intel Titan Ridge

Yehezkel Bernat (1):
  thunderbolt: Add 'boot' attribute for devices

 Documentation/ABI/testing/sysfs-bus-thunderbolt |  33 +
 Documentation/admin-guide/thunderbolt.rst       |  15 +-
 drivers/thunderbolt/dma_port.c                  |  28 +-
 drivers/thunderbolt/domain.c                    | 130 +++-
 drivers/thunderbolt/icm.c                       | 760 +++++++++++++++++++++---
 drivers/thunderbolt/nhi.c                       |   5 +-
 drivers/thunderbolt/nhi.h                       |   5 +
 drivers/thunderbolt/switch.c                    |  61 +-
 drivers/thunderbolt/tb.h                        |  14 +
 drivers/thunderbolt/tb_msgs.h                   | 180 +++++-
 drivers/thunderbolt/xdomain.c                   |  47 +-
 include/linux/thunderbolt.h                     |  19 +
 12 files changed, 1182 insertions(+), 115 deletions(-)

-- 
2.16.1
