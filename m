Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07992C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C618020839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C618020839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeLLReN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:34:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54274 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeLLReM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:34:12 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id EC115260A1E
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org
Subject: [PATCH v5 0/7] mfd / platform: cros_ec: move cros_ec sysfs attributes to its own drivers.
Date:   Wed, 12 Dec 2018 18:33:55 +0100
Message-Id: <20181212173402.27086-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.2
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

Most of the patches touches mfd subsystem and platform/chrome so I'd
suggest go all using and inmutable branch.

Best regards,
 Enric

Changes in v5:
- Add static at cros_ec_attr_group.

Changes in v4:
- Added Reviewed-by tags.
- Moved mfd_remove_devices to another patch, it's already queued in Lee's tree.
- Removed patch 8 from the series, was a fix and it's already applied in current mainline.
- Use <ec-device-name> instead of <cros-ec> in documentation.
- Use default MFD_CROS_EC_CHARDEV in Kconfig.
- Changed the subject to specify the cros_ec_vbc driver.
- Fix typo s/th/the
- Get rid of the cros_ec_has_lightbar function.

Changes in v3:
- Removed cros_ec_remove from include file.
- Removed unneded check for ec_dev.
- Fixed build error as reported by the kbuild test robot.
- Do not print ec_platform name as is with dev_err is enough.

Changes in v2:
- Use devm only for the cros-ec core.
- Removed the two exported functions to attach/detach to the cros_class.
- Use dev_warn instead of dev_err when adding the lightbar.
- Removed unneeded check of ec_dev.
- Add a "default MFD_CROS_EC_CHARDEV" in Kconfig for this.
- Remove the checks for missing debug_info, are not needed now.
- Remove a comment that no longer applies.
- Create the attributes directly instead of use the attach/detach callbacks.
- Remove unnecessary IS_ENABLED.
- Remove dev_err message telling that VBC is found.
- Use dev_warn instead of dev_err as the error is ignored.
- Removed ec_with_lightbar variable.

Enric Balletbo i Serra (7):
  mfd / platform: cros_ec: use devm_mfd_add_devices
  mfd / platform: cros_ec: move lightbar attributes to its own driver
  mfd / platform: cros_ec: move vbc attributes to its own driver
  mfd / platform: cros_ec: move debugfs attributes to its own driver
  mfd / platform: cros_ec: move device sysfs attributes to its own
    driver
  mfd / platform: cros_ec_vbc: instantiate only if the EC has a VBC
    NVRAM
  platform/chrome: cros_ec_lightbar: instantiate only if the EC has a
    lightbar

 .../ABI/testing/sysfs-class-chromeos          |  32 +++++
 ...sfs-class-chromeos-driver-cros-ec-lightbar |  74 ++++++++++
 .../sysfs-class-chromeos-driver-cros-ec-vbc   |   6 +
 drivers/mfd/Kconfig                           |   1 -
 drivers/mfd/cros_ec.c                         |  14 +-
 drivers/mfd/cros_ec_dev.c                     |  89 +++++--------
 drivers/mfd/cros_ec_dev.h                     |   6 -
 drivers/platform/chrome/Kconfig               |  47 ++++++-
 drivers/platform/chrome/Makefile              |   7 +-
 drivers/platform/chrome/cros_ec_debugfs.c     |  62 ++++++---
 drivers/platform/chrome/cros_ec_i2c.c         |  10 --
 drivers/platform/chrome/cros_ec_lightbar.c    | 126 +++++++++++-------
 drivers/platform/chrome/cros_ec_lpc.c         |   4 -
 drivers/platform/chrome/cros_ec_spi.c         |  11 --
 drivers/platform/chrome/cros_ec_sysfs.c       |  36 ++++-
 drivers/platform/chrome/cros_ec_vbc.c         |  59 +++++---
 include/linux/mfd/cros_ec.h                   |  21 ---
 17 files changed, 394 insertions(+), 211 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-vbc

-- 
2.19.2

