Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeEPRum (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 13:50:42 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:44142 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeEPRuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 13:50:39 -0400
X-Google-Smtp-Source: AB8JxZqWLKfBS+oY9w+Z2xyQ2UvZ4k2ZuspZ7Lp0TRWkV6KYxrEvosPZe07k+Bhvt6acEwtDTT6Fgg==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org
Cc: benjamin.gaignard@st.com, fabrice.gasnier@st.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v6 0/9] Introduce the Counter subsystem
Date: Wed, 16 May 2018 13:50:10 -0400
Message-Id: <cover.1526487615.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This revision is primarily a code refactor and formatting cleanup -- the
interface has remained essentially the same as revision 5, with some
minor additions.

Here's a brief summary of the Generic Counter interface and related code
changes in this revision:

    * checkpatch.pl formatting suggestions implemented (parameters line
      up with opening round bracket, etc.)
    * Implement struct counter_ops to enable const structure for
      driver callbacks
    * Provide const string array for count_direction and count_mode
      options to help maintain a consistent interface
    * Reduce local variables by inlining where appropriate
    * Bring memory cleanup code closer to respective allocations for
      clarity and easier debugging
    * Implement counter_name_attribute_create function to reduce
      repeated code for various "name" attributes
    * Implement counter_global_attr_register function to organize global
      counter attribute registration together
    * Implement prepare_counter_device_groups_list and
      prepare_counter_device_groups functions to organize sysfs
      attribute configuration into logical groups (this makes the
      counter_register function logic much easier to follow)

Furthermore, the following additions have been made:

    * The "ceiling" and "floor" attributes are defined to represent the
      upper limit and lower limit respectively for a Count
    * The following attributes are now part of the main Generic Counter
      interface: count_mode, direction, enable, preset, preset_enable,
      and error_noise
    * The "Quadrature x1" and "Quadrature x2" function modes are now
      known as "Quadrature x1 A" and "Quadrature x2 A" respectively
    * The following new function modes are defined in order to support
      the STM32 LP Timer quadrature modes: Quadrature x1 B, Quadrature
      x2 B, Quadrature x2 Rising, and Quadrature x2 Falling
    * The "num_counts" and "num_signals" attributes are defined to
      represent the total number of Counts and total number of Signals
      respectively

The 104-QUAD-8 counter driver has been updated to make use of the
Generic Counter API changes ("ceiling" and "floor" attributes, constant
counter_ops structure, count_mode and direction string arrays, etc.).

The STM32 Timer counter driver has been updated to make use of the
Generic Counter API changes ("ceiling" attribute, constant counter_ops
structure, etc.). In addition, Fabrice Gasnier added support for a
missing encoder mode (see STM32_COUNT_ENCODER_MODE_2).

Proper Generic Counter interface support for the STM32 LP Timer has been
added to its respective counter driver. This is the last in-tree Linux
kernel driver using the deprecated IIO Counter interface, so we can
safely remove that interface in the future now.

I've added deprecation notices to the IIO Counter attributes to
encourage the switch to the Generic Counter interface. I didn't mention
a removal date for the relevant code, but perhaps before the next
longterm kernel release would be a good idea -- this should prevent the
IIO Counter API from persisting longer than necessary.

William Breathitt Gray

Benjamin Gaignard (2):
  dt-bindings: counter: Document stm32 quadrature encoder
  counter: Add STM32 Timer quadrature encoder

Fabrice Gasnier (1):
  counter: stm32-lptimer: add counter device

William Breathitt Gray (6):
  counter: Introduce the Generic Counter interface
  counter: Documentation: Add Generic Counter sysfs documentation
  docs: Add Generic Counter interface documentation
  counter: 104-quad-8: Add Generic Counter interface support
  counter: 104-quad-8: Documentation: Add Generic Counter sysfs
    documentation
  iio: counter: Remove IIO counter subdirectory

 Documentation/ABI/testing/sysfs-bus-counter   |  241 +++
 .../ABI/testing/sysfs-bus-counter-104-quad-8  |   36 +
 Documentation/ABI/testing/sysfs-bus-iio       |    8 +
 .../testing/sysfs-bus-iio-counter-104-quad-8  |   16 +
 .../{iio => }/counter/stm32-lptimer-cnt.txt   |    0
 .../bindings/counter/stm32-timer-cnt.txt      |   26 +
 .../devicetree/bindings/mfd/stm32-lptimer.txt |    2 +-
 .../devicetree/bindings/mfd/stm32-timers.txt  |    7 +
 Documentation/driver-api/generic-counter.rst  |  336 ++++
 Documentation/driver-api/index.rst            |    1 +
 MAINTAINERS                                   |   14 +-
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/counter/104-quad-8.c                  | 1335 ++++++++++++++
 drivers/counter/Kconfig                       |   59 +
 drivers/{iio => }/counter/Makefile            |    6 +-
 drivers/counter/generic-counter.c             | 1541 +++++++++++++++++
 drivers/counter/stm32-lptimer-cnt.c           |  722 ++++++++
 drivers/counter/stm32-timer-cnt.c             |  390 +++++
 drivers/iio/Kconfig                           |    1 -
 drivers/iio/Makefile                          |    1 -
 drivers/iio/counter/104-quad-8.c              |  596 -------
 drivers/iio/counter/Kconfig                   |   34 -
 drivers/iio/counter/stm32-lptimer-cnt.c       |  382 ----
 include/linux/counter.h                       |  554 ++++++
 25 files changed, 5293 insertions(+), 1018 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
 create mode 100644 Documentation/driver-api/generic-counter.rst
 create mode 100644 drivers/counter/104-quad-8.c
 create mode 100644 drivers/counter/Kconfig
 rename drivers/{iio => }/counter/Makefile (52%)
 create mode 100644 drivers/counter/generic-counter.c
 create mode 100644 drivers/counter/stm32-lptimer-cnt.c
 create mode 100644 drivers/counter/stm32-timer-cnt.c
 delete mode 100644 drivers/iio/counter/104-quad-8.c
 delete mode 100644 drivers/iio/counter/Kconfig
 delete mode 100644 drivers/iio/counter/stm32-lptimer-cnt.c
 create mode 100644 include/linux/counter.h

-- 
2.17.0
