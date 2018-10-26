Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D639DECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F9320651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CXj6JMYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F9320651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeJZXWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:22:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40174 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeJZXWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:22:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id g21-v6so662784pfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9riTQ9ZUQloojan2IQ3yvqR1uY++RI/JA1qd1PVuxxo=;
        b=CXj6JMYzpt19nF8RCdog67DMukbYMr7N12u8gq6N357OOjnRvkhJqmGOFFVq0oAReO
         g1t2eAnpew4KnK+SLIYPDboFo6nJ8gSFI1o3jSBjHtKXOp/eCCrkhOXLh/5zr63QwlgO
         6QzbHMkUGB36l8yrLVxHydeH8kxpXCJOS/uFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9riTQ9ZUQloojan2IQ3yvqR1uY++RI/JA1qd1PVuxxo=;
        b=fdMyVVtBTsyLCFXMEzVmARnKePwVwG3oXLfv4l+61+GTxavQ3YRLxndtlH7Z6xeKBt
         G1jPv7ekuZH9j3XNS3BnWkBm+Nj8Og8fNRSf6gSmSmse0/c89jesB73g6yT7FdP5M4nT
         EIOiITCT0eCjKUk/7+WJG5J5nQu5YTGhKqHQ8tQn8SQQzAiaFnrs+0JbXdfjMWWRjdS0
         zzA6hNl6qBFCrI5tekysLAxj0APdt1w4KuXx3zK9NrKA0VwaJ+SSxCz1WFtaln2jWNqf
         V4ipFaBj8a/zLSDruuj6IQioRLEMzhcbtsy6ndRYohjn5AS0BAF9WgihqU3ciIFZH6U7
         Ll5w==
X-Gm-Message-State: AGRZ1gITBsS1JsQnvIPYv6IlaGUIs1f8W8YBKFIccDn3f211vUGqZoqr
        a9j+0y+yJmKv2qv8mJdn3FBwPQ==
X-Google-Smtp-Source: AJdET5fIDV0oa38s49ddMH0fRlRTaZ6oYCU6o5Evm1+pJ+bzTzN2Uh6hDhktwHJ2s3QBgBuighWIiQ==
X-Received: by 2002:a63:1555:: with SMTP id 21-v6mr3681066pgv.383.1540565080777;
        Fri, 26 Oct 2018 07:44:40 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id z22-v6sm12044467pgv.24.2018.10.26.07.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:44:40 -0700 (PDT)
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
Subject: [PATCH v3 05/25] dt-bindings: sun6i-dsi: Add compatible for A64 MIPI DSI
Date:   Fri, 26 Oct 2018 20:13:24 +0530
Message-Id: <20181026144344.27778-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
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
Tested-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- add tested credit
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

