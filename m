Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A179DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663B52088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663B52088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbeIQWIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:08:13 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:42656 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbeIQWIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:08:13 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id cgg31y00o3XaVaC06gg3sV; Mon, 17 Sep 2018 18:40:04 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g1wZ9-0006b8-D9; Mon, 17 Sep 2018 18:40:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g1wZ9-0004xh-AI; Mon, 17 Sep 2018 18:40:03 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v4 0/2] vfio: platform: Add generic reset controller support
Date:   Mon, 17 Sep 2018 18:39:53 +0200
Message-Id: <20180917163955.19023-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series implements generic reset controller support for
vfio-platform, for devices that are connected to an SoC-internal reset
controller and can be reset in a generic way.  This avoids having to
write/change a vfio-specific reset driver for each and every device to be
passed-through to a guest.

It consists of two patches:
  - The first patch enhances the reset controller subsystem to add support
    for dedicated resets.
    This addresses the issue that even reset_control_get_exclusive() does
    not guarantee that we have an exclusive wire between the device and
    the reset controller.
  - The second patch enhances vfio-platform to add generic reset controller
    support.

Changes compared to v3:
  - Add Reviewed-by,
  - New patch "reset: Add support for dedicated reset controls",
  - Use new RFC reset_control_get_dedicated() instead of
    of_reset_control_get_exclusive(), to (a) make it more generic, and
    (b) make sure the reset returned is really a dedicated reset, and
    does not affect other devices,
  - Drop vfio-platform reset leak fix, which has been applied.

Changes compared to v2:
  - Add Reviewed-by,
  - Merge similar checks in vfio_platform_has_reset().

Changes compared to v1:
  - Add Reviewed-by,
  - Don't store error values in vdev->reset_control,
  - Use of_reset_control_get_exclusive() instead of
    __of_reset_control_get(),
  - Improve description.

This has been tested on R-Car H3/Salvator-XS:
  - SATA can be exported, as it has a dedicated reset,
  - PWM1 cannot, as its reset is shared with all other PWM modules:
    "VFIO: No reset function found for device e6e31000.pwm".

Thanks for your comments!

Geert Uytterhoeven (2):
  [RFC] reset: Add support for dedicated reset controls
  [RFC] vfio: platform: Add generic reset controller support

 drivers/reset/core.c                          | 76 ++++++++++++++++---
 drivers/vfio/platform/vfio_platform_common.c  | 20 ++++-
 drivers/vfio/platform/vfio_platform_private.h |  1 +
 include/linux/reset.h                         | 60 ++++++++++-----
 4 files changed, 126 insertions(+), 31 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
