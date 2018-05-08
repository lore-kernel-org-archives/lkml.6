Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932339AbeEHKbE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 06:31:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7241 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754371AbeEHKa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 06:30:59 -0400
From: John Garry <john.garry@huawei.com>
To: <xuwei5@huawei.com>, <mika.westerberg@linux.intel.com>,
        <andriy.shevchenko@linux.intel.com>, <lee.jones@linaro.org>
CC: <rjw@rjwysocki.net>, <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <z.liuxinliang@hisilicon.com>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/3] HISI LPC ACPI UART support
Date: Tue, 8 May 2018 18:27:29 +0800
Message-ID: <1525775252-239214-1-git-send-email-john.garry@huawei.com>
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

It also drops MFD API usage. It's not right to use MFD
APIs outside drivers/mfd. As the alternate solution, we
use platform device APIs directly.

The UART is 8250-compatible, and has the following
profile:
- IO space iotype
- no interrupt, so polling mode required
- 16550 type

Currently no platform driver exists for the UART. Indeed,
for PNP-compatible devices - like this UART - it would be
better to create a PNP device so that we may use the
existing PNP driver. Thus, we should use the 8250 PNP
driver.

However this host driver does not support PNP devices.
An RFC was sent for PNP support in [1]. However it was
deemed impractical to follow this path.

So to provide this UART support we use the 8250 generic
isa driver. For this, we need to set the UART platform
device name to match the 8250 isa driver. This means
passing the 8250 serial config in the child pdev platform
data.

1. https://lkml.org/lkml/2018/4/20/278

Differences:
v1 -> v2:
- drop MFD API usage and use platform device APIs
  directly for ACPI support

RFC -> v1:
- drop PNP support
- use static MFD cells
- add 8250 setup

John Garry (3):
  HISI LPC: Stop using MFD APIs
  HISI LPC: Re-Add ACPI child enumeration support
  HISI LPC: Add ACPI UART support

 drivers/bus/Kconfig    |   1 -
 drivers/bus/hisi_lpc.c | 159 ++++++++++++++++++++++++++++++-------------------
 2 files changed, 97 insertions(+), 63 deletions(-)

-- 
1.9.1
