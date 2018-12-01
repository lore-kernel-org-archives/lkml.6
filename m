Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B53C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFCD20673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="enBmAVz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFCD20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbeLAMEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:04:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36532 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeLAMEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:04:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so3212339pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YxMkbstJjYz/SCOIKptS3dJ1kb5LfIKu8uvA4n0XIFU=;
        b=enBmAVz4ed7D8RtUpQot0W81h2FIWLqMsJp5pG2joCqPacMeH4VNap8RvviIjmh4U4
         eZhpQdAvbZUO2EZJmRTapRiM0zzdhqO1wk5/P+pl6Dn8purYNQBnXkeLIByNwL+v6VfK
         dUdtgmULKg6E1PGWJQvhUL7+AkEF5gjIsZzpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YxMkbstJjYz/SCOIKptS3dJ1kb5LfIKu8uvA4n0XIFU=;
        b=pORHp5misoUFS7W0Evff0fAjUljSV7tMKJ9avxnlM6DsVoqHEe4lfsLmVxMNIiuwYM
         kcvZ0k7FdkQwo2K8ZA31rS7OcavMjk+JVQqDAipimIUv6uyKj5V69rZKuc/3/hHked9V
         RwQlNgEChqWfPU/A7y5uMVxR1z72JgJpnnQNGoikhCepz9qgmc1tNy9CBw+LiyPClCcl
         MvOWXu3UsiKnxBiyEwojOi9x4dzzrf+gxPPBFef3nSqg8txf0lFESDlAcP8KCD8NMbB6
         iTYcwz2AxUW2dHcs8NpMP/2h19V6Ygn4tjv9eHW5abm5UVgDhwUUA3dzA3NMRZWoq2rU
         M3CQ==
X-Gm-Message-State: AA+aEWadxR5kKPUdpojh+apGGD9116GC6bgiruDVCY57QtDZAtxA83IX
        aGDbuSumng9Ta0++qewNF8BhTA==
X-Google-Smtp-Source: AFSGD/XfMCuzU5aCKP/5KCwKKSx0NCbpn9/5HnkpRatuRUEjkVhIoToh/CCHQTlkRFctydOCuaUEjg==
X-Received: by 2002:a62:2c81:: with SMTP id s123mr7573110pfs.174.1543625604513;
        Fri, 30 Nov 2018 16:53:24 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id z8sm16518566pgz.53.2018.11.30.16.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 16:53:23 -0800 (PST)
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
Subject: [PATCH v3 0/8] drm/msm/dsi: Get PHY ref clocks from the DT
Date:   Fri, 30 Nov 2018 16:52:46 -0800
Message-Id: <20181201005254.139908-1-mka@chromium.org>
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
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c    | 35 ++++++++++++++-----
 .../gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c   | 28 ++++++++++++---
 8 files changed, 87 insertions(+), 26 deletions(-)

-- 
2.20.0.rc1.387.gf8505762e3-goog

