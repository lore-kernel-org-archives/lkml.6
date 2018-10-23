Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40408C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0988820652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NbsYaNbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0988820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbeJXAPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:15:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35190 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbeJXAPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:15:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id l17-v6so896863pff.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UFr9vzKrF456DG+Pg5hEEmJgU+xNz0cRAoIrygcGoQk=;
        b=NbsYaNbz6wlrq1ZZXHHrvLy1RDVKKQusiSWTFBfpAeKMWXAAStMRMlG8unpfxgjx5T
         JI3O1SuExtYKHej8phzFWlK8YO5HX3+j+sAIw2vBzOOA76SnpaQAvIH8CXnJp7lITSIO
         EaVWf3PEPyJCFTISg1zqXfdrANM9Svka5uleE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UFr9vzKrF456DG+Pg5hEEmJgU+xNz0cRAoIrygcGoQk=;
        b=MqjoveX0duIagoD9rRKjC7wfu0jy7e86OCrOCt2T+mG9pPc1S0CLWjjf6NrR8VdE62
         PAydo/K6zgd2BzLxMapeP92A3u7eQOpa+kfAD8oZ8LPtuZdkx6/rKTfz4ZZWlCWZdv8v
         ZuW+CrBTeDP0tqJfLNO4ITledxk8/4ZP46LCEDyoJ2quE6j4de0g/mJZ1nMYRt25AjJN
         1rPsEOGWEgiZPCvz/c/0C/NHRBXhJy6Wi2XjivdYyq1uG0xUf0EE0obN+tt5GwH9/tj/
         OADfClqhspdqDoNjWr3BItBu5tMPePv694VqFt5L74rP9ZbELMSdiP1VDi3fOJhLrfbh
         wGCw==
X-Gm-Message-State: ABuFfojJawKNW+iC0RPjwgfO1RCpwf6E9doxV2AbGwS8L9yWyjsS3qN2
        Ky5BPN1DhlTtnXY33MEw+IOLrQ==
X-Google-Smtp-Source: ACcGV63WPpysLsuJQMv48NXTPtyXtyRl40D16tjRufTy0O5Mr0zeZKzhRXg5yTJ0jAXUQ3vZ9XCgpQ==
X-Received: by 2002:a63:4343:: with SMTP id q64-v6mr48790849pga.276.1540309887347;
        Tue, 23 Oct 2018 08:51:27 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id o75-v6sm7442829pfg.0.2018.10.23.08.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 08:51:26 -0700 (PDT)
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
Subject: [PATCH v2 05/15] dt-bindings: sun6i-dsi: Add compatible for A64 MIPI DSI
Date:   Tue, 23 Oct 2018 21:20:25 +0530
Message-Id: <20181023155035.9101-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181023155035.9101-1-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller on Allwinner A64 is similar to
Allwinner A31 without support of DSI mod clock.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v2:
- none

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

