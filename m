Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbeA3U33 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:29:29 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55888 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeA3U31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:27 -0500
From: Thierry Escande <thierry.escande@collabora.com>
To: Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Haixia Shi <hshi@chromium.org>,
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Zain Wang <wzz@rock-chips.com>, Yakir Yang <ykk@rock-chips.com>,
        Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Mark Yao <mark.yao@rock-chips.com>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 00/43] DRM Rockchip rk3399 (Kevin)
Date: Tue, 30 Jan 2018 21:28:30 +0100
Message-Id: <20180130202913.28724-1-thierry.escande@collabora.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset includes cleanups, improvements, and bug fixes for
Rockchip DRM driver and PSR support.

this patchset depends and needs to be applied on top of Rockchip rk3399
eDP support [1].

[1] https://lkml.org/lkml/2018/1/10/682

Regards,
Thierry

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

Haixia Shi (1):
  drm/rockchip: support prime import sg table

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

Sean Paul (3):
  drm/rockchip: Don't use atomic constructs for psr
  drm/rockchip: Remove analogix psr worker
  drm/panel: simple: Change mode for Sharp lq123p1jx31

Tomasz Figa (8):
  drm/rockchip: Get rid of unnecessary struct fields
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

zain wang (17):
  drm/bridge: analogix_dp: set psr activate/deactivate when
    enable/disable bridge
  drm/bridge: analogix_dp: Don't power bridge in analogix_dp_bind
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

Ørjan Eide (1):
  drm/rockchip: Respect page offset for PRIME mmap calls

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 475 +++++++++++++++------
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  14 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 274 +++++++-----
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h  |   7 +
 drivers/gpu/drm/exynos/exynos_dp.c                 |   2 +-
 drivers/gpu/drm/panel/panel-simple.c               |   7 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  73 ++--
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c         |  61 ++-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        | 125 +++++-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h        |   5 +-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c        | 361 +++++++++++-----
 drivers/gpu/drm/rockchip/rockchip_drm_psr.h        |   7 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  52 ++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |   1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |   1 +
 include/drm/bridge/analogix_dp.h                   |   5 +-
 18 files changed, 1048 insertions(+), 428 deletions(-)

-- 
2.14.1
