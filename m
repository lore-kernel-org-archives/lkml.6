Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeECPNx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:13:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751132AbeECPNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:13:47 -0400
From: John Garry <john.garry@huawei.com>
To: <xuwei5@huawei.com>, <mika.westerberg@linux.intel.com>,
        <andriy.shevchenko@linux.intel.com>, <lee.jones@linaro.org>
CC: <rjw@rjwysocki.net>, <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <z.liuxinliang@hisilicon.com>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/2] HISI LPC ACPI UART support
Date: Thu, 3 May 2018 23:08:37 +0800
Message-ID: <1525360119-102166-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds ACPI FW support for the UART on
the LPC bus on the Huawei D03 development board.

The UART is 8250-compatible, and has the following
profile:
- IO space iotype
- no interrupt, so polling mode required
- 16550 type

Currently an mfd-cell (platform device) is created per
device on the bus for using ACPI  firmware. As such,
we need require a platform driver for these devices.

Currently no platform driver exists for the UART. Indeed,
for PNP-compatible devices - like this UART - it would be
better to create a PNP device so that we may use the
existing PNP driver. Thus, we should use the 8250 PNP
driver.

However this host driver does not support PNP devices.
An RFC was sent for PNP support in [1]. However it was
deemed impractical to follow this path.

As a solution, we use the 8250 generic isa driver. For
this, we need to set the UART platform device name to
match the 8250 isa driver, so we require special setup 
for this. To support this, we introduce static MFD cells,
and support special setup handling for each device.
For the UART, this means passing the 8250 serial config
in the MFD cell platform data.

1. https://lkml.org/lkml/2018/4/20/278

Differences:
RFC -> v1:
https://lkml.org/lkml/2018/4/20/278
- drop PNP support
- use static MFD cells
- add 8250 setup

John Garry (2):
  HISI LPC: Reference static MFD cells for ACPI support
  HISI LPC: Add ACPI UART support

 drivers/bus/hisi_lpc.c | 130 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 93 insertions(+), 37 deletions(-)

-- 
1.9.1
