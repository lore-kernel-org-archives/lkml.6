Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeBHMWL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:22:11 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:50622 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbeBHMWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:22:08 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: andy.yan@rock-chips.com
X-FST-TO: cyrille.pitchen@wedev4u.fr
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: andy.yan@rock-chips.com
X-UNIQUE-TAG: <3e02e73a1eac11084fd99d4a4b00a3c9>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Andy Yan <andy.yan@rock-chips.com>
To: cyrille.pitchen@wedev4u.fr, mchehab@kernel.org, robh+dt@kernel.org,
        linux-mtd@lists.infradead.org, shawn.lin@rock-chips.com,
        heiko@sntech.de
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, boris.brezillon@free-electrons.com,
        Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v8 0/3] Add Rockchip SFC(serial flash controller) support
Date: Thu,  8 Feb 2018 20:12:38 +0800
Message-Id: <1518091958-3672-1-git-send-email-andy.yan@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is try to support SFC found on Rockchip RV1108 platform.
Thanks for Cyrille's review, this version trys to address all
his concern in V7 [0].

Feature:
(1) Support x1, x2, x4 data bits mode
(2) Support up to 4 chip select
(3) Support two independent clock domain: AHB clock and SPI clock
(4) Support DMA master up to 16KB - 1 transfer

Test environment:
This patchset was tested on RK1108 evb boards with Winboud w25q256,
Gigadevice GD25Q256, working fine with squashfs and jffs2.

[0] http://patchwork.ozlabs.org/patch/793292/

Changes in v8:
- remove unused macro SFC_CMD_TRAN_BYTES_MASK
- set max transfer length to 15.5KB
- remove unnecessary buffer align check
- remove the duplicate logic what spi-nor.c already does for spi_nor_write
- add spi_nor_erase, as the SFC should get the erase address.

Changes in v7:
- correct the fifo status check in pio read/write mode.
- copy data from user buffer to dma buffer

Changes in v6:
- fold in Andy's improvement for checking fifo level
  before pio read
- rename the controller to rv1108 since offically it's
  renamed and acked by Rob.
- use dma_coerce_mask_and_coherent suggested by Andy.

Changes in v5:
- check if the buf is aligned to 32bit
- check if the buf for dma comes from vmalloc
- fix to use 1-1-n according to the current framework
- avoid bytes cnt overflow

Changes in v4:
- use uppercase DMA for description
- simplify the code of get_if_type
- use dma_dir to simplify the code
- simplify the rockchip_sfc_do_rd_wr
- some minor improvements
- add reset controller when doing resume

Changes in v3:
- use io{read32,write32}_rep to simplify the corner cases
- remove more unnecessary bit definitions
- some minor comment fixes and improvement
- fix wrong unregister function
- unify more code
- use nor to avoid constantly replicating the whole
  sfc->flash[sfc->num_chip].nor
- add email for MODULE_AUTHOR
- remove #if 1 --- #endif
- extract DMA code to imporve the code structure
- reset all when failing to do dma
- pass sfc to get_if_type
- rename sfc-no-dma to sfc-no-DMA

Changes in v2:
- fix typos
- add some comment for buffer and others operations
- rename SFC_MAX_CHIP_NUM to MAX_CHIPSELECT_NUM
- use u8 for cs
- return -EINVAL for default case of get_if_type
- use readl_poll_*() to check timeout cases
- simplify and clarify some condition checks
- rework the bitshifts to simplify the code
- define SFC_CMD_DUMMY(x)
- fix ummap for dma read path and finish all the
  cache maintenance.
- rename to rockchip_sfc_chip_priv and embed struct spi_nor
  in it.
- add MODULE_AUTHOR
- add runtime PM and general PM support.
- Thanks for Marek's comments. Link:
  http://lists.infradead.org/pipermail/linux-mtd/2016-November/070321.html

Andy Yan (1):
  ARM: dts: rockchip: enable sfc for rv1108 evb

Shawn Lin (2):
  mtd: spi-nor: Bindings for Rockchip serial flash controller
  mtd: spi-nor: add rockchip serial flash controller driver

 .../devicetree/bindings/mtd/rockchip-sfc.txt       |  31 +
 MAINTAINERS                                        |   9 +
 arch/arm/boot/dts/rv1108-evb.dts                   |  10 +
 arch/arm/boot/dts/rv1108.dtsi                      |  13 +
 drivers/mtd/spi-nor/Kconfig                        |   7 +
 drivers/mtd/spi-nor/Makefile                       |   1 +
 drivers/mtd/spi-nor/rockchip-sfc.c                 | 942 +++++++++++++++++++++
 7 files changed, 1013 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/rockchip-sfc.txt
 create mode 100644 drivers/mtd/spi-nor/rockchip-sfc.c

-- 
2.7.4
