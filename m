Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421A7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556FB206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeLOATd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:19:33 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:37140 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeLOATd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 19:19:33 -0500
Received: by mail-it1-f199.google.com with SMTP id y86so7708856ita.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 16:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DEcu31luVBttjPxQ130sXAMmuXfwNoB+5lPQFrtQyDo=;
        b=iEV0nVs0Gv2sTINhABJycMgRJDU0p65UI7t5B1IYdrl++Ve7XP2ZPdkLiZ6qIuedlR
         G4RwjML3k0plk5c/cte3FbBqRs5hZ7Li0stJ8PSll1G86BXS+7UbUwMzFqFK+fuA3U7s
         2V+3N8f/FVlxQJKJs46XHQ/QBcUuSQEHbn5T9syg/dx/oh1Y27O+27VpBifGKW1J3YQW
         PMcLwDRXB/w+14cS/p+TyYAMrfsoI7mQYvHKLaSs11cjlRIPsrhby2NB+xt4K4WzAg5M
         DoHfFz2Ri2iUFp9V3Ln4D0rn2KLXZh1bGmis135Tflq2G9imn4Bpu8sIH8tRpyO56Hv3
         cwuQ==
X-Gm-Message-State: AA+aEWbQ770rDlG+rJee8pRnh9ZxNJHztvhuBeItOoVw+oRM5rlanEbs
        alYXOExIMJnZTpVUOQO5O3lLImcDL+djFcw13ZGPC1hzSj2pNDhVBqC6lE/6ePoQ9Ybzg3XyL9Q
        1SrJ1Xy9rcIGI/X9HpbsY7l6KFbMfg6XJLMQzYAWGRQ6ianZUxDXSkqt1rMZkM05vvXCyuYjZcL
        E=
X-Google-Smtp-Source: AFSGD/XCJ0tOqNv9gJnv+AoxVXBjKL0oK7/MMqxIFT6ftf6ZLoDPkUYmmTOVXqIO9U9XicfwbwCgmmaW5L0Z409N
X-Received: by 2002:a24:5ac2:: with SMTP id v185mr4539461ita.28.1544833172018;
 Fri, 14 Dec 2018 16:19:32 -0800 (PST)
Date:   Fri, 14 Dec 2018 17:18:33 -0700
Message-Id: <20181215001843.62404-1-ncrews@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [RFC PATCH 00/10] cros_ec: Add support for Wilco EC
From:   Nick Crews <ncrews@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nick Crews <ncrews@google.com>, Olof Johansson <olof@lixom.net>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Chromebook named wilco contains a different Embedded Controller
than the rest of the chromebook series, and thus the kernel requires
a different driver than the already existing and generalized
cros_ec_* drivers. Specifically, this driver adds support for getting
and setting the RTC on the EC, adding a binary sysfs attribute
that receives ACPI events from the EC, adding a binary sysfs
attribute to request telemetry data from the EC (useful for enterprise
applications), and adding normal sysfs attributes to get/set various
other properties on the EC. The core of the communication with the EC
is implemented in wilco_ec_mailbox.c, using a simple byte-level protocol
with a checksum, transmitted over an eSPI bus. For debugging purposes,
a raw attribute is also provided which can write/read arbitrary
bytes to/from the eSPI bus.

We attempted to adhere to the sysfs principles of "one piece of data per
attribute" as much as possible, and mostly succeded. However, with the
wilco_ec_adv_power.h attributes, which deal with scheduling power usage,
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

This is still an initial version of the driver, and we are sending it
upstream for comments now, so that we can incorporate any requested
changes such that it eventually can be merged. Thank you for your
comments!


Duncan Laurie (6):
  CHROMIUM: cros_ec: Remove cros_ec dependency in lpc_mec
  CHROMIUM: wilco_ec: Add new driver for Wilco EC
  CHROMIUM: wilco_ec: Add sysfs attributes
  CHROMIUM: wilco_ec: Add support for raw commands in sysfs
  CHROMIUM: wilco_ec: Add RTC class driver
  CHROMIUM: wilco_ec: Add event handling

Nick Crews (4):
  CHROMIUM: wilco_ec: Move legacy attributes to separate file
  CHROMIUM: wilco_ec: Add EC properties
  CHROMIUM: wilco_ec: Add peakshift and adv_batt_charging
  CHROMIUM: wilco_ec: Add binary telemetry attributes

 drivers/platform/chrome/Kconfig               |  24 +-
 drivers/platform/chrome/Makefile              |   9 +-
 drivers/platform/chrome/cros_ec_lpc_mec.c     |  54 +-
 drivers/platform/chrome/cros_ec_lpc_mec.h     |  45 +-
 drivers/platform/chrome/cros_ec_lpc_reg.c     |  43 +-
 drivers/platform/chrome/wilco_ec.h            | 180 ++++++
 drivers/platform/chrome/wilco_ec_adv_power.c  | 533 ++++++++++++++++++
 drivers/platform/chrome/wilco_ec_adv_power.h  | 193 +++++++
 drivers/platform/chrome/wilco_ec_event.c      | 343 +++++++++++
 drivers/platform/chrome/wilco_ec_legacy.c     | 204 +++++++
 drivers/platform/chrome/wilco_ec_legacy.h     |  96 ++++
 drivers/platform/chrome/wilco_ec_mailbox.c    | 427 ++++++++++++++
 drivers/platform/chrome/wilco_ec_properties.c | 327 +++++++++++
 drivers/platform/chrome/wilco_ec_properties.h | 163 ++++++
 drivers/platform/chrome/wilco_ec_rtc.c        | 163 ++++++
 drivers/platform/chrome/wilco_ec_sysfs.c      | 253 +++++++++
 drivers/platform/chrome/wilco_ec_sysfs_util.h |  47 ++
 drivers/platform/chrome/wilco_ec_telemetry.c  |  66 +++
 drivers/platform/chrome/wilco_ec_telemetry.h  |  42 ++
 19 files changed, 3153 insertions(+), 59 deletions(-)
 create mode 100644 drivers/platform/chrome/wilco_ec.h
 create mode 100644 drivers/platform/chrome/wilco_ec_adv_power.c
 create mode 100644 drivers/platform/chrome/wilco_ec_adv_power.h
 create mode 100644 drivers/platform/chrome/wilco_ec_event.c
 create mode 100644 drivers/platform/chrome/wilco_ec_legacy.c
 create mode 100644 drivers/platform/chrome/wilco_ec_legacy.h
 create mode 100644 drivers/platform/chrome/wilco_ec_mailbox.c
 create mode 100644 drivers/platform/chrome/wilco_ec_properties.c
 create mode 100644 drivers/platform/chrome/wilco_ec_properties.h
 create mode 100644 drivers/platform/chrome/wilco_ec_rtc.c
 create mode 100644 drivers/platform/chrome/wilco_ec_sysfs.c
 create mode 100644 drivers/platform/chrome/wilco_ec_sysfs_util.h
 create mode 100644 drivers/platform/chrome/wilco_ec_telemetry.c
 create mode 100644 drivers/platform/chrome/wilco_ec_telemetry.h

-- 
2.20.0.405.gbc1bbc6f85-goog

