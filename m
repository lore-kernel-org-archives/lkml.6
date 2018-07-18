Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A869AECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F13620850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jGdbbHSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F13620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbeGRLdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:33:21 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46871 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730831AbeGRLdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:33:20 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so1864504pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L8TWsRwru7hj4xPHFjioxjzHIm+mdqyF1T8tyLODzB8=;
        b=jGdbbHSc6epoj30SnOyHetxI8s9b8R0OUoU/HMQlUIIs9h2LMf1BYu6QzyXFnZ/sPC
         OV0JTGzU7Gsq9/A6INZ7IAh697yQpu2NP80f72HFGrpJv+cDCzGfEBmCuRLtsDQ3RR5K
         XzGrQ8UsJcs/OOIovYTuwKE2cpWhbfTv3rAv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L8TWsRwru7hj4xPHFjioxjzHIm+mdqyF1T8tyLODzB8=;
        b=P4Is8qBf4Ndrk2xlv0mCV1a5lMEwgDEhyTzmrt40hrzaqrWQCbIZyORM4vvh7Jng6O
         snXPc9WgKRptAGvQJGDHSxHyU8A77LIGdcq1rIdp2iMcCChaiV+9ps/D9THNAO3X9An0
         20n6a5tscuILrE6Q8lE9Tl9xiqQ/n9qdksB1+oDjd8f4Cu90CSHaiasVY2zXo2bITXu+
         dP01dmrfSMFqiqUueFGJSTJhPpW34/2JCewvOmo/zlis+rj1M2Twr4gpev2FOIcoQwPN
         qu4vQKdO743UbyCEG9BiWwrqEUxbE1H9qiq6j2ezZfrqg3onS1NASaN3GVGpaXrR0+ye
         Y/SQ==
X-Gm-Message-State: AOUpUlEaohDVFRnxcbKNjgCE+ugOhvufQMyjUoUvQehFVpHkvfun+sRY
        OjDSofIQG2MWHyRjYGhME3CKQA==
X-Google-Smtp-Source: AAOMgpcr2nm7LEtfM7SSjgy4eXaqYdbIoe16atzKvdtCKah+DPY4YJ7x0K4lTgxqfNyvM7RFNDHCXQ==
X-Received: by 2002:a17:902:64c2:: with SMTP id y2-v6mr5436227pli.53.1531911360861;
        Wed, 18 Jul 2018 03:56:00 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:56:00 -0700 (PDT)
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
Subject: [PATCH v3 08/18] clk: sunxi-ng: Enable DE2_CCU for SUN8I and SUN50I
Date:   Wed, 18 Jul 2018 16:24:48 +0530
Message-Id: <20180718105458.22304-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner SoC like SUN8I and SUN50I has DE2 CCU so enable them
as default.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none
Changes for v2:
- Enable for MACH_SUN8I

 drivers/clk/sunxi-ng/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 826674d090fd..e20182aa9748 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -63,6 +63,8 @@ config SUN8I_V3S_CCU
 
 config SUN8I_DE2_CCU
 	bool "Support for the Allwinner SoCs DE2 CCU"
+	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
+	depends on DRM_SUN4I && (MACH_SUN8I || (ARM64 && ARCH_SUNXI))
 
 config SUN8I_R40_CCU
 	bool "Support for the Allwinner R40 CCU"
-- 
2.17.1

