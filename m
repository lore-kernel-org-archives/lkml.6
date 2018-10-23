Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEF2C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70EC207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lOWcmQ8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70EC207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbeJXAQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:16:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44128 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbeJXAQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:16:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id r9-v6so875976pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c+3tc5fDsnKkB4SijQdkcRb3OP0M7xi1nDtiQqxDBrQ=;
        b=lOWcmQ8EcxQ1zNZqPNGFKa3ZvQt0BCQOgcXpBRDvnICP+Wghvk4tidAbe+AoEX1/Yq
         FFSBuMrKyrpEAj1jMotreodQWeXq4P0QM3IoftPKkQZWFD9gaIp8REqlxFxg1vO1NmdJ
         PNaTbawGm6AMEklFGEyKhFzwpR8xHbUu9weAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c+3tc5fDsnKkB4SijQdkcRb3OP0M7xi1nDtiQqxDBrQ=;
        b=p9YQX1PWL8Ke56kQWwWEHrUWMyAOIlwOSXE4IutGnLC9Xdp/VKiUxL9spWK4X455rl
         aoEFf70azAezs+Ypc1FW0lda8hLltNbVPv7y75Iuc/iqpvVVVVvX456aUrhfCiuoaVWN
         OR0vGcjKv7p1AziKwp8/xwtFYdtWaeYUj6/PJwNY+1nejRs7CPR6mmWMo0IiwSkHU5eW
         yaGpBIY+RhzSzoAdYQyrg6Kdokn9jyWZLqgjdh27Qm0AL0hxf2o86WaebGCaQczzzgoM
         cQw+xAkhDV8Zj/vkghU+ubsqpZwbyCtnPpcJK7glw+tCvIWF5wg1HEqN+8TCW5PLi9Pn
         efjQ==
X-Gm-Message-State: ABuFfoj11wPuGn7Pdz3hZKTkMkBRW0BLbVBdF1EDJfY8mPCuDrvD1V3X
        /EHcn3E+KWfrBTeJIbEWlMJAag==
X-Google-Smtp-Source: ACcGV635CgQMU05qYAGT/fcH4+BfHcLJPnkEZ1RtWvUUr7SuZyeuyZR16pR1i+w874dVcuRfEuHLyA==
X-Received: by 2002:a63:4243:: with SMTP id p64-v6mr48080207pga.127.1540309932389;
        Tue, 23 Oct 2018 08:52:12 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id o75-v6sm7442829pfg.0.2018.10.23.08.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 08:52:11 -0700 (PDT)
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
Subject: [PATCH v2 13/15] dt-bindings: sun6i-dsi: Add compatible for A64 DPHY
Date:   Tue, 23 Oct 2018 21:20:33 +0530
Message-Id: <20181023155035.9101-14-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181023155035.9101-1-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
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

