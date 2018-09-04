Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4F8C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE99120867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bdKprSAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE99120867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeIDVCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:02:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42818 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbeIDVCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:02:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so1955734pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 09:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q9bOpKtT4W64lwZMrmVPiyErnb0NEJ999Mlna9mqz7w=;
        b=bdKprSAGsojRgmeTLRjrQIvmfkx1ryPZtjS3MfOtnM1fV6wsx4g15U191hzAIAuVS6
         p+UWj9knsEkT4j4/tsaW3NmVIQk0AMTmAK3+/4wotsBH5FUH+W+wvfkze7cLjXgAcASq
         pM5Dzf3JjiACmSWEe27eYvm8zCsfVVc3e8VAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9bOpKtT4W64lwZMrmVPiyErnb0NEJ999Mlna9mqz7w=;
        b=XZ+T/QFd9pCGT0z9YGyGCuZPCaywDi4aHk/+eYeOWeYO1ylGpE125EKkQeVPW+0HmN
         5A37dJzs1OlzOIcuufkoFfEaaC70SpgwwJuEAQ3Nx2iCl1JKKK/uQ0hp//vOqSjj0Hw0
         D3fjFJdHZ8DRUwBQsYKBHKPyLh8YRkbXx1jhan362Au/MqqEytKBtdcFA9TqCvUXGJ5A
         +6xyL5tkKQa5hJTEg9RaxFDTQcP1nJriAXQTcIaFofo3tyRY0RgYiMr/4GqsAfqvq9SC
         9UqeTBX02CxjCGbaK9haJ7tThgGU3AAschR4Z1sTwx1qRrbYNuZ/a5LYvkoz/JP3L2LV
         +tXA==
X-Gm-Message-State: APzg51DB+wsAEb/W4GhHAgr4VT4mcsA/bD8k0uZ3h1z0eUTMqQGfRRJo
        ZfsT0Q83wkcd6QEXSlu50hEAWA==
X-Google-Smtp-Source: ANB0VdZ86wTfwbAI8I9JCTCrGMhsgp0MqDGf1bjquAQueFzYPMhGcU6nR47WhNvlEaC962k/vQrjyQ==
X-Received: by 2002:a63:4826:: with SMTP id v38-v6mr32254789pga.379.1536078999046;
        Tue, 04 Sep 2018 09:36:39 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.161])
        by smtp.gmail.com with ESMTPSA id t2-v6sm36037072pfj.7.2018.09.04.09.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 09:36:38 -0700 (PDT)
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
Subject: [PATCH v4 4/4] drm/sun4i: Enable DesignWare HDMI for SUN50I
Date:   Tue,  4 Sep 2018 22:06:09 +0530
Message-Id: <20180904163609.10171-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20180904163609.10171-1-jagan@amarulasolutions.com>
References: <20180904163609.10171-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Changes for v4:
- none
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
2.18.0.321.gffc6fa0e3

