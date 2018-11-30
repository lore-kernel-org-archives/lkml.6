Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AD5C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D204A2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0ginDUsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D204A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeLAAwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:52:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54200 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeLAAwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:52:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id y1so5831538wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 05:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nUl5MjrAt2nNf/2c4ohOygU7HWMJOdWxngvB/jTAZhk=;
        b=0ginDUspi3wBncFyoq4T/ydFyUaUic8AiZfvu/JpOXQeaaWB6mfuQsw6gAhUCPL53J
         2zkvGhZNol3AmlNO4DxqBR5acirMGHmu4b6gC3AO7kHcr/AY0PH28+gTaAgx6ly1XVHA
         ceFwYu6QZEhgpD7wQvNQaKvk7ScePDY1DGkgYWdFAB8yeLwc42djDctAf97QZk1hBYOH
         NC8BSslK/mP2KISZrC+D+zWj2XiVf/8gj+1BY1xQFZjZLC2goWrM/gS8F/IY3MeKEDen
         KYJEkC7OcklMcl+23y1TNzlmmm7ckkPcNr0Wih2JLnAnI7/TjKaP41FeOzBS5kP8exbb
         6gaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nUl5MjrAt2nNf/2c4ohOygU7HWMJOdWxngvB/jTAZhk=;
        b=kCfAjKTWzKWwhtEmAQMTotVeJ+hxHFFm3Gtg0fGH8ofpphVV0rPm+9f57Ci+6sqSrn
         4WQJ807QSWI0cEYtJDsCpPVPs8LqakGsMlUg7Kkr1EDEW9p6tp4TRfuFneFcenUyz1Pz
         ELfxRK8iRvN4+4P2P0ZWH6a2QyWxcmgRLw9rSp2yQIonJYFtDl/NY4VyI5u1jbay6XE+
         8YG+f9DVD2xokRgWGL92jYIBDd70NbH/eF5GOZSertj+QMD7v8D5a5m0n1zp5ccLuG0q
         Y6MosQN5TRtE+vxR6MjKftpaShpThZ+q00wAOU45ZHOV9xDrfrXED7isUuPp81xiR2mW
         0HIg==
X-Gm-Message-State: AA+aEWaN5kZKqay008xTO0MOeXv8JKQtfl2PsoO1KmfIaWkLMV/Z+EIp
        rahR94Ixym6/fo4wrhb16dvC4Q==
X-Google-Smtp-Source: AFSGD/UyEWOkZp1SvvYRRWcNiHf2uvkRuqWMPrqF2aBPE/CrVmEeZzvLJ6UPUunVeDQYFf1XhRoJDg==
X-Received: by 2002:a1c:e3d7:: with SMTP id a206mr5544130wmh.80.1543585393607;
        Fri, 30 Nov 2018 05:43:13 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 125sm6864898wml.35.2018.11.30.05.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 05:43:13 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 8/8] drm/meson: Output in YUV444 if sink supports it
Date:   Fri, 30 Nov 2018 14:43:01 +0100
Message-Id: <20181130134301.17963-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130134301.17963-1-narmstrong@baylibre.com>
References: <20181130134301.17963-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the YUV420 handling, we can dynamically setup the HDMI output
pixel format depending on the mode and connector info.
So now, we can output in YUV444, which is the native video pipeline
format, directly to the HDMI Sink if it's supported without
necessarily involving the HDMI Controller CSC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 83360f37d9ce..1b7092ab1be8 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -670,7 +670,10 @@ static int meson_venc_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 		dw_hdmi->output_bus_format = MEDIA_BUS_FMT_UYYVYY8_0_5X24;
 	} else {
 		dw_hdmi->input_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
-		dw_hdmi->output_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
+			dw_hdmi->output_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
+		else
+			dw_hdmi->output_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
 	}
 
 	return 0;
-- 
2.19.2

