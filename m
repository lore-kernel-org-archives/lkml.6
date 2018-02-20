Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeBTNB2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:01:28 -0500
Received: from foss.arm.com ([217.140.101.70]:42644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751591AbeBTNB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:01:27 -0500
From: Marc Zyngier <marc.zyngier@arm.com>
To: Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drm/rockchip: VOP interrupt fixes
Date: Tue, 20 Feb 2018 13:01:17 +0000
Message-Id: <20180220130120.5254-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series fixes a number of issues that I found while trying
to get kexec working on the Chromebook Plus (aka rk3399-gru-kevin) in
order to use it as some sort of interactive bootloader.

The main issue is that the vop driver expects the interrupts to be
cleared and disabled when booting. Nothing could be more wrong. The
device should be expected to be alive and screaming, and it is the
driver's job to put it back into a sane state.

This is what the first patch does, making sure the interrupt is
requested only when the device has been put back into a known
state. Given that this is an observable bug that has been around for a
while, I've tagged it with a Cc: stable.

The two following patches are less important: Using memcpy on MMIO
ranges is plain wrong, and using spin_lock_irqsave in irq context is
slightly pointless.

With these patches in, I'm able to get kexec to work. There is still
some funny issues at the iommu level, but that's for another day.

Patches on top of 4.16-rc2.

Marc Zyngier (3):
  drm/rockchip: Clear all interrupts before requesting the IRQ
  drm/rockchip: Do not use memcpy for MMIO addresses
  drm/rockchip: Don't use spin_lock_irqsave in interrupt context

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 44 +++++++++++++++--------------
 1 file changed, 23 insertions(+), 21 deletions(-)

-- 
2.14.2
