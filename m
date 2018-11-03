Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE344C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8316A2082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GIpnOSuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8316A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeKCTUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:20:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41638 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeKCTUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:20:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id k13so2049938pga.8
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 03:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFMYXF1pyse63r7JDB5cxSSXfiTGDzIKGn4uj7Xb3k0=;
        b=GIpnOSuHRPov2o+7ihDi02vxDH3z8E/FeqlXPPjMNU9MGXjWe7UW+OefYYSodEVg2O
         3M1RBzZRqd+rzTwVMBu9i7kOOuFx278vf4+VWYn9JcL3bWcLloAGYwVSNyMPnvGB4p0Q
         09IXLXWqINfje8xcvvfD/c6jnN3m4Rfm/FMWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFMYXF1pyse63r7JDB5cxSSXfiTGDzIKGn4uj7Xb3k0=;
        b=NsmtTGPE6Yh5UtQBLGOq1ediGPqeS9H5Fo6D2tm2DmLKs/5rzSBnN3YHW8/LA+SJre
         2IS/1qPtnjkwZGuRTWqHmj405oQeUXKiHdu+3BQ9UNeUW2UTUoZTCpzRtXZKJFMVxmam
         AqHcRYur5+PYDOpPStJt6qRFNXWTbzDmgUdwZrU8ikFuf9cmnP13YpIGAIiRM3piZmP9
         98ga3x/MwdpYylyd0kVMR3kqtHHIS2C3C6tbBrx/xDBxTmmmCtYoZssU3olwJ22GZaHA
         MY5dbBV+QFqw56sXR2tEjP1H0JHqQ8rwgtLzqiEpLfAelOrKF7v1kxGKeq2jnAn7FqeK
         OccA==
X-Gm-Message-State: AGRZ1gKqOqvXDKK+7DWZocDtaCOICO+kN5LbRTyzPArT9ktyhpqQAwgQ
        e/uyKGgd2op0V7PQ9ZH0KFmE1g==
X-Google-Smtp-Source: AJdET5eJognxVUs7SAmu4mLiOMKUtNICq3a7vesH4xNcEzh4ahiTx/38ME2A0JipRgWCUcaxCQtOSA==
X-Received: by 2002:a62:6181:: with SMTP id v123-v6mr15073159pfb.117.1541239762735;
        Sat, 03 Nov 2018 03:09:22 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:6094:3f7a:ed0a:fb74:1220:defe])
        by smtp.gmail.com with ESMTPSA id z79-v6sm28466823pfl.33.2018.11.03.03.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 03:09:22 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 00/10] drm/sun4i: Allwinner MIPI-DSI Burst mode support
Date:   Sat,  3 Nov 2018 15:38:50 +0530
Message-Id: <20181103100900.30313-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series support MIPI-DSI Burst mode on Allwinner platform, which
is tested in burst supported panel in Pine64-LTS board.

Series depends on previous A64 MIPI-DSI series[1] and all changes are
available in [2] repo with WIPI-A64-DSI branch.

Any inputs,
Jagan.

[2] https://github.com/amarula/linux-amarula
[1] https://patchwork.kernel.org/cover/10657467/

Jagan Teki (10):
  drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop N1 instruction
    delay
  drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode
  drm/sun4i: sun6i_mipi_dsi: Enable burst mode
  drm/sun4i: sun6i_mipi_dsi: Enable 2byte trail for 4-lane burst mode
  drm/sun4i: sun6i_mipi_dsi: Enable burst mode HBP, HSA_HSE
  dt-bindings: panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel
  drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel
  [DO NOT MERGE] arm64: allwinner: a64: pine64-lts: Enable Feiyang FY07024DI26A30-D DSI
    panel

 .../display/panel/feiyang,fy07024di26a30d.txt |  20 ++
 .../dts/allwinner/sun50i-a64-pine64-lts.dts   |  37 +++
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-feiyang-fy07024di26a30d.c | 305 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        | 186 +++++++----
 6 files changed, 500 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
 create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c

-- 
2.18.0.321.gffc6fa0e3

