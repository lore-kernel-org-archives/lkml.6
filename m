Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02831C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAB2244C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAB2244C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeGDNfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:35:20 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:45684 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbeGDNfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:35:17 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 591BC4314C; Wed,  4 Jul 2018 15:35:13 +0200 (CEST)
Message-Id: <cover.1530710826.git.nikolaus.voss@loewensteinmedical.de>
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date:   Wed, 4 Jul 2018 15:27:06 +0200
Subject: [PATCH v3 0/2] IIO: st_sensors_i2c: improve device enumeration
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        Javier Martinez Canillas <javier@dowhile0.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to instantiate a st_accel_i2c device from an ACPI based
system, I ran into some problems:

For my device, there is no ACPI match table entry, so rather than
creating /allocating a new ACPI HID for the device, I wanted to use an
existing DT table compatible entry via creating an ACPI_DT_NAMESPACE_HID
/PRP0001 HID ACPI entry (see Documentation/acpi/enumeration.txt).

This did not work because st_accel_i2c.c bails out if there is a ACPI
node but no ACPI table match. Use device_get_match_data API to get the
right driver data.

acpi_device_get_match_data() currently doesn't return DT compatible
matches. A separate patch is submitted to fix this.

v3:
  - remove unused i2c_device_id .driver_data fields as suggested by
    Javier Martinez Canillas.
v2:
  - use device_get_match_data API as suggested by Andy Shevchenko
  - removed syncing DT/I2C table names as Jonathan Cameron pointed out
    this would be an ABI change
  - converting from probe() to probe_new() is moved into a separate
    patch (as suggested by Jonathan Cameron)

Nikolaus Voss (2):
  IIO: st_accel_i2c.c: Simplify access to driver data
  IIO: st_accel_i2c.c: Use probe_new() instead of probe()

 drivers/iio/accel/st_accel_i2c.c | 61 ++++++++++++++------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

-- 
2.17.1

