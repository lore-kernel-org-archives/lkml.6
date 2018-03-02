Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427800AbeCBMng (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:43:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:43762 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1427615AbeCBMi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:38:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,412,1515484800";
   d="scan'208";a="21556736"
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
Subject: [PATCH v3 00/18] thunderbolt: Add support for Intel Titan Ridge
Date: Fri,  2 Mar 2018 15:38:34 +0300
Message-Id: <20180302123852.50463-1-mika.westerberg@linux.intel.com>
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

The previous versions of the patch series can be seen here:

  v2: https://lwn.net/Articles/748030/
  v1: https://www.spinics.net/lists/kernel/msg2721243.html           

Changes from v2:

  - Change wording of the message when Thunderbolt device is rejected by
    the firmware to be more clear what the reason for the rejection might
    be. Patches [7/18 and 18/18].
  - Use GENMASK() also in ICM_AR_INFO_SLEVEL_MASK in patch [18/18].
  - Added Andy's tag to patch [18/18].

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
 drivers/thunderbolt/icm.c                       | 761 +++++++++++++++++++++---
 drivers/thunderbolt/nhi.c                       |   5 +-
 drivers/thunderbolt/nhi.h                       |   5 +
 drivers/thunderbolt/switch.c                    |  61 +-
 drivers/thunderbolt/tb.h                        |  14 +
 drivers/thunderbolt/tb_msgs.h                   | 180 +++++-
 drivers/thunderbolt/xdomain.c                   |  47 +-
 include/linux/thunderbolt.h                     |  19 +
 12 files changed, 1183 insertions(+), 115 deletions(-)

-- 
2.16.1
