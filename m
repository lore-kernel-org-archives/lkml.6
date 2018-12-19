Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1974C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC31E20811
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbeLSXzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:55:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34618 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeLSXzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:55:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so10601012pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 15:55:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XyIMYAL5qBnmvWOCPA7vcQI2SfJsc96HrX1N6dGqLOs=;
        b=heJoAC7rX3aTYbOwt2TDQ/P+Y1spRnryUStNDWLUhLCK+u9t9fo/fuR+UkaXpd259L
         eS29PcDPUk645sX0CYkDN5EZQImV07EMvW4sD7Zm/II9dMquBvg/3wTqg260BdXJ92Yr
         xLyTJabRy3FWZq4oPGvR4OgLPpEYzCZ9c3+z2DcUu8tb2T5Y3bh8AAd88A9XBENbA9FW
         GzkUSpCrXq/7igoRjapFskj0El7kPPjEzFn4exNnem5cy33jmAI0EizzyNo8S1f8acrt
         HwG81Nyl6pli0N/9EfAukdrPRyBiFMooYdiXWUZJ67UEymdK5TCr5jy/TU7ojySErz3f
         LpsQ==
X-Gm-Message-State: AA+aEWbzijj4+mdN19/A4fdVM12+nX8U36QSWT6OsKvvdqWWqNYqUCp6
        ucoyFK6Kqj4IJv3HV0wj59Urgg==
X-Google-Smtp-Source: AFSGD/VjxWZjGtpglJs4TWeaHZHEP8v/rEMIDMx+k0M8YWsuPuAaRzBXbgN6Wkm7JXO4CFTZcWgDWA==
X-Received: by 2002:a63:b24a:: with SMTP id t10mr19772542pgo.223.1545263740904;
        Wed, 19 Dec 2018 15:55:40 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t67sm37045048pfd.90.2018.12.19.15.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 15:55:39 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 0/8] drm/msm/dsi: Get PHY ref clocks from the DT
Date:   Wed, 19 Dec 2018 15:55:20 -0800
Message-Id: <20181219235528.114830-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSM DSI PHY drivers currently hardcode the name and the rate of
the PHY ref clock. Get the ref clock from the device tree instead.

Note: testing of this series was limited to SDM845 and the 10nm PHY

Major changes in v5:
- none (see per-patch change log for minor changes)

Major changes in v4:
- always use parent rate for 28nm and 28nm 8960 PHYs

Major changes in v3:
- keep supporting DTs without ref clock for the 28nm and the 28nm
  8960 PHYs
- added patch to add ref clock to qcom-apq8064.dtsi

Major changes in v2:
- apply to all MSM DSI PHY drivers, not only 10nm

Matthias Kaehlcke (8):
  dt-bindings: msm/dsi: Add ref clock for PHYs
  drm/msm/dsi: 28nm 8960 PHY: Get ref clock from the DT
  drm/msm/dsi: 28nm PHY: Get ref clock from the DT
  drm/msm/dsi: 14nm PHY: Get ref clock from the DT
  drm/msm/dsi: 10nm PHY: Get ref clock from the DT
  arm64: dts: qcom: msm8916: Set 'xo_board' as ref clock of the DSI PHY
  arm64: dts: sdm845: Set 'bi_tcxo' as ref clock of the DSI PHYs
  ARM: dts: qcom-apq8064: Set 'xo_board' as ref clock of the DSI PHY

 .../devicetree/bindings/display/msm/dsi.txt   |  1 +
 arch/arm/boot/dts/qcom-apq8064.dtsi           |  5 +--
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  5 +--
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 10 +++---
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c    | 20 +++++++++--
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c    | 23 +++++++++---
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c    | 36 +++++++++++++------
 .../gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c   | 24 ++++++++++---
 8 files changed, 92 insertions(+), 32 deletions(-)

-- 
2.20.1.415.g653613c723-goog

