Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57113C04EBC
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285AC208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285AC208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeK1WrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:47:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:63435 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbeK1WrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:47:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 03:45:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,290,1539673200"; 
   d="scan'208";a="112925136"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 28 Nov 2018 03:45:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 48BBF107; Wed, 28 Nov 2018 13:45:35 +0200 (EET)
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
Subject: [PATCH v5 00/15] i2c-multi-instantiate: Adapt for INT3515 and alike
Date:   Wed, 28 Nov 2018 13:45:20 +0200
Message-Id: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
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

In v5:
- unmess with patches 3 and 4 (there were squashed by my mistake)
- other than above no code change from v4

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
  platform/x86: intel_cht_int33fe: Remove duplicate NULL check
  platform/x86: intel_cht_int33fe: Accept errors of
    i2c_acpi_new_device()
  platform/x86: i2c-multi-instantiate: Accept errors of
    i2c_acpi_new_device()
  platform/x86: i2c-multi-instantiate: Defer probe when no adapter found
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

 drivers/acpi/scan.c                          |  1 +
 drivers/i2c/i2c-core-acpi.c                  | 64 +++++++++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c   | 16 ++--
 drivers/platform/x86/i2c-multi-instantiate.c | 97 ++++++++++++++++----
 drivers/platform/x86/intel_cht_int33fe.c     | 20 ++--
 drivers/usb/typec/tps6598x.c                 |  8 +-
 include/linux/acpi.h                         | 11 +++
 7 files changed, 157 insertions(+), 60 deletions(-)

--
2.19.2

