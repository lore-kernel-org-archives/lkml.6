Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932427AbeCLTJO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 15:09:14 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41866 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeCLTJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 15:09:12 -0400
X-Google-Smtp-Source: AG47ELtpZ7Y1NOVJpQ8F1GiOsYsMTcI8qBB8Q7tPhVW0nI74eVA2E+RcKI1ooqtQ6d3DNsF8F4QMsA==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] chrome_laptop: stop being a platform driver
Date: Mon, 12 Mar 2018 12:08:53 -0700
Message-Id: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series is a combination of Atmel touchscreen driver stopping using
platform data and moving over to generic device properties, and
chromeos-laptop switching from being platform driver, which is the wrong
abstraction for it, and moving to using i2c bis notifier. Switching from
platform driver to the notifiers allows us to get rid of the ugly code that
manually tries to handle deferrals in case i2c bus is not ready at the time
we start initializing the module.

Benson, because chromeos-laptop is instantiating Atmel devices the 2
changes are intertwined. While we could apply them in stages, with parts
going through input and parts going through your tree I was wondering if we
could speed up the process and push the series through one or another tree
(if you are OK with the patches, of course).

Thanks!

Dmitry Torokhov (14):
  Input: atmel_mxt_ts - do not pass suspend mode in platform data
  Input: atmel_mxt_ts - switch from OF to generic device properties
  Input: atmel_mxt_ts - switch ChromeOS ACPI devices to generic props
  platform/chrome: chromeos_laptop - add SPDX identifier
  platform/chrome: chromeos_laptop - stop setting suspend mode for Atmel devices
  platform/chrome: chromeos_laptop - introduce pr_fmt()
  platform/chrome: chromeos_laptop - factor out getting IRQ from DMI
  platform/chrome: chromeos_laptop - rework i2c peripherals initialization
  platform/chrome: chromeos_laptop - parse DMI IRQ data once
  platform/chrome: chromeos_laptop - use I2C notifier to create devices
  platform/chrome: chromeos_laptop - rely on I2C to set up interrupt trigger
  platform/chrome: chromeos_laptop - use device properties for Pixel
  platform/chrome: chromeos_laptop - discard data for unneeded boards
  Input: atmel_mxt_ts - remove platform data support

 MAINTAINERS                                |   1 -
 drivers/input/touchscreen/atmel_mxt_ts.c   | 216 +++--
 drivers/platform/chrome/chromeos_laptop.c  | 896 +++++++++++----------
 include/linux/platform_data/atmel_mxt_ts.h |  31 -
 4 files changed, 559 insertions(+), 585 deletions(-)
 delete mode 100644 include/linux/platform_data/atmel_mxt_ts.h

-- 
Dmitry
