Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C43C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C9C20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jLHJFckw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C9C20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeJZXXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:23:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43432 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbeJZXXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:23:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id h4-v6so656565pfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RdfPEPfFwzCV6ddXPOybIcNiGRmn4J/B+TPYYURh+3s=;
        b=jLHJFckwiXWYW5W7twLkdqf55MPpoFpXWfDu8RtGcEu22pyL+bZ2t42p8m/miVowPP
         2Ur3f+fDuKV9XntcCwKQgtRKPREdEcQuikwhSgUJ45kBI5AW6SI+Pipb6Bpf10dnX8iU
         JEGnb9SQ0JgZbbkYOZJJxSaRTCPmcTF0/gypM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RdfPEPfFwzCV6ddXPOybIcNiGRmn4J/B+TPYYURh+3s=;
        b=H9mxOMRCOsDUp3KUr7t+R3TQqxFKTvAgbviY+87lBKQrl7c5+Exk7HCHRZWNEbz8B3
         ymLpybKCLkSbWJevgYyqb/lUOCYZwH+XlJcxH35Q8eHCjOGkbBHFPD993xv5rzFH7Kjy
         J15aEHyrKvH/1LKS6auG9IEJOxW/hzsiPQA8ouViKFZdsKgBr9sS/Zn4vWoEAcW2ARr7
         Qagh4CDH23AuI5U3cRpThK3aFULymUdjlq7VtZsQ69c5KXGmFcw94+RZvJwEG8XE5fW5
         Dlaja0Kw9+U+XPUwF3inEbOA4DPk3mS6ogV6HsqPZYrL0dla8Vx7sfF7mW2r/RKg3fZT
         tEWQ==
X-Gm-Message-State: AGRZ1gLbqvPuICnp1k7ssvMFin1lnFcIE84hG6nX5ZjdKiQu/r7PX3iG
        j+JqkBkwUP6LHPTBYRCGnCOkKQ==
X-Google-Smtp-Source: AJdET5fLyo88zmi8dqWGYaZuIpyR30572ALOlL0bU6B1PADW0HSSm30WqlRSfNuLDgHITt5SdPLqaQ==
X-Received: by 2002:a63:d444:: with SMTP id i4-v6mr3720532pgj.194.1540565176628;
        Fri, 26 Oct 2018 07:46:16 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id z22-v6sm12044467pgv.24.2018.10.26.07.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:46:16 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
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
Subject: [PATCH v3 22/25] dt-bindings: sun6i-dsi: Add compatible for A64 DPHY
Date:   Fri, 26 Oct 2018 20:13:41 +0530
Message-Id: <20181026144344.27778-23-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI PHY HDMI controller on Allwinner A64 is similar
on the one on A31.

Add A64 compatible and append A31 compatible as fallback.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none
Changes for v2:
- new patch

 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 9fa6e7a758ad..704fb31962f2 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -36,7 +36,7 @@ D-PHY
 
 Required properties:
   - compatible: value must be one of:
-    * allwinner,sun6i-a31-mipi-dphy
+    * "allwinner,sun50i-a64-mipi-dphy", "allwinner,sun6i-a31-mipi-dphy"
   - reg: base address and size of memory-mapped region
   - clocks: phandles to the clocks feeding the DSI encoder
     * bus: the DSI interface clock
-- 
2.18.0.321.gffc6fa0e3

