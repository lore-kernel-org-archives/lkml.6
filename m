Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932906AbeCEWNb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:13:31 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37066 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932616AbeCEWN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:13:29 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        ykk@rock-chips.com, orjan.eide@arm.com, mark.yao@rock-chips.com,
        m.szyprowski@samsung.com, Andrzej Hajda <a.hajda@samsung.com>,
        Yakir Yang <kuankuan.y@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-samsung-soc@vger.kernel.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>, linux-input@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>, Kukjin Kim <kgene@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v4 00/38] DRM Rockchip rk3399 (Kevin)
Date: Mon,  5 Mar 2018 23:12:35 +0100
Message-Id: <20180305221313.3751-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset includes cleanups, improvements, and bug fixes for
Rockchip DRM driver and PSR support.

This new version is the same as before but rebased on top of
drm-misc-next plus the Marek patches that fixes Chromebook2 Peach-Pit [1]
and the latest series of Rockchip rk3399 eDP support [2].

[1] https://www.spinics.net/lists/dri-devel/msg167804.html
[2] https://www.spinics.net/lists/dri-devel/msg167770.html

Regards,
 Enric

Changes in v4:
- Rebased all on top of drm-misc-next
- Removed the following patches as are already applied.
  [PATCH v3 01/43] drm/rockchip: Get rid of unnecessary struct fields
  [PATCH v3 02/43] drm/rockchip: support prime import sg table
  [PATCH v3 03/43] drm/rockchip: Respect page offset for PRIME mmap
  calls
- Removed the following patches as now are part of another patchset
  [PATCH v3 05/43] drm/bridge: analogix_dp: Don't power bridge in
  analogix_dp_bind
  [PATCH v3 33/43] drm/panel: simple: Change mode for Sharp lq123p1jx31

Changes in v3:
- Addressed some of the comments from Sean on the v2

Changes in v2:
- A few patches have been replaced by newer and cleaner versions from
  the ChromeOS kernel gerrit, especially about disallowing PSR for the
  whole atomic commit.


Douglas Anderson (4):
  drm/bridge: analogix_dp: Reorder plat_data->power_off to happen sooner
  drm/bridge: analogix_dp: Properly log AUX CH errors
  drm/bridge: analogix_dp: Properly disable aux chan retries on rockchip
  drm/bridge: analogix_dp: Split the platform-specific poweron in two
    parts

Kristian H. Kristensen (1):
  drm/rockchip: Disable PSR on input events

Lin Huang (6):
  drm/bridge: analogix_dp: Move enable video into config_video()
  drm/bridge: analogix_dp: Check AUX_EN status when doing AUX transfer
  drm/bridge: analogix_dp: Ensure edp is disabled when shutting down the
    panel
  drm/bridge: analogix_dp: Extend hpd check time to 100ms
  drm/bridge: analogix_dp: Check dpcd write/read status
  drm/bridge: analogix_dp: Reset aux channel if an error occurred

Mark Yao (1):
  drm/rockchip: pre dither down when output bpc is 8bit

Sean Paul (2):
  drm/rockchip: Don't use atomic constructs for psr
  drm/rockchip: Remove analogix psr worker

Tomasz Figa (7):
  drm/rockchip: analogix_dp: Do not call Analogix code before bind
  drm/rockchip: Cancel PSR enable work before changing the state
  drm/rockchip: psr: Avoid redundant calls to .set() callback
  drm/rockchip: psr: Sanitize semantics of allow/disallow API
  drm/rockchip: Disable PSR from reboot notifier
  drm/rockchip: Disallow PSR for the whole atomic commit
  drm/rockchip: psr: Remove flush by CRTC

Yakir Yang (1):
  drm/bridge: analogix_dp: detect Sink PSR state after configuring the
    PSR

zain wang (16):
  drm/bridge: analogix_dp: set psr activate/deactivate when
    enable/disable bridge
  drm/bridge: analogix_dp: Don't change psr while bridge is disabled
  drm/rockchip: add mutex vop lock
  drm/bridge: analogix_dp: add fast link train for eDP
  drm/rockchip: Only wait for panel ACK on PSR entry
  drm/bridge: analogix_dp: Don't use fast link training when panel just
    powered up
  drm/bridge: analogix_dp: Retry bridge enable when it failed
  drm/bridge: analogix_dp: Wait for HPD signal before configuring link
  drm/bridge: analogix_dp: Set PD_INC_BG first when powering up edp phy
  drm/bridge: analogix_dp: Fix incorrect usage of enhanced mode
  drm/bridge: analogix_dp: Fix AUX_PD bit for Rockchip
  drm/rockchip: Restore psr->state when enable/disable psr failed
  drm/bridge: analogix_dp: Don't use ANALOGIX_DP_PLL_CTL to control pll
  drm/bridge: analogix_dp: Fix timeout of video streamclk config
  drm/bridge: analogix_dp: Fix incorrect operations with register
    ANALOGIX_DP_FUNC_EN_1
  drm/bridge: analogix_dp: Move fast link training detect to set_bridge

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 452 ++++++++++++++++-----
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  14 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 274 ++++++++-----
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h  |   7 +
 drivers/gpu/drm/exynos/exynos_dp.c                 |   2 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  73 ++--
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c         |  61 ++-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c        | 361 ++++++++++------
 drivers/gpu/drm/rockchip/rockchip_drm_psr.h        |   7 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  47 ++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |   1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |   1 +
 include/drm/bridge/analogix_dp.h                   |   5 +-
 15 files changed, 915 insertions(+), 395 deletions(-)

-- 
2.16.1
