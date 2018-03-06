Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932491AbeCFDDo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 22:03:44 -0500
Received: from regular1.263xmail.com ([211.150.99.133]:58623 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932410AbeCFDDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 22:03:42 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <22d24da876c48600d09fb8eae191fd80>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com,
        tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Romain Perier <romain.perier@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>, Liang Chen <cl@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Huibin Hong <huibin.hong@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>, Jacob Chen <jacob-chen@iotwrt.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rocky Hao <rocky.hao@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>,
        Nickey Yang <nickey.yang@rock-chips.com>, devicetree@vger.kernel.org,
        Mark Yao <markyao0591@gmail.com>, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        iommu@lists.linux-foundation.org, Caesar Wang <wxt@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 00/14] iommu/rockchip: Use OF_IOMMU
Date: Tue,  6 Mar 2018 11:02:38 +0800
Message-Id: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series fixes some issues in rockchip iommu driver, and add of_iommu
support in it.

Changes in v7:
Add WARN_ON in irq isr, and modify iommu archdata comment.
Use iommu_group_ref_get to avoid ref leak

Changes in v6:
Add clk names, and modify all iommu nodes in all existing rockchip dts
Fix dt-binding as Robin suggested.
Use aclk and iface clk as Rob and Robin suggested, and split binding
patch.
Fix dt-binding as Robin suggested.
Use aclk and iface clk as Rob and Robin suggested, and split binding
patch.

Changes in v5:
Use out labels to save the duplication between the error and success paths.
Use RK_MMU_POLL_PERIOD_US instead of 100.
Remove clk names.
Use clk_bulk APIs.
Avoid race about pm_runtime_get_if_in_use() and pm_runtime_enabled().

Changes in v4:
Rewrite commit message.

Changes in v3:
Also remove remove() and module_exit() as Tomasz suggested.
Loop platform_get_irq() as Robin suggested.
Add struct rk_iommudata.
Squash iommu/rockchip: Use iommu_group_get_for_dev() for add_device
Only call startup() and shutdown() when iommu attached.
Remove pm_mutex.
Check runtime PM disabled.
Check pm_runtime in rk_iommu_irq().
Remove rk_iommudata->domain.

Changes in v2:
Move irq request to probe(in patch[0])
Move bus_set_iommu() to rk_iommu_probe().

Jeffy Chen (10):
  iommu/rockchip: Prohibit unbind and remove
  iommu/rockchip: Fix error handling in probe
  iommu/rockchip: Request irqs in rk_iommu_probe()
  ARM: dts: rockchip: add clocks in iommu nodes
  dt-bindings: iommu/rockchip: Add clock property
  iommu/rockchip: Use IOMMU device for dma mapping operations
  iommu/rockchip: Use OF_IOMMU to attach devices automatically
  iommu/rockchip: Fix error handling in init
  iommu/rockchip: Add runtime PM support
  iommu/rockchip: Support sharing IOMMU between masters

Tomasz Figa (4):
  iommu/rockchip: Fix error handling in attach
  iommu/rockchip: Use iopoll helpers to wait for hardware
  iommu/rockchip: Fix TLB flush of secondary IOMMUs
  iommu/rockchip: Control clocks needed to access the IOMMU

 .../devicetree/bindings/iommu/rockchip,iommu.txt   |   7 +
 arch/arm/boot/dts/rk3036.dtsi                      |   2 +
 arch/arm/boot/dts/rk322x.dtsi                      |   8 +
 arch/arm/boot/dts/rk3288.dtsi                      |  12 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  10 +
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  10 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  14 +-
 drivers/iommu/rockchip-iommu.c                     | 608 +++++++++++----------
 8 files changed, 382 insertions(+), 289 deletions(-)

-- 
2.11.0
