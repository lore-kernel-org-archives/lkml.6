Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65471C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E55D208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UcbwSzXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E55D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389461AbeKPUQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:16:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41380 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbeKPUQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:16:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so57821plm.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0kw5X0zKvK4Q6Yba+l7pfp1viLl+JDSfRQQQ5+ExowM=;
        b=UcbwSzXIBVvyYEpbnua9/G4LDReAMFtU8V7mLinHD7lRnPDn27Fc2HYpomHvFDL6G6
         krBywPFbzhauaWGh+5kYVTl+EyqeIQciazIdaDryd5SbxX79s67/2ZSip1Nk0iahgl1Q
         drrrklWpebJ6qkFGH2ISpt4jfEAPKDO1vEfz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0kw5X0zKvK4Q6Yba+l7pfp1viLl+JDSfRQQQ5+ExowM=;
        b=IIDkGI+3X5Vwr9NPhqw37Xgs/DymVjEwAsXlVHGZdsj+AUjrNB5awe+tqbCHiezWVN
         8M8XAJ4zzs2AmoNHTz98AMbq27ZyHlkJeQgCK1KYwuV4JrDNwC3PdjA/jeLR083wpJVi
         NLjiCd7Z3z3HhpGvlVVvfL3F0IHus8cXTFWGdEvqVaHdgLcSdGxGABdcZH/E9tJqvjaP
         xmSDVUj8hsuREsH+KSI/Xb6+W5bJgZIqepCh7kTTQMPOgbgTwJhBl0CVMFfcYomcLZOS
         MuFYTEr0szdUY7gM13F9Jw15lgND3KkP+x4PpGx5Q4FvXreYE8fOWwb6OGlZWqduOCEt
         69aA==
X-Gm-Message-State: AGRZ1gImt/OtwuQq7ByikONWU9+KU6zblXfBwiL6cWH7vPrn5Ztro/ZU
        ZbYbGZHt+DaFWAzeprIfeWdrNQ==
X-Google-Smtp-Source: AJdET5eHllCOzVSbtyXlM/KjfCLWH/L86gyZE7af/0+ucqKSlqBwU0mtQ+5X9vJuTX/aNB75p91bOw==
X-Received: by 2002:a17:902:ab83:: with SMTP id f3-v6mr9744567plr.122.1542362686856;
        Fri, 16 Nov 2018 02:04:46 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id s184sm34059239pgc.38.2018.11.16.02.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:04:46 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, arm@kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        Carlo Caione <carlo@caione.org>,
        David Brown <david.brown@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Wei Xu <xuwei5@hisilicon.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH 00/10] ARM64: dts: Fix incomplete cooling-maps
Date:   Fri, 16 Nov 2018 15:34:23 +0530
Message-Id: <cover.1542362530.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Now that the below commit are merged in mainline, we can start fixing
the ARM64 platform specific DT files:
    
commit d7a4303b8d1f ("dt-bindings: thermal: Allow multiple devices to
share cooling map")

commit a92bab8919e3 ("of: thermal: Allow multiple devices to share
cooling map")

Each CPU can (and does) participate in cooling down the system but the
DT only captures a handful of them, normally CPU0, in the cooling maps.
Things work by chance currently as under normal circumstances its the
first CPU of each cluster which is used by the operating systems to
probe the cooling devices. But as soon as this CPU ordering changes and
any other CPU is used to bring up the cooling device, we will start
seeing failures.

Also the DT is rather incomplete when we list only one CPU in the
cooling maps, as the hardware doesn't have any such limitations.

Update cooling maps to include all devices affected by individual trip
points.

Individual maintainers can take the patches through their tree.

--
viresh

Viresh Kumar (10):
  ARM64: dts: amlogic: Add all CPUs in cooling maps
  ARM64: dts: exynos: Add all CPUs in cooling maps
  ARM64: dts: fsl: Add all CPUs in cooling maps
  arm64: dts: hi3660: Add missing cooling device properties for CPUs
  ARM64: dts: hisilicon: Add all CPUs in cooling maps
  ARM64: dts: mediatek: Add all CPUs in cooling maps
  ARM64: dts: msm8916: Add all CPUs in cooling maps
  ARM64: dts: renesas: Add all CPUs in cooling maps
  ARM64: dts: rockchip: Add all CPUs in cooling maps
  ARM64: dts: uniphier: Add all CPUs in cooling maps

 .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 22 +++++-------
 .../arm64/boot/dts/exynos/exynos5433-tmu.dtsi | 36 ++++++++++++-------
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  6 ++--
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  6 ++--
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 17 +++++----
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 28 +++++----------
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi     | 16 +++++++--
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi     |  9 ++++-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi      |  9 +++--
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  6 ++--
 arch/arm64/boot/dts/qcom/msm8916.dtsi         | 10 ++++--
 arch/arm64/boot/dts/renesas/r8a7795.dtsi      | 15 ++++++--
 arch/arm64/boot/dts/renesas/r8a7796.dtsi      |  6 ++--
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      |  5 ++-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi      | 15 ++++++--
 .../boot/dts/rockchip/rk3399-gru-kevin.dts    |  8 +++--
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      | 12 +++++--
 .../boot/dts/socionext/uniphier-ld20.dtsi     | 11 +++---
 18 files changed, 147 insertions(+), 90 deletions(-)

-- 
2.19.1.568.g152ad8e3369a

