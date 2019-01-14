Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561EAC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25564205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfANWEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:04:06 -0500
Received: from mail-vk1-f198.google.com ([209.85.221.198]:39345 "EHLO
        mail-vk1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfANWEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:04:06 -0500
Received: by mail-vk1-f198.google.com with SMTP id k8so205645vke.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=R24EoOsZ/INWMt6gZzg3TgbDQOWy4WLd/+llaYzCFU8=;
        b=tZCAB7EKIqThS6+2qIs1QGogjxBGeQSK7WrF+ZAAK6/3WyR0BYtf1aIQ3zKUqrL27Z
         S62pnhPyst0tnUGN7ecD1wQYQedUA/fSOe8w9jtA8y5VtpjyIdsZCr3YWamA8ng4MDie
         3vcNq8F5zpoOrOsT6OcgDXr2mTdnnUQnuegWmSlUluLIOnqeLl3ocKEtVlBvAbNR7HJp
         mo2uABqWB0pjtOPKdi515u5dzzuYoiIw/KF+bbGzd3M1RX0W5zRPryRYhLEZdBLP57aM
         YxiucH9XbWx9FSsADsyEw7NHFjOkBr8Fm14WGxExg7qgz1OlFyNo0Ki5u5jgQX/N7wGZ
         WLkg==
X-Gm-Message-State: AJcUukeJWQOJ9Za8CPoUZC4RjB0ho22rJNPcfNIRHG2n449AsyofjzaA
        8CSV4Pk294kYUmdBOPiPBnq5eMyhUoqcPCzT8F+UYns6ahlYEIRBH0A6HZWdu/biPliH8a1HKn3
        85R9wOZYP4zP43RJL1I7Ido4L1QmH6OyK/+E/yU3lCsPu5Y9FpyhBJvjfcmeHtuLoeIykVFAZOS
        0=
X-Google-Smtp-Source: ALg8bN4tmPr5veI2z7H4maDHZdriYKM2jHIfLY5OGpcVg/p8VQ/M299ek/mFBI3jkGvOZkZY8YTGGsurW+H+Khiu
X-Received: by 2002:a67:8542:: with SMTP id h63mr436773vsd.43.1547503444689;
 Mon, 14 Jan 2019 14:04:04 -0800 (PST)
Date:   Mon, 14 Jan 2019 15:03:47 -0700
Message-Id: <20190114220356.108916-1-ncrews@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v2 0/9] platform/chrome: rtc: Add support for Wilco EC
From:   Nick Crews <ncrews@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, sjg@chromium.org, dlaurie@chromium.org,
        Nick Crews <ncrews@google.com>, linux-rtc@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Duncan Laurie <dlaurie@google.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There is a new chromebook that contains a different Embedded Controller
(codename Wilco) than the rest of the chromebook series. Thus the kernel
requires a different driver than the already existing and generalized
cros_ec_* drivers. Specifically, this driver adds support for getting
and setting the RTC on the EC, adding a binary sysfs attribute
that receives ACPI events from the EC, adding a binary sysfs
attribute to request telemetry data from the EC (useful for enterprise
applications), and adding normal sysfs attributes to get/set various
other properties on the EC. The core of the communication with the EC
is implemented in wilco_ec/mailbox.c, using a simple byte-level protocol
with a checksum, transmitted over an eSPI bus. For debugging purposes,
a raw attribute is also provided which can write/read arbitrary
bytes to/from the eSPI bus.

We attempted to adhere to the sysfs principles of "one piece of data per
attribute" as much as possible, and mostly succeded. However, with the
wilco_ec/adv_power.h attributes, which deal with scheduling power usage,
we found it most elegant to bundle setting event times for an entire day
into a single attribute, so at most you are using attributes formatted
as "%d %d %d %d %d %d". With the telemetry attribute, we had to use a
binary attribute, instead of the preferable human-readable ascii, in
order to keep secure the information which is proprietary to the
enterprise service provider. This opaque binary data will be read and
sent using a proprietary daemon running on the OS. Finally, the
"version" attribute returns a formatted result that looks something
like:
> cat /sys/bus/platform/devices/GOOG000C\:00/version
Label        : 95.00.06
SVN Revision : 5960a.06
Model Number : 08;8
Build Date   : 11/29/18

The RTC driver is exposed as a standard RTC class driver with
read/write functionality.

For event notification, the Wilco EC can return extended events that
are not handled by standard ACPI objects. These events can
include hotkeys which map to standard functions like brightness
controls, or information about EC controlled features like the
charger or battery. These events are triggered with an
ACPI Notify(0x90) and the event data buffer is read through an ACPI
method provided by the BIOS which reads the event buffer from EC RAM.
These events are then processed, with hotkey events being sent
to the input subsystem and other events put into a queue which
can be read by a userspace daemon via a sysfs attribute.

The rest of the attributes are categorized as either "properties" or
"legacy". "legacy" implies that the attribute existed on the EC before it
was modified for ChromeOS, and "properties" implies that the attribute
exposes functionality that was added to the EC specifically for
ChromeOS. They are mostly boolean flags or percentages.

A full thread of the development of these patches can be found at
https://chromium-review.googlesource.com/c/1371034. This thread contains
comments and revisions that could be helpful in understanding how the
driver arrived at the state it is in now. The thread also contains some
ChromeOS specific patches that actually enable the driver. If you want
to test the patch yourself, you would have to install the ChromeOS SDK
and cherry pick in these patches.

I also wrote some integration tests using the Tast testing framework that
ChromeOS uses. It would require a full ChromeOS SDK to actually run the
tests, but the source of the tests, written in Go, are useful for
understanding what the desired behavior is. You can view the tests here:
https://chromium-review.googlesource.com/c/1372575

Thank you for your comments!

