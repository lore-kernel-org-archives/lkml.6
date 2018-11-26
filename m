Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD614C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3EF208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QPTPFXQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3EF208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeK0KIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:08:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38621 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeK0KIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:08:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so6891211pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8n0X+AwQ+aDlPqmHVuYT4MEwUglcvhXLUBo0oylE3So=;
        b=QPTPFXQ3WO5XYF2vm0qH8Jvq6OjSCT2B2wZCexQCbaZJpTP0jPcL73sW6dKSuT+wTn
         eKqWIz7CXEI+cD/1tOMZOyvqq47GGwDrSprxDgCrBLIRgjvM//uyr8kQslx0cnMJ+OUs
         QJnFxCMC3eLN2irnllIrAtUb7b8tw/kV6Lrcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8n0X+AwQ+aDlPqmHVuYT4MEwUglcvhXLUBo0oylE3So=;
        b=U/Ilxld8q9kVZv+6UXQnL9jSY3r4QIbf4imWKYtMl6mqW7Vw3HklVTSFEiikbV6QxE
         Mr0BSsajo+3SeTcoZj9FUGYYTLuWkna+GSu28Xx44dpeKomQ44XLUJHKn0qzieF+5t8S
         W9AVne7APfPu6HPfQzyTmPULS4Qisd9upuYmaGuc7XTBq55j7cJrAXYCFV2nT63kL4+1
         ll8DPnPV1Ye0LjFKd5LSem/5qRxw+CHgWHpFg4mbhG9QQ5PrdMwpSmYp10blxdANoY3Y
         fhlW+ro1XWS/jG1eKTb1ROiEK4m7upSq2dLOJaU8Rjf3aS4MHw4IG3/pBUV2giucNO6B
         FE3A==
X-Gm-Message-State: AA+aEWaNC5LX6GWthyRO/sYcHlmOYD42V3nF5uyk+gxdqcOjzetGtCa7
        KVyL9uX9Zngxkt3h1baREDGDpQ==
X-Google-Smtp-Source: AFSGD/WZdX1b/85YbZggHmxyve48V4MytFR1AJMSjFvs6F7s+WAJPxDhsMMCh6stEKlo4uXvkUarWQ==
X-Received: by 2002:a63:78cd:: with SMTP id t196mr26997411pgc.62.1543273950891;
        Mon, 26 Nov 2018 15:12:30 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id j6sm2128625pfg.126.2018.11.26.15.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 15:12:30 -0800 (PST)
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
Subject: [PATCH v2 0/7] drm/msm/dsi: Get PHY ref clocks from the DT
Date:   Mon, 26 Nov 2018 15:11:52 -0800
Message-Id: <20181126231159.122298-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSM DSI PHY drivers currently hardcode the name and the rate of
the PHY ref clock. Get the ref clock from the device tree instead.

Note: testing of this series was limited to SDM845 and the 10nm PHY

Major changes in v2:
- apply to all MSM DSI PHY drivers, not only 10nm

Matthias Kaehlcke (7):
  dt-bindings: msm/dsi: Add ref clock for PHYs
  drm/msm/dsi: 14nm PHY: Get ref clock from the DT
  drm/msm/dsi: 28nm 8960 PHY: Get ref clock from the DT
  arm64: dts: qcom: msm8916: Set 'xo_board' as ref clock of the DSI PHY
  drm/msm/dsi: 28nm PHY: Get ref clock from the DT
  arm64: dts: sdm845: Set 'bi_tcxo' as ref clock of the DSI PHYs
  drm/msm/dsi: 10nm PHY: Get ref clock from the DT

 .../devicetree/bindings/display/msm/dsi.txt   |  1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  5 ++--
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 10 ++++---
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c    | 13 ++++++++-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c    | 16 ++++++++--
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c    | 29 +++++++++++++------
 .../gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c   | 17 +++++++++--
 7 files changed, 69 insertions(+), 22 deletions(-)

-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

