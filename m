Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2894C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0070218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FTb54Ft0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfBAMIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:08:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35454 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfBAMH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:07:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so6016317wmt.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=XTiGJ1VEZnu97vXLW+QBmet+F5vZfNJMdDLx5SwWiGE=;
        b=FTb54Ft0nuS5pbx0Dtg8eIDFB9LUSOpLAgoC/fHIs0aIs4ENwINXSnR9U2Mh6f2Nal
         9QAgdMPZ0DuCb5Dr2U1abv0SVE7RnKAo8c2bd9lSWRgMxJZMnpKalbtcSdWXdZGMr5kH
         0TF/znVypu7G1cHVzOYaVE1dhqAuBpfJARjJ73SwgBKPEQWxzC25gGL63eQCucwJWeE6
         +7hwpYRRdD3tjBIJ3jKzXKkrF9LvmYQM8GnDxbvVBoZwiewlM02fIc8FqOkvmbcN15oz
         04SbNenbojWeNx6VRScRyEHSb4QCnHPoOV8Y0bK/iKhoB5Mli4oh3AgRNjnQvW7F4fNi
         HPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XTiGJ1VEZnu97vXLW+QBmet+F5vZfNJMdDLx5SwWiGE=;
        b=UAP1zyuU0brsEDgFWoBsXGVmiCaoVbIlgaohoa0RIabj0Y0zdkWcfv/XvmZge6NsKX
         kbSg8W5L6hqPF0D1Suboif/XCBrt1SNfwlBac8CzSwF5OBwh3REmtJhVGKIuBADnBTWO
         2jCmiDM7fCaBq4jbdHfTMWBJrlHXBumz+28pVx1K4FKLt+L4Rn1enh3aRxl/Z9tAG0jY
         LATa1oxmiuijMCMkeqZRegDDlCBFkjERasYyuj58TnPwObsl/dk0a74JKw8GqYKo6w01
         VTdENZ+ZttZCcTzhcnDbpJhJ383eaggyZIfZTLq4vJQzclxYyvB47Dfi0LyqzE31Bo5e
         BwSQ==
X-Gm-Message-State: AHQUAuYY+O1Fg36j9fReba2Jehe50D1aQR98vzRnujrPaiY0rmTn7qPv
        qEZPecDAlE1eI79nn1T4OUPBVA==
X-Google-Smtp-Source: AHgI3Iaq0wLTke+ryTSUqn0bwKpycw8u6ZdqSEBWZ8f0kaSp6nKz0UvGly3iImjzcEtbA/1IVgMkCg==
X-Received: by 2002:a1c:494:: with SMTP id 142mr2169892wme.111.1549022876509;
        Fri, 01 Feb 2019 04:07:56 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.gmail.com with ESMTPSA id m13sm2577103wmd.6.2019.02.01.04.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 04:07:55 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        p.zabel@pengutronix.de, Sandy Huang <hjc@rock-chips.com>,
        heiko@sntech.de, maxime.ripard@bootlin.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] drm/meson: Add support for HDMI2.0 4k60
Date:   Fri,  1 Feb 2019 12:07:45 +0000
Message-Id: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to add support for the following HDMI2.0 4k60 modes:
- 594Mhz TMDS frequency needing TMDS Scramling and 1/40 rate for RGB/YUV4:4:4
- 297MHz TMDS frequency with YUV4:2:0 encoding

The first mode uses the SCDC helpers introduced by intel to :
- discover where the monitor support SCDC
- setup the SCDC parameters
This is implemented in the dw-hdmi bridge driver by handling scrambling
support during the bridge setup and by exporting an helper for the PHY
setup to setup the SCDC configuration for the 1/40 TMDS rate.
This code will only be active if the encoder support a TMDS rate > 340MHz.

This patch could eventually break support on different SoC when connected
on a 4k60 monitor with SCDC :
- i.MX correctly discards pixel clocks > 216MHz
- R-CAR discards discards pixel clocks > 297MHz since [1]
- Rockchip discards invalid pixel clocks not in the rockchip_mpll_cfg table
- sun8i correctly discards pixel clocks > 297MHz on a83t
- sun8i discards discards pixel clocks > 594Mhz on h6, which is already broken

First patch should fix support for Allwinner H6.

The second mode is implemented by added the missing 4:2:0 bypass handling
in the dw-hdmi bridge driver and adding a "mtmdsclock" separating the
pixel clock from the tmds clock in the mode setup phase.
We also enable support for these modes in the connector only if the platform
glue code explicits the support.

Only the meson DRM dw_hdmi glue allows ycbcr420 modes, so no breakage
is expected here.

The remaining patches adds support for :
- 1/40 TMDS rate aka DIV40 in the dw-hdmi meson PHY setup
- 4:2:0 output and clock setup

The dw-hdmi support re-uses the support done by Rockchip engineers on the
Linux 4.4 BSP kernel.

These modes has been validated using a MuxLab HDMI Signal Analyser in
addition to different UHD TVs supporting full 4k60 or the 4:2:0 variant.

Changes since v1 at [2]:
- Rebased on drm-misc-next and fixed drm_hdmi_avi_infoframe_from_display_mode
 API change

Changes since RFC v1 at [2]:
- Fix all comments from Laurent :
- Add define for HDMI 1.4 max tmds clock and SCDC supported version
- Call dw_hdmi_set_high_tmds_clock_ratio() in dw_hdmi_phy_enable_powerdown()
to unbreak Allwinner H6
- Pass in_t(u8, bytes, SCDC_MIN_SOURCE_VERSION) as SCDC version
- Finally add comments for SCDC and Scrambling process

[1] https://patchwork.freedesktop.org/patch/263616/
[2] https://patchwork.freedesktop.org/series/52950/

Neil Armstrong (7):
  drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support
  drm/meson: add HDMI div40 TMDS mode
  drm/meson: add support for HDMI2.0 2160p modes
  drm/bridge: dw-hdmi: add support for YUV420 output
  drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
  drm/meson: Add YUV420 output support
  drm/meson: Output in YUV444 if sink supports it

Zheng Yang (1):
  drm/bridge: dw-hdmi: support dynamically get input/out color info

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 176 ++++++++++++++++++++++++++----
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |   1 +
 drivers/gpu/drm/meson/meson_dw_hdmi.c     | 128 +++++++++++++++++++---
 drivers/gpu/drm/meson/meson_vclk.c        |  93 ++++++++++++----
 drivers/gpu/drm/meson/meson_vclk.h        |   7 +-
 drivers/gpu/drm/meson/meson_venc.c        |   8 +-
 drivers/gpu/drm/meson/meson_venc.h        |  11 ++
 drivers/gpu/drm/meson/meson_venc_cvbs.c   |   3 +-
 include/drm/bridge/dw_hdmi.h              |   7 ++
 9 files changed, 369 insertions(+), 65 deletions(-)

-- 
2.7.4

