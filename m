Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeDKJP7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:15:59 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:39588 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbeDKJPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:15:54 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        kvm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 0/2] vfio: platform: Improve reset support
Date: Wed, 11 Apr 2018 11:15:47 +0200
Message-Id: <1523438149-16433-2-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523438149-16433-1-git-send-email-geert+renesas@glider.be>
References: <1523438149-16433-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series improves reset support for vfio-platform:
  - The first patch fixes a bug I ran into while working on this.
  - The second patch implements generic DT reset controller support, for
    devices that are connected to an SoC-internal reset controller and
    can be reset in a generic way.  This avoids having to write/change a
    vfio-specific reset driver for each and every device to be
    passed-through to a guest.

Changes compared to v2:
  - Add Reviewed-by,
  - Merge similar checks in vfio_platform_has_reset().

Changes compared to v1:
  - Add Reviewed-by,
  - Don't store error values in vdev->reset_control,
  - Use of_reset_control_get_exclusive() instead of
    __of_reset_control_get(),
  - Improve description.

This has been tested on R-Car H3/Salvator-XS by exporting a GPIO module
to a QEMU+KWM guest: the GPIO module is reset before QEMU opens the vfio
device, and reset again after QEMU has released it, as can be witnessed
by the LEDs connected to the GPIOs.

Thanks!

Geert Uytterhoeven (2):
  vfio: platform: Fix reset module leak in error path
  vfio: platform: Add generic DT reset support

 drivers/vfio/platform/vfio_platform_common.c  | 35 +++++++++++++++++++++------
 drivers/vfio/platform/vfio_platform_private.h |  1 +
 2 files changed, 29 insertions(+), 7 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