Changes in v2:
- Fixed kernel-doc comments
- Fixed include of linux/mfd/cros_ec_lpc_mec.h
- cros_ec_lpc_mec_in_range() returns -EINVAL on error
- Added parens around macro variables
- Removed COMPILE_TEST from Kconfig because inb()/outb()
won't work on anything but X86
- Moved everything to wilco_ec/ subdirectory
- Moved header file to include/platform_data/
so could be used by future sub-drivers
- Tweaked mailbox()
- Removed duplicate EC_MAILBOX_DATA_SIZE defs
- Removed some error messages / converted to dbg()
- Remove license boiler plate
- Remove "wilco_ec_sysfs -" docstring prefix
- Fix accidental Makefile deletion
- Add documentation for sysfs entries
- Change "enable ? 0 : 1" to "!enable"
- No longer override error code from sysfs_init()
- Put attributes in the legacy file to begin with, don't move later
- Remove duplicate error messages in sysfs_init() and its caller
- Add sysfs documentation
- rm duplicate EC_MAILBOX_DATA_SIZE defs
- Make docstrings follow kernel style
- Fix tags in commit msg
- Reading raw now includes ASCII translation
- rm license boiler plate
- rm "wilco_ec_rtc -" prefix in docstring
- Make rtc driver its own module within the drivers/rtc/ directory
- Register a rtc device from core.c that is picked up by this driver
- rm unused rtc_sync() function
- rm "wilco_ec_event -" prefix from docstring
- rm license boiler plate
- Add sysfs directory documentation
- Fix cosmetics
- Remove duplicate error messages
- rm license boiler plate
- rm "wilco_ec_properties -" prefix from docstring
- Add documentation
- rm license boiler plate
- rm "wilco_ec_adv_power - " prefix from docstring
- Add documentation
- Made format strings in store() and read() functions static
- rm "wilco_ec_telemetry - " prefix from docstring
- rm license boiler plate
- Fix commit msg tag

Duncan Laurie (6):
  platform/chrome: Remove cros_ec dependency in lpc_mec
  platform/chrome: Add new driver for Wilco EC
  platform/chrome: Add sysfs attributes
  platform/chrome: Add support for raw commands in sysfs
  platform/chrome: rtc: Add RTC driver for Wilco EC
  platform/chrome: Add event handling

Nick Crews (3):
  platform/chrome: Add EC properties
  platform/chrome: Add peakshift and adv_batt_charging
  platform/chrome: Add binary telemetry attributes

 .../ABI/testing/sysfs-platform-wilcoec        | 176 ++++++
 drivers/platform/chrome/Kconfig               |   4 +-
 drivers/platform/chrome/Makefile              |   2 +
 drivers/platform/chrome/cros_ec_lpc_mec.c     |  52 +-
 drivers/platform/chrome/cros_ec_lpc_mec.h     |  43 +-
 drivers/platform/chrome/cros_ec_lpc_reg.c     |  43 +-
 drivers/platform/chrome/wilco_ec/Kconfig      |  33 ++
 drivers/platform/chrome/wilco_ec/Makefile     |   6 +
 drivers/platform/chrome/wilco_ec/adv_power.c  | 544 ++++++++++++++++++
 drivers/platform/chrome/wilco_ec/adv_power.h  | 183 ++++++
 drivers/platform/chrome/wilco_ec/core.c       | 144 +++++
 drivers/platform/chrome/wilco_ec/event.c      | 347 +++++++++++
 drivers/platform/chrome/wilco_ec/legacy.c     | 190 ++++++
 drivers/platform/chrome/wilco_ec/legacy.h     |  93 +++
 drivers/platform/chrome/wilco_ec/mailbox.c    | 237 ++++++++
 drivers/platform/chrome/wilco_ec/properties.c | 344 +++++++++++
 drivers/platform/chrome/wilco_ec/properties.h | 179 ++++++
 drivers/platform/chrome/wilco_ec/sysfs.c      | 238 ++++++++
 drivers/platform/chrome/wilco_ec/telemetry.c  |  66 +++
 drivers/platform/chrome/wilco_ec/telemetry.h  |  41 ++
 drivers/platform/chrome/wilco_ec/util.h       |  38 ++
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-wilco-ec.c                    | 178 ++++++
 include/linux/platform_data/wilco-ec.h        | 186 ++++++
 25 files changed, 3319 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-wilcoec
 create mode 100644 drivers/platform/chrome/wilco_ec/Kconfig
 create mode 100644 drivers/platform/chrome/wilco_ec/Makefile
 create mode 100644 drivers/platform/chrome/wilco_ec/adv_power.c
 create mode 100644 drivers/platform/chrome/wilco_ec/adv_power.h
 create mode 100644 drivers/platform/chrome/wilco_ec/core.c
 create mode 100644 drivers/platform/chrome/wilco_ec/event.c
 create mode 100644 drivers/platform/chrome/wilco_ec/legacy.c
 create mode 100644 drivers/platform/chrome/wilco_ec/legacy.h
 create mode 100644 drivers/platform/chrome/wilco_ec/mailbox.c
 create mode 100644 drivers/platform/chrome/wilco_ec/properties.c
 create mode 100644 drivers/platform/chrome/wilco_ec/properties.h
 create mode 100644 drivers/platform/chrome/wilco_ec/sysfs.c
 create mode 100644 drivers/platform/chrome/wilco_ec/telemetry.c
 create mode 100644 drivers/platform/chrome/wilco_ec/telemetry.h
 create mode 100644 drivers/platform/chrome/wilco_ec/util.h
 create mode 100644 drivers/rtc/rtc-wilco-ec.c
 create mode 100644 include/linux/platform_data/wilco-ec.h

-- 
2.20.1.97.g81188d93c3-goog

