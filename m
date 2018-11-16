Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00AAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3062086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SheSrZzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3062086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390012AbeKQCwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:52:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39021 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbeKQCwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:52:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so10829768pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmGSJXILmj3MUjKA2xdObb0m4Pj4XtXgAOsc8OcM9vA=;
        b=SheSrZzbBrU6GENmIEnAvfrZ6TNcjIiNodPCo9AtN/keMvdwHWRV9b6HkhyLrUUY3D
         Cc2w3QVvh74V8u8gpYWqizES+QWvIr70jWYeam/TizLnQcu3uKn/xmlIh1qhgfnsBGZH
         2g3hLHFhOZjUZcywFIbif94B2b1G3yp8s6p0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmGSJXILmj3MUjKA2xdObb0m4Pj4XtXgAOsc8OcM9vA=;
        b=BwDvrLfFAbVQJR07DAkDTjRT4KpZJsHLuZOEs6vGNGhCEGyOqx83UxHjztq7lYM1ws
         CHUevgCIaAtY5UqSqRXw+gaEG5u+TLV+pMSHXPxu5MtZM1J0WAPWHhZ8wNV6VNk4qRIg
         xMB4+63QFIvaNnnWGihltE7/2O8/M5S8qyubAE3spXUX916yKMEY+cDVbyXd1Vo0r6pj
         7wbe8mOSxqHWSs2QPupxWgaKBUfKtyA8iRdKVO8ca9qvgJLK9fRsEs8dDHgyt2ua/kSK
         hQR69gwCNMn4nPRpVJzflkVH6Q5cRv5HVJyuicrH1hiYhss8i0O12b0b55EKJ56JQbIB
         Py3A==
X-Gm-Message-State: AGRZ1gJr8EQ5amC9UePvbuNLV4ev6t3I+D8yiQi+8x2dXUQ/AFwQmeL1
        1AHiYxHfa3QNKQPGSxDSBpKLVQ==
X-Google-Smtp-Source: AJdET5cYCrZUrMM0emp0VzH991k62BI55P30yrtu6lxlUnqw31ahv2YP16FifvW7Sdk0eaZH/APGkg==
X-Received: by 2002:a62:dbc2:: with SMTP id f185mr194257pfg.235.1542386378106;
        Fri, 16 Nov 2018 08:39:38 -0800 (PST)
Received: from localhost.localdomain ([115.97.190.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm34622213pfb.109.2018.11.16.08.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 08:39:37 -0800 (PST)
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
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 00/12] drm/sun4i: Allwinner MIPI-DSI Burst mode support 
Date:   Fri, 16 Nov 2018 22:09:04 +0530
Message-Id: <20181116163916.29621-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series support MIPI-DSI Burst mode on Allwinner platform, which
is tested in burst supported panel in Pine64-LTS board.

Series fixed few code changes commented in previous version[1] and
it depends on A64 MIPI-DSI series[2]

Changes for v2:
- add separate function for setup_inst_delay computation
- moved instruction loop seletion below delay compuation
- add separate function for dsi_get_timings and call for non-burst mode
- simplify burst mode timings compuatation
- add new patches, for tcon0 probing during dsi_bind
- add code to get the tcon0 divider value
- add multiple functions to get line_num, edge0, edge1
- squash 'enable burst mode' patch into 'Setup burst mode'
- fixed commit message of 'Enable burst mode HBP, HSA_HSE'
  s/enable/disable
- collect Rob R-b tag on panel dt-bindings patch
- panel driver changes,
  - dropped unneeded include files
  - s/fy07024di26a30d/feiyang function, variable names
  - use DRM_DEV_ERROR in panel driver
  - add set_display_on .enable
  - moved regulator enablement to .prepare
  - handle erro statements and release them properly during probe
  - remove panel if mipi_dsi_attach failed
  - fixed MODULE_LICENSE
  - update MAINTAINERS file about the panel
- add comments on dts about exact regulators used in schematics

[1] https://patchwork.kernel.org/cover/10666597/
[2] https://patchwork.kernel.org/cover/10680247/

Any inputs,
Jagan.

Jagan Teki (12):
  drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop N1 instruction
    delay
  drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
  drm/sun4i: sun6i_mipi_dsi: Simplify drq set to support all modes
  drm/sun4i: tcon: Export get tcon0 routine
  drm/sun4i: sun6i_mipi_dsi: Probe tcon0 during dsi_bind
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode
  drm/sun4i: sun6i_mipi_dsi: Enable 2byte trail for 4-lane burst mode
  drm/sun4i: sun6i_mipi_dsi: Enable burst mode HBP, HSA_HSE
  dt-bindings: panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel
  drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel
  [DO NOT MERGE] arm64: allwinner: a64: pine64-lts: Enable Feiyang FY07024DI26A30-D DSI
    panel

 .../display/panel/feiyang,fy07024di26a30d.txt |  20 ++
 MAINTAINERS                                   |   6 +
 .../dts/allwinner/sun50i-a64-pine64-lts.dts   |  37 +++
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-feiyang-fy07024di26a30d.c | 286 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |   3 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h            |   1 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        | 264 ++++++++++++----
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |   1 +
 10 files changed, 567 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
 create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c

-- 
2.18.0.321.gffc6fa0e3

