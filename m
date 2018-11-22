Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5095DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F5920684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F5920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394771AbeKVWNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:13:05 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54034 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387910AbeKVWNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:13:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C513D26056C
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 0/7] mfd / platform: cros_ec: move cros_ec sysfs attributes to its own drivers.
Date:   Thu, 22 Nov 2018 12:33:49 +0100
Message-Id: <20181122113356.23610-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is another patchset to try to cleanup a bit more the crossed
references for cros-ec driver between the MFD and the platform/chrome
subsystems.

The purpose of these patches is get rid of the different cros-ec attributes
from mfd/cros_ec_dev to its own sub-driver in platform/chrome. cros_ec_dev
continues instantiating the sub-devices but the sysfs attributes are owned
by the platform driver.E.g. The lightbar driver should own his sysfs
attributes and be instantiated only if the Embedded Controller has a
lightbar.

The patchset also adds the documentation of the sysfs attributes.

Waiting for your feedback. Best regards,
 Enric


Enric Balletbo i Serra (7):
  mfd: cros_ec: use devm_mfd_add_devices.
  mfd / platform: cros_ec: move lightbar attributes to its own driver.
  mfd / platform: cros_ec: move vbc attributes to its own driver.
  mfd / platform: cros_ec: move debugfs attributes to its own driver.
  mfd / platform: cros_ec: move device sysfs attributes to its own
    driver.
  mfd / platform: cros_ec: instantiate only if th EC has a VBC NVRAM.
  platform/chrome: cros_ec_lightbar: instantiate only if the EC has a
    lightbar.

 .../ABI/testing/sysfs-class-chromeos          |  32 +++++
 ...sfs-class-chromeos-driver-cros-ec-lightbar |  74 ++++++++++
 .../sysfs-class-chromeos-driver-cros-ec-vbc   |   6 +
 drivers/mfd/Kconfig                           |   1 -
 drivers/mfd/cros_ec.c                         |  12 +-
 drivers/mfd/cros_ec_dev.c                     | 115 ++++++++--------
 drivers/mfd/cros_ec_dev.h                     |   6 -
 drivers/platform/chrome/Kconfig               |  44 +++++-
 drivers/platform/chrome/Makefile              |   7 +-
 drivers/platform/chrome/cros_ec_debugfs.c     |  49 +++++--
 drivers/platform/chrome/cros_ec_i2c.c         |  10 --
 drivers/platform/chrome/cros_ec_lightbar.c    | 127 ++++++++++++------
 drivers/platform/chrome/cros_ec_lpc.c         |   4 -
 drivers/platform/chrome/cros_ec_spi.c         |  11 --
 drivers/platform/chrome/cros_ec_sysfs.c       |  43 +++++-
 drivers/platform/chrome/cros_ec_vbc.c         |  62 ++++++---
 include/linux/mfd/cros_ec.h                   |  15 +--
 17 files changed, 434 insertions(+), 184 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-vbc

-- 
2.19.1

