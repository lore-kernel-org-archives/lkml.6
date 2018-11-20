Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6761BC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233022087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233022087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeKUC3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:29:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:33297 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeKUC3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:29:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 07:59:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,257,1539673200"; 
   d="scan'208";a="87371397"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2018 07:59:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 511D09F; Tue, 20 Nov 2018 17:59:25 +0200 (EET)
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
Subject: [PATCH v1 00/15] i2c-multi-instantiate: Adapt for INT3515 and alike
Date:   Tue, 20 Nov 2018 17:59:09 +0200
Message-Id: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.1
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

Notes:
- series has been smoke tested (Heikki would do BAT or more) on Coffee Lake system
- patch for BOSC0200 might be considered as RFC since the modalias potential issue

The idea is to push this either through PDx86 tree (needs Rafael's ACKs) or ACPI.
In any case it needs tags from Heikki, Hans, Mika, Wolfram and Jonathan.

Testing and comments are warmly welcome.

Andy Shevchenko (15):
  platform/x86: intel_cht_int33fe: Remove duplicate NULL check
  platform/x86: intel_cht_int33fe: Accept errors of
    i2c_acpi_new_device()
  platform/x86: i2c-multi-instantiate: Accept errors of
    i2c_acpi_new_device()
  platform/x86: i2c-mutli-instantiate: Defer probe when no adapter found
  i2c: acpi: Return error pointers from i2c_acpi_new_device()
  i2c: acpi: Assign fwnode for devices created via i2c_acpi_new_device()
  i2c: acpi: Use ACPI_FAILURE instead of !ACPI_SUCCESS
  i2c: acpi: Introduce i2c_acpi_get_i2c_resource() helper
  platform/x86: i2c-multi-instantiate: Count I2cSerialBus() resources
  platform/x86: i2c-multi-instantiate: Distinguish IRQ resource type
  platform/x86: i2c-multi-instantiate: Introduce IOAPIC IRQ support
  platform/x86: i2c-multi-instantiate: Allow to have same slaves
  ACPI / scan: Create platform device for INT3515 ACPI nodes
  ACPI / scan: Create platform device for BOSC0200 ACPI nodes
  iio: inv_mpu6050: Use i2c_acpi_get_i2c_resource() helper

 drivers/acpi/scan.c                          |  2 +
 drivers/i2c/i2c-core-acpi.c                  | 43 +++++----
 drivers/iio/accel/bmc150-accel-i2c.c         |  1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c   | 16 ++--
 drivers/platform/x86/i2c-multi-instantiate.c | 99 ++++++++++++++++----
 drivers/platform/x86/intel_cht_int33fe.c     | 34 +++++--
 drivers/usb/typec/tps6598x.c                 |  8 +-
 include/linux/acpi.h                         | 11 +++
 8 files changed, 158 insertions(+), 56 deletions(-)

-- 
2.19.1

