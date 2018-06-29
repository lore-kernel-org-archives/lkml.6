Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDA8C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3CE27D9B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3CE27D9B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964826AbeF2LPg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:15:36 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:51590 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933159AbeF2LPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:15:33 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id DEE8F41BD7; Fri, 29 Jun 2018 13:05:25 +0200 (CEST)
Message-Id: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date:   Fri, 29 Jun 2018 12:30:35 +0200
Subject: [PATCH 0/3] IIO: st_sensors_i2c: improve device enumeration 
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>
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
node but no ACPI table match instead of looking for a match from one of
the fallback mechanisms (patch 1).

Patch 2 removes an error message when a ACPI node exists but no table
entry is found (this doesn't need to be fatal because of the fallback).

Patch 3 syncs the strings in the I2C device table (which is used by the
I2C core for fallback matching) with the DT compatible strings, so a
PRP0001 entry can use the same compatible strings as a corresponding
DT entry. As far as I can see, the old I2C table strings aren't used
in mainline, so renaming them should be safe.

Nikolaus Voss (3):
  IIO: st_accel_i2c.c: Use fallback if DT/ACPI enum failed
  IIO: st_sensors_i2c.c: Don't print error on failed ACPI match
  IIO: st_accel.h: sync DT and I2C device ID table strings

 drivers/iio/accel/st_accel.h                  | 32 +++++++++----------
 drivers/iio/accel/st_accel_i2c.c              | 21 ++++++------
 .../iio/common/st_sensors/st_sensors_i2c.c    |  5 ++-
 3 files changed, 30 insertions(+), 28 deletions(-)

-- 
2.17.1

