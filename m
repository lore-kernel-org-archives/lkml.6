Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A83ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3893420850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OwR+NDh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3893420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbeGRLdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:33:54 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38074 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbeGRLdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:33:54 -0400
Received: by mail-pf0-f195.google.com with SMTP id v15-v6so2026468pff.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HLGFoCEVFpCiOifepTECYua1kc50772Y5AMmI/8VfNc=;
        b=OwR+NDh70coDxywzKUMgucs60JQ+hHjM7k5sP4OzlRfyKq84rzqg787gTzqMI8mxOQ
         yTPy/KlK+OVj3ThEUEjdjp71E4SYDUKPjhVUc8zQclj7LWPHjaqAiF087GX/+WtlDp/S
         6cXF0egfXP2cYGLBUp58ToxiuBCeZsbOvDP/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HLGFoCEVFpCiOifepTECYua1kc50772Y5AMmI/8VfNc=;
        b=Q+theu/UTjD2CG8VXWgSHorFoIt325dLNMMna6UU124Hu2jeFKBGPvJmwr1KRY6dq5
         3UI6WFBGfWutA4xRv2IraN6rN7OtPsBnNL9yz8Rwwna1PXyeq+jgCfSmeQIUCFVDzeTr
         IH2sZirOhlZG9pqmHAYSDlsxur+X0xrQ4v85VPBZI9sgLCXFsXFAa7AQzIa9KRJwuF8j
         S9YIHJ/Z3f6kg+AcmaKxr3jCEb/Tn6fa2VTHrqcEPkxhquO5FY9XXLR2nK0o6efBNVqR
         QgI39mn3R6L0Tn8fxdv/MEM1nKI2yOvkhto8fp7xk50BR0QsBp2N9CVxoHl/Zbu308wG
         z55g==
X-Gm-Message-State: AOUpUlGC0eRNJJnmVQ73woAf0NyfyG4mkz6yZ8oTg5SHwg3AcGLVl/Oc
        9Dz3/+Mk5JX7yPtvJKdQiE8zdw==
X-Google-Smtp-Source: AAOMgpfhMw8A5MWWtIRh+lDOgejwk+iu1XGqxRgJOejZ1DM8UkZNZxKzQ5qJ23kcrz9va7xTc61DcQ==
X-Received: by 2002:a62:4147:: with SMTP id o68-v6mr4659201pfa.111.1531911394379;
        Wed, 18 Jul 2018 03:56:34 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:56:33 -0700 (PDT)
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
Subject: [PATCH v3 11/18] drm/sun4i: Enable DesignWare HDMI for SUN50I
Date:   Wed, 18 Jul 2018 16:24:51 +0530
Message-Id: <20180718105458.22304-12-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner SUN50I are now using DesignWare HDMI so enable
them as default. This can build DRM_SUN8I_DW_HDMI as module
since DRM in arm64 has module.

Making this as defult to SUN8I, may cause an issue while
loading since arm32 DRM built as static.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- skip SUN8I enablement, since it built statically for arm32
Changes for v2:
- Enable for SUN8I

 drivers/gpu/drm/sun4i/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index cfa8b96273fb..5d0c450db148 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -52,6 +52,7 @@ config DRM_SUN6I_DSI
 
 config DRM_SUN8I_DW_HDMI
 	tristate "Support for Allwinner version of DesignWare HDMI"
+	default ARM64 && ARCH_SUNXI
 	depends on DRM_SUN4I
 	select DRM_DW_HDMI
 	help
-- 
2.17.1

