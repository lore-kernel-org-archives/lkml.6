Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178B4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41B020850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VgK1g/PU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41B020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbeGRLeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:34:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43262 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbeGRLeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:34:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id v13-v6so1830854pgr.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yvkcdyq+XH9acvZSAOuqu6Z0+SAMtHko9BM9Dtyh8Ho=;
        b=VgK1g/PUhAtlM3nfEyoj1ENZvKJAhPYclCnv4QrjdEi26kCa5acsZ/FI23SBtnY+Mw
         edsNRha7Ow4Y1+pWEnNx7yPzEMwNRaqOCgaoalzpUqkLyBr+DqYYaKA1QXjBSZrooKw0
         iKnk1SckB1UNcrE1r/zRHalQnaCOLESUb4HD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yvkcdyq+XH9acvZSAOuqu6Z0+SAMtHko9BM9Dtyh8Ho=;
        b=Kho4taD/eA+6dkyNIdHjEGkeIIb7GjyVVFoHfDSEIbUKISnYasvWXhRtbxw13HdAkR
         Lbd2+9tdTW7ohtHqXz5qow3qwx9NM0JkqtlFg3qL3Exyd/F2evFk7upDHqsTftDzdmYi
         ENnTE6jKPNoVzxquiqs8S8Kmk2ELRw+LTCGh5QpUS2N6w6GWA0C2V+Q7ASQeIpIIAU7e
         y1e5i73wYEc6Z8Aeel2gn3A0XMo3BxE26vu3x/9/CQj2A4/e7EU+GUprFHLi096pZmqf
         uIjFqLMXxizlNTqKrNnrCUzhtnJHcJgkEOfGeRGJI7a2xP3h8SEL9Ts4vno9ugQW8p8R
         JnYA==
X-Gm-Message-State: AOUpUlEx47sD6EpYfwayVRC/x1f0ynkfK76G61Qj14hYi0HNJyyEqunL
        KMGfwGdigh9llshNctfqmyrpKg==
X-Google-Smtp-Source: AAOMgpeJid+L+kbkjCf9l3tbW3BSS/3z5F3/osPfw0sIXap/IYj2q/6XKPsHht6CcSTVz+RhCM3Hpg==
X-Received: by 2002:a62:34c4:: with SMTP id b187-v6mr4656608pfa.15.1531911399855;
        Wed, 18 Jul 2018 03:56:39 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:56:39 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 12/18] drm: sun4i: add support for HVCC regulator for DWC HDMI glue
Date:   Wed, 18 Jul 2018 16:24:52 +0530
Message-Id: <20180718105458.22304-13-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Allwinner SoCs with DWC HDMI controller have a "HVCC" power pin for the
HDMI part, and on some boards it's connected to a dedicated regulator
rather than the main 3.3v.

Add support for optional HVCC regulator. For boards that doesn't use a
dedicated regulator to power it, the default dummy regulator is used.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3, v2:
- none

 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 14 ++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 31875b636434..68623a6ac44e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -113,6 +113,12 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	if (encoder->possible_crtcs == 0)
 		return -EPROBE_DEFER;
 
+	hdmi->vcc_hdmi = devm_regulator_get(dev, "hvcc");
+	if (IS_ERR(hdmi->vcc_hdmi)) {
+		dev_err(dev, "Could not get HDMI power supply\n");
+		return PTR_ERR(hdmi->vcc_hdmi);
+	}
+
 	hdmi->rst_ctrl = devm_reset_control_get(dev, "ctrl");
 	if (IS_ERR(hdmi->rst_ctrl)) {
 		dev_err(dev, "Could not get ctrl reset control\n");
@@ -131,6 +137,12 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
+	ret = regulator_enable(hdmi->vcc_hdmi);
+	if (ret) {
+		dev_err(dev, "Cannot enable HDMI power supply\n");
+		goto err_disable_vcc;
+	}
+
 	ret = clk_prepare_enable(hdmi->clk_tmds);
 	if (ret) {
 		dev_err(dev, "Could not enable tmds clock\n");
@@ -183,6 +195,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	clk_disable_unprepare(hdmi->clk_tmds);
 err_assert_ctrl_reset:
 	reset_control_assert(hdmi->rst_ctrl);
+err_disable_vcc:
+	regulator_disable(hdmi->vcc_hdmi);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index aadbe0a10b0c..af34c498295e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -10,6 +10,7 @@
 #include <drm/drm_encoder.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
 #define SUN8I_HDMI_PHY_DBG_CTRL_REG	0x0000
@@ -176,6 +177,7 @@ struct sun8i_dw_hdmi {
 	struct drm_encoder		encoder;
 	struct sun8i_hdmi_phy		*phy;
 	struct dw_hdmi_plat_data	plat_data;
+	struct regulator		*vcc_hdmi;
 	struct reset_control		*rst_ctrl;
 };
 
-- 
2.17.1

