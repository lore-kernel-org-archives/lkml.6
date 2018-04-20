Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754636AbeDTKIX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:08:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6753 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754335AbeDTKIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:08:19 -0400
From: John Garry <john.garry@huawei.com>
To: <rjw@rjwysocki.net>, <andriy.shevchenko@linux.intel.com>,
        <linux-acpi@vger.kernel.org>, <lenb@kernel.org>,
        <mika.westerberg@linux.intel.com>, <lorenzo.pieralisi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <linuxarm@huawei.com>, <z.liuxinliang@hisilicon.com>,
        John Garry <john.garry@huawei.com>
Subject: [RFC PATCH 0/2] HISI LPC: Add PNP device support
Date: Fri, 20 Apr 2018 18:07:24 +0800
Message-ID: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for creating PNP devices
for devices attached to the HiSilicon LPC host bus.

Currently an mfd-cell (platform device) is created per
device on the bus for using ACPI-based firmware. As
such, we need require a platform driver for these
devices.

However for PNP-compatible devices, it would be better
to create a PNP device so that we may use the existing
PNP driver.

The PNP-compatible device we are interested in is the
8250-compatible UART on the Huawei D03 development
board. This uart has the following profile:
- IO space iotype
- no interrupt, so polling mode required
- 16550 compatible

Currently no platform driver exists for this. I did
send an RFC to add support to the 8250_dw driver, but
Andy Shevchenko suggested adding PNP support to the
host driver instead so we may use the appropriate PNP
driver (8250_pnp) without modification, see here:
https://lkml.org/lkml/2018/2/26/354

As for the implementation in this patchset, to avoid
the PNP scan from creating and adding the device,
we reuse the "enumeration_by_parent" flag to hold off
adding the PNP device, so the parent driver can modify
the IO resources to translate from the bus address
to the logical PIO address, and then add the device
for probing.

This solution is not good - hence the RFC. But I am
looking for suggestions on how to solve this.

Any opinions or ideas?

Thanks!

John Garry (2):
  ACPI / PNP: Don't add "enumeration_by_parent" devices
  HISI LPC: Add PNP device support

 drivers/bus/hisi_lpc.c     | 38 +++++++++++++++++++++++++++++++++++++-
 drivers/pnp/pnpacpi/core.c | 12 ++++++++----
 2 files changed, 45 insertions(+), 5 deletions(-)

-- 
1.9.1
