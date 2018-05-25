Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968385AbeEYUbS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:31:18 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38753 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968241AbeEYUbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:31:15 -0400
X-Google-Smtp-Source: AB8JxZrBy0hX1X2AROogdpSvv004sOqbrDFSscyFBd3Nm9bA/52d+Z94wqUsj0KLwt0WShDe5aY5lg==
From: Matthias Kaehlcke <mka@chromium.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 00/11] Add throttler driver for non-thermal throttling
Date: Fri, 25 May 2018 13:30:32 -0700
Message-Id: <20180525203043.249193-1-mka@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the throttler driver, for non-thermal throttling of
CPUs and devfreq devices. A use case for non-thermal throttling could
be the detection of a high battery discharge voltage, close to the
over-current protection (OCP) limit of the battery.

To support throttling of devfreq devices the series introduces the
concept of a devfreq policy and the DEVFREQ_ADJUST notifier (similar
to CPUFREQ_ADJUST). Further it includes some related devfreq bugfixes
and improvements that change some of the code that is also touched
by the policy changes.

Matthias Kaehlcke (11):
  PM / devfreq: Init user limits from OPP limits, not viceversa
  PM / devfreq: Fix handling of min/max_freq == 0
  PM / devfreq: Remove check for df->max_freq == 0 from governors
  PM / devfreq: Remove redundant frequency adjustment from governors
  PM / devfreq: governors: Return device frequency limits instead of
    user limits
  PM / devfreq: Add struct devfreq_policy
  PM / devfreg: Add support policy notifiers
  PM / devfreq: Make update_devfreq() public
  misc: throttler: Add core support for non-thermal throttling
  dt-bindings: misc: add bindings for throttler
  misc/throttler: Add Chrome OS EC throttler

 .../devicetree/bindings/misc/throttler.txt    |  41 ++
 drivers/devfreq/devfreq.c                     | 203 ++++++----
 drivers/devfreq/governor.h                    |   3 -
 drivers/devfreq/governor_passive.c            |   4 +-
 drivers/devfreq/governor_performance.c        |   5 +-
 drivers/devfreq/governor_powersave.c          |   2 +-
 drivers/devfreq/governor_simpleondemand.c     |  13 +-
 drivers/devfreq/governor_userspace.c          |  16 +-
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/throttler/Kconfig                |  28 ++
 drivers/misc/throttler/Makefile               |   2 +
 drivers/misc/throttler/core.c                 | 373 ++++++++++++++++++
 drivers/misc/throttler/cros_ec_throttler.c    | 122 ++++++
 include/linux/devfreq.h                       | 112 +++++-
 include/linux/throttler.h                     |  10 +
 16 files changed, 813 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/throttler.txt
 create mode 100644 drivers/misc/throttler/Kconfig
 create mode 100644 drivers/misc/throttler/Makefile
 create mode 100644 drivers/misc/throttler/core.c
 create mode 100644 drivers/misc/throttler/cros_ec_throttler.c
 create mode 100644 include/linux/throttler.h

-- 
2.17.0.921.gf22659ad46-goog
