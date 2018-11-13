Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9F6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F28C20685
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TzdlLeGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F28C20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbeKMVQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:16:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44289 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732611AbeKMVQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:16:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id b81-v6so5384748pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSLZfhqj5LlgFfpYLOueILNrvF0k+OKE5voNHu/WFJA=;
        b=TzdlLeGvxZi/sp4OdtAbRM2wrertCNfr9pdtMwXZYBYLQ8dYWZIbgiO9vKrPGUaflo
         e+8EKdq7rc1rBDTqvOFuvdK2pZhEIPwl0FJnnJ2y9c8CI2UuNJCTmJhqlBkJbsPXtb9p
         WXQMvm0ockoqDoNtnYfa0kgqQ4zz09W+axKNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSLZfhqj5LlgFfpYLOueILNrvF0k+OKE5voNHu/WFJA=;
        b=HQdBP0PFR+e2FQ4cb3YhZ4khtz4NoXS3m3vr86WYxb7v7eB56TwIFGOuyOgM90pBAV
         2WqxcgB32oXodpE9cQjB3q7yN0ftGU2ChdFS/PuadPV+58FFL+Ho8gkLyABmv8h9G7Id
         qXSlo0VCN4qlh5G1Te+c96FWk5mkkDl0mz1rqlAlQVD8Q+0ThoiMC5LoKZyiPDgIwL64
         KySQTKlXLVRiDEe0XElwU4g+yanyUbynrdkaIVuHhs9+IPccEipMkrNkgGUIYKc4Qiz5
         W3daRIpqvknUmnkawn8pb6wivUlgw6KFk/PTC0pSZDzNd5cn2IOyZZT1cLrHP5M2hJki
         Lq+Q==
X-Gm-Message-State: AGRZ1gITDxmzPrasx3pijjDsWq+sVn0yhZ7XFfra8hPbWlwBMrnsK92j
        bL4mIRtp4rXt21fAza5SZXdVwQ==
X-Google-Smtp-Source: AJdET5fa0KMs//bm0WsslCyYJAAXnsAUwbJaNcahS9xieHBRKUV/HKEJV2dDmlMjYMdtFi/DAzWfqA==
X-Received: by 2002:a63:310:: with SMTP id 16mr4256898pgd.79.1542107954710;
        Tue, 13 Nov 2018 03:19:14 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id 27-v6sm28531377pfm.36.2018.11.13.03.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 03:19:14 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 23/26] dt-bindings: sun6i-dsi: Add compatible for A64 DPHY
Date:   Tue, 13 Nov 2018 16:46:30 +0530
Message-Id: <20181113111633.20189-24-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index adc7cdf129dd..08f1f57abff5 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -40,6 +40,7 @@ D-PHY
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-mipi-dphy
+    * "allwinner,sun50i-a64-mipi-dphy", "allwinner,sun6i-a31-mipi-dphy"
   - reg: base address and size of memory-mapped region
   - clocks: phandles to the clocks feeding the DSI encoder
     * bus: the DSI interface clock
-- 
2.18.0.321.gffc6fa0e3

