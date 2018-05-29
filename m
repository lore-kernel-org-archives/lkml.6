Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934476AbeE2NKe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:10:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52555 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934083AbeE2NK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:10:27 -0400
X-Google-Smtp-Source: AB8JxZqDyq2cJCfiWkpyBtl40N8EeSPr8/QLDVQrAk3kVt8mOO0TLKB2nR7cmUax+mdWt7ZuyXtwSQ==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
Subject: [PATCH 00/19] Dynamically load/remove serdev devices via sysfs*
Date: Tue, 29 May 2018 15:09:55 +0200
Message-Id: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some situations where it is interesting to load/remove serdev
devices dynamically, like during board bring-up or when we are
developing a new driver or for devices that are neither described via
ACPI or device tree.

This implementation allows the creation of serdev devices via sysfs,
in a similar way as the i2c bus allows sysfs instantiation [1].

It also opens the door to create platform drivers for specific
platforms, such us notebooks or industrial computers, when their serial
devices are not described via DT or ACPI.

This patchset also supports automatic module load via udev/modprobe,
simplifying its use by the final user.

Currently, serdev does not manage ports that do not have a serdev device
defined at boot time. This implementation adds a new serdev module,
ttydev, that provides the same functionality of tty (it calls the
original one), but can be unloaded.

TL/DR:

When we want to create a new device, we just run:
root@qt5022:~# echo ttydev > /sys/bus/serial/devices/serial0/new_device

This will create a new device:
root@qt5022:~# ls /sys/bus/serial/devices/serial0-0/
driver	modalias  power  subsystem  tty  uevent

And load the required driver to use it:
root@qt5022:~# lsmod | grep serdev_ttydev
serdev_ttydev          16384  0

The device can be removed:
root@qt5022:~#
	echo serial0-0 > /sys/bus/serial/devices/serial0/delete_device

And now we can connect a new device:
root@qt5022:~# echo hci-ti > /sys/bus/serial/devices/serial0/new_device


[1] https://www.kernel.org/doc/Documentation/i2c/instantiating-devices

Ricardo Ribalda Delgado (19):
  serdev: Add id_table to serdev_device_driver
  Bluetooth: hci_bcm: Add serdev_id_table
  Bluetooth: hci_ll: Add serdev_id_table
  Bluetooth: hci_nokia: Add serdev_id_table
  serdev: Introduce modalias field
  serdev: Support bus matching with modalias field
  serdev: Allows dynamic creation of devices via sysfs
  serdev: Provide modalias attribute for modalias devices
  serdev: Provide modalias uevent for modalias devices
  file2alias: Support for serdev devices
  Bluetooth: hci_bcm: MODULE_DEVICE_TABLE(serdev)
  Bluetooth: hci_ll: MODULE_DEVICE_TABLE(serdev)
  Bluetooth: hci_nokia: MODULE_DEVICE_TABLE(serdev)
  mfd: rave-sp: MODULE_DEVICE_TABLE(serdev)
  net: qualcomm: MODULE_DEVICE_TABLE(serdev)
  serdev: ttyport: Move serport structure to its own header
  serdev: Mark controllers compatible with ttyport
  serdev: ttydev: Serdev driver that creates an standard TTY port
  serdev: Instantiate a ttydev serdev if acpi and of fails

 drivers/bluetooth/hci_bcm.c              |   8 ++
 drivers/bluetooth/hci_ll.c               |  19 ++++
 drivers/bluetooth/hci_nokia.c            |   8 ++
 drivers/mfd/rave-sp.c                    |   7 ++
 drivers/net/ethernet/qualcomm/qca_uart.c |   7 ++
 drivers/tty/serdev/Kconfig               |  11 ++
 drivers/tty/serdev/Makefile              |   2 +
 drivers/tty/serdev/core.c                | 133 +++++++++++++++++++++--
 drivers/tty/serdev/serdev-ttydev.c       |  70 ++++++++++++
 drivers/tty/serdev/serdev-ttyport.c      |  10 +-
 drivers/tty/serdev/serport.h             |  16 +++
 include/linux/mod_devicetable.h          |  10 ++
 include/linux/serdev.h                   |   4 +
 scripts/mod/devicetable-offsets.c        |   3 +
 scripts/mod/file2alias.c                 |  11 ++
 15 files changed, 304 insertions(+), 15 deletions(-)
 create mode 100644 drivers/tty/serdev/serdev-ttydev.c
 create mode 100644 drivers/tty/serdev/serport.h

-- 
2.17.0
