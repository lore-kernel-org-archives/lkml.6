Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAD5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B010121531
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Gu7vifzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B010121531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeI0SHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:07:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44422 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbeI0SHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:07:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so1722046pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 04:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=micJN1AyYSAo0SUFv6AD/9lj2AyYhuAPTyWQrFvkpuw=;
        b=Gu7vifzS0HvT6gK5gqIothHuVrNi3vKlOYNqFimdXQRQvK9V+V6hGsXqh5K0qxiRC9
         nv/2ttPbBpWxh6NDSN1DHsDgfKa5qa2Ll8kQSne7Xu3hdiM06HTRRHxG5geHOIwwePlm
         s9eRIwQ4N62ODY3WBtWlzvI8LFneN2/RSRtH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=micJN1AyYSAo0SUFv6AD/9lj2AyYhuAPTyWQrFvkpuw=;
        b=RnzJY1Ie9nlmhdQTCGJomtnpOXeR6OSoxUabEN2bnuaQITNPREh+bljl9uxAKIKpT8
         gr6orEtOuHXGFpDLt5CypZppjUexBkSzK2EniI9SZNyAxOZv05CBqBqgxwJL3RB4Li9p
         HMEteo+4l8QstWqcJ8EnPeC2cu8veJXqruT8BQ+DCcAcIkgvWkUERUilEOdrScPBmBQ8
         tDSFNbEJM4r/XwEl6vhkkx93NSLbPGzSj4lH/SNr1WH8iepIU2aB4syiN+HbIZTKu10O
         cMXR4OnBvwv5Ei+XYdBhxvCbWc1clfhtuAmgpdaCYpHzmrorqCPcRkUmWzFzEhmpGE/n
         w9bA==
X-Gm-Message-State: ABuFfohZduKf1qyuJuFTaqJygd0XtnIQT0q9wSpD47rXHdUaBST3sEbx
        8ML9Pg7EOI8f0ExXubFuEq4clQ==
X-Google-Smtp-Source: ACcGV60mG0x7EHQM7tmxVvAmr+qm7id0HJ/WqlRDvS0tFoSWnrULe/+M7XH/ouv6Desdq+cdWDR0lA==
X-Received: by 2002:a62:b09:: with SMTP id t9-v6mr4861259pfi.36.1538048976869;
        Thu, 27 Sep 2018 04:49:36 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.83])
        by smtp.gmail.com with ESMTPSA id v36-v6sm3744872pgn.85.2018.09.27.04.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 04:49:36 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
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
Subject: [PATCH 03/12] dt-bindings: sun6i-dsi: Add compatible for A64 MIPI DSI
Date:   Thu, 27 Sep 2018 17:18:41 +0530
Message-Id: <20180927114850.24565-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20180927114850.24565-1-jagan@amarulasolutions.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller on Allwinner A64 is similar to
Allwinner A31 without support of DSI mod clock.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 6a6cf5de08b0..9fa6e7a758ad 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -12,6 +12,7 @@ The DSI Encoder generates the DSI signal from the TCON's.
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-mipi-dsi
+    * allwinner,sun50i-a64-mipi-dsi
   - reg: base address and size of memory-mapped region
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the DSI encoder
-- 
2.18.0.321.gffc6fa0e3

