Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204C4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20B32081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20B32081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeK1Wbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:31:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:48565 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbeK1Wbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:31:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 03:30:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,290,1539673200"; 
   d="scan'208";a="113714265"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 28 Nov 2018 03:30:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 87AF7107; Wed, 28 Nov 2018 13:30:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 00/15] i2c-multi-instantiate: Adapt for INT3515 and alike
Date:   Wed, 28 Nov 2018 13:30:09 +0200
Message-Id: <20181128113024.42126-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently i2c-multi-instantiate driver does not support the case
of INT3515 USB PD device, where:

- Interrupt() is used instead of GpioInt()
- All slaves may be the same from IP point of view
- There can be variadic amount of slaves

This series is addressing all above.

Note, series has been smoke tested (Heikki would do BAT or more)
on Intel Coffee Lake system.

The idea is to push this either through PDx86 tree (needs Rafael's ACKs) or ACPI.
In any case it needs tags from Heikki, Hans, Mika, Wolfram and Jonathan.

Testing and comments are warmly welcome.

In v4:
- directly return -EPROBE_DEFER from i2c_acpi_new_device()
- due to above split error handling simplification to separate patches

In v3:
- revisit error codes returned by i2c_acpi_new_device() (Hans, Mika)
- add documentation to exported i2c_acpi_get_i2c_resource() (Mika)
- drop Hans' Rb tag in patch 5 due to changes
- append Mika's Ab tag to patch 6

In v2:
- drop patches to copy fwnode and to handle BOSC0200 device
- append check for amount of devices listed in the driver's mapping
- add Rb tag given by Hans

Andy Shevchenko (15):
  defconfig: enable I2C_DEBUG_CORE
  platform/x86: intel_cht_int33fe: Remove duplicate NULL check
  platform/x86: intel_cht_int33fe: Accept errors of
    i2c_acpi_new_device()
  platform/x86: i2c-multi-instantiate: Accept errors of
    i2c_acpi_new_device()
  i2c: acpi: Return error pointers from i2c_acpi_new_device()
  platform/x86: intel_cht_int33fe: Get rid of obsolete conditional
  platform/x86: i2c-multi-instantiate: Get rid of obsolete conditional
  i2c: acpi: Use ACPI_FAILURE instead of !ACPI_SUCCESS
  i2c: acpi: Introduce i2c_acpi_get_i2c_resource() helper
  platform/x86: i2c-multi-instantiate: Count I2cSerialBus() resources
  platform/x86: i2c-multi-instantiate: Distinguish IRQ resource type
  platform/x86: i2c-multi-instantiate: Introduce IOAPIC IRQ support
  platform/x86: i2c-multi-instantiate: Allow to have same slaves
  ACPI / scan: Create platform device for INT3515 ACPI nodes
  iio: inv_mpu6050: Use i2c_acpi_get_i2c_resource() helper

 arch/x86/configs/i386_defconfig              |  1 +
 arch/x86/configs/x86_64_defconfig            |  1 +
 drivers/acpi/scan.c                          |  1 +
 drivers/i2c/i2c-core-acpi.c                  | 64 +++++++++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c   | 16 ++--
 drivers/platform/x86/i2c-multi-instantiate.c | 97 ++++++++++++++++----
 drivers/platform/x86/intel_cht_int33fe.c     | 20 ++--
 drivers/usb/typec/tps6598x.c                 |  8 +-
 include/linux/acpi.h                         | 11 +++
 9 files changed, 159 insertions(+), 60 deletions(-)

--
2.19.2

