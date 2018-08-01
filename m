Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94F8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B06D20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B06D20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbeHAUjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:39:02 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:21243 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731501AbeHAUjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:39:02 -0400
Received: from localhost.localdomain ([81.67.76.113])
        by mwinf5d86 with ME
        id Huro1y0012Sg6Vd03urr0A; Wed, 01 Aug 2018 20:51:52 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Aug 2018 20:51:52 +0200
X-ME-IP: 81.67.76.113
From:   Maxime Jourdan <maxi.jourdan@wanadoo.fr>
To:     linux-amlogic@lists.infradead.org
Cc:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 0/4] soc: amlogic: add meson-canvas driver
Date:   Wed,  1 Aug 2018 20:51:24 +0200
Message-Id: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic SoCs feature a set of 256 canvas that act as pixel buffer
descriptors. Some IPs like the display and video decoders access those
pixels by using canvas IDs rather than direct phy addresses.

As such, allocating/manipulating canvases can be done concurrently and
there is a need for a standalone, lock-aware canvas provider module.

Currently, canvas code lies in the drm/meson module as it is the sole
user.

This patchset adds such canvas provider module and converts drm/meson to
using it, stripping/moving the current canvas code.

Maxime Jourdan (4):
  soc: amlogic: add meson-canvas driver
  dt-bindings: soc: amlogic: add meson-canvas documentation
  ARM64: dts: meson-gx: add dmcbus and canvas nodes.
  drm/meson: convert to the new canvas module

 .../bindings/display/amlogic,meson-vpu.txt    |   9 +-
 .../soc/amlogic/amlogic,meson-canvas.txt      |  36 ++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |  24 ++-
 drivers/gpu/drm/meson/Kconfig                 |   1 +
 drivers/gpu/drm/meson/Makefile                |   2 +-
 drivers/gpu/drm/meson/meson_canvas.c          |  70 -------
 drivers/gpu/drm/meson/meson_canvas.h          |  42 ----
 drivers/gpu/drm/meson/meson_crtc.c            |   5 +-
 drivers/gpu/drm/meson/meson_drv.c             |  35 ++--
 drivers/gpu/drm/meson/meson_drv.h             |   5 +-
 drivers/gpu/drm/meson/meson_plane.c           |   3 +-
 drivers/gpu/drm/meson/meson_viu.c             |   1 -
 drivers/soc/amlogic/Kconfig                   |   7 +
 drivers/soc/amlogic/Makefile                  |   1 +
 drivers/soc/amlogic/meson-canvas.c            | 182 ++++++++++++++++++
 include/linux/soc/amlogic/meson-canvas.h      |  37 ++++
 16 files changed, 319 insertions(+), 141 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
 delete mode 100644 drivers/gpu/drm/meson/meson_canvas.c
 delete mode 100644 drivers/gpu/drm/meson/meson_canvas.h
 create mode 100644 drivers/soc/amlogic/meson-canvas.c
 create mode 100644 include/linux/soc/amlogic/meson-canvas.h

-- 
2.17.1

