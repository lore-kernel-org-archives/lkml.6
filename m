Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD14BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865822086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HAIHFqXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865822086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeIDVC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:02:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33177 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeIDVC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:02:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id s7-v6so1947979pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 09:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gh77tlX9DJRKlbQ5msZn3Y2TLxH1edFdsNoBxcw/ePs=;
        b=HAIHFqXHn949JOCZLFl6+rf9fzTD1vviu5RM/6HtSjZqyOdp5jmpWeoFNoCf6nKwT+
         77WcujKmBq7IcffTTjg2WQYLFaKBGA11uNJmFV3n2vuqRbcKkPAb7d0ONmpwMQwFCama
         sJLSuR1r1zNXeLOq4zpj7F2Y+/x0VnVkdUOvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gh77tlX9DJRKlbQ5msZn3Y2TLxH1edFdsNoBxcw/ePs=;
        b=B5GWYbj9aUS30Ep0TnrXFGHK/zM7KRwcN/AU7QmF+rmFCe9iSMbavey4fyeGFsBBME
         DLmDGEgD7dJyScz5YrGkkdf9neBhhpemQKLc3ZYlhdFKF94LMkC/noF65a6wLcPNqpAU
         yPWulSdSbNmH2kFk964bxC9CyrzDac0SWUGztIARiABCJaMb85Zz86tJhXcP86nEJKFN
         lT61WswKXQSM1iALE9sqghvZ0zkG9n2XzcjYQ8uxLwnU86Lz/L6+SRJI7bKeoDJIg4dD
         DS7mumunk1Su0Fy7gbw8nGw/53NGYKgW+W/1T8j6QV0w0UMyVOIP6HahZkMXcQDb6OfZ
         0+4w==
X-Gm-Message-State: APzg51BfpMztuqSvIEkhrmh2f+tuzXSo0h0n8KH6Miz8jZFh9lVZHJ/a
        FhRQUlAw+xTzfTgwhGNfornn/Q==
X-Google-Smtp-Source: ANB0VdanTqcr3MHZkQlkhvpXWak6voMV5DZyeL/e3zB3v/znLiVTringW0xtbzPlYTEGaMv1Nh5NHQ==
X-Received: by 2002:a62:219b:: with SMTP id o27-v6mr35440585pfj.235.1536078994020;
        Tue, 04 Sep 2018 09:36:34 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.161])
        by smtp.gmail.com with ESMTPSA id t2-v6sm36037072pfj.7.2018.09.04.09.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 09:36:33 -0700 (PDT)
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
Subject: [PATCH v4 3/4] drm/sun4i: Enable DE2 Mixer for SUN8I and SUN50I
Date:   Tue,  4 Sep 2018 22:06:08 +0530
Message-Id: <20180904163609.10171-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20180904163609.10171-1-jagan@amarulasolutions.com>
References: <20180904163609.10171-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner SoC like SUN8I and SUN50I are now using DE2 Mixer
so enable them as default.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4, v3:
- none
Changes for v2:
- Enable for SUN8I

 drivers/gpu/drm/sun4i/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index c2c042287c19..cfa8b96273fb 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -61,7 +61,7 @@ config DRM_SUN8I_DW_HDMI
 
 config DRM_SUN8I_MIXER
 	tristate "Support for Allwinner Display Engine 2.0 Mixer"
-	default MACH_SUN8I
+	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
 	help
 	  Choose this option if you have an Allwinner SoC with the
 	  Allwinner Display Engine 2.0, which has a mixer to do some
-- 
2.18.0.321.gffc6fa0e3

