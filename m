Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CEDFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3D520893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3D520893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeG3Jp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:45:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55872 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeG3Jp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:45:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2F7EF263C00
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Lin Huang <hl@rock-chips.com>,
        kernel@collabora.com, robin.murphy@arm.com,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Yao <markyao0591@gmail.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        devicetree@vger.kernel.org,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>, Chris Zhong <zyw@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/8] Add support for drm/rockchip to dynamically control the DDR frequency.
Date:   Mon, 30 Jul 2018 10:11:16 +0200
Message-Id: <20180730081124.30698-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

The rk3399 platform has a DFI controller that can monitor DDR load and a
DMC driver that talks with the TF-A (Trusted Firmware-A) to dynamically
set the DDR frequency with following flow.

             kernel                          Trusted Firmware-A
                                                  (bl31)
        monitor ddr load
                |
                |
        get_target_rate
                |
                |           pass rate to TF-A
        clk_set_rate(ddr) --------------------->run ddr dvs flow
                                                    |
                                                    |
                 <------------------------------end ddr dvs flow
                |
                |
              return

These patches add support for devfreq to dynamically control the DDR
frequency into the drm rockchip driver. By default it uses the
'simple_ondemand' governor which can adjust the frequency based on the
DDR load.

Waiting for your feedback.

Best regards,
 Enric

Changes in v1:
- [RFC 1/10] Add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
- [RFC 1/10] s/Generic/General/ (Robin Murphy)
- [RFC 2/10] Add reviewed and acked tags from Chanwoo Choi and Rob Herring
- [RFC 3/10] Add an explanation for platform SIP calls.
- [RFC 3/10] Change if statement for a switch.
- [RFC 3/10] Rename ddr_flag to odt_enable to be more clear.
- [RFC 4/10] Removed from the series. I did not found a use case where not holding the mutex causes the issue.
- [RFC 7/10] Removed from the series. I did not found a use case where this matters.
- [RFC 8/10] Move rk3399-dram.h to dt-includes.
- [RFC 8/10] Put sdram default values under the dmc node.
- [RFC 8/10] Removed rk3399-dram-default-timing.dts

Derek Basehore (2):
  devfreq: rk3399_dmc / clk: rockchip: Sync with vblank in the kernel
    for DDRfreq.
  devfreq: rk3399_dmc / clk: rockchip: Disable DDR clk timeout on
    suspend.

Enric Balletbo i Serra (3):
  devfreq: rockchip-dfi: Move GRF definitions to a common place.
  dt-bindings: devfreq: rk3399_dmc: Add rockchip,pmu phandle.
  devfreq: rk3399_dmc: Pass ODT and auto power down parameters to TF-A.

Lin Huang (2):
  arm64: dts: rk3399: Add dfi and dmc nodes.
  arm64: dts: rockchip: Enable dmc and dfi nodes on gru.

Sean Paul (1):
  drm: rockchip: Add DDR devfreq support.

 .../bindings/devfreq/rk3399_dmc.txt           |   2 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  |  21 ++
 .../boot/dts/rockchip/rk3399-op1-opp.dtsi     |  29 +++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  51 ++++-
 drivers/clk/rockchip/clk-ddr.c                | 157 +++++++++++--
 drivers/clk/rockchip/clk.c                    |   2 +-
 drivers/clk/rockchip/clk.h                    |   3 +-
 drivers/devfreq/event/rockchip-dfi.c          |  23 +-
 drivers/devfreq/rk3399_dmc.c                  | 209 +++++++++++++++---
 drivers/devfreq/rk3399_dmc_priv.h             |  16 ++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |  46 ++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |   9 +
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c    |  35 +++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |  34 +++
 include/dt-bindings/power/rk3399-dram.h       |  73 ++++++
 include/soc/rockchip/rk3399_dmc.h             |  42 ++++
 include/soc/rockchip/rk3399_grf.h             |  21 ++
 include/soc/rockchip/rockchip_sip.h           |   1 +
 18 files changed, 704 insertions(+), 70 deletions(-)
 create mode 100644 drivers/devfreq/rk3399_dmc_priv.h
 create mode 100644 include/dt-bindings/power/rk3399-dram.h
 create mode 100644 include/soc/rockchip/rk3399_dmc.h
 create mode 100644 include/soc/rockchip/rk3399_grf.h

-- 
2.18.0

