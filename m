Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CF6C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCDE206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cL7MoXUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCDE206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbeLDWnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:43:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41854 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLDWnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:43:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so9003781plm.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 14:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbz+AWlhcCUXrpU2bSN/CZ8Hj20Pq4BqCxgPZZFepsA=;
        b=cL7MoXUIe/YWgokU3McEmQQM0/TqQtWR25pSS6uUTb4YCN2E3aCWK8IDv5rTH//zx7
         XAmsqog3MmosVDEb/tBrxjwEd94HHlVTDNKkQZ0w/sXL+dqv69gnjaAU27qHgiuITKDg
         4V5Op2jiNUaM5mfnSroPi+8awfUQgxFW3d9f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbz+AWlhcCUXrpU2bSN/CZ8Hj20Pq4BqCxgPZZFepsA=;
        b=KqAXaH6E0ySu8NEgOlbaE6RIRUSntsQEmJYzV3qg4qvNBHBXqF0ezJznFbzF+nqfrg
         WwtT5zVnu+PVILej7B+VBnhO2MQfFhML+movbz1cYDyjYpKVXC6a6/hJzH/04+j3vt5m
         JWqY0olaBZLIIgrhbEEfgaVr8yOGgf/jGxLjgg3qY4voRRtNe5i/lBa2KhWEpKQxkQQ6
         7V4mCstPCVeCWrj4l5zMHMeoD6uJvtcK6Ksqbg1H0g1JR/LNAyVmMWVFL+BYBXAs1eEd
         rjV9Zp02wRss+WPo8JAGYfHd3v0RJm9RAdH5b+fZFxIox6g+6Kb08Xb1xM3PIubhYSuQ
         XXaQ==
X-Gm-Message-State: AA+aEWb0CeupTILt2H+jMeL4hJGq5KRbbGJNJ8RIAI55K+xrjJfR+maF
        G7tae+T670sJhJ9NFCbltnJD3Q==
X-Google-Smtp-Source: AFSGD/U87YsN0vGxhb58rI9jVZ+TVIPoJHy2c289I8dgHLlWBPK51rotC9BD6hL/KisPQHG3zkAftQ==
X-Received: by 2002:a17:902:aa82:: with SMTP id d2mr13227136plr.153.1543963392845;
        Tue, 04 Dec 2018 14:43:12 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y184sm21961917pgd.71.2018.12.04.14.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:43:12 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 0/8] drm/msm/dsi: Get PHY ref clocks from the DT
Date:   Tue,  4 Dec 2018 14:42:26 -0800
Message-Id: <20181204224234.62619-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSM DSI PHY drivers currently hardcode the name and the rate of
the PHY ref clock. Get the ref clock from the device tree instead.

Note: testing of this series was limited to SDM845 and the 10nm PHY

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
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c    | 13 ++++++-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c    | 16 +++++++--
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c    | 36 +++++++++++++------
 .../gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c   | 24 ++++++++++---
 8 files changed, 82 insertions(+), 28 deletions(-)

-- 
2.20.0.rc1.387.gf8505762e3-goog

