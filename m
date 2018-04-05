Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbeDETno (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:43:44 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38875 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752848AbeDETnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:43:39 -0400
X-Google-Smtp-Source: AIpwx49c6ZNHFyYaUuxmf0D7M/pzmXlW2dIvu4V+lm5WTVnEh+I6s7Y1/d0pY8ewT99y2mcWMXlegA==
Date: Thu, 5 Apr 2018 12:43:35 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v4.17-rc0
Message-ID: <20180405194335.GA176669@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- a new driver for PhoenixRC Flight Controller Adapter 
- a new driver for RAVE SP Power button
- fixes for autosuspend-related deadlocks in a few unput USB dirvers
- support for 2nd wheel in ATech PS/2 mouse 
- fix for ALPS trackpoint detection on Thinkpad L570 and Latitude 7370
- bunch of cleanups in various in PS/2 protocols
- other assorted changes and fixes

There will be a conflict in drivers/input/joystick/analog.c, please
resolve so the line reads:

#elif defined(__alpha__) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_PPC) || defined(CONFIG_RISCV)

Thanks!

Changelog:
---------

Andi Shyti (1):
      Input: stmfts, s6sy761 - update my e-mail

Andrey Smirnov (1):
      Input: add RAVE SP Powerbutton driver

Dennis Wassenberg (1):
      Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list

Dmitry Torokhov (14):
      Input: psmouse - create helper for reporting standard buttons/motion
      Input: psmouse - clean up code
      Input: logips2pp - clean up code
      Input: lifebook - clean up code
      Input: libps2 - fix switch statement formatting
      Input: libps2 - use u8 for byte data
      Input: libps2 - use BIT() for bitmask constants
      Input: psmouse - move sliced command implementation to libps2
      Input: libps2 - add debugging statements
      Input: libps2 - support retransmission of command data
      Input: libps2 - relax command byte ACK handling
      Input: trackpoint - combine calls to ps2_command()
      Input: synaptics - switch to using input_set_capability
      Input: synaptics - handle errors from input_mt_init_slots()

Francis Therien (1):
      Input: xpad - add PDP device id 0x02a4

Gustavo A. R. Silva (2):
      Input: stmpe-keypad - remove VLA usage
      Input: appletouch - use true and false for boolean values

Jeffy Chen (1):
      Input: gpio-keys - add support for wakeup event action

Marcus Folkesson (7):
      Input: synaptics_usb - fix deadlock in autosuspend
      Input: synaptics_usb - do not rely on input_dev->users
      Input: pagasus_notetaker - fix deadlock in autosuspend
      Input: pegasus_notetaker - do not rely on input_dev->users
      Input: usbtouchscreen - fix deadlock in autosuspend
      Input: usbtouchscreen - do not rely on input_dev->users
      Input: pxrc - new driver for PhoenixRC Flight Controller Adapter

Marek Szyprowski (1):
      Input: stmfts - use async probe & suspend/resume to avoid 2s delay

Maruyama Shohei (1):
      Input: silead - add Chuwi Hi8 support

Masaki Ota (1):
      Input: ALPS - fix TrackStick detection on Thinkpad L570 and Latitude 7370

Michael Ellerman (1):
      Input: analog - use get_cycles() on PPC

Ondrej Zary (1):
      Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad

Pali Rohár (1):
      Input: alps - report pressure of v3 and v7 trackstick

Stephen Lyons (1):
      Input: psmouse - add support for 2nd wheel on A4Tech Dual-Scroll wheel mice

Diffstat:
--------

 .../devicetree/bindings/input/gpio-keys.txt        |   8 +
 .../bindings/input/zii,rave-sp-pwrbutton.txt       |  22 ++
 Documentation/input/devices/pxrc.rst               |  57 ++++
 drivers/input/joystick/Kconfig                     |  10 +
 drivers/input/joystick/Makefile                    |   1 +
 drivers/input/joystick/analog.c                    |   2 +-
 drivers/input/joystick/pxrc.c                      | 303 +++++++++++++++++++
 drivers/input/joystick/xpad.c                      |   9 +-
 drivers/input/keyboard/gpio_keys.c                 | 145 +++++++++-
 drivers/input/keyboard/stmpe-keypad.c              |  16 +-
 drivers/input/misc/Kconfig                         |   9 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/rave-sp-pwrbutton.c             |  94 ++++++
 drivers/input/mouse/alps.c                         |  64 ++--
 drivers/input/mouse/appletouch.c                   |   6 +-
 drivers/input/mouse/elantech.c                     |  40 +--
 drivers/input/mouse/lifebook.c                     |  62 ++--
 drivers/input/mouse/logips2pp.c                    | 152 +++++-----
 drivers/input/mouse/psmouse-base.c                 | 189 ++++++------
 drivers/input/mouse/psmouse.h                      |   5 +-
 drivers/input/mouse/sentelic.c                     |  11 +-
 drivers/input/mouse/synaptics.c                    |  90 +++---
 drivers/input/mouse/synaptics_usb.c                |  31 +-
 drivers/input/mouse/trackpoint.c                   |  60 ++--
 drivers/input/serio/i8042-x86ia64io.h              |  24 ++
 drivers/input/serio/libps2.c                       | 322 ++++++++++++++-------
 drivers/input/tablet/pegasus_notetaker.c           |  32 +-
 drivers/input/touchscreen/s6sy761.c                |   2 +-
 drivers/input/touchscreen/silead.c                 |   1 +
 drivers/input/touchscreen/stmfts.c                 |   4 +-
 drivers/input/touchscreen/usbtouchscreen.c         |  24 +-
 include/dt-bindings/input/gpio-keys.h              |  13 +
 include/linux/gpio_keys.h                          |   2 +
 include/linux/libps2.h                             |  38 ++-
 34 files changed, 1358 insertions(+), 491 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
 create mode 100644 Documentation/input/devices/pxrc.rst
 create mode 100644 drivers/input/joystick/pxrc.c
 create mode 100644 drivers/input/misc/rave-sp-pwrbutton.c
 create mode 100644 include/dt-bindings/input/gpio-keys.h

Thanks.

-- 
Dmitry
