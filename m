Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933363AbeCPC7F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 22:59:05 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33995 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeCPC7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:59:01 -0400
X-Google-Smtp-Source: AG47ELtTdoYMZ8U0towbeNr8UWyi4AbhFmd+TjiQy/k/CCTSGVa7oOyHeBv6k/My42OlKmjlqHk2gA==
From: Alexandru M Stan <amstan@chromium.org>
To: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <seanpaul@chromium.org>
Cc: devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>, briannorris@chromium.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        marcheu@chromium.org, hoegsberg@chromium.org,
        Thierry Escande <thierry.escande@collabora.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Alexandru M Stan <amstan@chromium.org>,
        Yakir Yang <kuankuan.y@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, zain wang <wzz@rock-chips.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/2] Add backlight-pwm-passthru in analogix DP driver
Date: Thu, 15 Mar 2018 19:56:57 -0700
Message-Id: <20180316025659.217423-1-amstan@chromium.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that the backlight on the ASUS Chromebook Flip C101 (bob) is
flickering.

We're sending it a high frequency pwm signal, but the EDP panel decided to
"parse" the signal, read the duty cycle, then make its own signal that
it sends to the LEDs.

So even though we send a nice high refresh rate at 1200Hz, the panel backlight
flickers at 200Hz (which is not even divisible by the 60Hz refresh rate).

The fix for that is to enable the EDP_BACKLIGHT_FREQ_PWM_PIN_PASSTHRU bit from
the DPCD EDP registers. This makes the panel actually follow the signal
we're giving it.

This series includes the optional dt binding to enable this fix
(backlight-pwm-passthru) and the corresponding code in the analogix
drm/bridge driver.


Alexandru M Stan (2):
  dt-bindings: analogix-dp: Add backlight-pwm-passthru
  drm/bridge: analogix: Enable EDP_BACKLIGHT_FREQ_PWM_PIN_PASSTHRU

 .../bindings/display/bridge/analogix_dp.txt        |  4 ++
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 48 ++++++++++++++++++++++
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  1 +
 3 files changed, 53 insertions(+)

-- 
2.13.5
