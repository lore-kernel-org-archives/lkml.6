Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEC8C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C6F20828
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOiS1e1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbeL2Ndf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 08:33:35 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37814 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeL2Ndf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 08:33:35 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so19467800edb.4;
        Sat, 29 Dec 2018 05:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VOEwkIxvI1q/i/WRRxMwm990tTHzp40HbWJrY1h5Srg=;
        b=QOiS1e1/tVwWeJpUnmvNrUZZmxafF+rTouOn0afGnzvEUNG6c+xsn3E2DfIGlY7oxh
         SNIPS0YcmX/i9WDRWW/Mi7vwbWpXu7PAOES8pg71CxrimPXFVdXVwNXdUjC4SDsr6ah6
         ArNCwZtxMtBaXsTYOIGRrxY8fGwEso+yCsbismMQEw3jEYo9Rmb4Kr/CgHczmjQFRKvs
         XDXnAFlfg4DhBJlvTbesd3crHVq8bWXkp0ulgMhsa7WUSxowAcW2gJsZmHf6ZysPgRzX
         dgR2/seLZ9ssm3UE9w+yvM4cPEMpY5dl4UfgOwyRLk3D5UriEj1JspqvlwLyovfFYbzB
         GbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VOEwkIxvI1q/i/WRRxMwm990tTHzp40HbWJrY1h5Srg=;
        b=C7lhMEJF4fnP6g9KCHYJnAIrWzkBBoMSQynt07XqyT0v6Vr9AEvzxh4+4psD45D7tN
         0OSVXQf0FXK9qE+4o2dX5FMzNw+BquNdNTyq98KghJiUPFLNvVOwfrHS8EBK1CfB1weX
         RpuBTJQrcgTwI6RrbDZ9fxsKQ0FZYWQjgh7l72RwJjZErHXrpuxTISQMJ7Lb5cV4l1x5
         JTmzd8R0Qpkb3WYcGaUqbLEfGNUShyxvHn2DtuHACzjcoNR5bV8thSfov3JwJLfsU3Qy
         RSRkuj86wrovo23YlidvSwwM590ojNe79qKqzHiuj0QqAaQ74A6e+ir6pGbtAOrkR6mA
         vNkg==
X-Gm-Message-State: AA+aEWZoFQcmaCy9lyqyQX/C10SzK8QWG9bsemfN65vwzrf/xLBrcp41
        QKbwDzfLeh5jD7GRGOdFhYs=
X-Google-Smtp-Source: AFSGD/UYOFS24TVFvlBj0Ecv6cUdhZZA7uE6oF+NVkTRWHBxFbetPqX3nvlmZdYuB1++JNd2TppOJw==
X-Received: by 2002:a50:9153:: with SMTP id f19mr26220211eda.159.1546090412895;
        Sat, 29 Dec 2018 05:33:32 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d7-v6sm8023063ejx.68.2018.12.29.05.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 05:33:32 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 0/7] Enable rk3066 VOP and HDMI for MK808
Date:   Sat, 29 Dec 2018 14:33:11 +0100
Message-Id: <20181229133318.18128-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DISCLAIMER: Use at your own risk.
For testing only!

Version: V2

Title: Enable rk3066 VOP and HDMI for MK808.

This patch serie only works in combination with a MK808 TV stick and
a rk3066 processor. Other boxes and tablets with a rk3066
need extra software for power management and lcd's.

What does it do:

With these 7 kernel patches a MK808 can show 2 penquins and a console
on a DVI-D monitor in combination with a framebuffer.

Not tested:

HDMI TV
DRM
Xorg
Display managers
Android
etc.

Problems:

Fixed screen size for DVI-D.
HDMI sound not included.
etc.

///////////////////////////////////////////

# How to make rkfs.cpio

find . | cpio -o --format=newc > ../rkfs.cpio

# How to compile/flash

make menuconfig  ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabi-
make -j4  ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabi-

cp ./arch/arm/boot/zImage ../zImage-dtb
cat ./arch/arm/boot/dts/rk3066a-mk808.dtb >> ../zImage-dtb
../tools/rkcrc -k ../zImage-dtb ../mk808.img
sudo ../tools/rkflashtool w 0x4000 0x8000 < ../mk808.img
sudo ../tools/rkflashtool b

///////////////////////////////////////////

Finley Xiao (1):
  clk: rockchip: rk3188: add CLK_SET_RATE_PARENT for lcdc dclk

Johan Jonker (2):
  ARM: dts: rockchip: rk3066: add HCLK_HDMI to pmu node
  ARM: dts: rockchip: rk3066a-mk808: enable vop0 and hdmi nodes

Mark Yao (2):
  drm: rockchip: vop: add rk3066 vop definitions
  ARM: dts: rockchip: add rk3066 vop display nodes

Zheng Yang (2):
  drm: rockchip: introduce rk3066 hdmi
  ARM: dts: rockchip: add rk3066 hdmi nodes

 .../bindings/display/rockchip/rockchip-vop.txt     |   1 +
 arch/arm/boot/dts/rk3066a-mk808.dts                |  12 +
 arch/arm/boot/dts/rk3066a.dtsi                     |  92 ++
 drivers/clk/rockchip/clk-rk3188.c                  |   4 +-
 drivers/gpu/drm/rockchip/Kconfig                   |   8 +
 drivers/gpu/drm/rockchip/Makefile                  |   1 +
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             | 928 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rk3066_hdmi.h             | 235 ++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        | 110 +++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h        |  53 ++
 12 files changed, 1445 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.c
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.h

-- 
2.11.0

