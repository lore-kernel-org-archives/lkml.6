Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C065EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8BE2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfBUUZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:25:12 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:35264 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBUUZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:25:12 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4455Yv6QLqz1qxPv;
        Thu, 21 Feb 2019 21:25:07 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4455Yv5P5Fz1qswp;
        Thu, 21 Feb 2019 21:25:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id NUd92X1ThMsb; Thu, 21 Feb 2019 21:25:06 +0100 (CET)
X-Auth-Info: raEbNznEnTAoqzrDy1dECZOrfx0nRgOJ+7obzICSC7I=
Received: from localhost.localdomain (p54833194.dip0.t-ipconnect.de [84.131.49.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 21 Feb 2019 21:25:06 +0100 (CET)
From:   Anatolij Gustschin <agust@denx.de>
To:     linux-usb@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, broonie@kernel.org, atull@kernel.org,
        mdf@kernel.org
Subject: [PATCH v4 0/3] Add support for ARRI FPGA configuration
Date:   Thu, 21 Feb 2019 21:25:03 +0100
Message-Id: <20190221202506.17744-1-agust@denx.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds drivers and FPGA manager support required
for FT232H based ARRI FPGA configuration adapters.

Patch 1/3 adds FT232H interface driver (for ARRI USB PIDs)
implementing commonly used FTDI USB transfer operations and
ACBUS/MPSSE GPIO controllers. Depending on USB PIDs it creates
platform devices for MPSSE SPI bus with attached SPI slaves
or platform devices for ARRI FPP FPGA manager.

Patch 2/3 adds MPSSE SPI controller driver which registers
an FTDI USB-SPI bus with attached SPI slaves from description
in platform data, so existing SPI protocol drivers can be
used for these slave devices (in our case altera-ps-spi).
Via interface driver in patch 1/3 it is easily possible to add
support for other slave devices using custom USB PIDs (e.g.
spi-nor flash W25Q32 with m25p80 driver has beed used for
testing MPSSE SPI controller driver).

Patch 3/3 adds FPGA manager driver for ARRI FPP adapters for
FPGA configuration via Altera fast passive parallel interface.

Changes since v3:
  Patch 1/3
  - rebase on v5.0-rc7
  - add depends on GPIOLIB to Kconfig to fix build errors
  - fix build errors due to removed devm_gpiochip_remove()
    (replace by gpiochip_remove())

  Patch 2/3
  - rebase on v5.0-rc7

  Patch 3/3
  - update Date/Version in sysfs-driver-ftdi-fifo-fpp

Changes since v2:
  Patch 1/3
  - use unsigned type for baudrate and clk divider calculation
    (don't mix signed/unsigned types)
  - switch to unsigned int for 'encoded_divisor' 
  - use DIV_ROUND_CLOSEST() in ftdi_to_clkbits()
  - update error messages in ftdi_convert_baudrate()
  - update return code check of ftdi_to_clkbits()
  - fix boolconv coccinelle warning
  - add and use macro for MPSSE GPIOs number
  - update struct mpsse_spi_platform_data to drop pin description
    fields and add mpsse_spi_dev_data struct instead. This allows
    easier pin description and init for multiple SPI devices with
    multiple control pins. Pass pin description via platform_data
    of spi_bus_info for esier IO pin init code in MPSSE driver.
    Update spi_board_info table accordingly
  - keep Makefile entry sorted

  Patch 2/3
  - keep Makefile entry sorted
  - make the entire comment block a C++ one
  - don't use magic number for the size of the lookup table
  - use sizeof() instead of magic number for the buffer size
  - rework gpio chip select function to use it as .set_cs()
  - convert to use transfer_one instead of transfer_one_message
  - update dev_*() to use MPSSE platform device prefix
  - s/spi_master/spi_controller
  - use u16 for chip_select vars and update dev_dbg format
  - use unsigned type for index vars
  - reduce arguments number for ftdi_spi_tx()/ftdi_spi_rx()
  - fix ftdi_spi_tx() to send all buffer data correctly even if
    the USB driver signals transfer of less data than requested
  - update ftdi_spi_init_io() to differentiate between platform
    data for devices using MPSSE I/O pins and other SPI devices
    (e.g. using flash_platform_data, mmc_spi_platform_data, etc.).
    This makes the driver more generic and allows using multiple
    SPI slaves on the MPSSE bus
  - reduce !xfer->len checks

  Patch 3/3
    fix 'specified bound 8 equals destination size' gcc 8 warning

Changes since v1:
  Patch 1/3
  - add myself as a maintainer for these drivers
  - update copyright line to include 2018
  - include required linux headers
  - fix gcc 7.3.0 build warnings -Wunused-const-variable=
  - make ftdi functions and spi_board_info struct static
  - use KBUILD_MODNAME in drivers struct
  - use dev_err() for error messages instead of dev_info()
  - drop not needed output about number of used MPSSE pins
    since it is constant (not configurable)
  - remove ftdi function prototypes from header ft232h-intf.h
    as these are not exported anymore
  - update comments (don't use kernel-doc format as we do not
    export symbols anymore and functions are "static")

  Patch 2/3
  - fix build breakage when building with ARCH=i386 allmodconfig
  - add checks for ops->lock/ops->unlock presence in pdata
  - update copyright line to include 2018
  - remove printing numbers in parentheses (%d)

  Patch 3/3
  - update copyright line to include 2018
  - add sysfs ABI documentation
 
Changes since initial version (MFD based):
  - don't use MFD framework
  - don't use original FT232H USB PID (it is too generic and collides
    with existing ftdi_sio driver)
  - don't add separate CBUS GPIO driver based on FT232H MFD device
  - redesign/rework the drivers as described under [4]
  - add basic FT232H interface driver under drivers/usb/misc/
  - use custom reserved USB PIDs in the USB driver for adapter devices
  - add notes about borrowed protocol code from libftdi to commit log
    and header file
  - add MPSSE SPI controller driver supporting USB-SPI bus with
    dynamically added SPI slaves from description in platform data
    (the initial attempt didn't include USB SPI bus support for PS-
     SPI FPGA configuration via USB)
  - rework FPP fpga manager driver based on new FT232H interface
    driver and extend it according to CPLD changes for additional
    support of new hardware revision B.

Anatolij Gustschin (3):
  usb: misc: add driver for FT232H based FPGA configuration devices
  spi: add FTDI MPSSE SPI controller driver
  fpga: Add fpga manager driver for ARRI Altera FPP

 .../ABI/testing/sysfs-driver-ftdi-fifo-fpp    |    7 +
 MAINTAINERS                                   |    8 +
 drivers/fpga/Kconfig                          |    7 +
 drivers/fpga/Makefile                         |    1 +
 drivers/fpga/ftdi-fifo-fpp.c                  |  594 +++++++
 drivers/spi/Kconfig                           |    7 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-ftdi-mpsse.c                  |  651 ++++++++
 drivers/usb/misc/Kconfig                      |   10 +
 drivers/usb/misc/Makefile                     |    1 +
 drivers/usb/misc/ft232h-intf.c                | 1467 +++++++++++++++++
 include/linux/usb/ft232h-intf.h               |  206 +++
 12 files changed, 2960 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ftdi-fifo-fpp
 create mode 100644 drivers/fpga/ftdi-fifo-fpp.c
 create mode 100644 drivers/spi/spi-ftdi-mpsse.c
 create mode 100644 drivers/usb/misc/ft232h-intf.c
 create mode 100644 include/linux/usb/ft232h-intf.h

-- 
2.17.1

